import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/models/brands_model.dart';
import 'package:flutter/material.dart';

class DiscoverController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxList<Brands> brandsList = RxList([]);
}
