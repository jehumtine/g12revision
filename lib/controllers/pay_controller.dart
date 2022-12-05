import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:g12revision/widgets/dialogs.dart';

class PayController extends GetxController {
  static PayController instance = Get.put(PayController());
  final User? _user = FirebaseAuth.instance.currentUser;

  void pay(String amount, courseId) async {
    //String userEmail = '';
    // the amount should be fetched from courses collection
    //  String amount = '100';
    //  String courseId = '';
    final today = DateTime.now();
    final expiryDate = today.add(const Duration(days: 30));
    final Customer customer = Customer(
        name: courseId, phoneNumber: "1234566677777", email: "${_user!.email}");
    final Flutterwave flutterwave = Flutterwave(
        context: Get.overlayContext!,
        publicKey: "FLWPUBK_TEST-b922dd7cdb7e1617a621409d3435e116-X",
        currency: "ZMW",
        redirectUrl: "add-your-redirect-url-here",
        // transaction reference needs to be unique for the entire app
        txRef: "${_user!.email!}${DateTime.now()}",
        amount: amount,
        customer: customer,
        paymentOptions: "mobilemoneyzambia",
        customization: Customization(
            //  logo: logo,
            title: "Transcended Institute"),
        // change to false later
        isTestMode: true);
// {status: successful, success: true, transaction_id: 3940885, tx_ref: app_txRef}

// {status: cancelled, success: false, transaction_id: null, tx_ref: app_txRef}
    var response = await flutterwave.charge();
    if (response.status == 'successful') {
// call the user document
      var firestore = FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.email)
          .update({
        'coursesPaymentsDate.$courseId': expiryDate,
      });

      Get.dialog(Dialogs.paymentDialog(Get.overlayContext!));
    } else {
      Fluttertoast.showToast(msg: "Payment cancelled");
    }
  }
}
