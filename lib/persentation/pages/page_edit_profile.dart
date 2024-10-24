import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/profile_detail_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_image_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/button_loading_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/flushbar_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/loading_indicator.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController textEditingEmail = TextEditingController();
  TextEditingController textEditingFirstname = TextEditingController();
  TextEditingController textEditingLastname = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? foto;

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

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text(
                "Pilih sumber gambar",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: themeColor,
                    fontSize: 16),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text(
                    "Camera",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text(
                    "Gallery",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await _picker.pickImage(source: imageSource);
      if (file != null) {
        int size = await file.length();

        if (size > 100000) {
          flushbarMessage('Maksimum ukuran file 100kb', themeColor)
              .show(context);
        } else {
          setState(() {
            foto = file;
          });
        }
      }
    }
  }

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<ProfileDetailNotifier>(context, listen: false)
            .fetchProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.inter(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: Consumer<ProfileDetailNotifier>(builder: (context, data, child) {
          if (data.userState == RequestState.Loading) {
            return const Center(
              child: LoadingIndicator(),
            );
          }

          if (data.userState == RequestState.Error) {
            return Center(
              child: Text(data.message),
            );
          }

          if (data.userState == RequestState.Loaded) {
            textEditingEmail =
                TextEditingController(text: data.user.data!.email);
            textEditingFirstname =
                TextEditingController(text: data.user.data!.firstName);
            textEditingLastname =
                TextEditingController(text: data.user.data!.lastName);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<PutProfileImageNotifier>(
                        builder: (context, dataImage, child) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: dataImage.userImageState ==
                                    RequestState.Loading
                                ? const ButtonLoadingWidget(color: themeColor)
                                : Stack(
                                    children: [
                                      Center(
                                        child: foto == null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(120),
                                                child: CachedNetworkImage(
                                                  imageUrl: data.user.data!
                                                          .profileImage ??
                                                      "",
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child: Shimmer
                                                              .fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(120),
                                                        color: Colors.white,
                                                      ),
                                                      width: 120,
                                                      height: 120,
                                                    ),
                                                  )),
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      ClipRRect(
                                                          child: Image.asset(
                                                    "assets/images/profile-photo-1.png",
                                                    fit: BoxFit.cover,
                                                    width: 120,
                                                    height: 120,
                                                  )),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(120),
                                                child: FadeInImage(
                                                    fit: BoxFit.cover,
                                                    height: 120,
                                                    width: 120,
                                                    image: FileImage(
                                                        File(foto!.path)),
                                                    placeholder:
                                                        const AssetImage(
                                                      "assets/images/profile-photo-1.png",
                                                    )),
                                              ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey.shade300)),
                                          child: Center(
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text(
                        "${data.user.data!.firstName!} ${data.user.data!.lastName!}",
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: textEditingEmail,
                      cursorColor: themeColor,
                      readOnly: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration(
                          'masukan email anda',
                          const Icon(
                            Icons.alternate_email,
                            color: Colors.black,
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
                      height: 24,
                    ),
                    const Text(
                      'Nama Depan',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: textEditingFirstname,
                      cursorColor: themeColor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration(
                          'nama depan',
                          const Icon(
                            Icons.person_outline,
                            color: Colors.black,
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
                      height: 24,
                    ),
                    const Text(
                      'Nama Belakang',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: textEditingLastname,
                      cursorColor: themeColor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration(
                          'nama belakang',
                          const Icon(
                            Icons.person_outline,
                            color: Colors.black,
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
                      height: 48,
                    ),
                    Consumer<PutProfileNotifier>(
                        builder: (context, dataPutProfile, child) {
                      return GestureDetector(
                        onTap: () {
                          if (validates()) {
                            Provider.of<PutProfileNotifier>(context,
                                    listen: false)
                                .putUserProcess(textEditingFirstname.text,
                                    textEditingLastname.text, foto)
                                .then((value) {
                              if (dataPutProfile.userPutState ==
                                  RequestState.Loaded) {
                                Navigator.pop(context, true);
                                flushbarMessage(dataPutProfile.userPut.message!,
                                        textNormalColor)
                                    .show(context);
                              }

                              if (dataPutProfile.userPutState ==
                                  RequestState.Error) {
                                flushbarMessage(
                                        dataPutProfile.message, themeColor)
                                    .show(context);
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: dataPutProfile.userPutState ==
                                    RequestState.Loading
                                ? const ButtonLoadingWidget(color: Colors.white)
                                : const Text(
                                    'Simpan',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: themeColor)),
                        child: const Center(
                          child: Text(
                            'Batalkan',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: themeColor,
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

          return Container();
        }),
      ),
    );
  }
}
