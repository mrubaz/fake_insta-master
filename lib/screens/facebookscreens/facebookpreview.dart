import 'dart:io';
import 'package:fake_instagram/models/facebookmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_stack/image_stack.dart';
import 'package:readmore/readmore.dart';
import 'package:screenshot/screenshot.dart';
import '../../utils/const.dart';

class FbPreview extends StatefulWidget {
  final FacebookModel fbmodel;
  const FbPreview({
    Key? key,
    required this.fbmodel,
  }) : super(key: key);

  @override
  State<FbPreview> createState() => _FbPreviewState();
}

class _FbPreviewState extends State<FbPreview> {
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FacebookHeader(),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.blue,
              thickness: 2,
              height: 0,
              indent: 212,
              endIndent: 130,
            ),
            Divider(color: Colors.blueGrey.shade200, height: 0),
            Screenshot(
                controller: controller, child: FbPost(fbmodel: widget.fbmodel)),
            Container(height: 10, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class FbPost extends StatefulWidget {
  final FacebookModel fbmodel;

  const FbPost({
    Key? key,
    required this.fbmodel,
  }) : super(key: key);

  @override
  State<FbPost> createState() => _FbPostState();
}

class _FbPostState extends State<FbPost> {
  bool youliked = false;
  double finalLikedCount = 0;

  String numberFormatForCount(int num) {
    if (num >= 0 && num < 1000) {
      return '$num';
    }
    if (num >= 1000 && num < 1000000) {
      finalLikedCount = num / 1000;
      return '${finalLikedCount.toStringAsFixed(1)}k';
    }
    if (num >= 1000000) {
      finalLikedCount = num / 1000000;
      return '${finalLikedCount.toStringAsFixed(1)}M';
    } else {
      return '$num';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 15,
              top: 8,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: widget.fbmodel.story!
                            ? Border.all(
                                color: Colors.grey,
                                width: 2,
                                style: BorderStyle.solid,
                              )
                            : Border.all(
                                color: Colors.white,
                                width: 0,
                                style: BorderStyle.solid,
                              ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: widget.fbmodel.pickedfbProfile!.isEmpty
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.grey,
                                )
                              : Image.file(
                                  File(widget.fbmodel.pickedfbProfile!),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          SizedBox(
                            width: 250,
                            child: RichText(
                              text: TextSpan(
                                  text: widget.fbmodel.username,
                                  style: const TextStyle(
                                    fontFamily: "segoe_ui/bold",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    widget.fbmodel.verifyUser == true
                                        ? const WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Icon(
                                                CupertinoIcons
                                                    .checkmark_alt_circle_fill,
                                                color: Colors.blue,
                                                size: 14,
                                              ),
                                            ),
                                          )
                                        : const WidgetSpan(child: Offstage()),
                                    widget.fbmodel.location!.isNotEmpty
                                        ? TextSpan(
                                            text: " is at ",
                                            style: const TextStyle(
                                              fontFamily: "segoe_ui/regular",
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: fbgrey,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: widget.fbmodel.location,
                                                style: const TextStyle(
                                                  fontFamily: "segoe_ui/bold",
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const WidgetSpan(child: Offstage()),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.fbmodel.faketime} · ",
                                style: const TextStyle(
                                  fontFamily: "segoe_ui/regular",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: fbgrey,
                                ),
                              ),
                              const Icon(
                                CupertinoIcons.person_2_fill,
                                size: 15,
                                color: fbgrey,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_horiz),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 15,
              bottom: 10,
            ),
            child: widget.fbmodel.caption!.isNotEmpty
                ? ReadMoreText(
                    trimLength: 370,
                    widget.fbmodel.caption!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "segoe_ui/regular",
                      fontWeight: FontWeight.w500,
                    ),
                    trimCollapsedText: ' See More',
                    moreStyle: const TextStyle(color: fbgrey),
                    trimExpandedText: ' Show Less',
                    lessStyle: const TextStyle(color: fbgrey),
                  )
                : const Offstage(),
          ),
          AspectRatio(
            aspectRatio: 4 / 5,
            child: widget.fbmodel.pickedfbPost!.isEmpty
                ? Container(
                    color: Colors.grey,
                  )
                : Image.file(
                    File(widget.fbmodel.pickedfbPost!),
                    fit: BoxFit.fitWidth,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageStack(
                      imageList: const [
                        'assets/icons/facebook_like.png',
                        'assets/icons/facebook_love.png',
                      ],
                      totalCount: 2,
                      imageBorderWidth: 2,
                      imageRadius: 21,
                      imageBorderColor: Colors.white,
                      imageSource: ImageSource.Asset,
                    ),
                    Text(
                      "${widget.fbmodel.friendname} and ${numberFormatForCount(widget.fbmodel.fblike!.toInt())} others",
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "segoe_ui/regular",
                        color: fbgrey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${numberFormatForCount(widget.fbmodel.fbcomments!.toInt())} comments",
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "segoe_ui/regular",
                        color: fbgrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 2,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                PostBottomBar(
                  logo: "assets/icons/likeunfill.svg",
                  cheight: 18,
                  reaction: "Like",
                ),
                PostBottomBar(
                  logo: "assets/icons/comment.svg",
                  cheight: 18,
                  reaction: "Comment",
                ),
                PostBottomBar(
                  logo: "assets/icons/share.svg",
                  cheight: 18,
                  reaction: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostBottomBar extends StatelessWidget {
  final String logo;
  final String reaction;
  final double cheight;
  const PostBottomBar({
    Key? key,
    required this.logo,
    required this.reaction,
    required this.cheight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          logo,
          height: cheight,
          color: customgrey,
        ),
        const SizedBox(width: 6),
        Text(
          reaction,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: "segoe_ui/regular",
            color: customgrey,
          ),
        ),
      ],
    );
  }
}

class FacebookHeader extends StatelessWidget {
  const FacebookHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * (0.043),
        right: MediaQuery.of(context).size.width * (0.043),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/icons/home.svg",
            height: 35,
            color: fbgrey,
          ),
          SvgPicture.asset(
            "assets/icons/video.svg",
            height: 35,
            color: fbgrey,
          ),
          SvgPicture.asset(
            "assets/icons/shop.svg",
            height: 35,
            color: fbgrey,
          ),
          const Icon(
            CupertinoIcons.person_crop_circle,
            size: 35,
            color: customBlue,
          ),
          SvgPicture.asset(
            "assets/icons/bell.svg",
            height: 35,
            color: fbgrey,
          ),
          SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 20,
            color: fbgrey,
          ),
        ],
      ),
    );
  }
}
