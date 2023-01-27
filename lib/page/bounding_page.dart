import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/service/project_service.dart';
import 'package:provider/provider.dart';

import 'dart:ui' as UI;

import 'home_page.dart';

class BoundingPage extends StatefulWidget {
  const BoundingPage({super.key, required this.projectId});

  final String projectId;

  @override
  State<BoundingPage> createState() => _BoundingState(projectId: projectId);
}

class _BoundingState extends State<BoundingPage> {
  _BoundingState({required this.projectId});

  final String projectId;
  bool isTool = true;
  bool isLabel = false;
  late List<bool> isSelected;
  late Size imageSize = const Size(0, 0);
  dynamic _boundingBox;
  double startXpos = 100;
  double startYpos = 100;
  double xPos = 100;
  double yPos = 100;
  bool isClick = false;

  @override
  void initState() {
    // TODO: implement initState
    isSelected = [isTool, isLabel];
    super.initState();
  }

  void toggleSelect(value) {
    if (value == 0) {
      isTool = true;
      isLabel = false;
    } else {
      isTool = false;
      isLabel = true;
    }
    setState(() {
      isSelected = [isTool, isLabel];
    });
  }

  void _drawBoundingBox(BuildContext context, var dx, var dy) {
    print('x: $dx, y: $dy');
  }

  void _startPosition(BuildContext context, var dx) {
    print('position : $dx');
  }

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('project')
        .doc(projectId)
        .collection('images');
    _boundingBox = _paint(
      startXPosition: startXpos,
      startYPosition: startYpos,
      xPosition: xPos,
      yPosition: yPos,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        elevation: 0,
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
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/caution.png',
                            height: 50,
                          ),
                          const SizedBox(height: 5),
                          Text(
                              '아직 한 세트를 완료하지 못했습니다\n세트를 완료하지 못하면 리워드 수령에 \n어려움이 있을 수 있습니다. \n\n뒤로 가시겠습니까?',
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  '아니오',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                              const SizedBox(width: 40),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                },
                                child: Text(
                                  '예',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            color: Colors.black,
            icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              color: const Color(0xFFF4F7FC),
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 3 / 5,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Stack(
                  children: [
                    Consumer<ProjectService>(
                      builder: (context, projectService, _) {
                        return FutureBuilder<QuerySnapshot>(
                          future: projectService.readImage(projectId),
                          builder: (context, snapshot) {
                            final docs = snapshot.data?.docs ?? [];
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                final doc = docs[index];
                                String image = doc.get('imageUrl');
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      child: CustomPaint(
                        painter: _boundingBox,
                      ),
                    ),
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
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                '0/10',
                style: Theme.of(context).textTheme.displaySmall,
              )),
          const SizedBox(height: 37),
          Center(
            child: isTool == true
                ? Container(
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
                            setState(() {
                              startXpos = xPos;
                            });
                          },
                          icon: const Icon(
                            Icons.undo,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            //action coe when button is pressed
                          },
                          icon: const Icon(
                            Icons.redo,
                            color: Colors.white,
                          ),
                        ),
                        const VerticalDivider(
                            thickness: 5, width: 4, color: Colors.white),
                        IconButton(
                          onPressed: () {
                            //action coe when button is pressed
                            if (startXpos != xPos) {
                              setState(() {
                                isSelected[0] = false;
                                isSelected[1] = true;
                                isTool = false;
                                isLabel = true;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.crop,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            //action coe when button is pressed
                          },
                          icon: const Icon(
                            Icons.open_with_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 365,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              )),
                          onPressed: () {
                            ref.doc('9Bq9BSuqZF2L5M6T3I4Y').update({
                              'uid': authService.currentUser()!.uid,
                              'isSolved': true,
                              'x1': startXpos,
                              'y1': startYpos,
                              'x2': xPos,
                              'y2': yPos,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('제출하셨습니다!'),
                              ),
                            );
                            setState(() {
                              startXpos = xPos;
                            });
                          },
                          child: Text(
                            '나무',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              )),
                          onPressed: () {
                            ref.doc('w3jkpOVGPdmWj93uASM6').update({
                              'uid': authService.currentUser()!.uid,
                              'isSolved': true,
                              'x1': startXpos,
                              'y1': startYpos,
                              'x2': xPos,
                              'y2': yPos,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('제출하셨습니다!'),
                              ),
                            );
                          },
                          child: Text(
                            '꽃',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              )),
                          onPressed: () {},
                          child: Text(
                            '들풀',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              )),
                          onPressed: () {},
                          child: Text(
                            '덤불',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: isSelected,
                    renderBorder: false,
                    color: Colors.grey,
                    selectedColor: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor,
                    onPressed: toggleSelect,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('tool'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('label'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _paint extends CustomPainter {
  final double startXPosition;
  final double startYPosition;
  final double xPosition;
  final double yPosition;

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
          ..color = const Color(0xFF6D3DD2)
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
