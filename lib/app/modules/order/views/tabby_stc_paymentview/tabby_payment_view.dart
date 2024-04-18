import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/tabby_stc_controllers/tabby_controller.dart';


class TabbyPaymentView extends GetView<TabbyPaymentController> {
  const TabbyPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isArabic = Get.locale!.languageCode == 'ar';
    //final String appointmentId = Get.arguments as String;
    Get.lazyPut(() => TabbyPaymentController());
    controller.initWebView('1551');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        elevation: 0,
        leading: Padding(
          padding: isArabic
              ? const EdgeInsets.only(right: 30)
              : const EdgeInsets.only(left: 30),
          child: IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon:  Icon(
              Icons.arrow_back,
              color: MYColor.white,
            ),
          ),
        ),
        title: Text(
          'tabby_payment'.tr,
          style: const TextStyle(fontSize: 25.0),
          ),


      ),
      body: WebViewWidget(
        controller: controller.webViewController,
      ),
    );
  }
}