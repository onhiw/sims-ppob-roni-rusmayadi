import 'package:flutter/material.dart';

class ButtonLoadingWidget extends StatelessWidget {
  final Color? color;
  const ButtonLoadingWidget({super.key, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20.0,
        width: 20.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color!),
        ),
      ),
    );
  }
}
