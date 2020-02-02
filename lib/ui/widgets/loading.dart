import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  final bool showLoading;
  final double opacity;
  final Color color;
  final bool dismissible;
  final Widget child;

  LoadingScreen({
    Key key,
    @required this.showLoading,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(showLoading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (showLoading) {
      Widget layOutProgressIndicator;
      layOutProgressIndicator = Center(
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                //color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              //need this due to bug...https://github.com/flutter/flutter/issues/18399
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 80.0,
                  ),
                  height: 80.0,
                  width: 80.0,
                ),
              )));
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
