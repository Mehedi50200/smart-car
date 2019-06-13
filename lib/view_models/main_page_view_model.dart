import 'dart:async';
import 'package:meta/meta.dart';
import 'package:redcar/interfaces/i_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:redcar/models/car.dart';
import 'package:redcar/models/car_parts.dart';

class MainPageViewModel extends Model {

  Future<List<Car>> _carList;

  Future<List<Car>> get carList => _carList;

  set carList(Future<List<Car>> value) {
    _carList = value;
    notifyListeners();
  }

//  Future<List<CarParts>> _CarParts;

//  Future<List<CarParts>> get carParts => _CarParts;

  set carParts(Future<List<CarParts>> value) {
  //  _CarParts = value;
    notifyListeners();
  }

  final IService apiSvc;

  MainPageViewModel({@required this.apiSvc});

  Future<bool> setCarList() async {
    carList = apiSvc?.getCarList();
    return carList != null;
  }
  Future<bool> setCarParts() async {
    carParts = apiSvc?.getCarParts();
    return carList != null;
  }
}