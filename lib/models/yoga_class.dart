class YogaClass {
  final String id;
  final String dayOfWeek;
  final String date;
  final String time;
  final int capacity;
  final int duration;
  final double price;
  final String type;
  final String description;
  final String teacher;

  YogaClass({
    required this.id,
    required this.dayOfWeek,
    required this.date,
    required this.time,
    required this.capacity,
    required this.duration,
    required this.price,
    required this.type,
    required this.description,
    required this.teacher,
  });

  factory YogaClass.fromMap(String id, Map<dynamic, dynamic> map) {
    print('Parsing class with data: $map');
    return YogaClass(
      id: id,
      dayOfWeek: map['dayOfWeek']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      time: map['time']?.toString() ?? '',
      capacity: int.tryParse(map['capacity']?.toString() ?? '0') ?? 0,
      duration: int.tryParse(map['duration']?.toString() ?? '0') ?? 0,
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
      type: map['type']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      teacher: map['teacher']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayOfWeek': dayOfWeek,
      'date': date,
      'time': time,
      'capacity': capacity,
      'duration': duration,
      'price': price,
      'type': type,
      'description': description,
      'teacher': teacher,
    };
  }
}
