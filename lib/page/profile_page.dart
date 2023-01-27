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
        body: SingleChildScrollView(
          child: Padding(
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 160,
                      height: 210,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '현재 승인율',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Pretendard-Medium",
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/Group 55.png'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 210,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  '쌓인 크레딧',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Pretendard-Medium",
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 24,
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('10,000',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: "NanumSquareNeo-cBd")),
                                    const SizedBox(height: 5),
                                    const Text('coin',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "NanumSquareNeo-eHv")),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 340,
                  height: 40,
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F7FC),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '이전 프로젝트 내역',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Pretendard-Medium",
                          color: Colors.black,
                        ),
                      ),
                    ],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('자연물 이미지 인식',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/won.png',
                                  color: const Color(0xFFECC53A),
                                ),
                                Text(
                                  " 3000    ",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Image.asset(
                                  'assets/pencil.png',
                                  color: const Color(0xFFD7D7D7),
                                ),
                                Text(' 사진',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/Group43.png'),
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              '전체 중 87% 완료',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: "NanumSquareNeo-aLt",
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        )
                      ],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('자연물 사진 인식',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/won.png',
                                  color: const Color(0xFFD7D7D7),
                                ),
                                Text(
                                  " 500    ",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Image.asset(
                                  'assets/pencil.png',
                                  color: const Color(0xFFD7D7D7),
                                ),
                                Text(' 사진',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/Group41.png'),
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              '전체 중 40% 완료',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: "NanumSquareNeo-aLt",
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontFamily: "NanumSquareNeo-cBd"))
          ],
        ),
        Row(
          children: [
            Text(
              work,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: "Pretendard-Medium",
                color: Colors.black,
              ),
            )
          ],
        ),
      ],
    );
  }
}
