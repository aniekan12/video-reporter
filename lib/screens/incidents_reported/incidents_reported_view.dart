import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/models/firebase_file.dart';
import 'package:frsc_presentation/core/services/database.dart';
import 'package:frsc_presentation/general%20widgets/image_page.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/style.dart';
import 'package:frsc_presentation/utilities/ui_helper.dart';
import 'package:video_player/video_player.dart';

class IncidentsReportedView extends StatefulWidget {
  const IncidentsReportedView({
    Key? key,
  }) : super(key: key);

  @override
  _IncidentsReportedViewState createState() => _IncidentsReportedViewState();
}

class _IncidentsReportedViewState extends State<IncidentsReportedView> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  TextEditingController controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Future<List<FirebaseFile>> futureFiles;
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  @override
  void initState() {
    super.initState();
    futureFiles = DatabaseService.listAll();

    //   firestore
    //       .collection("reports")
    //       .get()
    //       .then((QuerySnapshot querySnapshot) => {
    //             // ignore: avoid_function_literals_in_foreach_calls
    //             querySnapshot.docs.forEach((doc) {
    //               videoUrl = doc["image_url"];

    //               _controller = VideoPlayerController.network(videoUrl);
    //               _initializeVideoPlayerFuture =
    //                   _controller!.initialize().then((_) {
    //                 _controller!.setLooping(true);
    //                 _controller!.play();
    //                 // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //                 setState(() {
    //                   _controller!.value.isPlaying
    //                       ? _controller!.pause()
    //                       : _controller!.play();
    //                 });
    //               });
    //             })
    //           });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
      leading: Icon(Icons.video_camera_back),
      title: Text(
        file.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImagePage(file: file),
      )),
    );

Widget buildHeader(int length) => ListTile(
      tileColor: Colors.blue,
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      title: Text(
        '$length Report(s)',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
