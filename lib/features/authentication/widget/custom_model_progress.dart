import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomModalProgressHUD extends StatelessWidget {
  const CustomModalProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.progressIndicator = const CustomLoadingIndicator(),
  }) : super(key: key);

  final Widget child;
  final bool inAsyncCall;
  final Widget progressIndicator;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      key: key,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: progressIndicator,
      inAsyncCall: inAsyncCall,
      child: child,
    );
  }
}

/// Text must provide white text color
class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    Key? key,
    this.child = const CupertinoActivityIndicator(radius: 14),
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme:
            const CupertinoThemeData(brightness: Brightness.dark),
        
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black.withOpacity(0.9),
        ),
        padding: const EdgeInsets.all(14),
        child: child,
      ),
    );
  }
}