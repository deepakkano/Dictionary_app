import 'package:flutter/material.dart';
import 'package:loginapp/SearchScreen.dart';
import 'package:loginapp/models/Datbase.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DBHandler _dbHandler = DBHandler();
// Searchscreen searchscreen=Searchscreen();
  Future<List<Map<String, dynamic>>> _fetchWords() async {
    try {
      return await _dbHandler.fetchAllWords();
    } catch (e) {
      print('Error fetching words: $e');
      return [];
    }
  }

  Future<void> _deleteWord(int id) async {
    try {
      await _dbHandler.deleteWord(id);
      setState(() {}); 
    } catch (e) {
      print('Error deleting word: $e');
    }
  }


//   Searchword(String word){
// searchscreen.
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchWords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No words found'));
            } else {
              final words = snapshot.data!;
              return ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return Dismissible(
                    key: Key(word['id'].toString()),
                    onDismissed: (direction) {
                      _deleteWord(word['id']);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        tileColor: Colors.teal.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          word['Word'] ?? 'No word',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteWord(word['id']);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}