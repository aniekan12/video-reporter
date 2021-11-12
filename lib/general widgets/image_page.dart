import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/models/firebase_file.dart';
import 'package:frsc_presentation/core/services/database.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'video_player_widget.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.file.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isImage =
        ['.jpeg', '.jpg', '.png', '.mp4'].any(widget.file.name.contains);

    final videothumb = VideoThumbnail.thumbnailData(
        video: widget.file.url, maxWidth: 128, quality: 40);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.file.name),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await DatabaseService.downloadFile(widget.file.ref);

                final snackBar = SnackBar(
                  content: Text('Downloaded ${widget.file.name}'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Column(
          children: [
            VideoPlayerWidget(controller: controller),
          ],
        ));
  }
}
