import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await checkPermission(Permission.storage, context);
        },
        child: const Text("Check Permission"),
      ),
    );
  }
}

Future<bool> checkPermission(
  Permission permission,
  BuildContext context,
) async {
  final status = await permission.request();
  if (status.isGranted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    return true;
  } else if (status.isPermanentlyDenied) {
    // Show dialog to open app settings
    await showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
              'Storage permission is permanently denied. Please enable it in app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
    );
    return false;
  } else {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Permission is not Granted")));
    return false;
  }
}
