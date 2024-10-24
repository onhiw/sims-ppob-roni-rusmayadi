import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_ppob_roni_rusmayadi/common/helper.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_payment.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/banner_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/services_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/profile_detail_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSaldo = false;

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<ProfileDetailNotifier>(context, listen: false)
            .fetchProfile());
    Future.microtask(() =>
        Provider.of<BalanceNotifier>(context, listen: false).fetchBalance());
    Future.microtask(() =>
        Provider.of<ServicesNotifier>(context, listen: false).fetchServices());
    Future.microtask(() =>
        Provider.of<BannerNotifier>(context, listen: false).fetchBanner());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    'assets/logos/logo.png',
                    width: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'SIMS PPOB',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Consumer<ProfileDetailNotifier>(builder: (context, data, child) {
              if (data.userState == RequestState.Loaded) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: data.user.data!.profileImage ?? "",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        width: 30,
                        height: 30,
                      ),
                    )),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                        child: Image.asset(
                      "assets/images/profile-photo.png",
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    )),
                  ),
                );
              }

              return Container();
            })
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ProfileDetailNotifier>(
                      builder: (context, data, child) {
                    if (data.userState == RequestState.Loaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat datang,",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${data.user.data!.firstName!} ${data.user.data!.lastName!}",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            'assets/images/background-saldo.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 150,
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
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        showSaldo
                                            ? MyHelper.formatCurrency(data
                                                .balance.data!.balance!
                                                .toDouble())
                                            : "Rp. •••••••••",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showSaldo = !showSaldo;
                                          });
                                        },
                                        child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Lihat Saldo",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.remove_red_eye_outlined,
                                              size: 14,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Consumer<ServicesNotifier>(builder: (context, data, child) {
              if (data.servicesState == RequestState.Loading) {
                return const Center(
                  child: LoadingIndicator(),
                );
              }

              if (data.servicesState == RequestState.Loaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.7),
                  itemCount: data.services.data!.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PaymentPage(
                              services: data.services.data![index]);
                        }));
                      },
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                data.services.data![index].serviceIcon ?? "",
                            fit: BoxFit.contain,
                            width: 42,
                            height: 42,
                            placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 42,
                              height: 42,
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
                              width: 42,
                              height: 42,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            data.services.data![index].serviceName!
                                .replaceAll(' Berlangganan', ''),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 10.0, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }

              return Container();
            }),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Temukan Promo Menarik",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<BannerNotifier>(builder: (context, data, child) {
              if (data.bannerState == RequestState.Empty) {
                return const Center(
                  child: Text('belum ada promo menarik saat ini'),
                );
              }

              if (data.bannerState == RequestState.Loading) {
                return const Center(
                  child: LoadingIndicator(),
                );
              }

              if (data.bannerState == RequestState.Error) {
                return Center(
                  child: Text(data.message),
                );
              }
              if (data.bannerState == RequestState.Loaded) {
                return SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...data.banner.data!.map((banner) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: banner.bannerImage ?? "",
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                    ),
                                  )),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/images/default-image.png",
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          )),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }

              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
