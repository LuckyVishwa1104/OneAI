// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:one_ai/screen/all_chat/all_chat_view.dart' as _i9;
import 'package:one_ai/screen/chat/chat_view.dart' as _i4;
import 'package:one_ai/screen/home/home_view.dart' as _i2;
import 'package:one_ai/screen/model_selection/model_select_view.dart' as _i6;
import 'package:one_ai/screen/project/project_view.dart' as _i8;
import 'package:one_ai/screen/signup/signup_view.dart' as _i3;
import 'package:one_ai/screen/subscription/subscription_view.dart' as _i7;
import 'package:one_ai/screen/user_profile/user_profile_view.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const homeView = '/home-view';

  static const signupView = '/';

  static const chatView = '/chat-view';

  static const userProfileView = '/user-profile-view';

  static const modelSelectView = '/model-select-view';

  static const subscriptionView = '/subscription-view';

  static const projectView = '/project-view';

  static const allChatView = '/all-chat-view';

  static const all = <String>{
    homeView,
    signupView,
    chatView,
    userProfileView,
    modelSelectView,
    subscriptionView,
    projectView,
    allChatView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.homeView, page: _i2.HomeView),
    _i1.RouteDef(Routes.signupView, page: _i3.SignupView),
    _i1.RouteDef(Routes.chatView, page: _i4.ChatView),
    _i1.RouteDef(Routes.userProfileView, page: _i5.UserProfileView),
    _i1.RouteDef(Routes.modelSelectView, page: _i6.ModelSelectView),
    _i1.RouteDef(Routes.subscriptionView, page: _i7.SubscriptionView),
    _i1.RouteDef(Routes.projectView, page: _i8.ProjectView),
    _i1.RouteDef(Routes.allChatView, page: _i9.AllChatView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(key: args.key),
        settings: data,
      );
    },
    _i3.SignupView: (data) {
      final args = data.getArgs<SignupViewArguments>(
        orElse: () => const SignupViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.SignupView(key: args.key),
        settings: data,
      );
    },
    _i4.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(
        orElse: () => const ChatViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder:
            (context) =>
                _i4.ChatView(key: args.key, initialPrompt: args.initialPrompt),
        settings: data,
      );
    },
    _i5.UserProfileView: (data) {
      final args = data.getArgs<UserProfileViewArguments>(
        orElse: () => const UserProfileViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.UserProfileView(key: args.key),
        settings: data,
      );
    },
    _i6.ModelSelectView: (data) {
      final args = data.getArgs<ModelSelectViewArguments>(
        orElse: () => const ModelSelectViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.ModelSelectView(key: args.key),
        settings: data,
      );
    },
    _i7.SubscriptionView: (data) {
      final args = data.getArgs<SubscriptionViewArguments>(
        orElse: () => const SubscriptionViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.SubscriptionView(key: args.key),
        settings: data,
      );
    },
    _i8.ProjectView: (data) {
      final args = data.getArgs<ProjectViewArguments>(
        orElse: () => const ProjectViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ProjectView(key: args.key),
        settings: data,
      );
    },
    _i9.AllChatView: (data) {
      final args = data.getArgs<AllChatViewArguments>(
        orElse: () => const AllChatViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AllChatView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupViewArguments {
  const SignupViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChatViewArguments {
  const ChatViewArguments({this.key, this.initialPrompt});

  final _i10.Key? key;

  final String? initialPrompt;

  @override
  String toString() {
    return '{"key": "$key", "initialPrompt": "$initialPrompt"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.initialPrompt == initialPrompt;
  }

  @override
  int get hashCode {
    return key.hashCode ^ initialPrompt.hashCode;
  }
}

class UserProfileViewArguments {
  const UserProfileViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant UserProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ModelSelectViewArguments {
  const ModelSelectViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ModelSelectViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SubscriptionViewArguments {
  const SubscriptionViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SubscriptionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProjectViewArguments {
  const ProjectViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProjectViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AllChatViewArguments {
  const AllChatViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AllChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignupView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupView,
      arguments: SignupViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChatView({
    _i10.Key? key,
    String? initialPrompt,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.chatView,
      arguments: ChatViewArguments(key: key, initialPrompt: initialPrompt),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToUserProfileView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.userProfileView,
      arguments: UserProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToModelSelectView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.modelSelectView,
      arguments: ModelSelectViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSubscriptionView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.subscriptionView,
      arguments: SubscriptionViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProjectView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.projectView,
      arguments: ProjectViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAllChatView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.allChatView,
      arguments: AllChatViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignupView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupView,
      arguments: SignupViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChatView({
    _i10.Key? key,
    String? initialPrompt,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.chatView,
      arguments: ChatViewArguments(key: key, initialPrompt: initialPrompt),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithUserProfileView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.userProfileView,
      arguments: UserProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithModelSelectView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.modelSelectView,
      arguments: ModelSelectViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSubscriptionView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.subscriptionView,
      arguments: SubscriptionViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithProjectView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.projectView,
      arguments: ProjectViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAllChatView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.allChatView,
      arguments: AllChatViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
