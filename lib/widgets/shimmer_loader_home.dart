import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

class LoadingShimmerHome extends StatelessWidget {
  const LoadingShimmerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: 200,
      height: 150.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    var bigContainer = Container(
      width: double.infinity,
      height: 200.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return SizedBox(
      height: UIParameters.getHeight(context),
      width: UIParameters.getWidth(context),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.blueGrey.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: answer),
            SizedBox(
              width: 10,
            ),
            Flexible(child: answer),
          ],
        ),
      ),
    );
  }
}
