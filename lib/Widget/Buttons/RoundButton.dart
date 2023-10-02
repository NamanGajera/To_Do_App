// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/Utils/Decorations/BoxDecoration.dart';

class RoundButton extends StatelessWidget {
  void Function()? onTap;
  String buttonname;
  bool loading;
  RoundButton({
    super.key,
    required this.buttonname,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: nBoxDecoration.nboxDecoration,
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : Text(
                buttonname,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
