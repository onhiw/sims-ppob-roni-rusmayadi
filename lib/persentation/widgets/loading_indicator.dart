import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const widget = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          const SizedBox(
            height: 8,
          ),
          Text(
            "Mohon Tunggu...",
            style: TextStyle(
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : subTextColor),
          )
        ],
      )),
    );
  }
}
