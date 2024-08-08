import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickAudioFile() async {
  try{
  final result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
    allowCompression: true,
  );

  if (result != null) {
    final file = File(result.files.first.xFile.path);
    return file;
  }
  return null;
  }
  catch(e){
    return null;
  }
}

Future<File?> pickImageFile() async {
  try{
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowCompression: true,
  );

  if (result != null) {
    final file = File(result.files.first.xFile.path);
    return file;
  }
  return null;
  }
  catch(e){
    return null;
  }
}