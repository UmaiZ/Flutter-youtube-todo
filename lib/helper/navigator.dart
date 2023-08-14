import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget rn) {
    return navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => rn));
  }

  goBack() {
    return navigationKey.currentState!.pop();
  }

  //LETS CREATE LOADER ALSO IN THIS SERVICE

  showLoader() {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          });
    });
  }
}
