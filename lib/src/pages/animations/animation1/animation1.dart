import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './details.dart';

const List<String> images = [
  "assets/img/1.jpg",
  "assets/img/2.jpg",
  "assets/img/3.jpg",
];

const List<Map> dummy = [
  {
    "title": "Beautiful Cardigan",
    "price": "\$600"
  },
  {
    "title": "Leather Bag",
    "price": "\$400"
  },
  {
    "title": "White Beautiful Bag",
    "price": "\$350"
  },
];
class AnimationOnePage extends StatefulWidget {
  @override
  _AnimationOnePageState createState() => _AnimationOnePageState();
}

class _AnimationOnePageState extends State<AnimationOnePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int prevIndex = 0;
  final SwiperController _swiperController = SwiperController();
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Best items",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " from around"),
          ])),
          Expanded(
            flex: 2,
            child: Swiper(
              physics: BouncingScrollPhysics(),
              viewportFraction: 0.8,
              itemCount: 3,
              loop: false,
              controller: _swiperController,
              onIndexChanged: (index) {
                _controller.reverse();
                setState(() {
                  prevIndex = currentIndex;
                  currentIndex = index;
                  _controller.forward();
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(seconds: 1),
                                pageBuilder: (_, __, ___) => AnimationOneDetails(index: index,))),
                        child: Hero(
                          tag: "image$index",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
          Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: currentIndex == 0 ? 1 : 0,
                child: _buildDesc(0),
                duration: Duration(seconds: 1),
              ),
              AnimatedOpacity(
                opacity: currentIndex == 1 ? 1 : 0,
                child: _buildDesc(1),
                duration: Duration(seconds: 1),
              ),
              AnimatedOpacity(
                opacity: currentIndex == 2 ? 1 : 0,
                child: _buildDesc(2),
                duration: Duration(seconds: 1),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDesc(int index) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10.0),
          Hero(
            tag: "title$index",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                dummy[index]["title"],
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Hero(
            tag: "price$index",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                dummy[index]["price"],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
