// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class nHelpper {
  // void ntoastmessage(String msg) {
  //   Fluttertoast.showToast(
  //     msg: msg,
  //     backgroundColor: nColors.primarycolor,
  //     gravity: ToastGravity.BOTTOM,
  //     textColor: Colors.white,
  //     toastLength: Toast.LENGTH_SHORT,
  //     fontSize: 12.0,
  //   );
  // }

  void Function(PointerDownEvent)? hidekeybord = (event) {
    FocusManager.instance.primaryFocus?.unfocus();
  };

  void nerrortoast(BuildContext context, String description) {
    MotionToast toast = MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 12),
      ),
      layoutOrientation: ToastOrientation.ltr,
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
    toast.show(context);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toast.dismiss();
    });
  }

  void nsuccesstoast(BuildContext context, String description) {
    MotionToast toast = MotionToast.success(
      title: const Text(
        'Successful',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 12),
      ),
      layoutOrientation: ToastOrientation.ltr,
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
    toast.show(context);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toast.dismiss();
    });
  }

  void ndeletetoast(BuildContext context, String description) {
    MotionToast toast = MotionToast.delete(
      title: const Text(
        'Delete',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 12),
      ),
      layoutOrientation: ToastOrientation.ltr,
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
    toast.show(context);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toast.dismiss();
    });
  }
}
