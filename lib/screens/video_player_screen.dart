import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/screens/pdf_screen.dart';

import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/shimmers.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import 'package:video_player/video_player.dart';

import '../widgets/custom_indicater.dart';
import '../widgets/custom_text_styles.dart';
import '../widgets/loadinig_shimmer.dart';

class VideoPlayerScreen extends StatefulWidget {
  String? url;
  final String? name;
  final String? courseId;
  final String? topic;
  final String? pdfQuestionUrl;
  final String? pdfSolutionUrl;
  VideoPlayerScreen({
    Key? key,
    this.url = '',
    this.name,
    this.courseId,
    this.topic,
    this.pdfSolutionUrl,
    this.pdfQuestionUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  Stream<QuerySnapshot<Object?>>? stream;

  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .collection('Topics')
        .doc(widget.topic)
        .collection('Tutorial Sheets')
        .snapshots();
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.url!);
    await videoPlayerController.initialize().then((value) {
      chewieController =
          ChewieController(videoPlayerController: videoPlayerController);
      setState(() {});
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
          bufferedColor: darkOrangeColor.withOpacity(0.5),
          backgroundColor: darkOrangeColor.withOpacity(0.5),
          handleColor: darkOrangeColor,
          playedColor: darkOrangeColor),
      cupertinoProgressColors: ChewieProgressColors(),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name!),
          backgroundColor: purpleColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          width: UIParameters.getWidth(context),
          height: UIParameters.getHeight(context),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            chewieController == null
                ? const Card(
                    color: blackColor,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: darkOrangeColor,
                        ),
                      ),
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  ),
            Card(
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.question,
                  color: redColor,
                ),
                trailing: const Icon(FontAwesomeIcons.rightLong),
                title: Text('${widget.name!} Questions'),
                onTap: () => Get.to(
                  () => PdfScreen(
                      url: widget.pdfQuestionUrl!,
                      id: '${widget.name!} Questions'),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.graduationCap,
                  color: greenColor,
                ),
                trailing: const Icon(FontAwesomeIcons.rightLong),
                title: Text('${widget.name!} Solutions'),
                onTap: () => Get.to(
                  () => PdfScreen(
                      url: widget.pdfSolutionUrl!,
                      id: '${widget.name!} Solutions'),
                ),
              ),
            ),
          ]),
        )));
  }
}
