import 'package:flutter/material.dart';

import 'project_view_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 160),
        child: Column(
          children: [
            const HomeItem(
              width: 350,
              height: 300,
              title: '',
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const HomeItem(
                    width: 170,
                    height: 200,
                    title: '프로젝트 참여하기',
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectViewPage(),
                    ),
                  ),
                ),
                const HomeItem(
                  width: 170,
                  height: 200,
                  title: '',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  final double width;
  final double height;
  final String title;

  const HomeItem({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.yellow,
      ),
      width: width,
      height: height,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
