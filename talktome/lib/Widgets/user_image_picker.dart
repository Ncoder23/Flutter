import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage(this.onPickImage, {super.key});
  final void Function(File pickedImage) onPickImage;
  //File? user_image;
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? selected_image;
  void _imagePicker() async {
    final clicked_image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (clicked_image == null) {
      return;
    }
    setState(() {
      selected_image = File(clicked_image.path);
    });
    widget.onPickImage(selected_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          foregroundImage:
              (selected_image != null) ? FileImage(selected_image!) : null,
          radius: 50,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
          onPressed: _imagePicker,
          icon: Icon(Icons.image),
          label: Text(
            'select image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
