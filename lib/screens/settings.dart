import 'dart:io';
import 'package:fake_instagram/models/settingsmodel.dart';
import 'package:fake_instagram/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/instagrammodel.dart';
import '../utils/const.dart';
import '../utils/customspacewidget.dart';
import '../utils/feildcontainer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  InstagramModel instagramModel = InstagramModel.empty();

  String? pickedProfile;
  final TextEditingController username = TextEditingController();
  final TextEditingController location = TextEditingController();
  SettingsModel settingsModel = SettingsModel.empty();

  //Profile Photo Functions
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Upload Your Profile Photo",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickProfile(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickProfile(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickProfile(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempProfile = File(photo.path);
      setState(() {
        pickedProfile = tempProfile.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomePage())));
              });
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
          title: const Text(
            "Add New Profile",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                settingsModel.location = location.text.trim();
                settingsModel.pickedProfile = pickedProfile!;
                settingsModel.username = username.text.trim();

                const snackBar = SnackBar(
                  content: Text(
                    'Saved!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                setState(() {
                  Get.to(const HomePage());
                });
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
              ),
              child: const Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: ClipOval(
                      child: pickedProfile == null
                          ? const SizedBox(
                              width: 120,
                              height: 120,
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                            )
                          : Image.file(
                              File(pickedProfile!),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: imagePickerOption,
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: customBlue,
                        ),
                        child: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const CustomSpaceWidget(),
              FieldContiner(
                onChange: (value) {
                  if (mounted) {
                    setState(() {
                      settingsModel.username = value;
                    });
                  }
                },
                hinttexts: "username",
                lengthoftext: 25,
                isSpace: true,
              ),
              FieldContiner(
                onChange: (value) {
                  if (mounted) {
                    setState(() {
                      settingsModel.location = value;
                    });
                  }
                },
                hinttexts: "Location",
                lengthoftext: 30,
                isSpace: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
