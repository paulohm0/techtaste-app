import 'package:flutter/material.dart';
import 'package:techtaste_app/helpers/order/order_helper.dart';

class CheckDeliveryViewModel extends ChangeNotifier {
  final clientController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  bool get isEmptyClient => clientController.text.isEmpty;
  bool get isEmptyPhone => phoneController.text.isEmpty;
  bool get isEmptyAddress => addressController.text.isEmpty;

  late int deliveryFee;
  late int orderCode;
  late int deliveryTime;

  int _selectedPaymentMethod = 0;
  int get selectedPaymentMethod => _selectedPaymentMethod;

  void setSelectedPaymentMethod(int value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }

  CheckDeliveryViewModel() {
    clientController.addListener(notifyListeners);
    phoneController.addListener(notifyListeners);
    addressController.addListener(notifyListeners);
    deliveryFee = generateDeliveryFee();
    orderCode = generateTwoDigitNumber();
    deliveryTime = generateDeliveryTime();
  }

  @override
  void dispose() {
    clientController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void clearDataClient() {
    clientController.clear();
    phoneController.clear();
    addressController.clear();
    notifyListeners();
  }
}
