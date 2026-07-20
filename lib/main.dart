import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/app/app_theme.dart';
import 'package:one_ai/firebase_options.dart';
import 'package:one_ai/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  await locator<ThemeService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAppViewModel>.reactive(
      viewModelBuilder: () => MyAppViewModel(),
      builder:
          (context, model, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: model.themeMode, // ← reactive
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
          ),
    );
  }
}

class MyAppViewModel extends ReactiveViewModel {
  final _themeService = locator<ThemeService>();
  ThemeMode get themeMode => _themeService.themeMode;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];
}
