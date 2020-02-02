import 'package:flutter/material.dart';
import 'package:flutter_state_cnprovider/ui/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'models/state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StateModel>(
      create: (context) => StateModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<StateModel>(builder: (context, state, child) {
        return LoadingScreen(
          showLoading: state.isLoading,
          child: Center(
            child: Text(
              state.toString(),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
        );
      }),
    );
  }
}
