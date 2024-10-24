import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/helper.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/transaction_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/alert_dialog_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/button_loading_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/home_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';

class PaymentPage extends StatefulWidget {
  final Services? services;
  const PaymentPage({super.key, @required this.services});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController textEditingNominal = TextEditingController();

  @override
  void initState() {
    textEditingNominal = TextEditingController(
        text: MyHelper.formatCurrencyWithoutSymbol(
            widget.services!.serviceTariff!.toDouble()));
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
          'Pembayaran',
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
              "Pembayaran",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.services!.serviceIcon ?? "",
                  fit: BoxFit.contain,
                  width: 24,
                  height: 24,
                  placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  )),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/default-image.png",
                    fit: BoxFit.cover,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.services!.serviceName ?? "",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: textEditingNominal,
              cursorColor: themeColor,
              readOnly: true,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              decoration: inputDecoration(
                  'nominal',
                  const Icon(
                    Icons.money_rounded,
                    color: Colors.black,
                    size: 24,
                  )),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () {
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
                          Text(
                            'Beli ${widget.services!.serviceName!} senilai',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${MyHelper.formatCurrencyTopUp(widget.services!.serviceTariff!.toDouble())} ?",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Consumer<TransactionNotifier>(
                              builder: (context, data, child) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<TransactionNotifier>(context,
                                        listen: false)
                                    .posttransactionDetailProcess(
                                        widget.services!.serviceCode!)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (data.transactionDetailState ==
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
                                              'Pembayaran ${widget.services!.serviceName} sebesar',
                                              MyHelper.formatCurrencyTopUp(
                                                  widget
                                                      .services!.serviceTariff!
                                                      .toDouble()),
                                              'berhasil'),
                                        );
                                      },
                                    );
                                  }

                                  if (data.transactionDetailState ==
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
                                              'Pembayaran ${widget.services!.serviceName} sebesar',
                                              MyHelper.formatCurrencyTopUp(
                                                  widget
                                                      .services!.serviceTariff!
                                                      .toDouble()),
                                              'gagal'),
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                              child: data.transactionDetailState ==
                                      RequestState.Loading
                                  ? const ButtonLoadingWidget(color: themeColor)
                                  : const Text(
                                      'Ya, lanjutkan Bayar',
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
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Bayar',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
