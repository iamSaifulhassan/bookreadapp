import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'app_logger.dart';

/// Wraps RevenueCat for subscription entitlements.
///
/// RevenueCat (not the raw in_app_purchase plugin) handles regional
/// pricing/currency display and receipt validation for us, which matters
/// for a multi-country launch. See the "You do this" checklist below for
/// the account setup this service assumes.
///
/// YOU DO THIS (cannot be done from code):
/// 1. Create a RevenueCat account and project at app.revenuecat.com.
/// 2. Create your subscription product(s) in App Store Connect and/or
///    Play Console, then link them to RevenueCat as "Products" and group
///    them into an "Offering" (RevenueCat's dashboard term for a paywall's
///    set of packages) with an "Entitlement" (e.g. "premium") attached.
/// 3. Replace the placeholder API keys below with your RevenueCat public
///    SDK keys (Project Settings > API Keys in the RevenueCat dashboard;
///    these are safe to embed client-side, unlike secret keys).
/// 4. Decide which entitlement identifier gates premium content and make
///    sure it matches [_entitlementId] below.
class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  // TODO: replace with your real RevenueCat public API keys before release.
  static const String _androidApiKey = 'YOUR_REVENUECAT_ANDROID_API_KEY';
  static const String _iosApiKey = 'YOUR_REVENUECAT_IOS_API_KEY';

  /// The RevenueCat entitlement identifier that unlocks premium content.
  static const String _entitlementId = 'premium';

  bool _initialized = false;

  /// Reactive subscription status other widgets can listen to, mirroring
  /// the ValueNotifier pattern used by LocaleService/ThemeService.
  final ValueNotifier<bool> isSubscribed = ValueNotifier<bool>(false);

  Future<void> initialize() async {
    if (_initialized) return;
    final apiKey = defaultTargetPlatform == TargetPlatform.iOS
        ? _iosApiKey
        : _androidApiKey;

    if (apiKey.startsWith('YOUR_REVENUECAT')) {
      // No real key configured yet - skip RevenueCat entirely rather than
      // crash the app. Subscriptions stay unavailable until it's set up.
      AppLogger.log(
        'SubscriptionService: no RevenueCat API key configured, skipping init',
      );
      return;
    }

    try {
      await Purchases.setLogLevel(
        kDebugMode ? LogLevel.debug : LogLevel.error,
      );
      await Purchases.configure(PurchasesConfiguration(apiKey));
      _initialized = true;

      Purchases.addCustomerInfoUpdateListener(_onCustomerInfoUpdated);
      final info = await Purchases.getCustomerInfo();
      _onCustomerInfoUpdated(info);
    } catch (e) {
      AppLogger.error('SubscriptionService: initialization failed', e);
    }
  }

  void _onCustomerInfoUpdated(CustomerInfo info) {
    isSubscribed.value = info.entitlements.active.containsKey(_entitlementId);
  }

  /// Fetches the current offerings (paywall packages) configured in the
  /// RevenueCat dashboard. Returns null if not initialized or on error.
  Future<Offerings?> getOfferings() async {
    if (!_initialized) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      AppLogger.error('SubscriptionService: getOfferings failed', e);
      return null;
    }
  }

  Future<PurchaseResult> purchasePackage(Package package) async {
    if (!_initialized) {
      return const PurchaseResult.failure('Subscriptions are not available.');
    }
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      _onCustomerInfoUpdated(result.customerInfo);
      return const PurchaseResult.success();
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        return const PurchaseResult.cancelled();
      }
      return PurchaseResult.failure(e.message ?? 'Purchase failed.');
    } catch (e) {
      return PurchaseResult.failure(e.toString());
    }
  }

  Future<PurchaseResult> restorePurchases() async {
    if (!_initialized) {
      return const PurchaseResult.failure('Subscriptions are not available.');
    }
    try {
      final info = await Purchases.restorePurchases();
      _onCustomerInfoUpdated(info);
      final restored = info.entitlements.active.containsKey(_entitlementId);
      return restored
          ? const PurchaseResult.success()
          : const PurchaseResult.failure('No previous purchase found.');
    } catch (e) {
      return PurchaseResult.failure(e.toString());
    }
  }
}

/// Outcome of a purchase/restore attempt, distinct from a plain bool so
/// the UI can tell a user-cancelled flow apart from a real failure.
class PurchaseResult {
  final bool success;
  final bool cancelled;
  final String? message;

  const PurchaseResult.success()
    : success = true,
      cancelled = false,
      message = null;

  const PurchaseResult.cancelled()
    : success = false,
      cancelled = true,
      message = null;

  const PurchaseResult.failure(this.message)
    : success = false,
      cancelled = false;
}
