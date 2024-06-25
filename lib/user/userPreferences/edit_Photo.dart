import 'dart:typed_data';
import 'package:project_attendance_app/user/model/profil_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_attendance_app/user/userPreferences/user_preferences.dart';

class BuildEditImage extends StatefulWidget{
  const BuildEditImage({super.key});

  @override
  State<BuildEditImage> createState() {
    return _BuilEditImageState();
  }
}

class _BuilEditImageState extends State<BuildEditImage>{
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    Uint8List? savedImage = await RememberUserPrefs.loadProfileImage();
    if (savedImage != null) {
      setState(() {
        _image = savedImage;
      });
    }
  }

  void _saveImage(Uint8List image) async {
    await RememberUserPrefs.storeProfileImage(image);
  }

  void getImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      _saveImage(img);
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
    children: [
      _image != null ?
        CircleAvatar(
          radius: 70,
          backgroundImage: MemoryImage(_image!),
        ) :
      const CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('images/art.png'),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue
          ),
          child: IconButton(
            onPressed: getImage, 
            icon: const Icon(Icons.camera_alt_rounded,color: Colors.white,))
        ),
      )
    ],
  );
  }
}