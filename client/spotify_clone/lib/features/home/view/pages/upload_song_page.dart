import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/features/home/view/widgets/audio_wave.dart';

import '../../../../core/utils.dart';
import '../../../../core/widgets/CustomTextField.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  @override
  _UploadSongPageState createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController _songTitleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  Color currentColor = Colors.white;
  File? coverArt;
  File? song;

  void _pickSong() async {
    final file = await pickAudioFile();
    if (file != null) {
      setState(() {
        song = file;
      });
    }
  }

  void _pickCoverArt() async {
    final file = await pickImageFile();
    if (file != null) {
      setState(() {
        coverArt = file;
      });
    }
  }

  @override
  void dispose() {
    _songTitleController.dispose();
    _artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Song'),
          actions: [
            IconButton(
              icon: Icon(Icons.upload),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickCoverArt,
                  child: coverArt != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Image.file(coverArt!, fit: BoxFit.cover),
                          ),
                        )
                      : DottedBorder(
                          color: AppPallete.borderColor,
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(6),
                          child: const SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_open, size: 50),
                                SizedBox(height: 10),
                                Text(
                                  'Select the Cover Art',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          )),
                ),
                SizedBox(height: 30),
                song != null
                    ? AudioWave(path: song!.path)
                    : CustomTextField(
                        hintText: 'Pick Song',
                        controller: TextEditingController(),
                        isReadOnly: true,
                        onTap: () {
                          _pickSong();
                        },
                      ),
                SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Artist',
                  controller: _artistController,
                ),
                SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Song title',
                  controller: _songTitleController,
                ),
                SizedBox(height: 30),
                ColorPicker(
                    pickersEnabled: {
                      ColorPickerType.wheel: true,
                    },
                    onColorChanged: (Color color) {
                      log(color.toString());
                    }),
              ],
            ),
          ),
        ));
  }
}
