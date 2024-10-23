import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_roni_rusmayadi/common/utils.dart';
import 'package:sims_ppob_roni_rusmayadi/injection.dart' as di;
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_root.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/banner_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/services_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/login_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/profile_detail_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_image_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/register_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/history_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/topup_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/transaction_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<ProfileDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<LoginNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RegisterNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PutProfileNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PutProfileImageNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<BannerNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ServicesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<BalanceNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<HistoryNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopUpNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TransactionNotifier>(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SIMS PPOB App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const Root());
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          }),
    );
  }
}
