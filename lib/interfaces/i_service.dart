import 'dart:async';
import 'package:redcar/models/car.dart';
import 'package:redcar/models/car_parts.dart';

abstract class IService {
  Future<List<Car>> getCarList();
  Future<List<CarParts>> getCarParts();
}