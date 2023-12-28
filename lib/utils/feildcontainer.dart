import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const.dart';

class FieldContiner extends StatefulWidget {
  final String hinttexts;
  final bool isSpace;
  final int lengthoftext;
  final Function(String) onChange;
  const FieldContiner({
    Key? key,
    required this.hinttexts,
    required this.isSpace,
    required this.lengthoftext,
    required this.onChange,
  }) : super(key: key);

  @override
  State<FieldContiner> createState() => _FieldContinerState();
}

class _FieldContinerState extends State<FieldContiner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 17,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: greyColor,
      ),
      child: Column(
        children: [
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [
              if (widget.isSpace)
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              LengthLimitingTextInputFormatter(widget.lengthoftext),
            ],
            onChanged: (value) => widget.onChange(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hinttexts,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
