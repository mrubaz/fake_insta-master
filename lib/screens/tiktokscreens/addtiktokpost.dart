import 'dart:io';
import 'package:fake_instagram/models/titkokmodel.dart';
import 'package:fake_instagram/screens/tiktokscreens/tiktok_preview.dart';
import 'package:fake_instagram/screens/tiktokscreens/tiktokfinalscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';
import '../../utils/customsliderdata.dart';
import '../../utils/customspacewidget.dart';
import '../../utils/feildcontainer.dart';
import '../../utils/native_app_dialogue.dart';

class AddTikTokPost extends StatefulWidget {
  const AddTikTokPost({Key? key}) : super(key: key);

  @override
  State<AddTikTokPost> createState() => _AddTikTokPostState();
}

class _AddTikTokPostState extends State<AddTikTokPost> {
  TiktokModel tiktokmodel = TiktokModel.empty();

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
      setState(() {
        tiktokmodel.pickedProfile = photo.path;
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
        tiktokmodel.pickedPost = photo.path;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Show Error msg
  void currentMsg() {
    if (tiktokmodel.pickedProfile!.isEmpty) {
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
    if (tiktokmodel.username!.trim().isEmpty) {
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

    if (tiktokmodel.pickedPost!.isEmpty) {
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
    if (tiktokmodel.likedCount!.toDouble().round() == 0) {
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
    if (tiktokmodel.commentCount!.toDouble().round() == 0) {
      AppDialog().showOSDialog(
        context,
        'Error',
        'Comments are required',
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
    if (tiktokmodel.faketime!.trim().isEmpty) {
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
      TiktokFinalScreen(tiktokmodel: tiktokmodel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        // Appbar
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
                    () => PreviewTiktok(tiktokmodel: tiktokmodel),
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

                // Pick Profile
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
                        child: tiktokmodel.pickedProfile!.isEmpty
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
                                File(tiktokmodel.pickedProfile!),
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

                //
                const CustomSpaceWidget(),
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        tiktokmodel.username = value;
                      });
                    }
                  },
                  hinttexts: "username",
                  lengthoftext: 25,
                  isSpace: true,
                ),

                // Your Music
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
                    value: tiktokmodel.yourMusic,
                    title: Row(
                      children: [
                        const Expanded(
                          child: Text("Your Music?"),
                        ),
                        tiktokmodel.yourMusic == false
                            ? const Icon(Icons.music_note, color: customMehroon)
                            : const Icon(Icons.music_note, color: Colors.black),
                      ],
                    ),
                    onChanged: (getValue) => setState(() {
                      tiktokmodel.yourMusic = getValue ?? false;
                    }),
                  ),
                ),

                // Verified User
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
                    value: tiktokmodel.verifyUser,
                    title: Row(
                      children: const [
                        Expanded(
                          child: Text("Verified User"),
                        ),
                        Icon(Icons.check_circle_rounded, color: Colors.blue),
                      ],
                    ),
                    onChanged: (getValue) => setState(() {
                      tiktokmodel.verifyUser = getValue ?? false;
                    }),
                  ),
                ),

                // Pick Post Option
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
                  child: tiktokmodel.pickedPost!.isEmpty
                      ? IconButton(
                          onPressed: () {
                            postPickerOption();
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                          iconSize: 70,
                          color: customBlue,
                        )
                      : Image.file(
                          File(tiktokmodel.pickedPost!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                ),

                // Add Post Button
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

                //Caption
                FieldContiner(
                  onChange: (value) {
                    if (mounted) {
                      setState(() {
                        tiktokmodel.caption = value;
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

                // Sliders Start

                // LikedCount Slider
                CustomSlider(
                    sliderName: "Liked Count",
                    slidervalue: tiktokmodel.likedCount!),
                Slider(
                  value: tiktokmodel.likedCount!,
                  min: 0,
                  max: 1000000,
                  label: tiktokmodel.likedCount!.toInt().toString(),
                  onChanged: (number) => setState(
                    () {
                      tiktokmodel.likedCount = number;
                    },
                  ),
                ),

                // Comment Count Slider
                CustomSlider(
                    sliderName: "Comments",
                    slidervalue: tiktokmodel.commentCount!),
                Slider(
                  value: tiktokmodel.commentCount!,
                  min: 0,
                  max: 10000,
                  label: tiktokmodel.commentCount!.toInt().toString(),
                  onChanged: (comment) => setState(
                    () {
                      tiktokmodel.commentCount = comment;
                    },
                  ),
                ),

                // Saved Count Slider
                CustomSlider(
                    sliderName: "Saved Count",
                    slidervalue: tiktokmodel.savedCount!),
                Slider(
                  value: tiktokmodel.savedCount!,
                  min: 0,
                  max: 1000000,
                  label: tiktokmodel.savedCount!.toInt().toString(),
                  onChanged: (number) => setState(
                    () {
                      tiktokmodel.savedCount = number;
                    },
                  ),
                ),

                //Sliders END
                const CustomSpaceWidget(),

                // Time of Post
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
                                    tiktokmodel.faketime = value;
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
