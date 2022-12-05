import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g12revision/controllers/links_controller.dart';
import 'package:g12revision/screens/overviewscreen.dart';

import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/drawer.dart';
import 'package:g12revision/widgets/shimmer_loader_home.dart';
import 'package:g12revision/widgets/shimmers.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Stream<QuerySnapshot<Object?>>? stream;
  List<String> carouselImgs = [];
  int dotPosition = 0;
  @override
  void initState() {
    stream = FirebaseFirestore.instance.collection('courses').snapshots();
    fetchCarouselImg();
    super.initState();
  }

  // fetch carousel images
  fetchCarouselImg() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('carousel-images').get();
    setState(() {
      for (var i = 0; i < qn.docs.length; i++) {
        carouselImgs.add(qn.docs[i]['imgUrl']);
      }
    });
    return qn.docs;
  }

  User? user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(kMobileScreenPadding),
          child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                // handle snapshot error
                if (!snapshot.hasData) {
                  return const QuizScreenPlaceHolder();
                }

                return SizedBox(
                  height: UIParameters.getHeight(context),
                  width: UIParameters.getWidth(context),
                  child: EasySeparatedColumn(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),

                    children: [
                      // greeting text
                      Flexible(
                          child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${LinkController.instance.greeting()}\n',
                              style: googleStyle,
                            ),
                            TextSpan(
                                text: user!.email!,
                                style: googleStyle.copyWith(
                                  color: blackColor,
                                )),
                          ],
                        ),
                      )),
                      Flexible(
                        child: AspectRatio(
                          aspectRatio: 2.51,
                          child: CarouselSlider(
                            items: carouselImgs
                                .map((item) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: CachedNetworkImage(
                                        imageUrl: item,
                                        fit: BoxFit.fill,
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                viewportFraction: .4,
                                autoPlay: true,
                                //viewportFraction: 1,
                                enlargeCenterPage: true,
                                //   enlargeStrategy: CenterPageEnlargeStrategy.height,
                                onPageChanged: (val, carouselpagechanged) {
                                  setState((() {
                                    dotPosition = val;
                                  }));
                                }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.topCenter,
                        child: DotsIndicator(
                          dotsCount:
                              carouselImgs.isEmpty ? 1 : carouselImgs.length,
                          position: dotPosition.toDouble(),
                          decorator: DotsDecorator(
                              activeColor: darkOrangeColor,
                              spacing: EdgeInsets.all(2),
                              activeSize: Size(8, 8),
                              size: Size(6, 6),
                              color: darkOrangeColor.withOpacity(0.2)),
                        ),
                      ),
                      Text(
                        'Courses',
                        style: googleStyle.copyWith(
                            color: blackColor, fontSize: 16),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          child: MasonryGridView.builder(
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 10,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int idx) {
                              // load data
                              final data = snapshot.data!.docs[idx];
                              final docId = snapshot.data!.docs[idx].id;
                              return InkWell(
                                onTap: () => Get.to(() => OverViewScreen(
                                      imgUrl: data['courseImg'],
                                      amount: data['amount'],
                                      index: idx,
                                      courseId: docId,
                                      title: data['name'],
                                      vidUrl: data['introductionVideo'],
                                    )),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kCardBorderrRadius),
                                  child: SizedBox(
                                    width: UIParameters.getWidth(context) / 2,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            // img
                                            Flexible(
                                              child: CachedNetworkImage(
                                                imageUrl: data['courseImg'],
                                                fit: BoxFit.cover,
                                                height: 160,
                                                width: UIParameters.getWidth(
                                                        context) /
                                                    2,
                                              ),
                                            ),
                                            // title and des
                                            ListTile(
                                              title: Text(
                                                data['name'],
                                                style: googleStyle.copyWith(
                                                    color: darkOrangeColor),
                                              ),
                                              subtitle: Text(
                                                data['description'],
                                                style: inputStyle.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),

                      const Flexible(flex: 1, child: SizedBox())
                    ],

                    // listview
                  ),
                );
              }),
        )));
  }
}
