import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lancarjayaabadi/screenPage/homePage.dart';
import '../class/network.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class addProduct extends StatefulWidget {
  addProduct({Key key}) : super(key: key);

  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  final namaBarangController = TextEditingController();
  final modalBarangController = TextEditingController();
  final jumlahBarangController = TextEditingController();
  bool _saving = false;
  

  _APIaddProductToServer() async {
    _saving = true;
    setState(() {
      
    });
    var namaBarangData = namaBarangController.text;
    var modalBarangData = modalBarangController.text;
    var jumlahBarangData = jumlahBarangController.text;

    FormData formData = FormData.from({
      "nama": namaBarangData,
      "modal": modalBarangData,
      "jumlah": jumlahBarangData,
    });

    var result = await Api().productPost(formData);
    if (result == "sukses") {
      setState(() {
       _saving = false; 
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah produk"),
      ),
      body: ModalProgressHUD(
              child: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text("Nama barang"),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: namaBarangController,
                        decoration:
                            InputDecoration(hintText: "Input nama barang"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text("Modal "),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: modalBarangController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: "Modal beli barang"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text("Jumlah "),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: jumlahBarangController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Jumlah"),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: FlatButton(
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(56, 142, 60, 1),
                    ),
                    child: Text(
                      "Tambahkan barang",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  onPressed: () {
                    _APIaddProductToServer();
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
