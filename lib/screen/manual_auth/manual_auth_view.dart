import 'package:flutter/material.dart';
import 'package:one_ai/screen/manual_auth/manual_auth_view_model.dart';
import 'package:stacked/stacked.dart';

class ManualAuthView extends StatelessWidget {
  const ManualAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ManualAuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Placeholder()
        );
      },
    );
  }
}
