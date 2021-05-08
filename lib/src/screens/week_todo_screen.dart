import 'package:flutter/material.dart';

class WeekTodoScreen extends StatefulWidget {
  @override
  _WeekTodoScreenState createState() => _WeekTodoScreenState();
}

class _WeekTodoScreenState extends State<WeekTodoScreen> {
  List<bool> _isExpanded = [false, false, false, false, false, false, false];
  List<String> _titles = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _titles.length,
        itemBuilder: (context, index) {
          return ExpansionPanelList(
            expansionCallback: (_, isExpanded) {
              setState(() {
                _isExpanded[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(title: Text(_titles[index]));
                  },
                  body: ListBody(
                    children: [
                      ListTile(
                          leading: Icon(Icons.check_box_outline_blank),
                          title: Text('Ders çalış'),
                          subtitle: Text('10.00')),
                      ListTile(
                          leading: Icon(Icons.check_box_outline_blank),
                          title: Text('Ders çalış'),
                          subtitle: Text('10.00')),
                    ],
                  ),
                  isExpanded: _isExpanded[index]),
            ],
          );
        },
      ),
    );
  }
}
