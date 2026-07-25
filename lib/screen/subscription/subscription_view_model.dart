import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/subscription_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SubscriptionViewModel extends BaseViewModel{
  final navigationService = locator<NavigationService>();

  bool isAnnual = false;

  final List<SubscriptionPlan> _plans = [
    SubscriptionPlan(
      id: 'free',
      title: 'Free',
      subtitle: 'Get started with AI',
      icon: Icons.chat_bubble_outline_rounded,
      price: 'Free',
      duration: '',
      isCurrent: true,
      features: [
        '40 messages per day',
        'Nova Flash',
        'Basic image understanding',
        'Standard response speed',
        'Basic file upload',
      ],
    ),

    SubscriptionPlan(
      id: 'plus',
      title: 'Plus',
      subtitle: 'For curious minds',
      icon: Icons.bolt_rounded,
      badge: 'Popular',
      price: '\$9.99',
      duration: '/month',
      features: [
        '300 messages per day',
        'Nova Flash + Nova Pro',
        'Image generation',
        'Priority response speed',
        'File uploads',
        'Vision',
        'Web Search',
      ],
    ),

    SubscriptionPlan(
      id: 'pro',
      title: 'Pro',
      subtitle: 'For power users',
      icon: Icons.workspace_premium_outlined,
      badge: 'Best Value',
      isSelected: true,
      price: '\$19.99',
      duration: '/month',
      features: [
        'Unlimited messages',
        'All AI Models',
        'Advanced image tools',
        'Fastest responses',
        'Memory',
        'Code Interpreter',
        'Web Browsing',
        'Priority Support',
      ],
    ),

    SubscriptionPlan(
      id: 'max',
      title: 'Max',
      subtitle: 'Professionals & Teams',
      icon: Icons.all_inclusive_rounded,
      badge: 'Ultimate',
      price: '\$39.99',
      duration: '/month',
      features: [
        'Everything in Pro',
        '5× Usage Limits',
        'Early access',
        'Advanced Voice',
        'Team Workspace',
        'API Credits',
      ],
    ),
  ];

  List<SubscriptionPlan> get plans => _plans;

  void toggleBilling(bool annual) {
    isAnnual = annual;
    notifyListeners();
  }

  void selectPlan(String id) {
    for (var i = 0; i < _plans.length; i++) {
      _plans[i] = _plans[i].copyWith(
        isSelected: _plans[i].id == id,
      );
    }

    notifyListeners();
  }

}