import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g12revision/controllers/pay_controller.dart';
import 'package:g12revision/screens/lessons_screen.dart';
import 'package:g12revision/screens/resources_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import 'package:video_player/video_player.dart';

class OverViewScreen extends StatefulWidget {
  final int index;
  final String imgUrl;
  final String courseId;
  final String vidUrl;
  final String amount;
  final String title;
  const OverViewScreen(
      {super.key,
      required this.imgUrl,
      required this.index,
      required this.courseId,
      required this.vidUrl,
      required this.amount,
      required this.title});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title.toUpperCase(), style: GoogleFonts.amaranth()),
        backgroundColor: purpleColor,
        bottom: TabBar(
            labelColor: whiteColor,
            unselectedLabelColor: whiteColor,
            indicatorColor: whiteColor,
            labelStyle: googleStyle,
            indicatorWeight: 5,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'LESSONS',
                icon: Icon(
                  FontAwesomeIcons.graduationCap,
                  color: whiteColor,
                ),
              ),
              Tab(
                text: 'RESOURCES',
                icon: Icon(
                  FontAwesomeIcons.solidFilePdf,
                  color: whiteColor,
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LessonsScreen(
            title: widget.title,
            amount: widget.amount,
            courseId: widget.courseId,
            imgUrl: widget.imgUrl,
          ),
          ResourcesScreen(
            showAppbar: false,
            title: widget.title,
            courseId: widget.courseId,
            imgUrl: widget.imgUrl,
            amount: widget.amount,
          )
        ],
      ),
    );
  }

  // tabview

}
