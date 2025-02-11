// To parse this JSON data, do
//
//     final offlineWalletRechargeResponse = offlineWalletRechargeResponseFromJson(jsonString);

import 'package:active_ecommerce_cms_demo_app/repositories/api-request.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'dart:convert';

import '../app_config.dart';
import '../custom/device_info.dart';
import 'message_response.dart';

OfflineWalletRechargeResponse offlineWalletRechargeResponseFromJson(
        String str) =>
    OfflineWalletRechargeResponse.fromJson(json.decode(str));

String offlineWalletRechargeResponseToJson(
        OfflineWalletRechargeResponse data) =>
    json.encode(data.toJson());

class OfflineWalletRechargeResponse {
  OfflineWalletRechargeResponse({
    this.result,
    this.message,
  });

  bool? result;
  String? message;

  factory OfflineWalletRechargeResponse.fromJson(Map<String, dynamic> json) =>
      OfflineWalletRechargeResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}