import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:g12revision/controllers/pay_controller.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/shimmers.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

import '../widgets/app_colors.dart';

class Payments extends StatelessWidget {
  final String? categoryId;
  final String? courseId;
  const Payments({super.key, this.categoryId, this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                pay(context);
              },
              child: Text('Pay'))),
    );
  }

  void pay(BuildContext context) async {
    String userEmail = '';
    // the amount should be fetched from courses collection
    String amount = '100';
    String courseId = '';
    final Customer customer = Customer(
        name: "Flutterwave Developer",
        phoneNumber: "1234566677777",
        email: "customer@customer.com");
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-b922dd7cdb7e1617a621409d3435e116-X",
        currency: "ZMW",
        redirectUrl: "add-your-redirect-url-here",
        // transaction reference needs to be unique for the entire app
        txRef: userEmail + DateTime.now().toString(),
        amount: amount,
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Transcended Institute"),
        // change to false later
        isTestMode: true);
// {status: successful, success: true, transaction_id: 3940885, tx_ref: app_txRef}

// {status: cancelled, success: false, transaction_id: null, tx_ref: app_txRef}
    var response = await flutterwave.charge();
    if (response.status == 'successful') {
// call the user document
      // var firestore = FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userEmail)
      //     .update({});
      print('payment successful');
    } else {
      print('user cancelled payment');
    }
  }
}
