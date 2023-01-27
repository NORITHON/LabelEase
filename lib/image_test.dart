import 'package:flutter/material.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter_http_input/image_size_getter_http_input.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late Size size;

  Future<Size> _getSize() async {
    const testUrl =
        'https://mblogthumb-phinf.pstatic.net/20130508_178/ichufs_1367997175282LLvRG_JPEG/IMG_3337s.jpg?type=w2';
    final httpInput = await HttpInput.createHttpInput(testUrl);
    size = await ImageSizeGetter.getSizeAsync(httpInput);

    return size;
  }

  void _handleTapDown(BuildContext context, var dx, var dy) {
    print("size: $size");
    print("$dx / $dy");
    print("${dx / size.width * 2} / ${dy / size.height * 2}");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            child: FutureBuilder(
              future: _getSize(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.network(
                    'https://mblogthumb-phinf.pstatic.net/20130508_178/ichufs_1367997175282LLvRG_JPEG/IMG_3337s.jpg?type=w2',
                    width: snapshot.data!.width < 390
                        ? snapshot.data!.width.toDouble()
                        : snapshot.data!.width < 741
                            ? snapshot.data!.width.toDouble() / 2
                            : snapshot.data!.width < 1100
                                ? snapshot.data!.width.toDouble() / 3
                                : snapshot.data!.width.toDouble() / 4,
                    height: snapshot.data!.height.toDouble() / 2,
                    fit: BoxFit.cover,
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            onTapDown: (details) {
              _handleTapDown(
                context,
                details.localPosition.dx,
                details.localPosition.dy,
              );
            },
          ),
        ),
      ),
    );
  }
}
