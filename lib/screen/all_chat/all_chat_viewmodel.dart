import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AllChatViewmodel extends BaseViewModel{
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();

  final TextEditingController searchController = TextEditingController();

  void navToNewChat(){
    navigationService.navigateToChatView();
  }


}