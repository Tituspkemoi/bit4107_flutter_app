import 'package:flutter/material.dart';
import '../models/student.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({super.key});

  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  final List<Student> students = [];

  void registerStudent() {
    String name = nameController.text;
    String regNo = regController.text;
    String course = courseController.text;

    if (name.isEmpty || regNo.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      students.add(
        Student(
          name: name,
          regNo: regNo,
          course: course,
        ),
      );
    });

    nameController.clear();
    regController.clear();
    courseController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student Registered Successfully")),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    regController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Student Name"),
            ),
            TextField(
              controller: regController,
              decoration: const InputDecoration(labelText: "Registration Number"),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: "Course"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerStudent,
              child: const Text("Register"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Registered Students",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    child: ListTile(
                      title: Text(student.name),
                      subtitle: Text(
                        "${student.regNo} • ${student.course}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}