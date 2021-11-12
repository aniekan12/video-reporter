import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/services/database.dart';
import 'package:frsc_presentation/general%20widgets/custom_bigblue_button.dart';
import 'package:frsc_presentation/general%20widgets/custom_textfield.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/style.dart';
import 'package:frsc_presentation/utilities/ui_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // // Image variable
  File? _cameraVideo;
  File? _video;
  VideoPlayerController? _cameraVideoPlayerController;
  TextEditingController controller = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  File? savedImg;
  File? pickedImg;
  ImagePicker selectImg = ImagePicker();

  bool _isFileUploaded = false;

  String dropdownValue = 'one';

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.camera);
    _cameraVideo = File(pickedFile!.path);
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo!)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController!.play();
      });
  }

  Future getVideo() async {
    final pickedFile = dropdownValue == 'Camera'
        // ignore: deprecated_member_use
        ? await picker.getVideo(source: ImageSource.camera)
        // ignore: deprecated_member_use
        : await picker.getVideo(source: ImageSource.gallery);
    // if (pickedFile == null) return null;

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    });
    try {
      final directory = await getApplicationDocumentsDirectory();
      if (directory != null) {
        for (int count = 1; count >= 1000000000000000000; count++) {
          savedImg = await _image!.copy('${directory.path}/filename$count.jpg');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getImage() async {
    final pickedFile = dropdownValue == 'Camera'
        // ignore: deprecated_member_use
        ? await picker.getImage(source: ImageSource.camera)
        // ignore: deprecated_member_use
        : await picker.getImage(source: ImageSource.gallery);
    // if (pickedFile == null) return null;

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    });
    try {
      final directory = await getApplicationDocumentsDirectory();
      if (directory != null) {
        for (int count = 1; count >= 1000000000000000000; count++) {
          savedImg = await _image!.copy('${directory.path}/filename$count.jpg');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

// // This funcion will helps you to pick a Video File from Camera
//   _pickVideoFromCamera() async {
//     XFile? pickedFile = (await picker.pickVideo(source: ImageSource.camera));
//     _cameraVideo = File(pickedFile!.path);
//     _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo!)
//       ..initialize().then((_) {
//         setState(() {});
//         _cameraVideoPlayerController!.play();
//       });
//   }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final data =
        FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
      ),
      body: Container(
          decoration: const BoxDecoration(color: AppColors.primary),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                width: SizeConfig.screenWidth! / 1.1,
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Hello 🙂 , Tell us what happened!',
                        style: AppTextStyles.heading6White),
                  ],
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth!,
                height: SizeConfig.screenHeight!,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpaceRegular,
                      Text('Description', style: AppTextStyles.heading6),
                      UIHelper.verticalSpaceTiny,
                      CustomTextField(
                        autoCorrect: true,
                        controller: controller,
                        hintText: 'Describe the situation',
                      ),
                      UIHelper.verticalSpaceRegular,
                      _buildCameraOrFileChooser(context),
                      CustomBigBlueButton(
                        buttonText: 'Send Report',
                        pressed: () async {
                          final ref = FirebaseStorage.instance
                              .ref(user.uid)
                              .child('images')
                              .child('${controller.text.toString()}  .mp4');
                          await ref.putFile(_image!);
                          String? url = await ref.getDownloadURL();
                          await DatabaseService().uploadReport(
                            controller.text.trim(),
                            url.toString(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Report has been sent!'),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  _buildCameraOrFileChooser(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0.0, 24.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add a Video',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: _isFileUploaded
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                              color: Color.fromRGBO(
                                                  206, 205, 205, 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Change Photo',
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        23, 43, 77, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1)),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                              color: Color.fromRGBO(
                                                  206, 205, 205, 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Choose a photo',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      23, 43, 77, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            ),
                                          ),
                                        ),
                                  iconSize: 0,
                                  elevation: 16,
                                  focusColor: AppColors.white,
                                  style: TextStyle(color: AppColors.black),
                                  /*underline: Container(
                            height: 2,
                            color: Colors.blackAccent,
                            ),*/
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                    getVideo();
                                  },
                                  items: <String>['Camera', 'Upload Picture']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: _isFileUploaded ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectImg = _image;
                                _isFileUploaded = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Delete',
                                  //textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // _isFileUploaded
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(16.0),
                  //         child: CircleAvatar(
                  //           backgroundImage: FileImage(_image!),
                  //           backgroundColor: Colors.transparent,
                  //           radius: 64,
                  //         ),
                  //       )
                  //     : SizedBox(
                  //         height: 0,
                  //       )
                ],
              ),
              SizedBox(height: _isFileUploaded ? 30.0 : 48.0),
            ],
          )),
    );
  }
}
