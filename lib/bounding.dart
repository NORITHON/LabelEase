import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 34.0, fontFamily: "NanumSquareNeo"),
          titleMedium: TextStyle(fontSize: 28.0, fontFamily: "NanumSquareNeo"),
          titleSmall: TextStyle(fontSize: 22.0, fontFamily: "NanumSquareNeo"),
          subtitle1: TextStyle(fontSize: 20.0, fontFamily: "NanumSquareNeo"),,
          bodyLarge: TextStyle(fontSize: 17.0, fontFamily: "Pretendard"),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: "Pretendard"),
          bodySmall: TextStyle(fontSize: 14.0, fontFamily: "Pretendard"),
          labelMedium: TextStyle(fontSize: 12.0, fontFamily: "Pretendard"),
          labelSmall: TextStyle(fontSize: 10.0, fontFamily: "Pretendard"),
        ),

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    dynamic _boundingBox;
    double startXpos = 100;
    double startYpos = 100;
    double xPos = 100;
    double yPos = 100;
    bool isClick = false;

    void _drawBoundingBox (BuildContext context, var dx, var dy){
      print('x: $dx, y: $dy');
    }


    void _startPosition(BuildContext context, var dx) {
     print('position : $dx');
    }


  @override
  Widget build(BuildContext context) {

    _boundingBox= _paint (
        startXPosition : startXpos,
        startYPosition :startYpos,
        xPosition: xPos,
        yPosition: yPos,
    );
    return GestureDetector(

        child: Stack(
          children: <Widget>[
            Image.asset('assets/dog.jpeg'),
            Container(
              child: CustomPaint(
                painter: _boundingBox,
              ),
            )
          ],
        ),

        onVerticalDragUpdate: (DragUpdateDetails details){
          setState(() {
            startXpos = details.localPosition.dx;
            startYpos = details.localPosition.dy;

          });
          _drawBoundingBox(context, details.globalPosition.dx, details.globalPosition.dy);
        },

        onVerticalDragStart: (DragStartDetails details){

            setState(() {
              xPos = details.localPosition.dx;
              yPos = details.localPosition.dy;
            });
            _startPosition(
                context, details);
          }


    );
  }
}

class _paint extends CustomPainter {

  final startXPosition ;
  final startYPosition ;
  final xPosition ;
  final yPosition;

  _paint({
    required this.startXPosition,
    required this.startYPosition,
    required this.xPosition,
    required this.yPosition
});

  @override
  void paint(Canvas canvas, Size size){
    final paint = (startXPosition == xPosition) ?
    (Paint()
    ..color = Colors.transparent
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke) :
    (Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke);

    final a = Offset(startXPosition, startYPosition);
    final b = Offset(xPosition, yPosition);
    print("a : $a, b: $b");
    final rect =  Rect.fromPoints(b,a);
    
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
