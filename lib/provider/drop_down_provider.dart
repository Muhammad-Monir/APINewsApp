import 'package:flutter/foundation.dart';

class DropDownProvider extends ChangeNotifier {
  String? _selectedServiceType;
  final List<String> _serviceTypesList = [
    '1 Hours',
    '2 Hours',
    '6 Hours',
    '12 Hours',
    '24 Hours',
  ];

  String? get selectedServiceType => _selectedServiceType;
  List<String>? get serviceTypesList => _serviceTypesList;

  void setSelectedServiceType(String? serviceType) {
    _selectedServiceType = serviceType;
    notifyListeners();
  }
}