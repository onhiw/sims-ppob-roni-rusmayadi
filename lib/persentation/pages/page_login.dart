import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_register.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/auth_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/login_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/button_loading_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/home_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidePassword = true;
  final textEditingEmail = TextEditingController();
  final textEditingPassword = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 150,
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
                  'Masuk atau buat akun\nuntuk memulai',
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
                  hintText: "masukan password anda",
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
                height: 24,
              ),
              Consumer<LoginNotifier>(builder: (context, data, child) {
                return GestureDetector(
                  onTap: () {
                    if (data.loginState != RequestState.Loading) {
                      if (validates()) {
                        Future.microtask(() =>
                            Provider.of<LoginNotifier>(context, listen: false)
                                .postLoginProcess(textEditingEmail.text,
                                    textEditingPassword.text)
                                .then((value) {
                              if (Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .isLoggedIn) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeWidget();
                                  }), (route) => false);
                                });
                              }
                            }));
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: data.loginState == RequestState.Loading
                          ? const ButtonLoadingWidget(color: Colors.white)
                          : const Text(
                              'Masuk',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 24,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'belum punya akun? register ',
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegisterPage();
                          }));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
