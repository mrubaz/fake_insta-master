import 'package:fake_instagram/screens/facebookscreens/addfbpost.dart';
import 'package:fake_instagram/screens/settings.dart';
import 'package:fake_instagram/screens/tiktokscreens/addtiktokpost.dart';
import 'package:fake_instagram/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'instagramscreens/add_post.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * (0.14)),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const AddPost());
                          },
                          child: const GridWidget(
                            iconToDisplay: CupertinoIcons.camera_fill,
                            titleText: "Add Instagram Post",
                            subtitleText: "",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AddFBPost());
                          },
                          child: const GridWidget(
                              iconToDisplay: Icons.facebook_sharp,
                              titleText: "Add Facebook Post",
                              subtitleText: ""),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const AddTikTokPost());
                          },
                          child: const GridWidget(
                              iconToDisplay: Icons.tiktok_sharp,
                              titleText: "Add Tiktok Post",
                              subtitleText: ""),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const Settings());
                          },
                          child: const GridWidget(
                              iconToDisplay: CupertinoIcons.gear_big,
                              titleText: "Settings",
                              subtitleText: ""),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final iconToDisplay;
  final String titleText;
  final String subtitleText;
  const GridWidget({
    Key? key,
    required this.iconToDisplay,
    required this.titleText,
    required this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: customBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconToDisplay,
              size: 38,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              titleText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subtitleText,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
