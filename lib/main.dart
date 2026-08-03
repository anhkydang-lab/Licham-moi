import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lich Am Duong Hoa No',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<int, String> hoaNoTheoThang = {
    1: "Hoa Mai, Hoa Dao",
    2: "Hoa Dao, Hoa Ban",
    3: "Hoa Sau, Hoa Gao",
    4: "Hoa Loa Ken, Hoa Phuong Tim",
    5: "Hoa Phuong, Hoa Bang",
    6: "Hoa Sen, Hoa Muong",
    7: "Hoa Sen, Hoa Huong Duong",
    8: "Hoa Cuc, Hoa Sua",
    9: "Hoa Cuc, Hoa Sua",
    10: "Hoa Cuc, Hoa Sua, Hoa Cai",
    11: "Hoa Cai, Hoa Da Quynh",
    12: "Hoa Mai, Hoa Man",
  };

  String amLichDemo(DateTime d) {
    // Demo don gian, muon chuan thi them thu vien am lich
    return "Ngay ${d.day} - Thang ${(d.month+5)%12 +1} AL (demo)";
  }

  @override
  Widget build(BuildContext context) {
    final thang = _selectedDay?.month ?? _focusedDay.month;
    return Scaffold(
      appBar: AppBar(title: const Text("Lich Am Duong - Hoa No"), centerTitle: true, backgroundColor: Colors.green[700], foregroundColor: Colors.white),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() { _selectedDay = selected; _focusedDay = focused; });
            },
            calendarStyle: const CalendarStyle(todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(_selectedDay != null ? DateFormat('dd/MM/yyyy').format(_selectedDay!) : "Chon 1 ngay", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(amLichDemo(_selectedDay ?? _focusedDay), style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green)),
                  child: Row(
                    children: [
                      const Icon(Icons.local_florist, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(child: Text("Hoa no thang $thang: ${hoaNoTheoThang[thang]}", style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}