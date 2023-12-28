import 'dart:io';
import 'package:fake_instagram/models/titkokmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';
import '../../utils/const.dart';

class PreviewTiktok extends StatefulWidget {
  final TiktokModel tiktokmodel;

  const PreviewTiktok({
    Key? key,
    required this.tiktokmodel,
  }) : super(key: key);

  @override
  State<PreviewTiktok> createState() => _PreviewTiktokState();
}

class _PreviewTiktokState extends State<PreviewTiktok> {
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Screenshot(
          controller: controller,
          child: TikTokPostBody(tiktokmodel: widget.tiktokmodel)),
    );
  }
}
//

class TikTokPostBody extends StatefulWidget {
  const TikTokPostBody({Key? key, required this.tiktokmodel}) : super(key: key);
  final TiktokModel tiktokmodel;

  @override
  State<TikTokPostBody> createState() => _TikTokPostBodyState();
}

class _TikTokPostBodyState extends State<TikTokPostBody> {
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
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: widget.tiktokmodel.pickedPost!.isEmpty
              ? Container(
                  color: Colors.grey,
                )
              : Image.file(
                  File(widget.tiktokmodel.pickedPost!),
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * (0.16167),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                SvgPicture.asset(
                  "assets/images/tiktoksearch.svg",
                  width: 24,
                ),
              ],
            ),
          ),
        ),

        // RIght SIde ICons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: double.infinity),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.5),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.tiktokmodel.pickedProfile!.isEmpty
                          ? Container(
                              height: 50,
                              width: 50,
                              color: Colors.grey,
                            )
                          : Image.file(
                              File(widget.tiktokmodel.pickedProfile!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  SizedBox(
                      height: MediaQuery.of(context).size.height * (0.0279)),

                  SvgPicture.asset(
                    "assets/images/tiktokheart.svg",
                    color: Colors.white.withOpacity(0.9),
                    width: 36,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    numberFormatForCount(
                        widget.tiktokmodel.likedCount!.toInt()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "montserat/regular",
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * (0.0221)),
                  SvgPicture.asset(
                    "assets/images/tiktokcomments.svg",
                    color: Colors.white.withOpacity(0.9),
                    width: 36,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    numberFormatForCount(
                        widget.tiktokmodel.commentCount!.toInt()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "montserat/regular",
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * (0.0254)),
                  SvgPicture.asset(
                    "assets/images/tiktoksaved.svg",
                    color: Colors.white.withOpacity(0.9),
                    width: 40,
                    height: 33,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    numberFormatForCount(
                        widget.tiktokmodel.savedCount!.toInt()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "montserat/regular",
                    ),
                  ),

                  SizedBox(
                      height: MediaQuery.of(context).size.height * (0.0184)),
                  Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.white.withOpacity(0.9),
                    size: 36,
                  ),

                  SizedBox(
                      height: MediaQuery.of(context).size.height * (0.0334)),

                  // Disc
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        gradient: discGradient,
                        borderRadius: BorderRadius.circular(22.5),
                        border: Border.all(
                          width: 10.5,
                          style: BorderStyle.none,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.tiktokmodel.yourMusic == false
                          ? Image.network(
                              'https://source.unsplash.com/random/',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(widget.tiktokmodel.pickedProfile!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  const SizedBox(height: 68),
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * (0.72),
                height: MediaQuery.of(context).size.height * (0.0930),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(111, 233, 53, 83),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: widget.tiktokmodel.pickedProfile!.isEmpty
                                ? Container(
                                    color: Colors.grey,
                                  )
                                : Image.file(
                                    File(widget.tiktokmodel.pickedProfile!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 45),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "${widget.tiktokmodel.username} ",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 186, 184, 184),
                                  fontSize: 11,
                                  fontFamily: "montserat/regular",
                                ),
                              ),
                              const SizedBox(width: 2),
                              widget.tiktokmodel.verifyUser == true
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.blue, size: 12)
                                  : const Offstage(),
                              Text(
                                " · ${widget.tiktokmodel.faketime}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 186, 184, 184),
                                  fontSize: 11,
                                  fontFamily: "montserat/regular",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.tiktokmodel.caption!,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: "montserat/semibold",
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(
                            " · Followers only",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "montserat/semibold",
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RandomComments(
                imageTodisplay: Image.network(
                  'https://source.unsplash.com/random/?city,day',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              RandomComments(
                imageTodisplay: Image.network(
                  'https://source.unsplash.com/random/?city,night',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              RandomComments(
                imageTodisplay: Image.network(
                  'https://source.unsplash.com/random/?fruit',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 58),
            ],
          ),
        ),
        const Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: Color.fromARGB(173, 255, 255, 255),
            size: 60,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Container(
              height: 50,
              color: Colors.black,
              child: Row(
                children: [
                  const SizedBox(width: 18),
                  const Text(
                    "Add comment...",
                    style: TextStyle(
                        color: Color.fromARGB(225, 123, 115, 115),
                        // fontFamily: "montserat/regular",
                        fontSize: 13),
                  ),
                  const Spacer(),
                  SvgPicture.asset("assets/images/@.svg", height: 24),
                  const SizedBox(width: 12),
                  SvgPicture.asset("assets/images/tiktoksmiley.svg",
                      height: 23),
                  const SizedBox(width: 24),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//

class RandomComments extends StatelessWidget {
  final Image imageTodisplay;
  const RandomComments({
    Key? key,
    required this.imageTodisplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Stack(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color.fromARGB(30, 189, 189, 189),
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: imageTodisplay,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 18,
              height: 18,
              child: Image.asset("assets/icons/facebook_love.png"),
            ),
          ),
        ],
      ),
    );
  }
}
