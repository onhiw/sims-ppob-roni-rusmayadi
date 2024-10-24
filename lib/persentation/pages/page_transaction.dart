import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/helper.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/history_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/loading_indicator.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<BalanceNotifier>(context, listen: false).fetchBalance());
    Future.microtask(() => Provider.of<HistoryNotifier>(context, listen: false)
        .fetchhistory(0, 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Transaksi',
          style: TextStyle(
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
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            );
                          }

                          return const Text(
                            "Rp",
                            style: TextStyle(
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
              "Transaksi",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<HistoryNotifier>(
              builder: (context, data, child) {
                if (data.historyState == RequestState.Empty) {
                  return const Center(
                    child: Text('Maaf tidak ada history transaksi saat ini'),
                  );
                }

                if (data.historyState == RequestState.Loading) {
                  return const Center(
                    child: LoadingIndicator(),
                  );
                }

                if (data.historyState == RequestState.Error) {
                  return Center(
                    child: Text(data.message),
                  );
                }

                if (data.historyState == RequestState.Loaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...data.history.data!.records!
                          .map((transaction) => Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade300)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (transaction.transactionType ==
                                                      "TOPUP"
                                                  ? "+ "
                                                  : "- ") +
                                              MyHelper.formatCurrency(
                                                      transaction.totalAmount!
                                                          .toDouble())
                                                  .replaceAll(' ', ''),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  transaction.transactionType ==
                                                          "TOPUP"
                                                      ? textNormalColor
                                                      : textMinusColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          transaction.description ?? "-",
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      transaction.createdOn == null
                                          ? "-"
                                          : MyHelper.formatDateHms(
                                              transaction.createdOn!),
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ))
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
