import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F7FC),
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          title: Text(
            '내 정보',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          foregroundColor: const Color(0xFFF4F7FC),
          backgroundColor: const Color(0xFFF4F7FC),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                width: 340,
                height: 20,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F7FC),
                ),
                child: const Text(
                  '나의 작업',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Pretendard-Medium",
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  width: 340,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        WorkItem(number: 3, work: '제출'),
                        Bar(),
                        WorkItem(number: 5, work: '대기'),
                        Bar(),
                        WorkItem(number: 4, work: '완료'),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/Line 5.png',
          color: const Color(0xFFD7D7D7),
        ),
      ],
    );
  }
}

class WorkItem extends StatelessWidget {
  final int number;
  final String work;
  const WorkItem({
    Key? key,
    required this.number,
    required this.work,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text('$number',
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "NanumSquareNeo-eHv",
                    color: Theme.of(context).primaryColor))
          ],
        ),
        Row(
          children: [
            Text(work, style: Theme.of(context).textTheme.displayMedium)
          ],
        ),
      ],
    );
  }
}
