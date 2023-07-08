import 'package:flutter/material.dart';
import 'package:tokoumb/bloc/produk_bloc.dart';
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
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage("https://plus.unsplash.com/premium_photo-1686604504223-47a6aef5c3f2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80"),
                      fit: BoxFit.scaleDown)),
              child: Text(''),
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
              ),
              title: const Text('Input Produk'),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProdukView()));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await UserInfo().logout().then((value) => {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()))
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduk(),
        builder: (context, snapshot) {
          // ignore: avoid_print
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),

      // body: ListView(
      //   children: [
      //     ItemProduk(
      //         produk: ProdukModel(
      //             id: 1,
      //             kodeproduk: "BRG001",
      //             namaproduk: "Macbook Pro M1",
      //             hargaproduk: 10000000)),
      //     ItemProduk(
      //         produk: ProdukModel(
      //             id: 1,
      //             kodeproduk: "BRG002",
      //             namaproduk: "Macbook Pro M2",
      //             hargaproduk: 10000000)),
      //     ItemProduk(
      //         produk: ProdukModel(
      //             id: 1,
      //             kodeproduk: "BRG003",
      //             namaproduk: "Macbook Air M2",
      //             hargaproduk: 10000000)),
      //   ],
      // ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list![i],
          );
        });
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
          leading: Image.network(
              'https://miro.medium.com/v2/resize:fit:640/format:webp/0*ObJbOfJnx4QIPUq9.png',
              height: 50,
              fit: BoxFit.fill),
          subtitle: Text(produk.hargaproduk.toString()),
        ),
      ),
    );
  }
}
