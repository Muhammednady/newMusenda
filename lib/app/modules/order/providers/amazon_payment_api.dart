import 'package:amazon_payfort/amazon_payfort.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../../../../config/amazonpayment_constants.dart';
import '../amazon_model/sdk_token_response_model.dart';

class AmazonPayApi {
  AmazonPayApi._();

  static AmazonPayApi get instance => AmazonPayApi._();

  static Future<SdkTokenResponse?> generateSdkToken(
      SdkTokenRequest request) async {
    var response = await post(
      // for the test enviroment
      Uri.parse(AmazonPayConfigue.testEnviroment.paymentApi),
      // for the production enviroment
      // Uri.parse(AmazonPayConfigue.productionEnviroment.paymentApi),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.asRequest()),
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return SdkTokenResponse.fromMap(decodedResponse);
    }
    return null;
  }



}
