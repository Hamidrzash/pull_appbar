import 'package:flutter/material.dart';
import 'package:pull_appbar/pull_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List gradients = [
    const LinearGradient(
      colors: [Color(0xffbde5d0), Color(0xff123c6c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff97c794), Color(0xff12656c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffcaa285), Color(0xffc0bf3c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffa589b0), Color(0xffd35c5c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff808fb6), Color(0xff373f52)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffbba793), Color(0xffa65d3d)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffafabb2), Color(0xff695f64)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffae93bb), Color(0xffa63d71)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff93bb95), Color(0xff5a774e)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffcaa285), Color(0xffc0bf3c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff93b0bb), Color(0xff3d7aa6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff9d93bb), Color(0xff6659a1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];
  late final remainingSize = MediaQuery.of(context).size.height - 80;
  final titleNames = [
    'Latest Movies',
    'Best Movies',
    'Archive',
    'About',
  ];
  late final List<Widget> _titles = [
    for (int i = 0; i < 4; i++)
      Text(
        titleNames[i],
        style: const TextStyle(color: Colors.white),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PullAppBar(
        titles: _titles,
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: remainingSize,
                child: Column(
                  children: [
                    Expanded(child: ListItem(gradient: gradients[0], title: 'INTERSTELLAR')),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(child: ListItem(gradient: gradients[1], title: 'THE GODFATHER')),
                              Expanded(child: ListItem(gradient: gradients[2], title: 'THE DARK KNIGHT')),
                            ],
                          ),
                        ),
                        Expanded(child: ListItem(gradient: gradients[3], title: 'THE LORD\nOF THE\nRINGS')),
                      ],
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: remainingSize / 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: ListItem(gradient: gradients[4], title: 'INCEPTION')),
                          Expanded(child: ListItem(gradient: gradients[5], title: 'FIGHT CLUB')),
                        ],
                      ),
                    ),
                    Expanded(child: ListItem(gradient: gradients[6], title: 'PULP FICTION')),
                  ],
                ),
              ),
            ],
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[0], title: 'OPPENHEIMER'),
              ),
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[1], title: 'SPIDER-MAN: ACROSS THE SPIDER-VERSE'),
              ),
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[2], title: 'JOHN WICK: CHAPTER 4'),
              ),
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[3], title: 'DUNE: PART TWO'),
              ),
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[4], title: 'FURIOSA: A MAD MAX SAGA'),
              ),
              SizedBox(
                height: remainingSize / 4,
                child: ListItem(gradient: gradients[5], title: 'WONKA'),
              ),
            ],
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[0], title: 'CASABLANCA'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[1], title: 'GONE WITH THE WIND'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[2], title: 'CITIZEN KANE'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[3], title: 'THE WIZARD OF OZ'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[4], title: 'IT\'S A WONDERFUL LIFE'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[5], title: 'PSYCHO '),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[6], title: 'LAWRENCE OF ARABIA'),
              ),
              SizedBox(
                height: remainingSize / 6,
                child: ListItem(gradient: gradients[7], title: 'SUNSET BOULEVARD'),
              ),
            ],
          ),
          Container(
            height: remainingSize,
            decoration: BoxDecoration(
              gradient: gradients[1],
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MENU\nINTERACTION\nCONCEPT',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'By Hamid reza Shakeri',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

class ListItem extends StatelessWidget {
  final String title;
  final LinearGradient gradient;
  const ListItem({
    super.key,
    required this.title,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 24),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
