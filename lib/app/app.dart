import 'package:one_ai/screen/chat/chat_view.dart';
import 'package:one_ai/screen/home/home_view.dart';
import 'package:one_ai/screen/model_selection/model_select_view.dart';
import 'package:one_ai/screen/project/project_view.dart';
import 'package:one_ai/screen/signup/signup_view.dart';
import 'package:one_ai/screen/subscription/subscription_view.dart';
import 'package:one_ai/screen/user_profile/user_profile_view.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:one_ai/services/theme_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SignupView, initial: true),
    MaterialRoute(page: ChatView,),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: ModelSelectView),
    MaterialRoute(page: SubscriptionView),
    MaterialRoute(page: ProjectView),

  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: ThemeService), 
    LazySingleton(classType: ModelSelectionService),
  ],
)
class App {}
