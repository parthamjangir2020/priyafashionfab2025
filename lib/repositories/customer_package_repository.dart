import 'dart:convert';

import 'package:active_ecommerce_cms_demo_app/app_config.dart';
import 'package:active_ecommerce_cms_demo_app/data_model/common_response.dart';
import 'package:active_ecommerce_cms_demo_app/data_model/customer_package_response.dart';
import 'package:active_ecommerce_cms_demo_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_cms_demo_app/middlewares/banned_user.dart';
import 'package:active_ecommerce_cms_demo_app/repositories/api-request.dart';

class CustomerPackageRepository {
  Future<CustomerPackageResponse> getList() async {
    String url = ('${AppConfig.BASE_URL}/customer-packages');

    final response = await ApiRequest.get(url: url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$!,
    });

    return customerPackageResponseFromJson(response.body);
  }

  Future<dynamic> freePackagePayment(id) async {
    String url = ('${AppConfig.BASE_URL}/free/packages-payment');

    var post_body = jsonEncode({"package_id": "${id}"});
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        body: post_body,
        middleware: BannedUser());
    return commonResponseFromJson(response.body);
  }

  Future<dynamic> offlinePackagePayment(
      {packageId, method, trx_id, photo}) async {
    String url = ('${AppConfig.BASE_URL}/offline/packages-payment');

    var post_body = jsonEncode({
      "package_id": "${packageId}",
      "payment_option": "${method}",
      "trx_id": "${trx_id}",
      "photo": "${photo}",
    });
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        body: post_body,
        middleware: BannedUser());
    return commonResponseFromJson(response.body);
  }
}
