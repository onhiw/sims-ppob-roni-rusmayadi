import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_login.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHidePassword = true;
  bool _isHidePasswordConfirm = true;
  final textEditingEmail = TextEditingController();
  final textEditingFirstname = TextEditingController();
  final textEditingLastname = TextEditingController();
  final textEditingPassword = TextEditingController();
  final textEditingPasswordConfirm = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool validates() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void togglePasswordVisibilityConfirm() {
    setState(() {
      _isHidePasswordConfirm = !_isHidePasswordConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logos/logo.png',
                      width: 32,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'SIMS PPOB',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Center(
                  child: Text(
                    'Lengkap data untuk\nmembuat akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: textEditingEmail,
                  cursorColor: themeColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: inputDecoration(
                      'masukan email anda',
                      Icon(
                        Icons.alternate_email,
                        color: Colors.grey.shade300,
                        size: 24,
                      )),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: textEditingFirstname,
                  cursorColor: themeColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: inputDecoration(
                      'nama depan',
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey.shade300,
                        size: 24,
                      )),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: textEditingLastname,
                  cursorColor: themeColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: inputDecoration(
                      'nama belakang',
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey.shade300,
                        size: 24,
                      )),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: textEditingPassword,
                  cursorColor: themeColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "buat password",
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
                    contentPadding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: Colors.grey.shade300,
                      ),
                      onPressed: null,
                    ),
                    suffixIcon: _isHidePassword
                        ? IconButton(
                            icon: Icon(
                              Icons.visibility_off_outlined,
                              size: 24,
                              color: Colors.grey.shade300,
                            ),
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.visibility_outlined,
                              size: 24,
                              color: Colors.grey.shade300,
                            ),
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                          ),
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
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isHidePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: textEditingPasswordConfirm,
                  cursorColor: themeColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "konfirmasi password",
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
                    contentPadding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: Colors.grey.shade300,
                      ),
                      onPressed: null,
                    ),
                    suffixIcon: _isHidePasswordConfirm
                        ? IconButton(
                            icon: Icon(
                              Icons.visibility_off_outlined,
                              size: 24,
                              color: Colors.grey.shade300,
                            ),
                            onPressed: () {
                              togglePasswordVisibilityConfirm();
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.visibility_outlined,
                              size: 24,
                              color: Colors.grey.shade300,
                            ),
                            onPressed: () {
                              togglePasswordVisibilityConfirm();
                            },
                          ),
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
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak boleh kosong";
                    } else if (val != textEditingPassword.text) {
                      return "konfirmasi password tidak sama";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isHidePasswordConfirm,
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    if (validates()) {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }), (route) => false);
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Registrasi',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'sudah punya akun? login ',
                        style: GoogleFonts.inter(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: 'disini',
                        style: GoogleFonts.inter(
                          color: themeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
