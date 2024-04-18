import 'dart:async';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/constance.dart';

import '../../amazon_model/tabby_model.dart';




class PayWithTabbyProvider extends GetConnect {
  static PayWithTabbyProvider get instance => PayWithTabbyProvider.instance;
  // FlutterSecureStorage secureStorage = const FlutterSecureStorage(
  //   aOptions: AndroidOptions(
  //     encryptedSharedPreferences: true,
  //   ),
  // );
  Timer? timer;
  @override
  void onInit() {
    httpClient.baseUrl = Constance.sandenyBaseUrl;
    EasyLoading.addStatusCallback(
          (status) {
        if (status == EasyLoadingStatus.dismiss) {
          timer?.cancel();
        }
      },
    );
  }


  // Pay with Tabby and StcPay
  Future<TabbyModel> payWithTabby({
    required String appointmentId,
    required String type,
    required String urlType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await get(
      "${Constance.sandenyBaseUrl}${Constance.sandenyAmazonPay}",
      headers: {
        "authorization": "Bearer ${Constance.instance.token}",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      query: {
        "appointment_id": appointmentId,
        "type": type,
        "url_type": urlType
      },
    );

    var statusCode = response.statusCode;
    var data = response.body;
    log('this is the signature data: $data');
    log('this is the status code: $statusCode');

    if(statusCode == 401){
      //userNotRegisteredWidget(Get.context!);
    }

    if (data['code'] == 1) {
      EasyLoading.dismiss();
      return TabbyModel.fromJson(data);
    }

    if (data['code'] == 2) {
      EasyLoading.dismiss();
      //Dialogs.errorDialog(Get.context!, 'unknown_error'.tr);
    }
    return TabbyModel.fromJson(data);
  }
}