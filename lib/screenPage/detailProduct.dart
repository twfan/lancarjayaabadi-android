import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lancarjayaabadi/class/network.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'homePage.dart';

class detailProduct extends StatefulWidget {
  var namaBarang,idBarang,modalBarang,jumlahBarang;

  detailProduct(this.idBarang,this.namaBarang,this.modalBarang,this.jumlahBarang);

  _detailProductState createState() => _detailProductState();
}

class _detailProductState extends State<detailProduct> {
  bool _saving = false;
  var namaBarangController = TextEditingController();
  var modalBarangController = TextEditingController();
  var jumlahBarangController = TextEditingController();
  var idBarang = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    idBarang = widget.idBarang;
    namaBarangController.text = widget.namaBarang;
    modalBarangController.text = widget.modalBarang;
    jumlahBarangController.text = widget.jumlahBarang;
    
  }

  _APIeditProductToServer() async {
    _saving = true;
    setState(() {
      
    });
    var namaBarangData = namaBarangController.text;
    var modalBarangData = modalBarangController.text;
    var jumlahBarangData = jumlahBarangController.text;

    FormData formData = FormData.from({
      "id": idBarang,
      "nama": namaBarangData,
      "modal": modalBarangData,
      "jumlah": jumlahBarangData,
    });

    var result = await Api().productEdit(formData);
    if (result == "sukses") {
      _saving = false;
      setState(() {
        
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    }
  }

  _APIdeleteProductToServer() async {
    _saving = true;
    setState(() {
      
    });
    FormData formData = FormData.from({
      "id": idBarang,
    });
    var result = await Api().productDelete(formData);
    if (result == "sukses") {
      _saving = false;
      setState(() {
        
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
        title: Text("Detail Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _APIdeleteProductToServer();
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
              child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5.0),
          height: 250.0,
          // color: Colors.red,
          child: Card(
            child: Container(
              padding: EdgeInsets.only(left: 10.0,right: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Text("Nama barang"),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: namaBarangController,
                            decoration:
                                InputDecoration(hintText: "Input nama barang"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Text("Modal"),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: modalBarangController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(hintText: "Input modal barang"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Text("Jumlah"),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: jumlahBarangController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(hintText: "Input jumlah barang"),
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
                          "Edit barang",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                      onPressed: () {
                        _APIeditProductToServer();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: _saving,
      ),
    );
  }
}
