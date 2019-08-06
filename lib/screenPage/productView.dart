import 'package:flutter/material.dart';
import 'package:lancarjayaabadi/screenPage/detailProduct.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../class/network.dart';
import '../class/data.dart';

class productView extends StatefulWidget {
  productView({Key key}) : super(key: key);

  _productViewState createState() => _productViewState();
}

class _productViewState extends State<productView> {
  List<dynamic> listProduct = LjaData().dataProduct;
  int count = LjaData().dataProduct.length;
  bool _saving = false;

  String formatMoney(double total_rupiah) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: total_rupiah,
        settings: MoneyFormatterSettings(
          symbol: 'Rp ',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ));
    return fmf.output.symbolOnLeft;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(LjaData().search==false){
      listProduct = [];
      LjaData().dataProduct = [];
      fetchingProduct();
    }else{
      listProduct = [];
      listProduct.addAll(LjaData().dataProduct);
    }
  }

  fetchingProduct() async {
    setState(() {
      _saving = true;
    });
    var result = await Api().productGet();

    listProduct.addAll(result);
    LjaData().dataProduct = listProduct;
    setState(() {
      _saving = false;
    });
  }

  Future<void> _refreshStockPrices() async {
    setState(() {
     listProduct = [];
     LjaData().dataProduct = [];
     fetchingProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: RefreshIndicator(
        onRefresh: _refreshStockPrices,
        child: ListView.builder(
          itemCount: listProduct == null ? 0 : listProduct.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => detailProduct(
                          listProduct[i]["id"],
                          listProduct[i]["nama"],
                          listProduct[i]["modal"],
                          listProduct[i]["jumlah"])),
                );
              },
              child: Card(
                child: Container(
                  // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Color.fromRGBO(35, 103, 104, 1),
                          // width: 150.0,
                          // height: 50.0,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  listProduct[i]["nama"],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 5.0),
                                        child: Text(
                                          "Sisa",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        listProduct[i]["sisa"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "Pcs",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.green,
                          padding:
                              EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Color.fromRGBO(145, 190, 37, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("modal"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["modal"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromRGBO(248, 230, 32, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("grosir"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["grosir"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromRGBO(145, 190, 37, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("semi grosir"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["semi"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromRGBO(248, 230, 32, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("ecer"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["ecer"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromRGBO(145, 190, 37, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("pkp1"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["pkp1"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromRGBO(248, 230, 32, 1),
                                      margin: EdgeInsets.only(
                                          bottom: 5.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 70.0,
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, right: 20.0),
                                            child: Text("pkp2"),
                                          ),
                                          Text(
                                            formatMoney(double.parse(
                                                listProduct[i]["pkp2"])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      inAsyncCall: _saving,
    );
  }
}
