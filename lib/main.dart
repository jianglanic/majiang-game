// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

void main() => runApp(GameScoreCalculation());

class GameScoreCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Flutter Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Chart Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key ? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Player {
  final String name;
  final int? score;
  charts.Color color;

  Player(this.name, this.score, Color color)
    : this.color = new charts.Color(
      r: color.red,
      g: color.green,
      b: color.blue,
      a: color.alpha
    );

  charts.Color renderColor() {
    Color colorToRender = Color(0xffe33a13);
    if (this.score! < 0) {
       colorToRender = Color(0xffbf0e0e);
    } else if (this.score! <=10) {
      // red
      colorToRender = Color(0xffe33a13);
    } else if (this.score! <= 20) {
      colorToRender = Color(0xfff14118);
    } else if (this.score! <= 30) {
      colorToRender = Color(0xffff4f21);
    } else if (this.score! <= 40) {
      colorToRender = Color(0xffff6b43);
    } else if (this.score! <= 50) {
      // yellow
      colorToRender = Color(0xffffa900);
    } else if (this.score! <= 60) {
      colorToRender = Color(0xffffc200);
    } else if (this.score! <= 70) {
      colorToRender = Color(0xfff8e800);
    } else if (this.score! <= 80) {
      colorToRender = Color(0xfffaed3f);
    } else if (this.score! <= 90) {
      // blue
      colorToRender = Color(0xff008cd8);
    } else if (this.score! <= 100) {
      colorToRender = Color(0xff00adf9);
    } else if (this.score! <= 110) {
      colorToRender = Color(0xff00c6f8);
    } else if (this.score! <= 120) {
      colorToRender = Color(0xff6fd7f9);
    } else if (this.score! <= 130) {
      // purple
      colorToRender = Color(0xff7912e5);
    } else if (this.score! <= 140) {
      colorToRender = Color(0xff9410ec);
    } else if (this.score! <= 150) {
      colorToRender = Color(0xffb641f5);
    } else if (this.score! <= 160) {
      colorToRender = Color(0xffc468f8);
    } else if (this.score! <= 170) {
      // green
      colorToRender = Color(0xff98f973);
    } else if (this.score! <= 180) {
      colorToRender = Color(0xff77f54a);
    } else if (this.score! <= 190) {
      colorToRender = Color(0xff3de000);
    } else if (this.score! <= 200) {
      colorToRender = Color(0xff00b500);
    } else {
      colorToRender = Color(0xfff875d7);
    }
    return new charts.Color(
      r: colorToRender.red,
      g: colorToRender.green,
      b: colorToRender.blue,
      a: colorToRender.alpha,
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, int> _playerToScoreMap = {
    'Player1': 50,
    'Player2': 50,
    'Player3': 50,
    'Player4': 50};
  var _currentPlayer = 'Player1';
  var _selectedPlayer;
  var _scoreToPay = 0.0;

  void _updateScore(String player, int score) {
    setState(() {
      if (player != null)  {
        _playerToScoreMap.update(player, (oldScore) {
          return  oldScore + score;
        });
        _playerToScoreMap.update(_currentPlayer, (oldScore) {
          return oldScore - score;
        });
        var t = _playerToScoreMap[player];
        print('player: $player');
        print('score: $t');
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      Player('Player1', _playerToScoreMap['Player1'], Colors.orangeAccent),
      Player('Player2', _playerToScoreMap['Player2'], Colors.lightBlue),
      Player('Player3', _playerToScoreMap['Player3'], Colors.pinkAccent),
      Player('Player4', _playerToScoreMap['Player4'], Colors.green),
    ];


    var series = [
      charts.Series(
        domainFn: (Player clickData, _) => clickData.name,
        measureFn: (Player clickData, _) => clickData.score,
        colorFn: (Player clickData, _) => clickData.renderColor(),
        id: 'Clicks',
        data: data,
        labelAccessorFn: (Player clickData, _) => '${clickData.score}',
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator(
        insideLabelStyleSpec: new charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 20,
        ),
        outsideLabelStyleSpec: new charts.TextStyleSpec(
          color: charts.MaterialPalette.black,
          fontSize: 14,
        ),
      ),
      // barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 14, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.black))),
    );

    // var chartWidget = Padding(
    //   padding: EdgeInsets.all(42.0),
    //   child: FractionallySizedBox(
    //     widthFactor: 1.0,
    //     heightFactor: 1.0,
    //     child: chart,
    //   ),
    // );

    var chartWidget =  FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: chart,
      );

    double _sliderMin = 0;
    double _sliderMax = 15;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(9.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Current Player: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ), 
                Text(
                  '$_currentPlayer',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ), 
              ],
             ),
            Flexible(
              child: chartWidget,
            ),
            Text(
              'Score to pay: $_scoreToPay',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
            ),
            SliderTheme(
              data:Theme.of(context).sliderTheme.copyWith(
                trackHeight: 25.0,
                thumbColor: Colors.limeAccent,
              ),
              child: Slider(
                min: _sliderMin,
                max: _sliderMax,
                divisions: _sliderMax.toInt(),
                label: '$_scoreToPay',
                value: _scoreToPay,
                onChanged: (value) {
                  setState(() {
                    _scoreToPay = value;
                  });
                },
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                ),
                Text(
                  '$_sliderMin',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  '$_sliderMax',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 35.0),
                ),
              ],
            ),
            DropdownButton<String>(
              value: _selectedPlayer,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600),
              items: <String>[
                'Player1',
                'Player2',
                'Player3',
                'Player4',
              ]
              .where((player) => player != _currentPlayer)
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                'Select a player to pay',
                style: TextStyle(
                    color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
                ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPlayer = newValue!;
                  print('Selected: $_selectedPlayer');
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pay: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  _selectedPlayer == null? '' : '$_selectedPlayer',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' with score: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$_scoreToPay',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {_updateScore(_selectedPlayer, _scoreToPay.toInt());},
                child: Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(9.0),
            )
          ],
        ),
      ),
    );
  }
}
