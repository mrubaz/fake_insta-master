// INSTAGRAM HEADER

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InstagramHeader extends StatelessWidget {
  const InstagramHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * (0.030),
        left: MediaQuery.of(context).size.width * (0.043),
        right: MediaQuery.of(context).size.width * (0.043),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/Instagram.svg",
            height: MediaQuery.of(context).size.height * (0.0343),
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/images/message.svg",
            color: Colors.black,
            height: MediaQuery.of(context).size.height * (0.0372),
          ),
        ],
      ),
    );
  }
}
