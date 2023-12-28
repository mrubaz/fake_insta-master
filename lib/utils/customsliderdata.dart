import 'package:fake_instagram/utils/const.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String sliderName;
  final double slidervalue;
  const CustomSlider({
    Key? key,
    required this.sliderName,
    required this.slidervalue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * (0.02),
        ),
        Expanded(
          child: Text(
            sliderName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              slidervalue.toInt().toString(),
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
