import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../amazon_model/tabby_model.dart';
import '../../providers/stc_tabby_provider/stc_provider.dart';


class TabbyPaymentController extends GetxController {
  final NetworkInfo _info = NetworkInfo();

  static TabbyPaymentController get instance =>
      Get.put(TabbyPaymentController());

  RxBool isLoading = false.obs;

  RxString tabbySignature = ''.obs;

  TabbyModel getTabbyData = TabbyModel();

  set setTabbyData(TabbyModel data) {
    getTabbyData = data;
    update();
  }

  TabbyModel get getSignatureData => getTabbyData;

  final payWithTabbyProvider = PayWithTabbyProvider();

  late final WebViewController webViewController;

  Future<void> paymentWithTabby(String appointmentId) async {
    log('this is the appointmentId in tabby: $appointmentId');
    var generatedSignature = await payWithTabbyProvider.payWithTabby(
        appointmentId: appointmentId, type: 'TABBY', urlType: '0');
    setTabbyData = generatedSignature;
  }

  void initWebView(String appointmentId) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    await paymentWithTabby(appointmentId);

    _loadUrl();
  }

  void _loadUrl() {
    _postFormData();
  }

  void _postFormData() async {
    String formData = getSignatureData.data!;
    await webViewController.loadHtmlString(
      formData,
    );

    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          EasyLoading.show(status: 'loading'.tr);
          log('this is the progress: $progress');
          if (progress == 100) {
            EasyLoading.dismiss();
          }
        },
        onPageFinished: (url) {
          EasyLoading.dismiss();
          log('this is the url: $url');

          if (url.contains('success')) {
            Future.delayed(
              const Duration(seconds: 3),
                  () {
                Get.offAllNamed(Routes.HOME);
              },
            );
            //Dialogs.successDialog(Get.context!, 'booking_success_des'.tr);
            mySnackBar(title: 'sucess', message: 'sucess', color: MYColor.secondary, icon: Icons.info);
          }

          if (url.contains('confirm')) {
            Future.delayed(
              const Duration(seconds: 3),
                  () {
                Get.offAllNamed(Routes.HOME);
              },
            );
            mySnackBar(title: 'sucess', message: 'sucess', color: MYColor.secondary, icon: Icons.info);
          }

          if (url.contains('reject')) {
            Future.delayed(
              const Duration(seconds: 3),
                  () {
                Get.back();
                mySnackBar(title: 'reject', message: 'reject', color: MYColor.secondary, icon: Icons.info);

                  },
            );
          }
        },
        onWebResourceError: (error) {
          EasyLoading.dismiss();
          log('this is the error: $error');
        },
      ),
    );
  }
}