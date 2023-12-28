import 'dart:io';
import 'package:fake_instagram/models/instagrammodel.dart';
import 'package:fake_instagram/screens/instagramscreens/insta_preview.dart';
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
import 'finalscreen.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  InstagramModel instagramModel = InstagramModel.empty();
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
        instagramModel.pickedProfile = tempProfile.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Post Photo Functions
  void postPickerOption() {
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
                      pickpost(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickpost(ImageSource.gallery);
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

  pickpost(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      setState(() {
        instagramModel.pickedPost = photo.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Show Error msg
  void currentMsg() {
    if (instagramModel.pickedProfile!.isEmpty) {
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
    if (instagramModel.username!.trim().isEmpty) {
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
    if (instagramModel.pickedPost!.isEmpty) {
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
    if (instagramModel.num!.toDouble().round() == 0) {
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
    if (instagramModel.comments!.toDouble().round() == 0) {
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
    if (instagramModel.likedby!.trim().isEmpty) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Liked by name is required',
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

    if (instagramModel.faketime!.trim().isEmpty) {
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
      () => FinalScreen(instagramModel: instagramModel),
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
                    () => PreviewInsta(instagramModel: instagramModel),
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
                        child: instagramModel.pickedProfile!.isEmpty
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
                                File(instagramModel.pickedProfile!),
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
                        instagramModel.username = value;
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
                        instagramModel.location = value;
                      });
                    }
                  },
                  hinttexts: "Location",
                  lengthoftext: 30,
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
                    value: instagramModel.verifyUser,
                    title: Row(
                      children: const [
                        Expanded(
                          child: Text("Verified User"),
                        ),
                        Icon(Icons.verified_sharp, color: Colors.blue),
                      ],
                    ),
                    onChanged: (getValue) => setState(() {
                      instagramModel.verifyUser = getValue ?? false;
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
                  child: instagramModel.pickedPost!.isEmpty
                      ? IconButton(
                          onPressed: () {
                            postPickerOption();
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                          iconSize: 70,
                          color: customBlue,
                        )
                      : Image.file(
                          File(instagramModel.pickedPost!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: postPickerOption,
                    icon: const Icon(Icons.add_a_photo_rounded),
                    label: const Text(
                      "Add Your Post",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const CustomSpaceWidget(),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        instagramModel.caption = value;
                      });
                    }
                  },
                  hinttexts: "Caption...",
                  lengthoftext: -1,
                  isSpace: false,
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
                    sliderName: "Liked Count",
                    slidervalue: instagramModel.num!),
                Slider(
                  value: instagramModel.num!,
                  min: 0,
                  max: 1000000,
                  label: instagramModel.num!.toInt().toString(),
                  onChanged: (number) => setState(
                    () {
                      instagramModel.num = number;
                    },
                  ),
                ),
                CustomSlider(
                    sliderName: "Comments",
                    slidervalue: instagramModel.comments!),
                Slider(
                  value: instagramModel.comments!,
                  min: 0,
                  max: 10000,
                  label: instagramModel.comments!.toInt().toString(),
                  onChanged: (comment) => setState(
                    () {
                      instagramModel.comments = comment;
                    },
                  ),
                ),
                const CustomSpaceWidget(),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        instagramModel.likedby = value;
                      });
                    }
                  },
                  hinttexts: "Liked by",
                  lengthoftext: 30,
                  isSpace: true,
                ),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        instagramModel.customUID = value;
                      });
                    }
                  },
                  hinttexts: "Custom comment username",
                  lengthoftext: 30,
                  isSpace: true,
                ),
                FieldContiner(
                  hinttexts: "Custom comment",
                  lengthoftext: -1,
                  isSpace: false,
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        instagramModel.customComment = value;
                      });
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: greyColor,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 120,
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              onChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    instagramModel.faketime = value;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: "9:00 AM",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.time,
                          color: customBlue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
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
