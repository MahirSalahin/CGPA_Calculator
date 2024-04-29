import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  double chosenCredit = 0.0;
  String chosenGrade = 'A+';
  late VoidCallback delete;

  Course({super.key});
  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  List<String> grades = <String>[
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'D',
    'F'
  ];

  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20),
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Course name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(),
            // inputFormatters:[],
            textInputAction: TextInputAction.done,
            onChanged: (String value) {
              widget.chosenCredit = double.tryParse(value)??0.0;
            },
            onTapOutside: (x){
              FocusScope.of(context).nextFocus();
            },
            decoration: const InputDecoration(
              hintText: 'Credit',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 20),
        DropdownButton<String>(
            hint: const Text('Choose Grade'),
            value: widget.chosenGrade,
            items: grades.map<DropdownMenuItem<String>>((String newVal) {
              return DropdownMenuItem<String>(
                value: newVal,
                child: Text(newVal),
              );
            }).toList(),
            onChanged: (String? newVal) {
              setState(() {
                widget.chosenGrade = newVal!;
              });
            }),
        const SizedBox(width: 20),
        IconButton(onPressed: widget.delete, icon: const Icon(Icons.delete)),
      ],
    );
  }
}
