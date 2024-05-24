import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadDocsWidget extends StatefulWidget {
  final IconData iconName;
  final String text;
  final Function(String) onIconSelected;

  UploadDocsWidget({
    required this.text,
    required this.iconName,
    required this.onIconSelected,
  });
  @override
  _UploadDocsWidgetState createState() => _UploadDocsWidgetState();
}

class _UploadDocsWidgetState extends State<UploadDocsWidget> {
  File? pickImgPath;
  String? imgUri;

  Future<void> _imagePicker() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    setState(() {
      pickImgPath = File(image.path);
    });

    print(pickImgPath);
  }

  void _uploadImg(BuildContext context) async {
    if (pickImgPath == null) {
      // Handle case where imageFile is null
      return;
    }

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    String imagePath = '/foldername/$fileName.jpg';

    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(imagePath);

    // Set content type explicitly for image files
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      contentType: 'image/jpeg', // Change to 'image/png' if PNG format
    );

    firebase_storage.UploadTask uploadTask = ref.putFile(
      pickImgPath!,
      metadata,
    );

    try {
      await uploadTask.whenComplete(() async {
        imgUri = await ref.getDownloadURL();
        print("Uploaded image URL: $imgUri");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully!')),
        );
        widget.onIconSelected(imgUri!);
        setState(() {
          imgUri = null;
        });

        // Notify parent widget about the icon name
        // Assuming 'upload' as the icon name
      });
    } catch (error) {
      print("Error uploading image: $error");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return pickImgPath == null
        ? InkWell(
            onTap: () async {
              await _imagePicker();
              if (pickImgPath != null) {
                _uploadImg(context);
              }
            },
            child: Expanded(
              child: DottedBorder(
                color: Colors.white,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: MediaQuery.sizeOf(context).height / 3.5,
                  width: MediaQuery.sizeOf(context).width / 5.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Icon(
                        widget.iconName,
                        color: Colors.white,
                        size: 55,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    pickImgPath != null ? FileImage(pickImgPath!) : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _uploadImg(context);
                    },
                    child: const Text('Upload Image'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _imagePicker();
                    },
                    child: const Text('Change Image'),
                  )
                ],
              )
            ],
          );
  }
}
