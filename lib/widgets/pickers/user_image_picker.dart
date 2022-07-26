import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File? _pickedImage;

  void addAvatar() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150
    );
    final pickedImageFile = File(pickedImage?.path as String);
    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePickFn(pickedImageFile);// requires import
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          backgroundColor: Colors.grey,
          child: _pickedImage != null
              ? null
              : const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 80,
                ),
        ),
        TextButton.icon(
          onPressed: addAvatar,
          label: const Text('Add image'),
          icon: const Icon(Icons.image),
        ),
      ],
    );
  }
}
