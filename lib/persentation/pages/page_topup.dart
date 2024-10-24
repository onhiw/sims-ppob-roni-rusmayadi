import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/helper.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/topup_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/alert_dialog_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/button_loading_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/flushbar_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/home_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController textEditingNominal = TextEditingController();
  int? currentIndex;
  List<int> nominalList = [10000, 20000, 50000, 100000, 250000, 500000];

  int currentNominal = 0;

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<BalanceNotifier>(context, listen: false).fetchBalance());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Top Up',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/background-saldo.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Saldo anda",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Consumer<BalanceNotifier>(
                            builder: (context, data, child) {
                          if (data.balanceState == RequestState.Loaded) {
                            return Text(
                              MyHelper.formatCurrency(
                                  data.balance.data!.balance!.toDouble()),
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            );
                          }

                          return Text(
                            "Rp",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Silahkan masukan",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const Text(
              "Nominal Top Up",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: textEditingNominal,
              cursorColor: themeColor,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    currentIndex = null;
                    currentNominal = int.parse(
                        value.replaceAll('.', '').replaceAll(',', ''));
                    textEditingNominal.text =
                        MyHelper.formatCurrencyTopUp(double.parse(value));
                  });
                }
              },
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              decoration: inputDecoration(
                  'masukan nominal',
                  Icon(
                    Icons.money_rounded,
                    color: Colors.grey.shade300,
                    size: 24,
                  )),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(
              height: 24,
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2),
              itemCount: nominalList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      currentNominal = nominalList[index];
                      textEditingNominal.text = MyHelper.formatCurrencyTopUp(
                          nominalList[index].toDouble());
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1,
                            color: currentIndex == null
                                ? Colors.grey.shade300
                                : index == currentIndex
                                    ? themeColor
                                    : Colors.grey.shade300)),
                    child: Center(
                      child: Text(
                        MyHelper.formatCurrencyTopUp(
                            nominalList[index].toDouble()),
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                if (currentNominal == 0) {
                  flushbarMessage(
                          'Anda belum memilih atau mengisi nominal', themeColor)
                      .show(context);
                } else if (currentNominal < 10000) {
                  flushbarMessage('Minimal Top Up Rp. 10.000', themeColor)
                      .show(context);
                } else if (currentNominal > 1000000) {
                  flushbarMessage('Maksimal Top Up Rp. 1.00.000', themeColor)
                      .show(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/logos/logo.png', width: 72),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Anda yakin untuk Top Up sebesar',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${MyHelper.formatCurrencyTopUp(currentNominal.toDouble())} ?",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Consumer<TopUpNotifier>(
                                builder: (context, data, child) {
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<TopUpNotifier>(context,
                                          listen: false)
                                      .postTopUpProcess(currentNominal)
                                      .then((value) {
                                    Navigator.pop(context);
                                    if (data.messageState ==
                                        RequestState.Loaded) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return WillPopScope(
                                            onWillPop: () async {
                                              Navigator.pushAndRemoveUntil(
                                                  context, MaterialPageRoute(
                                                      builder: (context) {
                                                return const HomeWidget();
                                              }), (route) => false);
                                              return true;
                                            },
                                            child: alertDialog(
                                                context,
                                                'assets/icons/ic_checklist.png',
                                                'Top Up sebesar',
                                                MyHelper.formatCurrencyTopUp(
                                                    currentNominal.toDouble()),
                                                data.message.message!),
                                          );
                                        },
                                      );
                                    }

                                    if (data.messageState ==
                                        RequestState.Error) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return WillPopScope(
                                            onWillPop: () async {
                                              Navigator.pushAndRemoveUntil(
                                                  context, MaterialPageRoute(
                                                      builder: (context) {
                                                return const HomeWidget();
                                              }), (route) => false);
                                              return true;
                                            },
                                            child: alertDialog(
                                                context,
                                                'assets/icons/ic_cross.png',
                                                'Top Up sebesar',
                                                MyHelper.formatCurrencyTopUp(
                                                    currentNominal.toDouble()),
                                                data.messageErr),
                                          );
                                        },
                                      );
                                    }
                                  });
                                },
                                child: data.messageState == RequestState.Loading
                                    ? const ButtonLoadingWidget(
                                        color: themeColor)
                                    : const Text(
                                        'Ya, lanjutkan Top Up',
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                              );
                            }),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Batalkan',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: currentIndex != null ||
                            textEditingNominal.text.isNotEmpty
                        ? themeColor
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Top Up',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
