import 'package:flutter/material.dart';
import '../Screens/search_screen/category_model.dart';
import '../widgets/filter_page/Model/tractor_model.dart';

CategoryProvider categoryProvider = CategoryProvider();
AdsDataProvider adsDataProvider = AdsDataProvider();
TractorAdsDataProvider tractorAdsDataProvider = TractorAdsDataProvider();

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  void setCategories(List<Category> cs) {
    _categories = cs;
    notifyListeners();
  }

  void deleteCategory(Category category) {
    _categories.remove(category);
    notifyListeners();
  }

  void clear() {
    _categories.clear();
  }
}

class AdsDataProvider extends ChangeNotifier {
  List _usedData = [];
  List _newData = [];
  List _rentData = [];

  List get usedData => _usedData;
  List get newData => _newData;
  List get rentData => _rentData;

  void setUsedData(List data) {
    _usedData = data;
    notifyListeners();
  }

  void setNewData(List data) {
    _newData = data;
    notifyListeners();
  }

  void setRentData(List data) {
    _rentData = [];
    notifyListeners();
  }
}

class TractorAdsDataProvider extends ChangeNotifier {
  List<Tractor> _usedData = [];
  List<Tractor> _newData = [];
  List<Tractor> _rentData = [];
  bool _loading = false;
  bool get loading => _loading;

  set setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  List<Tractor> get usedData => _usedData;
  List<Tractor> get newData => _newData;
  List<Tractor> get rentData => _rentData;

  void setUsedData(List<Tractor> data) {
    _usedData = data;
    notifyListeners();
  }

  void setNewData(List<Tractor> data) {
    _newData = data;
    notifyListeners();
  }

  void setRentData(List<Tractor> data) {
    _rentData = data;
    notifyListeners();
  }
}
