import 'package:one_ai/pages/chat/chat_view.dart';
import 'package:one_ai/pages/counter/counter_view.dart';
import 'package:one_ai/pages/home/home_view.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:one_ai/services/theme_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../pages/splash_screen/splash_screen_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: ChatView,)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: CounterService),
    LazySingleton(classType: ThemeService), 
  ],
)
class App {}
