import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_edit_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_login.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/profile_detail_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_image_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/button_loading_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/flushbar_widget.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingEmail = TextEditingController();
  TextEditingController textEditingFirstname = TextEditingController();
  TextEditingController textEditingLastname = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? foto;

  void _pickImage(PutProfileImageNotifier data) async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (cn) => AlertDialog(
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
        setState(() {
          foto = file;
        });

        int size = await file.length();

        if (size > 100000) {
          flushbarMessage('Maksimum ukuran file 100kb', themeColor)
              .show(context);
        } else {
          Provider.of<PutProfileImageNotifier>(context, listen: false)
              .putUserProcess(file)
              .then((value) {
            if (data.userImageState == RequestState.Loaded) {
              Future.microtask(() =>
                  Provider.of<ProfileDetailNotifier>(context, listen: false)
                      .fetchProfile());
              flushbarMessage(data.message, textNormalColor).show(context);
            }

            if (data.userImageState == RequestState.Error) {
              flushbarMessage(data.message, themeColor).show(context);
            }
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Akun',
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
          textEditingEmail = TextEditingController(text: data.user.data!.email);
          textEditingFirstname =
              TextEditingController(text: data.user.data!.firstName);
          textEditingLastname =
              TextEditingController(text: data.user.data!.lastName);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<PutProfileImageNotifier>(
                    builder: (context, dataImage, child) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        _pickImage(dataImage);
                      },
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: dataImage.userImageState == RequestState.Loading
                            ? const ButtonLoadingWidget(color: themeColor)
                            : Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data.user.data!.profileImage ?? "",
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(120),
                                              color: Colors.white,
                                            ),
                                            width: 120,
                                            height: 120,
                                          ),
                                        )),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                                child: Image.asset(
                                          "assets/images/profile-photo-1.png",
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 120,
                                        )),
                                      ),
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
                    textAlign: TextAlign.center,
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
                  readOnly: true,
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
                  readOnly: true,
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
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 48,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const EditProfilePage();
                    })).then((value) {
                      if (value) {
                        Provider.of<ProfileDetailNotifier>(context,
                                listen: false)
                            .fetchProfile();
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: themeColor)),
                    child: const Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: themeColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setString('token', '');
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }), (route) => false);
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Logout',
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
          );
        }

        return Container();
      }),
    );
  }
}
