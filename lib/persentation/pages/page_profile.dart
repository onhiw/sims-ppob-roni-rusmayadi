import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_edit_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_login.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/widgets/input_decoration.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final textEditingEmail = TextEditingController();
  final textEditingFirstname = TextEditingController();
  final textEditingLastname = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? foto;

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
      final file = await _picker.pickImage(source: imageSource, maxHeight: 420);
      if (file != null) {
        setState(() {
          foto = file;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Akun',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: CachedNetworkImage(
                            imageUrl: "",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(120),
                                  color: Colors.white,
                                ),
                                width: 120,
                                height: 120,
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
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300)),
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
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text(
                'Kristanto Wibowo',
                style: TextStyle(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfilePage();
                }));
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
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }), (route) => false);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(8)),
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
      ),
    );
  }
}
