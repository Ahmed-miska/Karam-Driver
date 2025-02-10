import 'package:app_links/app_links.dart';
import 'package:get/get.dart';

class AppLinkService {
  final AppLinks appLinks = AppLinks();

  Future<void> initialize() async {
    // Check for initial deep link when the app is launched
    try {
      final Uri? initialUri = await appLinks.getInitialLink();
      if (initialUri != null) {
        await _handleDeepLink(initialUri);
      }
    } catch (err) {
      print('Failed to get initial link: $err');
    }
    // Listen for deep link changes while the app is running
    appLinks.uriLinkStream.listen(
      (Uri? uri) async {
        if (uri != null) {
          await _handleDeepLink(uri);
        }
      },
      onError: (err) {
        print('Failed to receive deep link: $err');
      },
    );
  }

  Future<void> _handleDeepLink(Uri uri) async {
    String? path = uri.path; // Use nullable String for safety
    var parameters = uri.queryParameters;

    // Debugging: Log the URI and parameters
    print('Received deep link: $uri');
    print('Path: $path');
    print('Parameters: $parameters');

    // Ensure path is not null or empty
    if (path.isEmpty) {
      print('Error: Deep link path is null or empty');
      return;
    }

    // Navigate to the route
    try {
      Get.toNamed(path, parameters: parameters);
    } catch (e) {
      print('Error during navigation: $e');
    }
  }
}
