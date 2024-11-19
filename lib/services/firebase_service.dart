import 'package:firebase_database/firebase_database.dart';
import '../models/yoga_class.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  FirebaseService() {
    FirebaseDatabase.instance.databaseURL =
        'https://finalyoga-f8d29-default-rtdb.asia-southeast1.firebasedatabase.app';
    print('FirebaseService initialized');
  }

  Stream<List<YogaClass>> getYogaClasses() {
    print('Getting yoga classes from Firebase');
    return _database.child('yoga_classes').onValue.map((event) {
      final data = event.snapshot.value;
      print('Received data: $data');

      if (data == null) return [];

      try {
        List<YogaClass> classes = [];

        if (data is List) {
          for (var i = 0; i < data.length; i++) {
            if (data[i] != null && data[i] is Map) {
              try {
                classes.add(YogaClass.fromMap(
                    i.toString(), Map<String, dynamic>.from(data[i] as Map)));
              } catch (e) {
                print('Error parsing class at index $i: $e');
              }
            }
          }
        }

        // Sort by date and time
        classes.sort((a, b) {
          int dateCompare = a.date.compareTo(b.date);
          if (dateCompare != 0) return dateCompare;
          return a.time.compareTo(b.time);
        });

        print('Processed ${classes.length} classes');
        return classes;
      } catch (e) {
        print('Error processing data: $e');
        return [];
      }
    });
  }

  Stream<List<YogaClass>> searchClasses({String? dayOfWeek, String? teacher}) {
    return getYogaClasses().map((classes) {
      return classes.where((yogaClass) {
        if (dayOfWeek != null &&
            !yogaClass.dayOfWeek
                .toLowerCase()
                .contains(dayOfWeek.toLowerCase())) {
          return false;
        }
        if (teacher != null &&
            !yogaClass.teacher.toLowerCase().contains(teacher.toLowerCase())) {
          return false;
        }
        return true;
      }).toList();
    });
  }
}
