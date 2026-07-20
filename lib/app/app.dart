import 'package:one_ai/screen/chat/chat_view.dart';
import 'package:one_ai/screen/counter/counter_view.dart';
import 'package:one_ai/screen/home/home_view.dart';
import 'package:one_ai/screen/model_selection/model_select_view.dart';
import 'package:one_ai/screen/user_profile/user_profile_view.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:one_ai/services/theme_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../screen/splash_screen/splash_screen_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: ChatView,),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: ModelSelectView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: CounterService),
    LazySingleton(classType: ThemeService), 
    LazySingleton(classType: ModelSelectionService),
  ],
)
class App {}
