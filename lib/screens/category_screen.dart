import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g12revision/screens/course_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/menu_button.dart';
import '../widgets/shimmers.dart';
import 'web_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String? url;
  final int? index;
  final String? categoryId;
  final String? des;
  const CategoryScreen({
    Key? key,
    this.index,
    this.url,
    this.categoryId,
    this.des,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Stream<QuerySnapshot<Object?>>? stream;
  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection('home')
        .doc(widget.categoryId)
        .collection('category')
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: Text(
            'Category',
            style: kHeaderTS,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.to(
                      () => const WebScreen(
                        showAppbar: true,
                        url: 'https://www.youtube.com/c/g12revision',
                        name: 'Channel',
                      ),
                    ),
                icon: const Icon(
                  FontAwesomeIcons.youtube,
                  color: whiteColor,
                )),
            MenuButton.instance.popUpMenuBtn(context)
          ],
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          width: UIParameters.getWidth(context),
          height: UIParameters.getHeight(context),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top container
                Flexible(
                  child: SizedBox(
                    // height: 200,
                    width: UIParameters.getWidth(context),
                    child: Stack(
                      children: [
                        // image
                        Positioned.fill(
                            child: Hero(
                                tag: "index ${widget.index}",
                                child: CachedNetworkImage(
                                  imageUrl: widget.url!,
                                  fit: BoxFit.cover,
                                ))),
                        // ns text
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          top: 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // natural scinces text
                              Flexible(
                                flex: 2,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${widget.categoryId}\n"
                                              .toUpperCase(),
                                          style: GoogleFonts.secularOne(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: whiteColor)),
                                      TextSpan(
                                          text: '${widget.des}',
                                          style: inputStyle.copyWith(
                                              color: whiteColor)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // bottom container
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(kMobileScreenPadding),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: stream,
                        builder: (context, snapshot) {
                          // handle snapshot error
                          if (!snapshot.hasData) {
                            return const QuizScreenPlaceHolder();
                          }

                          return MasonryGridView.builder(
                            shrinkWrap: true,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int idx) {
                              // load data
                              final data = snapshot.data!.docs[idx];
                              final docId = snapshot.data!.docs[idx].id;
                              return ListTile(
                                onTap: () => Get.to(() => CoursesScreen(
                                      categoryId: widget.categoryId,
                                      courseId: docId,
                                    )),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: darkOrangeColor),
                                    borderRadius: BorderRadius.circular(
                                        kCardBorderrRadius)),
                                title: Text(data['name'], style: googleStyle),
                              );
                            },
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                          );
                        }),
                  ),
                ),
              ]),
        )));
  }
}
