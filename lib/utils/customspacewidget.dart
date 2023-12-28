import 'package:flutter/material.dart';

class CustomSpaceWidget extends StatelessWidget {
  const CustomSpaceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (0.017),
    );
  }
}
