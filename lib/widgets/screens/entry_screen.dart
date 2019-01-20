import 'package:flutter/material.dart';
import 'package:harpy/core/utils/harpy_navigator.dart';
import 'package:harpy/models/application_model.dart';
import 'package:harpy/models/login_model.dart';
import 'package:harpy/theme.dart';
import 'package:harpy/widgets/screens/home_screen.dart';
import 'package:harpy/widgets/screens/login_screen.dart';
import 'package:logging/logging.dart';

/// The screen shown during the start of the app.
///
/// A 'splash screen' with the title will be drawn during initialization.
///
/// After initialization the [EntryScreen] will navigate to the [LoginScreen] or
/// skip to the [HomeScreen] if the user is already logged in
class EntryScreen extends StatelessWidget {
  static final Logger _log = Logger("EntryScreen");

  @override
  Widget build(BuildContext context) {
    final applicationModel = ApplicationModel.of(context);

    applicationModel.onInitialized = () {
      _onInitialized(context, applicationModel);
    };

    return Material(
      color: HarpyTheme.harpyColor,
    );
  }

  Future<void> _onInitialized(
    BuildContext context,
    ApplicationModel model,
  ) async {
    _log.fine("on initialized");

    if (model.loggedIn) {
      final loginModel = LoginModel.of(context);
      await loginModel.initBeforeHome();

      _log.fine("navigating to home screen");
      HarpyNavigator.push(context, HomeScreen());
    } else {
      _log.fine("navigating to login screen");
      // route without a transition
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, _a, _b) => LoginScreen(),
        transitionDuration: Duration.zero,
      ));
    }
  }
}
