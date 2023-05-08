import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class User {
  String username;

  User({required this.username});
}

void main() {
  var usuario = User(username: 'Username');
  runApp(MyApp(user: usuario));
}

class MyApp extends StatelessWidget {
  final User user;
  const MyApp({super.key, required this.user});
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 12, 19, 79),
              brightness: Brightness.light,
              primary: const Color.fromARGB(255, 12, 19, 79),
              secondary: Color(getColorHexFromStr("#1D267D")),
              tertiary: Color(getColorHexFromStr("#5C469C")))),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 12, 19, 79),
              brightness: Brightness.dark,
              primary: const Color.fromARGB(255, 12, 19, 79),
              secondary: Color(getColorHexFromStr("#1D267D")),
              tertiary: Color(getColorHexFromStr("#5C469C"))
              
              )),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page', user: user),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.user});
  final User user;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isActiveList = [false, false, false, false];
  void _onButtonPressed(int index) {
    setState(() {
      // Se actualiza el estado del botón presionado
      isActiveList[index] = !isActiveList[index];

      // Se desactivan los otros botones
      for (int i = 0; i < isActiveList.length; i++) {
        if (i != index) {
          isActiveList[i] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: colors.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: colors.primary,
                  ),
                  Positioned(
                    bottom: 20,
                    right: 100.0,
                    child: Container(
                      height: 400.0,
                      width: 400.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2)),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: -75.0,
                    child: Container(
                      height: 250.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0, left: 15.0, top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/gat.jpg'))),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu_sharp,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                                iconSize: 30.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 15),
                        child: Text(
                          'Hola, ${widget.user.username}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Valera',
                              fontSize: 30,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 50, bottom: 40),
                        child: Text(
                          'Qué buscas hoy?',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Valera',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 10),
                        child: Material(
                          elevation: 5.0,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search_sharp,
                                color: colors.primary,
                                size: 30,
                              ),
                              contentPadding:
                                  const EdgeInsets.only(top: 15, left: 15),
                              hintText: 'Buscar',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Stack(
                  children: <Widget>[
                    Material(
                      elevation: 0,
                      child: Container(
                        height: 75,
                        color: colors.primary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 75,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ElevatedButton(
                            onPressed: () => _onButtonPressed(0),
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) => 4.0),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return const Color.fromRGBO(
                                        0, 112, 209, 1.0);
                                  }
                                  return Colors.transparent;
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                  if (isActiveList[0]) {
                                    return Colors.white;
                                  }
                                  return colors.primary;
                                }),
                                shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            size: 30,
                                            color: isActiveList[0]
                                                ? const Color.fromRGBO(
                                                    0, 112, 209, 1.0)
                                                : colors.onPrimary,
                                          ),
                                        ),
                                        Text(
                                          "Playstation",
                                          style: TextStyle(
                                              color: isActiveList[0]
                                                  ? const Color.fromRGBO(
                                                      0, 112, 209, 1.0)
                                                  : colors.onPrimary,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ElevatedButton(
                            onPressed: () => _onButtonPressed(1),
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) => 4.0),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return const Color.fromRGBO(
                                        16, 124, 16, 1.000);
                                  }
                                  return Colors.transparent;
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                  if (isActiveList[1]) {
                                    return Colors.white;
                                  }
                                  return colors.primary;
                                }),
                                shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: FaIcon(
                                            FontAwesomeIcons.xbox,
                                            size: 30,
                                            color: isActiveList[1]
                                                ? const Color.fromRGBO(
                                                    16, 124, 16, 1.000)
                                                : colors.onPrimary,
                                          ),
                                        ),
                                        Text(
                                          "Xbox",
                                          style: TextStyle(
                                              color: isActiveList[1]
                                                  ? const Color.fromRGBO(
                                                      16, 124, 16, 1.000)
                                                  : colors.onPrimary,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ElevatedButton(
                            onPressed: () => _onButtonPressed(2),
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) => 4.0),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return colors.secondary;
                                  }
                                  return Colors.transparent;
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                  if (isActiveList[2]) {
                                    return Colors.white;
                                  }
                                  return colors.primary;
                                }),
                                shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: FaIcon(
                                              FontAwesomeIcons.desktop,
                                              size: 30,
                                              color: isActiveList[2] ? colors.tertiary: colors.onPrimary),
                                        ),
                                        Text(
                                          "PC",
                                          style: TextStyle(
                                              color: isActiveList[2]
                                                  ? colors.tertiary
                                                  : colors.onPrimary,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ElevatedButton(
                            onPressed: () => _onButtonPressed(3),
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) => 4.0),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return const Color.fromRGBO(
                                        230, 0, 18, 1.0);
                                  }
                                  return Colors.transparent;
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                  if (isActiveList[3]) {
                                    return Colors.white;
                                  }
                                  return colors.primary;
                                }),
                                shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: FaIcon(
                                            FontAwesomeIcons.gamepad,
                                            size: 30,
                                            color: isActiveList[3] ? const Color.fromRGBO(230,0,18,1.0) : colors.onPrimary,
                                          ),
                                        ),
                                        Text(
                                          "Switch",
                                          style: TextStyle(
                                              color: isActiveList[3]
                                                  ? const Color.fromRGBO(
                                                      230, 0, 18, 1.0)
                                                  : colors.onPrimary,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
