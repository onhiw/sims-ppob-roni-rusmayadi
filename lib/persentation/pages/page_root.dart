import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_login.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/auth_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/home_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/loading_indicator.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildProgressIndicator() {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoadingIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isLogin();

    return Consumer<AuthProvider>(
      builder: (context, data, child) {
        if (data.isLoggedIn) {
          return const HomeWidget();
        }
        if (!data.isLoggedIn) {
          return const LoginPage();
        }
        return buildProgressIndicator();
      },
    );
  }
}
