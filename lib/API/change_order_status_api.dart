// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/Utils/widgets/app_snackbar.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';

changeStatus({orderId, statusId}) async {
  HomeController homeController = Get.put(HomeController());

  homeController.detailLoading.value = true;

  http.Response response = await ApiHandler.post(ApiUrls.changeStatus,
      withToken: true,
      body: {
        "order_status_id": int.parse(statusId),
        "delivery_id": orderId.toString()
      });
  print(orderId);
  print({"order_status_id": int.parse(statusId)});
  Logger().f(response.body);
  homeController.detailLoading.value = false;
  print("CHANGE STATUS ::: ${response.statusCode}");
  print("CHANGE STATUS ::: ${response.body}");
  if (response.statusCode == 200) {
    appSnackBar(
      title: "Successfully",
      message: jsonDecode(response.body)['message'],
      success: true,
    );
  } else {
    appSnackBar(
      title: "Failed",
      message: jsonDecode(response.body)['message'],
      success: false,
    );
  }
}
