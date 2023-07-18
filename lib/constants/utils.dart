import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:amazon/constants/global_variables.dart';

showSnackBar(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

Future<List<File>> pickImages() async {
  List<File> image = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        image.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    log.e(e.toString());
  }
  return image;
}
