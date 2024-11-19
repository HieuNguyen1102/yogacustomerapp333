import 'package:flutter/foundation.dart';
import '../models/yoga_class.dart';
import '../services/firebase_service.dart';

class YogaProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final List<YogaClass> _classes = [];
  bool _isLoading = false;
  String _error = '';

  List<YogaClass> get classes => _classes;
  bool get isLoading => _isLoading;
  String get error => _error;

  Stream<List<YogaClass>> getYogaClasses() {
    return _firebaseService.getYogaClasses();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
