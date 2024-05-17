
import 'package:flutter/material.dart';
// import 'package:intelligentsia1/quizapp.dart/levels.dart';
import 'package:intt/levels.dart';

class CategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'General Knowledge', 'categoryId': '9'},
    {'name': 'Science',  'categoryId': '18'},
    {'name': 'Sports', 'categoryId': '21'},
    {'name': 'Film',  'categoryId': '11'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 192, 207, 178),
      ),
      body: ListView(
        children: [
          Container(
            color: Color.fromARGB(255, 192, 207, 178),
            child: Column(
              children: [
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                      // child: Image.asset(categories[index]['image']),
                    ),
                  ),
                ),
                Text("Categories", style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: 90,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          // leading: Image.asset(categories[index]['image']),
                          title: Text(categories[index]['name']),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DifficultyLevels(
                                categoryId: categories[index]['categoryId'],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}