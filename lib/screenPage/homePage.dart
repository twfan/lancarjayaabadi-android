import 'package:flutter/material.dart';
import 'package:lancarjayaabadi/screenPage/searchPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './productView.dart';
import '../class/network.dart';
import '../class/data.dart';
import 'addProduct.dart';

class homePage extends StatefulWidget {
  homePage({Key key}) : super(key: key);

  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<dynamic> arrDataProduct = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lancar jaya abadi"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => searchPage()),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: productView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addProduct()),
          );
        },
      ),
    );
  }
}

Widget cardProduct() {
  return Container(
    child: Text("data"),
  );
}
