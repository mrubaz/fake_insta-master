import 'dart:io';
import 'package:fake_instagram/models/instagrammodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import '../../utils/bottomsheet.dart';
import '../../utils/instagramutils/instabottomnavigation.dart';
import '../../utils/instagramutils/instagramheader.dart';

class FinalScreen extends StatefulWidget {
  final InstagramModel instagramModel;

  const FinalScreen({
    Key? key,
    required this.instagramModel,
  }) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final controller = ScreenshotController();
  bool youliked = false;
  double finalLikedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            bottomSheetFloatingButton(context, controller);
          });
        },
        elevation: 0,
        backgroundColor: Colors.cyan.shade300,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InstagramHeader(),
            Divider(color: Colors.blueGrey.shade200),
            Screenshot(
                controller: controller,
                child: PostWidget(instagramModel: widget.instagramModel)),
          ],
        ),
      ),
      bottomNavigationBar: const InstagramBottomNavigation(),
    );
  }
}

class PostWidget extends StatefulWidget {
  final InstagramModel instagramModel;

  const PostWidget({Key? key, required this.instagramModel}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool youliked = false;
  double finalLikedCount = 0;
  String numberFormatForLikedCount() {
    if (widget.instagramModel.num! >= 0 &&
        widget.instagramModel.num! < 1000000) {
      return NumberFormat('#,##,###').format(widget.instagramModel.num!);
    } else if (widget.instagramModel.num! >= 1000000 &&
        widget.instagramModel.num! < 1000000000) {
      finalLikedCount = widget.instagramModel.num! / 100000;
      return '${finalLikedCount.toInt()}M';
    } else if (widget.instagramModel.num! >= 1000000000) {
      finalLikedCount = widget.instagramModel.num! / 1000000000;
      return '${finalLikedCount.toStringAsFixed(1)}B';
    } else {
      return '${widget.instagramModel.num!}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(children: [
        // Username profile picture area
        SizedBox(
          height: 52,
          child: ListTile(
            minLeadingWidth: 8,
            horizontalTitleGap: 10,
            leading: SizedBox(
              height: 32,
              width: 32,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(widget.instagramModel.pickedProfile!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.instagramModel.username!,
                          style: const TextStyle(
                            fontFamily: "helvetica-font",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        widget.instagramModel.verifyUser == true
                            ? const Icon(Icons.verified_sharp,
                                color: Colors.blue, size: 15)
                            : const Offstage()
                      ],
                    ),
                    const SizedBox(height: 2),
                    widget.instagramModel.location!.isNotEmpty
                        ? Text(
                            widget.instagramModel.location!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: "helvetica-font",
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : const Offstage()
                  ],
                ),
              ],
            ),
            trailing: SvgPicture.asset("assets/images/three-dots-thin.svg"),
          ),
        ),
        // Picked Post Area
        GestureDetector(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 480),
            width: 1080,
            child: Image.file(
              File(widget.instagramModel.pickedPost!),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: MediaQuery.of(context).size.width * (0.043),
            right: MediaQuery.of(context).size.width * (0.043),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icons Below Post Area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: youliked == false
                        ? SvgPicture.asset(
                            "assets/images/heart.svg",
                            width: 24,
                            height: 21,
                            color: Colors.black,
                          )
                        : Image.asset(
                            "assets/images/love.png",
                            color: Colors.red,
                            width: 24,
                            height: 21,
                          ),
                  ),
                  const SizedBox(width: 18),
                  SvgPicture.asset(
                    "assets/images/comment.svg",
                    color: Colors.black,
                    width: 24,
                    height: 21,
                  ),
                  const SizedBox(width: 18),
                  SvgPicture.asset(
                    "assets/images/plane.svg",
                    color: Colors.black,
                    width: 24,
                    height: 19,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/images/save.svg",
                    color: Colors.black,
                    width: 24,
                    height: 19,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageStack(
                    imageList: const [
                      'https://source.unsplash.com/random/?fruit',
                      'https://source.unsplash.com/random/?city,day',
                      'https://source.unsplash.com/random/?city,night',
                    ],
                    totalCount: 3,
                    imageRadius: 24,
                    imageBorderWidth: 2,
                    imageBorderColor: Colors.white,
                    imageSource: ImageSource.Network,
                  ),
                  // Liked By Count Area
                  const SizedBox(width: 5),
                  const Text(
                    "Liked by ",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "helvetica-font",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.instagramModel.likedby!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "helvetica-font",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    " and ",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "helvetica-font",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${numberFormatForLikedCount()} others",
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "helvetica-font",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Username And Caption
              RichText(
                softWrap: true,
                text: TextSpan(
                  text: widget.instagramModel.username,
                  style: const TextStyle(
                    fontFamily: "helvetica-font",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: " "),
                    TextSpan(
                      text: widget.instagramModel.caption,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "helvetica-font",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              // Below Caption Area
              Text(
                "View all ${widget.instagramModel.comments} comments",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "helvetica-font",
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 5),
              (widget.instagramModel.customUID!.isEmpty ||
                      widget.instagramModel.customComment!.isEmpty)
                  ? const Offstage()
                  : Row(
                      children: [
                        RichText(
                          softWrap: true,
                          text: TextSpan(
                            text: widget.instagramModel.customUID,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "helvetica-font",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: " "),
                              TextSpan(
                                text: widget.instagramModel.customComment,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "helvetica-font",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                          size: 14,
                        ),
                      ],
                    ),
              const SizedBox(height: 5),
              Text(
                widget.instagramModel.faketime!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}
