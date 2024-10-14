import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class DetailsController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  var submitPressed = false.obs;
  var isLoading = false.obs;
  var phoneNoKey = GlobalKey<FormFieldState>().obs;
  var verificationCodeTimer = Rxn<int>();
  Timer? timer;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController icNumberController = TextEditingController();
  TextEditingController occupationCategoryController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void submit(PageController pageController) {
    submitPressed.value = true;

    if (!(formKey.value.currentState?.validate() ?? false)) {
      showFormErrorSnackbar();
      return;
    }

    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void sendSMSCode() async {
    // if (!(phoneNoKey.value.currentState?.validate() ?? false)) {
    //   showFormErrorSnackbar();
    //   return;
    // }

    // isLoading.value = true;

    // try {
    //   await Get.find<EasigoldAPIService>()
    //       .sendSMSVerification(phoneNo: formatPhoneNumber(contactNumberController.text));

    //   const int total = kResendSMSCodeCountdownInSecond;
    //   verificationCodeTimer.value = total;

    //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //     if (timer.tick == total) {
    //       verificationCodeTimer.value = null;
    //       return timer.cancel();
    //     }

    //     verificationCodeTimer.value = (verificationCodeTimer.value ?? 0) - 1;
    //   });

    //   isLoading.value = false;

      
    // } catch (e) {
    //   isLoading.value = false;

     
    // }
  }

  void showFormErrorSnackbar() {
    // Implement your snackbar logic here
  }
}
