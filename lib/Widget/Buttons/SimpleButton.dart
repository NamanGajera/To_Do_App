// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:to_do_app/Utils/Decorations/BoxDecoration.dart';

class SimpleButton extends StatelessWidget {
  void Function()? onTap;
  String buttonname;
  bool loading;
  SimpleButton({
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
        decoration: nBoxDecoration.nboxDecoration
            .copyWith(borderRadius: BorderRadius.circular(0.0)),
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
