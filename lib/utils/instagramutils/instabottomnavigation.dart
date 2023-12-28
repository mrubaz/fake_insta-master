import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstagramBottomNavigation extends StatelessWidget {
  const InstagramBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      iconSize: 23,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: "",
        ),
      ],
    );
  }
}
