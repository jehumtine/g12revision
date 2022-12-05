import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ValidationController extends GetxController {
  static ValidationController instance = Get.put(ValidationController());
  var isLoading = false.obs;
  late final FirebaseAuth _auth = FirebaseAuth.instance;
// validate email
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Invalid email";
    } else if (value.isEmpty) {
      return 'This field required';
    }
    return '';
  }

  String? validateFirstname(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Invalid first name";
    } else if (value.isEmpty) {
      return 'This field required';
    }
    return '';
  }

  String? validateLastName(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Invalid last name";
    } else if (value.isEmpty) {
      return 'This field required';
    }
    return '';
  }

// validate password
  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be minimum of 6 characters";
    } else if (value.isEmpty) {
      return 'This field required';
    }
    return '';
  }

// login method itself

}
