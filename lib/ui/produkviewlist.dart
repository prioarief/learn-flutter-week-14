import 'package:flutter/material.dart';
import 'package:tokoumb/helper/user_info.dart';
import 'package:tokoumb/model/produkmodel.dart';
import 'package:tokoumb/ui/loginview.dart';
import 'package:tokoumb/ui/produkdetail.dart';
import 'package:tokoumb/ui/produkview.dart';

class ProdukViewList extends StatefulWidget {
  const ProdukViewList({Key? key}) : super(key: key);

  @override
  _ProdukViewListState createState() => _ProdukViewListState();
}

class _ProdukViewListState extends State<ProdukViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Produk"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukView()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await UserInfo().logout();
                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          ItemProduk(
              produk: ProdukModel(
                  id: 1,
                  kodeproduk: "BRG001",
                  namaproduk: "Macbook Pro M1",
                  hargaproduk: 10000000)),
          ItemProduk(
              produk: ProdukModel(
                  id: 1,
                  kodeproduk: "BRG002",
                  namaproduk: "Macbook Pro M2",
                  hargaproduk: 10000000)),
          ItemProduk(
              produk: ProdukModel(
                  id: 1,
                  kodeproduk: "BRG003",
                  namaproduk: "Macbook Air M2",
                  hargaproduk: 10000000)),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final ProdukModel produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdukDetailView(
                      produk: produk,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaproduk!),
          subtitle: Text(produk.hargaproduk.toString()),
        ),
      ),
    );
  }
}
