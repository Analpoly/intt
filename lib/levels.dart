
import 'package:flutter/material.dart';
import 'package:intt/question.dart';

class DifficultyLevels extends StatelessWidget {
  final String categoryId;

  DifficultyLevels({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    String _getUrl(String difficulty, int amount) =>
        'https://opentdb.com/api.php?amount=$amount&category=$categoryId&difficulty=$difficulty&type=multiple';

    Widget _buildDifficultyCard(String difficulty, int amount) => Container(
          height: 100,
          width: 100,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            child: ListTile(
              title: Text(difficulty, textAlign: TextAlign.center),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(categoryUrl: _getUrl(difficulty.toLowerCase(), amount), level: difficulty),
                  ),
                );
              },
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 192, 207, 178),
        title: Text('Difficulty Levels', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Color.fromARGB(255, 192, 207, 178),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDifficultyCard('Easy', 10),
            SizedBox(height: 15),
            _buildDifficultyCard('Medium', 12),
            SizedBox(height: 15),
            _buildDifficultyCard('Hard', 15),
          ],
        ),
      ),
    );
  }
}