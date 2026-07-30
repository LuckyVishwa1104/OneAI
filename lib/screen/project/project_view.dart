import 'package:flutter/material.dart';
import 'package:one_ai/screen/project/project_view_model.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:stacked/stacked.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectViewModel>.reactive(viewModelBuilder: () => ProjectViewModel(),
    builder: (context, model, child){
      return Scaffold(
        appBar: AppBarComponent(isAction: false, title: "Projects",),
        body: Column(
          children: [

          ],
        ),
      );
    },
    );
  }
}