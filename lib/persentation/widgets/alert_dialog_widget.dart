import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/home_widget.dart';

AlertDialog alertDialog(BuildContext context, String image, String title,
        String nominal, String message) =>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image, width: 72),
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            nominal,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeWidget();
              }), (route) => false);
            },
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(
                  color: themeColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
