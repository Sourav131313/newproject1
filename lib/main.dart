import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('JSON Cards'),
        ),
        body: FutureBuilder(
          future: _loadUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> userData = snapshot.data!;
              return UserGrid(userData);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading data'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

class UserGrid extends StatelessWidget {
  final List<Map<String, dynamic>> userData;

  UserGrid(this.userData);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return UserCard(
          userId: userData[index]['id'],
          username: userData[index]['username'],
          imageUrl: 'https://picsum.photos/536/354?id=$index',
          name: userData[index]['name'],
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final int userId;
  final String username;
  final String imageUrl;
  final String name;

  UserCard({required this.userId, required this.username, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            width: double.infinity, 
            height: 180, 
            color: Colors.blue,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Username: $username'),
                Text('Name: $name'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                       
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'TO-Dos',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Albums',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
