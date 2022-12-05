import 'dart:async';
import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import '../widgets/custom_indicater.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key, required this.url, required this.id})
      : super(key: key);
  final String id;
  final String url;

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final controller = PdfViewerController();

  TapDownDetails? _doubleTapDetails;
  Timer? timer;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleColor,
        title: Text(
          widget.id,
          style: inputStyle,
        ),
        actions: [
          ValueListenableBuilder<Matrix4>(
            // The controller is compatible with ValueListenable<Matrix4> and you can receive notifications on scrolling and zooming of the view.
            valueListenable: controller,
            builder: (context, _, child) => Center(
                child: controller.isReady
                    ? Text(
                        'Page ${controller.currentPageNumber}',
                        style: inputStyle,
                      )
                    : const SizedBox()),
          ),
        ],
      ),
      body: GestureDetector(
        // Supporting double-tap gesture on the viewer.
        onDoubleTapDown: (details) => _doubleTapDetails = details,
        onDoubleTap: () => controller.ready?.setZoomRatio(
          zoomRatio: controller.zoomRatio * 1.5,
          center: _doubleTapDetails!.localPosition,
        ),
        child: !kIsWeb && Platform.isMacOS
            // Networking sample using flutter_cache_manager
            ? PdfViewer.openFutureFile(
                // Accepting function that returns Future<String> of PDF file path
                () async =>
                    (await DefaultCacheManager().getSingleFile(widget.url))
                        .path,
                viewerController: controller,
                onError: (err) =>
                    Center(child: CustomIndicator.circularIndicator),
                loadingBannerBuilder: (context) => Center(
                  child: CustomIndicator.circularIndicator,
                ),
                params: const PdfViewerParams(
                  padding: 10,
                  minScale: 1.0,
                  // scrollDirection: Axis.horizontal,
                ),
              )
            : PdfViewer.openFutureFile(
                // Accepting function that returns Future<String> of PDF file path
                () async =>
                    (await DefaultCacheManager().getSingleFile(widget.url))
                        .path,

                viewerController: controller,
                loadingBannerBuilder: (context) => Center(
                  child: CustomIndicator.circularIndicator,
                ),
                onError: (err) => CustomIndicator.circularIndicator,
                params: const PdfViewerParams(
                  padding: 10,
                  minScale: 1.0,
                  // scrollDirection: Axis.horizontal,
                ),
              ),
      ),
    );
  }
}
