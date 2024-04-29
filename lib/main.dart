import 'package:flutter/material.dart';
import 'course.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CGPA Calculator',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey)),
      home: const CgpaCalc(),
    );
  }
}

class CgpaCalc extends StatefulWidget {
  const CgpaCalc({super.key});

  @override
  State<StatefulWidget> createState() => _CgpaCalc();
}

class _CgpaCalc extends State<CgpaCalc> {
  List<Course> courses = [];
  String result = '';
  double res = 0.00;
  Map<String, double> grades = {
    'A+': 4.00,
    'A': 3.75,
    'A-': 3.50,
    'B+': 3.25,
    'B': 3.00,
    'B-': 2.75,
    'C+': 2.50,
    'C': 2.25,
    'D': 2.00,
    'F': 0.00,
  };

  @override
  void initState() {
    super.initState();
    addCourse();
  }

  void addCourse() {
    setState(() {
      Course newCourse = Course();
      newCourse.delete = () {
        setState(() {
          courses.removeWhere((c) => c == newCourse);
          result = '';
        });
      };
      courses.add(newCourse);
    });
  }

  void calculateCgpa() {
    double earnedScore = 0.0, totalCredit = 0.0;
    for (var course in courses) {
      String grade = course.chosenGrade;
      double credit = course.chosenCredit;
      earnedScore += (grades[grade]!) * credit;
      totalCredit += credit;
    }
    res = earnedScore / totalCredit;
    setState(() {
      result = 'CGPA: ${res.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CGPA Calculator"),
        backgroundColor: Colors.grey[400],
        centerTitle: true,
      ),
      body: ListView(children: [
        const SizedBox(height: 20,),
        ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red[900],
                  child: const Icon(Icons.delete),
                ),
                key: ValueKey<Course>(courses[index]),
                child: courses[index],
                onDismissed: (direction) {
                  setState(() {
                    courses.removeAt(index);
                  });
                },
              );
            }),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {
              addCourse();
            },
            child: const Text('Add Course'),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              calculateCgpa();
            },
            child: const Text(
              'Calculate',
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(result,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.green[600],
                )),
          ),
        ),
      ]),
    );
  }
}
