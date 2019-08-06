import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lancarjayaabadi/class/data.dart';
import 'package:lancarjayaabadi/class/network.dart';
import 'package:lancarjayaabadi/screenPage/homePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class searchPage extends StatefulWidget {
  searchPage({Key key}) : super(key: key);

  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  List<dynamic> listProduct = [];
  int count = LjaData().dataProduct.length;
  var namaController = TextEditingController();
  bool _saving = false;


  @override
  void initState() {
    // TODO: implement initState
    LjaData().dataProduct=[];
    super.initState();
  }

  
  fetchingSearch() async {
    _saving = true;
    setState(() {
      
    });
    var namaBarangData = namaController.text;

    FormData formData = FormData.from({
      "nama": namaBarangData,
    });

    var result = await Api().productSearch(formData);
    // print(result);
    listProduct.addAll(result);
    // print(listProduct);
    LjaData().dataProduct = listProduct;
    LjaData().search = true;
    // print(LjaData().dataProduct);
    setState(() {
     _saving = false; 
    });
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari barang"),
      ),
      body: ModalProgressHUD(
              child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Text("Nama Barang"),
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: namaController,
                        decoration:
                            InputDecoration(hintText: "Input nama barang"),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: FlatButton(
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(56, 142, 60, 1),
                    ),
                    child: Text(
                      "Cari barang",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  onPressed: () {
                    fetchingSearch();
                  },
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: _saving,
      ),
    );
  }
}
