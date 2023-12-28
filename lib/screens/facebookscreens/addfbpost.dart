import 'dart:io';
import 'package:fake_instagram/models/facebookmodel.dart';
import 'package:fake_instagram/screens/facebookscreens/facebookpreview.dart';
import 'package:fake_instagram/utils/customsliderdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';
import '../../utils/customspacewidget.dart';
import '../../utils/feildcontainer.dart';
import '../../utils/native_app_dialogue.dart';
import 'fbmainscreen.dart';

// ignore: must_be_immutable
class AddFBPost extends StatefulWidget {
  const AddFBPost({Key? key}) : super(key: key);

  @override
  State<AddFBPost> createState() => _AddFBPostState();
}

class _AddFBPostState extends State<AddFBPost> {
  // bool value = false;
  // double fblike = 0;
  // double fbcomments = 0;
  // bool story = false;
  // bool verifyUser = false;
  // final TextEditingController _username = TextEditingController();
  // final TextEditingController _caption = TextEditingController();
  // final TextEditingController _faketime = TextEditingController();
  // final TextEditingController _location = TextEditingController();
  // final TextEditingController _friendname = TextEditingController();
  // String? pickedfbProfile;
  // String? pickedfbPost;
  FacebookModel fbmodel = FacebookModel.empty();

  //Profile Photo Functions
  void fbimagePickerOption() {
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
                      pickfbProfile(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickfbProfile(ImageSource.gallery);
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

  pickfbProfile(ImageSource imageType) async {
    try {
      final fbphoto = await ImagePicker().pickImage(source: imageType);
      if (fbphoto == null) return;
      final tempfbProfile = File(fbphoto.path);
      setState(() {
        fbmodel.pickedfbProfile = tempfbProfile.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Post Photo Functions
  void fbpostPickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Upload Your Post",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickfbpost(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickfbpost(ImageSource.gallery);
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

  pickfbpost(ImageSource imageType) async {
    try {
      final fbphoto = await ImagePicker().pickImage(source: imageType);
      if (fbphoto == null) return;
      setState(() {
        fbmodel.pickedfbPost = fbphoto.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Show Error msg
  void currentMsg() {
    if (fbmodel.pickedfbProfile!.isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Profile picture is required',
        "Ok",
        () async {},
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.username!.trim().isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Username is required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.pickedfbPost!.isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Post picture is required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.fblike!.toDouble().round() == 0) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Liked counts are required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.fbcomments!.toDouble().round() == 0) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Comments count are required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.friendname!.trim().isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Friend name is required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }
    if (fbmodel.faketime!.trim().isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Time of post is required',
        "Ok",
        () async {
          return;
        },
        firstActionStyle: ActionStyle.destructive,
        secondButtonText: "",
        secondCallback: () => {},
      );
      return;
    }

    Get.to(
      () => FbMainScreen(fbmodel: fbmodel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
          title: const Text(
            "Add New Post",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(
                    () => FbPreview(fbmodel: fbmodel),
                  );
                },
                child: const Icon(Icons.remove_red_eye_outlined)),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                currentMsg();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const CustomSpaceWidget(),
                const CustomSpaceWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "User's Information",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const CustomSpaceWidget(),
                const CustomSpaceWidget(),
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
                        child: fbmodel.pickedfbProfile!.isEmpty
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
                                File(fbmodel.pickedfbProfile!),
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
                        onPressed: fbimagePickerOption,
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
                        fbmodel.username = value;
                      });
                    }
                  },
                  hinttexts: "Name",
                  lengthoftext: 25,
                  isSpace: false,
                ),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        fbmodel.location = value;
                      });
                    }
                  },
                  hinttexts: "Location",
                  lengthoftext: -1,
                  isSpace: false,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 17,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: greyColor,
                  ),
                  child: CheckboxListTile(
                    activeColor: customBlue,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: fbmodel.story,
                    title: Row(
                      children: const [
                        Expanded(
                          child: Text("Have you uploaded story"),
                        ),
                      ],
                    ),
                    onChanged: (getStory) => setState(() {
                      fbmodel.story = getStory ?? false;
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 17,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: greyColor,
                  ),
                  child: CheckboxListTile(
                    activeColor: customBlue,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: fbmodel.verifyUser,
                    title: Row(
                      children: const [
                        Expanded(
                          child: Text("Verified User"),
                        ),
                        Icon(CupertinoIcons.checkmark_alt_circle_fill,
                            color: Colors.blue),
                      ],
                    ),
                    onChanged: (getValue) => setState(() {
                      fbmodel.verifyUser = getValue ?? false;
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 13,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * (0.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: greyColor,
                  ),
                  child: fbmodel.pickedfbPost!.isEmpty
                      ? IconButton(
                          onPressed: () {
                            fbpostPickerOption();
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                          iconSize: 70,
                          color: customBlue,
                        )
                      : Image.file(
                          File(fbmodel.pickedfbPost!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: fbpostPickerOption,
                    icon: const Icon(Icons.add_a_photo_rounded),
                    label: const Text(
                      "Upload Your Post",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const CustomSpaceWidget(),
                FieldContiner(
                  hinttexts: "Caption...",
                  lengthoftext: -1,
                  isSpace: false,
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        fbmodel.caption = value;
                      });
                    }
                  },
                ),
                const Divider(),
                const CustomSpaceWidget(),
                const CustomSpaceWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Post Details",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const CustomSpaceWidget(),
                const CustomSpaceWidget(),
                CustomSlider(
                    sliderName: "Facebook Liked Count",
                    slidervalue: fbmodel.fblike!),
                Slider(
                  value: fbmodel.fblike!,
                  min: 0,
                  max: 1000000,
                  label: fbmodel.fblike!.toInt().toString(),
                  onChanged: (fbnumber) => setState(
                    () {
                      fbmodel.fblike = fbnumber;
                    },
                  ),
                ),
                CustomSlider(
                    sliderName: "Facebook Comments Count",
                    slidervalue: fbmodel.fbcomments!),
                Slider(
                  value: fbmodel.fbcomments!,
                  min: 0,
                  max: 10000,
                  label: fbmodel.fbcomments!.toInt().toString(),
                  onChanged: (fbcomment) => setState(
                    () {
                      fbmodel.fbcomments = fbcomment;
                    },
                  ),
                ),
                const CustomSpaceWidget(),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        fbmodel.friendname = value;
                      });
                    }
                  },
                  hinttexts: "Your Friend Name",
                  lengthoftext: 15,
                  isSpace: false,
                ),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        fbmodel.faketime = value;
                      });
                    }
                  },
                  hinttexts: "1 Jan / 1h / 1m / 1d",
                  isSpace: false,
                  lengthoftext: 15,
                ),
                const CustomSpaceWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
