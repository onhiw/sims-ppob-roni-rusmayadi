import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';

InputDecoration inputDecoration(String hint, Icon iconPrefix) =>
    InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      errorStyle: const TextStyle(
        color: themeColor,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      contentPadding:
          const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
      prefixIcon: iconPrefix,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: themeColor)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: themeColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: themeColor)),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
