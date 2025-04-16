import 'package:one_ai/pages/counter/counter_view.dart';
import 'package:one_ai/pages/home/home_view.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView),
  MaterialRoute(page: CounterView, initial: true,),
], 
dependencies: [
  Singleton(classType: NavigationService),
  LazySingleton(classType: CounterService),
])
class App {}