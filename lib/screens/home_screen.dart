import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../widgets/class_card.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _testFirebaseConnection();
  }

  Future<void> _testFirebaseConnection() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      print('Testing Firebase connection...');
      
      // Test write
      await ref.child('test').set({
        'timestamp': DateTime.now().toIso8601String(),
      });
      print('Successfully wrote to Firebase');
      
      // Test read
      final snapshot = await ref.child('yoga_classes').get();
      print('Read from Firebase: ${snapshot.value}');
    } catch (e) {
      print('Firebase connection error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Classes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firebaseService.getYogaClasses(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Stream error: ${snapshot.error}');
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final classes = snapshot.data ?? [];
          print('Received ${classes.length} classes in UI');

          if (classes.isEmpty) {
            return const Center(
              child: Text('No classes available'),
            );
          }

          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final yogaClass = classes[index];
              return ClassCard(
                yogaClass: yogaClass,
                onTap: () {
                  // Navigate to class details
                },
              );
            },
          );
        },
      ),
    );
  }
}