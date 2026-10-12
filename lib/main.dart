import 'package:flutter/material.dart';

// Bước 1: class Student gồm name, email (nullable), phone (nullable)
class Student {
  final String name;
  final String? email;
  final String? phone;

  Student({required this.name, this.email, this.phone});
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});
  static final List<Student> students = [
    Student(name: 'Nguyễn Văn An', email: 'an@sv.edu.vn', phone: '0901 234 567'),
    Student(name: 'Trần Thị Bình', email: null, phone: '0912 888 999'),
    Student(name: 'Lê Minh Chi', email: 'chi@sv.edu.vn', phone: null),
    Student(name: 'Phạm Quốc Dũng', email: null, phone: null),
    Student(name: 'Võ Thanh Em', email: 'em@sv.edu.vn', phone: '0933 111 222'),
  ];

  static const Color primaryColor = Color(0xFF2C4A7C);
  static const Color textGrey = Color(0xFF5F6673);
  static const Color missingRed = Color(0xFFC62828);

  Widget _infoRow(String label, String? value) {
    final bool isMissing = value == null;
    final String shown = value ?? 'Chưa cập nhật';

    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 13, color: textGrey),
          ),
          Text(
            shown,
            style: TextStyle(
              fontSize: 13,
              color: isMissing ? missingRed : textGrey,
              fontStyle: isMissing ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _studentCard(Student s) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E8EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B2333),
            ),
          ),
          const SizedBox(height: 4),
          _infoRow('Email', s.email),
          _infoRow('SĐT', s.phone),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [];
    for (int i = 0; i < students.length; i++) {
      cards.add(_studentCard(students[i]));
    }
    int missingEmailCount = 0;
    for (int i = 0; i < students.length; i++) {
      if (students[i].email == null) {
        missingEmailCount++;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Danh sách sinh viên',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...cards,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 14, color: primaryColor),
                      children: [
                        const TextSpan(text: 'Tổng: '),
                        TextSpan(
                          text: '${students.length} sinh viên',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 14, color: primaryColor),
                      children: [
                        const TextSpan(text: 'Thiếu email: '),
                        TextSpan(
                          text: '$missingEmailCount',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: missingRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
