import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Home Screen')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(model.counterService.counterValue.toString()),
                ElevatedButton(
                  onPressed: () {
                    model.addValues();
                  },
                  child: Text('Increase Counter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    model.navigateToCounter();
                  },
                  child: Text('Counter Screen'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
