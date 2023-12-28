import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TikTokBottomNavigation extends StatelessWidget {
  const TikTokBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/images/hometiktok.svg"),
          label: "For You",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/addtiktok.svg",
            width: 45,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/images/inboxtiktok.svg"),
          label: "Inbox",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/images/profiletiktok.svg"),
          label: "Profile",
        ),
      ],
    );
  }
}
