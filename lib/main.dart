import 'package:flutter/material.dart';
import 'engel_tespit.dart';
import 'obje_arama.dart';
import 'goruntulu_arama.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3 Container Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  int battery = 55;

  IconData getBatteryIcon(int battery) {
    if (battery >= 70) {
      return Icons.battery_full;
    } else if (battery >= 30) {
      return Icons.battery_5_bar;
    } else {
      return Icons.battery_0_bar;
    }
  }

  Widget buildContainer(
    BuildContext context,
    String title,
    String content,
    Color color,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 4),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEBEBEB)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Merhaba! 👋 Hoş geldiniz.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Text(
                'Bugün size nasıl yardımcı olabiliriz?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              //SizedBox(height: 16),
              SizedBox(height: 16),
              buildContainer(
                context,
                '📢 Engelleri Tespit Et',
                '"Önümde engel var mi?" \nBas hizasindaki engelleri \nalgilayin ve bildirim alin.',
                Colors.white,
                '/page1',
              ),
              buildContainer(
                context,
                '🔎 Aradığın Nesneleri Bul',
                '"Yakinimda ne var?" \nCevrenizdeki nesneleri algilayin \nve konumlarini ögrenin.',
                Colors.white,
                '/page2',
              ),
              buildContainer(
                context,
                '📞 Görüntülü Arama',
                'Aninda kamera paylas, destek \niste.',
                Colors.white,
                '/page3',
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(getBatteryIcon(battery)),
                        SizedBox(width: 8),
                        Text('Gözlük', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(getBatteryIcon(battery)),
                        SizedBox(width: 8),
                        Text('RPI', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
