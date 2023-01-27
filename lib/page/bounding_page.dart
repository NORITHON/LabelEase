import 'package:flutter/material.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter_http_input/image_size_getter_http_input.dart';
import 'home_page.dart';
import 'dart:ui' as UI;

class BoundingPage extends StatefulWidget {
  const BoundingPage({super.key});

  @override
  State<BoundingPage> createState() => _BoundingState();
}

class _BoundingState extends State<BoundingPage> {
  late Size size;
  dynamic _boundingBox;
  double startXpos = 100;
  double startYpos = 100;
  double xPos = 100;
  double yPos = 100;
  bool isClick = false;

  void _drawBoundingBox(BuildContext context, var dx, var dy) {
    print('x is  $dx, y is $dy');
  }

  void _startPosition(BuildContext context, var dx) {
    print('start position : $dx');
  }

  Future<Size> _getSize() async {
    const testUrl =
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*';
    final httpInput = await HttpInput.createHttpInput(testUrl);
    size = await ImageSizeGetter.getSizeAsync(httpInput);

    return size;
  }

  void _handleTapDown(BuildContext context, var dx, var dy) {
    print("size: $size");
    print("$dx / $dy");
    print("${dx / size.width } / ${dy / size.height }");
  }

  @override
  Widget build(BuildContext context) {
    _boundingBox = _paint(
      startXPosition: startXpos,
      startYPosition: startYpos,
      xPosition: xPos,
      yPosition: yPos,
    );

    return Scaffold(
        backgroundColor:  Color(0xFFF4F7FC),
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        insetPadding: const EdgeInsets.symmetric(
                            vertical: 260, horizontal: 0),
                        content: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/caution.png',
                                width: 100,
                              ),
                              const SizedBox(height: 23),
                              Text(
                                  '아직 한 세트를 완료하지 못했습니다\n세트를 완료하지 못하면 리워드 수령에 \n어려움이 있을 수 있습니다. \n\n뒤로 가시겠습니까?',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      '아니오',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: Text(
                                      '예',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ));
                  },
                );
              },
              color: Colors.black,
              icon: Icon(Icons.keyboard_arrow_left_rounded)),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Positioned(
                top: 0,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height) * 3 / 5,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        FutureBuilder(
                          future: _getSize(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(
                                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*',
                                // width: snapshot.data!.width <
                                //         MediaQuery.of(context).size.width
                                //     ? snapshot.data!.width.toDouble()
                                //     : snapshot.data!.width <
                                //             MediaQuery.of(context).size.width *
                                //                 2
                                //         ? snapshot.data!.width.toDouble() / 2
                                //         : snapshot.data!.width <
                                //                 MediaQuery.of(context)
                                //                         .size
                                //                         .width *
                                //                     4
                                //             ? snapshot.data!.width.toDouble() /
                                //                 3
                                //             : snapshot.data!.width.toDouble() /
                                //                 4,
                                // height: snapshot.data!.height.toDouble() ,
                                fit: BoxFit.cover,
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                        Container(
                            child: CustomPaint(
                          painter: _boundingBox,
                        ))
                      ],
                    ),
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      setState(() {
                        startXpos = details.localPosition.dx;
                        startYpos = details.localPosition.dy;
                      });
                      _drawBoundingBox(context, details.globalPosition.dx,
                          details.globalPosition.dy);
                    },

                    onVerticalDragStart: (DragStartDetails details) {
                      setState(() {
                        xPos = details.localPosition.dx;
                        yPos = details.localPosition.dy;
                      });
                      _startPosition(context, details);
                    },
                    onTapDown: (details) {
                      _handleTapDown(
                        context,
                        details.localPosition.dx,
                        details.localPosition.dy,
                      );
                    },
                  ),
                )),
            Positioned(
                bottom: 60,
                child: Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/5,
                    color: Color(0xFFF4F7FC),
                    child: Column(
                      children: [
                        Text(
                          '0/10',
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height:24),
                        Container(
                          width: 365,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(24.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //action coe when button is pressed
                                },
                                icon: Icon(Icons.settings_backup_restore),
                              ),
                              IconButton(
                                onPressed: () {
                                  //action coe when button is pressed
                                },
                                icon: Icon(Icons.call),
                              ),
                              VerticalDivider(
                                  thickness: 5, width: 4, color: Colors.white),
                              IconButton(
                                onPressed: () {
                                  //action coe when button is pressed
                                },
                                icon: Icon(Icons.call),
                              ),
                              IconButton(
                                onPressed: () {
                                  //action coe when button is pressed
                                },
                                icon: Icon(Icons.mail),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                //Respond to button press
                              },
                              child: Text("tool", style: TextStyle(color: Colors.black, fontSize: 17) ),
                            ),
                            SizedBox(width: 24),
                            TextButton(
                              onPressed: () {
                                //Respond to button press
                              },
                              child: Text("label", style: TextStyle(color: Colors.black, fontSize: 17) ),
                            )
                          ],
                        )
                      ],
                    ))),
          ],
        ));
  }
}

class _paint extends CustomPainter {
  final startXPosition;
  final startYPosition;

  final xPosition;

  final yPosition;

  _paint(
      {required this.startXPosition,
      required this.startYPosition,
      required this.xPosition,
      required this.yPosition});

  @override
  void paint(Canvas canvas, UI.Size size) {
    final paint = (startXPosition == xPosition)
        ? (Paint()
          ..color = Colors.transparent
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke)
        : (Paint()
          ..color = Color(0xFF6D3DD2)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);

    final a = Offset(startXPosition, startYPosition);
    final b = Offset(xPosition, yPosition);
    print("a : $a, b: $b");
    final rect = Rect.fromPoints(b, a);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
