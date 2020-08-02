import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomLoadingWidget({@required this.child, @required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: child,
      isLoading: isLoading,
      color: Theme.of(context).primaryColor,
    );
  }
}
