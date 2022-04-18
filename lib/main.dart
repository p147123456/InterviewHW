import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexCount
{
  IndexCount({int index,int count,MaterialColor color})
  {
    this.index = index;
    this.count = count;
    this.color = color;
  }
  int index =0;
  int count = 0;
  MaterialColor color = Colors.blue;
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '面試題目',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '面試題目'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<IndexCount> _list = <IndexCount>[];
  int _index1 = 0;
  int _index2 = 0;
  @override
  void initState() {
    for(int i=0 ; i<10 ; i++)
    {
      _list.add(new IndexCount(index: i,count: 0,color:Colors.primaries[Random().nextInt(Colors.primaries.length)]));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Flex(
              direction: Axis.horizontal,
              children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (v)
                  {
                    if( v.isNotEmpty){ _index1 = int.tryParse(v); }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "輸入index1",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (v)
                    {
                      if( v.isNotEmpty){ _index2 = int.tryParse(v); }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "輸入index2",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    onPressed: (){
                      if(!_checkInputIsValidator(_index1,_index2)) return;
                      int indexTemp1 = _list.indexWhere((item) => item.index == _index1);
                      int indexTemp2 = _list.indexWhere((item) => item.index == _index2);

                      var temp = _list[indexTemp1];
                      _list[indexTemp1] = _list[indexTemp2];
                      _list[indexTemp2] = temp;
                      setState(() {});
                    },
                    child: Text('交換',style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),

                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _list.length
              ,itemBuilder: (context, index){
                return Container(
                  color: _list[index].color,
                  child: ListTile(
                    title: Text('${_list[index].index}.點擊數量${_list[index].count}',style: TextStyle(color: Colors.white),),
                    trailing: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _list[index].count++;
                        });
                      }, child: Text('點擊+1',style: TextStyle(color: Colors.black),),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                  ),
                );
              }),)
        ],
      ),
    );
  }

  ///檢查輸入的數字是否在範圍內
  bool _checkInputIsValidator(int index1,int index2)
  {
    if( index1>_list.length-1 || index2>_list.length-1) return false;
    return true;
  }
}
