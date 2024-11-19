import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../widgets/class_card.dart';
import 'class_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _searchType = 'day'; // 'day' or 'teacher'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search ${_searchType == 'day' ? 'by day' : 'by teacher'}...',
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.black54),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String value) {
              setState(() {
                _searchType = value;
                _searchController.clear();
                _searchQuery = '';
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'day',
                  child: Text('Search by Day'),
                ),
                const PopupMenuItem(
                  value: 'teacher',
                  child: Text('Search by Teacher'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firebaseService.searchClasses(
          dayOfWeek: _searchType == 'day' ? _searchQuery : null,
          teacher: _searchType == 'teacher' ? _searchQuery : null,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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

          if (classes.isEmpty) {
            return const Center(
              child: Text('No classes found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final yogaClass = classes[index];
              return ClassCard(
                yogaClass: yogaClass,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassDetailsScreen(yogaClass: yogaClass),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}