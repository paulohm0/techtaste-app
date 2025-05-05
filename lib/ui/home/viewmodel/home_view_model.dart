import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final searchAIController = TextEditingController();
  bool isLoading = false;

  bool get isEmptySearchAIController => searchAIController.text.isEmpty;

  HomeViewModel() {
    searchAIController.addListener(notifyListeners);
  }
  @override
  void dispose() {
    searchAIController.dispose();
    super.dispose();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void clearInputUser() {
    searchAIController.clear();
  }
}
