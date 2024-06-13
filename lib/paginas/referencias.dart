import '../drawer_menu.dart';
import 'package:flutter/material.dart';

class Referencias extends StatelessWidget {
  static const routeName = "/referencias";
  const Referencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Referencias', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff24384e),
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerMenu(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              Column(
                children: [
                  Text(
                    "LINKS DE REFERENCIA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://github.com/PaolaIbarraOrdaz/loginCbtis128",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://www.youtube.com/watch?v=MHuQd9MXva0",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://www.youtube.com/watch?v=FhMUkCNIvH8",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://www.youtube.com/watch?v=FhMUkCNIvH8&list=PLutrh4gv1YI83wAtYOimbUDGTP41UlTa8&index=4",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://www.youtube.com/watch?v=nfX84prLpSE&list=PLutrh4gv1YI83wAtYOimbUDGTP41UlTa8&index=5",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://www.youtube.com/watch?v=bnZUyHNaxfU",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://pub.dev/packages/google_maps_flutter_web",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://api.flutter.dev/flutter/material/Icons-class.html",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://api.flutter.dev/flutter/material/TabBar-class.html",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              )
            ])),
          )
        ],
      ),
    );
  }
}
