import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'counter_view_model.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CounterViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Counter Screen')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(model.counterService.counterValue.toString()),
                // SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    model.addValue();
                  },
                  child: Text('Increase counter'),
                ),
                // SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    model.navigateToHome();
                  },
                  child: Text('Home Screen'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
