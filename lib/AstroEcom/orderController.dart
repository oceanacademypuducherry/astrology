import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

class OrderController extends GetxController {
  final postalList = [].obs;
  final userPinCode = ''.obs;
  final wrongPinCode = false.obs;
  final stateList = [].obs;
  final cityList = [].obs;

  /// area instead of city
  final selectedCity = 'Select area'.obs;
  final selectedState = 'Select State'.obs;

  final orderDelivery = {}.obs;

  updateOrderDelivery(key, value) {
    orderDelivery[key] = value;
  }

  setOrderDelivery(orderInfo) {
    orderDelivery(orderInfo);
  }

  setStateList(statelist) {
    stateList(statelist);
  }

  setCityList(city) {
    cityList(city);
  }

  setSelectedState(city) {
    for (var cState in postalList) {
      if (cState['Name'] == city) {
        selectedState(cState['State']);
      }
    }
  }

  setSelectedCitiy(String city) {
    selectedCity(city);
    setSelectedState(city);
  }

  setUserPinCode(pinCode) {
    userPinCode(pinCode);
  }

  setWrongPinCode(boolValue) {
    wrongPinCode(boolValue);
  }

  getPincodeData(pinCode) async {
    final response = await https
        .get(Uri.parse('https://api.postalpincode.in/pincode/${pinCode}'));

    print(response.statusCode);
    final datas = json.decode(response.body);
    // final postofice = json.decode(datas);

    if (datas[0]['PostOffice'] == null) {
      setWrongPinCode(false);
      setSelectedCitiy('Select City');
    } else {
      postalList(datas[0]['PostOffice']);
      // print(postalList);
      List tempCityList = [];
      for (var state in postalList) {
        print(state['Name']);
        tempCityList.add(state['Name']);
      }
      setWrongPinCode(true);
      setCityList(tempCityList);
      setSelectedCitiy(tempCityList[0]);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debounce(userPinCode, (_) => getPincodeData(userPinCode),
        time: Duration(seconds: 1));
  }
}
