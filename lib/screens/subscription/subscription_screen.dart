import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../themes/app_colors.dart';
import '../../services/subscription_service.dart';
import '../../l10n/generated/app_localizations.dart';

/// Paywall screen showing RevenueCat's configured offerings. Prices are
/// shown via `storeProduct.priceString`, which the App Store/Play Store
/// already formats for the user's own region/currency - no manual
/// currency handling needed here.
///
/// Which content this gates is a product decision left to the app owner;
/// this screen only implements the purchase mechanism itself. Wire a
/// check against `SubscriptionService().isSubscribed.value` wherever a
/// feature should require an active subscription.
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  Offerings? _offerings;
  bool _isLoading = true;
  String? _purchasingPackageId;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    final offerings = await SubscriptionService().getOfferings();
    if (!mounted) return;
    setState(() {
      _offerings = offerings;
      _isLoading = false;
    });
  }

  Future<void> _purchase(Package package) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _purchasingPackageId = package.identifier);
    final result = await SubscriptionService().purchasePackage(package);
    if (!mounted) return;
    setState(() => _purchasingPackageId = null);

    if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.subscriptionPurchaseSuccessMessage)),
      );
      Navigator.of(context).pop();
    } else if (result.cancelled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.subscriptionPurchaseCancelledMessage)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.subscriptionPurchaseFailedMessage(
              result.message ?? l10n.unknownErrorMessage,
            ),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _restore() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await SubscriptionService().restorePurchases();
    if (!mounted) return;

    if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.subscriptionRestoreSuccessMessage)),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.subscriptionRestoreFailedMessage(
              result.message ?? l10n.unknownErrorMessage,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.subscriptionTitle)),
      body: ValueListenableBuilder<bool>(
        valueListenable: SubscriptionService().isSubscribed,
        builder: (context, isSubscribed, _) {
          if (isSubscribed) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.subscriptionAlreadyActiveMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          }

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final packages = _offerings?.current?.availablePackages ?? [];
          if (packages.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.subscriptionNoOfferingsMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Icon(Icons.auto_stories, color: AppColors.primary, size: 56),
              const SizedBox(height: 12),
              Text(
                l10n.subscriptionUnlockPremium,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              for (final package in packages)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      title: Text(package.storeProduct.title),
                      subtitle: Text(package.storeProduct.description),
                      trailing:
                          _purchasingPackageId == package.identifier
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                package.storeProduct.priceString,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      onTap:
                          _purchasingPackageId == null
                              ? () => _purchase(package)
                              : null,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _restore,
                child: Text(l10n.subscriptionRestoreButton),
              ),
            ],
          );
        },
      ),
    );
  }
}
