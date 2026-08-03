
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(LichAmApp());

class LichAmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lịch Âm Dương',
      theme: ThemeData(primarySwatch: Colors.red, scaffoldBackgroundColor: Color(0xFFFEF9E7)),
      home: LichHome(),
    );
  }
}

class LichHome extends StatefulWidget { @override _LichHomeState createState() => _LichHomeState(); }

class _LichHomeState extends State<LichAmApp> {
  DateTime selected = DateTime.now();
  DateTime displayMonth = DateTime.now();

  // Simple lunar conversion approx (for demo, real app use lunar lib)
  String toLunar(DateTime d) {
    // Approx - real implementation uses amlich algorithm
    int lunarDay = (d.day + 10) % 30 + 1;
    int lunarMonth = d.month;
    return "$lunarDay/$lunarMonth";
  }

  String canChi(DateTime d) {
    List can = ["Giáp","Ất","Bính","Đinh","Mậu","Kỷ","Canh","Tân","Nhâm","Quý"];
    List chi = ["Tý","Sửu","Dần","Mão","Thìn","Tỵ","Ngọ","Mùi","Thân","Dậu","Tuất","Hợi"];
    return "${can[d.year % 10]} ${chi[d.year % 12]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB71C1C),
        title: Column(children:[
          Text("Lịch Vạn Niên", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(DateFormat("EEEE, dd/MM/yyyy", "vi").format(selected), style: TextStyle(fontSize:12))
        ]),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFFB71C1C),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
                  Text("${selected.day}", style: TextStyle(fontSize:48, color:Colors.white, fontWeight:FontWeight.bold)),
                  Text("Tháng ${selected.month} - ${canChi(selected)}", style: TextStyle(color:Colors.amber[200]))
                ]),
                Column(children:[
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
                    child: Column(children:[
                      Text("ÂM LỊCH", style: TextStyle(fontSize:10, fontWeight: FontWeight.bold)),
                      Text("${toLunar(selected)}", style: TextStyle(fontSize:22, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  SizedBox(height:8),
                  Text("Ngày tốt", style: TextStyle(color: Colors.white, backgroundColor: Colors.green)),
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
              IconButton(onPressed: (){setState(()=>displayMonth=DateTime(displayMonth.year, displayMonth.month-1));}, icon: Icon(Icons.chevron_left)),
              Text("Tháng ${displayMonth.month} / ${displayMonth.year}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:18)),
              IconButton(onPressed: (){setState(()=>displayMonth=DateTime(displayMonth.year, displayMonth.month+1));}, icon: Icon(Icons.chevron_right)),
            ]),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemCount: DateTime(displayMonth.year, displayMonth.month+1,0).day + DateTime(displayMonth.year, displayMonth.month,1).weekday -1,
              itemBuilder: (c,i){
                int startOffset = DateTime(displayMonth.year, displayMonth.month,1).weekday -1;
                if(i<startOffset) return SizedBox();
                int day = i-startOffset+1;
                bool isToday = day==DateTime.now().day && displayMonth.month==DateTime.now().month;
                bool isSelected = day==selected.day && displayMonth.month==selected.month;
                return GestureDetector(
                  onTap: ()=>setState(()=>selected=DateTime(displayMonth.year, displayMonth.month, day)),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected?Colors.red: isToday?Colors.amber[100]:Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isToday?Colors.red: Colors.grey.shade200),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
                      Text("$day", style: TextStyle(fontWeight: isSelected?FontWeight.bold:FontWeight.normal, color: isSelected?Colors.white:Colors.black)),
                      Text("${toLunar(DateTime(displayMonth.year, displayMonth.month, day))}", style: TextStyle(fontSize:9, color: Colors.grey[600])),
                    ]),
                  ),
                );
              }
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Row(children:[Icon(Icons.wb_sunny, color: Colors.orange), SizedBox(width:6), Text("Giờ hoàng đạo: Dần (3-5h), Mão (5-7h), Tỵ (9-11h)", style: TextStyle(fontSize:12))]),
              SizedBox(height:6),
              Row(children:[Icon(Icons.check_circle, color: Colors.green, size:18), SizedBox(width:6), Text("Nên: Khai trương, cưới hỏi, động thổ", style: TextStyle(fontSize:12))]),
              Row(children:[Icon(Icons.cancel, color: Colors.red, size:18), SizedBox(width:6), Text("Kiêng: An táng, xuất hành xa", style: TextStyle(fontSize:12))]),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Text("Quảng cáo AdMob sẽ hiện ở đây - Kiếm lúa", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize:11)),
      ),
    );
  }
}
