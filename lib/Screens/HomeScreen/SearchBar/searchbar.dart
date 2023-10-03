// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';

class nsearchbar extends StatelessWidget {
  TextEditingController searchcontroller;
  void Function(String)? onChanged;
  nsearchbar({
    super.key,
    required this.searchcontroller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchcontroller,
      decoration: nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
        prefixIcon: const Icon(CupertinoIcons.search),
        hintText: 'Search',
      ),
      onChanged: onChanged,
      onTapOutside: nHelpper().hidekeybord,
    );
  }
}
