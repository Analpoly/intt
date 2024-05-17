
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intt/homepage.dart';
// import 'package:intelligentsia1/quizapp.dart/database1.dart';
// import 'package:intelligentsia1/quizapp.dart/homepage.dart';
import 'package:intt/quiz_database.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizSuccessPage extends StatelessWidget {
  const QuizSuccessPage({
    Key? key,
    required this.totalQuestions,
    required this.currentscore,
    required this.wrongAnswers,
    required this.level,
  }) : super(key: key);

  final int currentscore;
  final int totalQuestions;
  final int wrongAnswers;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 207, 178),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 207, 178),
        title: const Text(
          'Quiz Completed',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<String?>(
        future: getUsernameFromSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          String username = snapshot.data ?? '';
          return buildBody(username, context);
        },
      ),
    );
  }

  Widget buildBody(String username, BuildContext context) {
    return FutureBuilder<List<ScoreModel>>(
      future: ScoreDatabase().getData(),
      builder: (context, scoreSnapshot) {
        if (scoreSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (scoreSnapshot.hasError) {
          return Center(child: Text('Error: ${scoreSnapshot.error}'));
        }

        updateOrAddScore(username, scoreSnapshot.data);
        return buildContent(username, context);
      },
    );
  }

  void updateOrAddScore(String username, List<ScoreModel>? scores) {
    int previousScore = 0;
    if (scores != null && scores.isNotEmpty) {
      var data = scores.firstWhere(
        (element) => element.username == username,
        orElse: () => ScoreModel(username: '', score: null),
      );

      if (data.score != null) {
        previousScore = data.score!;
        if (previousScore < currentscore) {
          ScoreDatabase().updateScore(username, currentscore, level);
        }
      } else {
        addscoretoscoreboard(currentscore, username);
      }
    } else {
      addscoretoscoreboard(currentscore, username);
    }
  }

  Widget buildContent(String username, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'asset/animations/cup.json',
            width: 200,
            height: 200,
          ),
          const Text(
            'Eureka!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Total Questions: $totalQuestions',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Correct Answers: $currentscore',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Wrong Answers: $wrongAnswers',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(234, 245, 160, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> getUsernameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (kDebugMode) {
      print('Username retrieved from SharedPreferences: $username');
    }
    return username;
  }

  void addscoretoscoreboard(int currentscore, String username) async {
    final scoreModel = ScoreModel(
      username: username,
      score: currentscore,
      level: level,
    );
    await ScoreDatabase().sendData(scoreModel);
  }
}