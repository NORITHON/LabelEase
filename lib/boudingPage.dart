import 'package:flutter/material.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter_http_input/image_size_getter_http_input.dart';

class BoundingPage extends StatefulWidget {
  const BoundingPage({super.key});

  @override
  State<BoundingPage> createState() => _BoundingState();
}

class _BoundingState extends State<BoundingPage> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              child: FutureBuilder(
                future: _getSize(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/hackathon-fee8f.appspot.com/o/project%2FPao5EdDppq20wLszEtN7%2Fimage%2010.png?alt=media&token=75fd3104-1983-4a9b-9775-9ca1b73e59b1',
                      width: snapshot.data!.width < MediaQuery.of(context).size.width
                          ? snapshot.data!.width.toDouble()
                          : snapshot.data!.width < MediaQuery.of(context).size.width*2
                              ? snapshot.data!.width.toDouble() / 2
                              : snapshot.data!.width < MediaQuery.of(context).size.width*4
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
          Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '0/10',
                style: Theme.of(context).textTheme.labelMedium,
              )),
          SizedBox(height:37),
          Center(
            child: Container(
              width: 365,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor ,
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
                  VerticalDivider(thickness: 5, width: 4, color: Colors.white),
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
          ),
          Positioned(
            bottom: 20,
              child: Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          //Respond to button press
                        },
                        child: Text("tool"),
                      ),
                      SizedBox(
                        width: 83,
                      ),
                      TextButton(
                        onPressed: () {
                          //Respond to button press
                        },
                        child: Text("label"),
                      )
                    ],
                  )))
          ),

        ],
      )),
    );
  }
}
