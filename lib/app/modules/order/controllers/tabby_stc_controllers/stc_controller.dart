import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../components/mySnackbar.dart';
import '../../../../../config/myColor.dart';
import '../../../../routes/app_pages.dart';
import '../../amazon_model/tabby_model.dart';
import '../../providers/stc_tabby_provider/stc_provider.dart';


class StcPayPaymentController extends GetxController {
  final NetworkInfo _info = NetworkInfo();

  static StcPayPaymentController get instance =>
      Get.put(StcPayPaymentController());

  RxBool isLoading = false.obs;

  RxString tabbySignature = ''.obs;

  TabbyModel payWithTabbyModel = TabbyModel();

  set setPayWithTabbyData(TabbyModel data) {
    payWithTabbyModel = data;
    update();
  }

 TabbyModel get getPayWithTabbyData => payWithTabbyModel;

  final payWithTabbyProvider = PayWithTabbyProvider();

  late final WebViewController webViewController;

  Future<void> paymentWithStcPay(String appointmentId) async {
    var generatedSignature = await payWithTabbyProvider.payWithTabby(
      appointmentId: appointmentId,
      type: 'STCPAY',
      urlType: '0',
    );
    setPayWithTabbyData = generatedSignature;
  }

  void initWebView(String appointmentId) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    await paymentWithStcPay(appointmentId);
    _loadUrl();
  }

  void _loadUrl() {
    _postFormData();
  }

  void _postFormData() async {
    String formData = getPayWithTabbyData.data!;
    await webViewController.loadHtmlString(
      formData,
    );

    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          EasyLoading.show(status: 'loading'.tr);
          if (progress == 100) {
            EasyLoading.dismiss();
          }
        },
        onPageFinished: (url) {
          EasyLoading.dismiss();
          if (url.contains('success')) {
            Future.delayed(
              const Duration(seconds: 4),
                  () {
                Get.offAllNamed(Routes.HOME);
              },
            );
            mySnackBar(title: 'sucess', message: 'sucess', color: MYColor.secondary, icon: Icons.info);

          }

          if (url.contains('confirm')) {
            Future.delayed(
              const Duration(seconds: 4),
                  () {
                Get.offAllNamed(Routes.HOME);
              },
            );
           // Dialogs.successDialog(Get.context!, 'booking_success_des'.tr);
            mySnackBar(title: 'sucess', message: 'sucess', color: MYColor.secondary, icon: Icons.info);

          }

          if (url.contains('reject')) {
            Future.delayed(
              const Duration(seconds: 4),
                  () {
                Get.back();
                mySnackBar(title: 'error', message: 'error', color: MYColor.secondary, icon: Icons.info);

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