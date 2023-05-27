import 'package:flutter/material.dart';
import 'package:tokoumb/bloc/produk_bloc.dart';
import 'package:tokoumb/model/produkmodel.dart';
import 'package:tokoumb/ui/produkview.dart';
import 'package:tokoumb/ui/produkviewlist.dart';

class ProdukDetailView extends StatefulWidget {
  final ProdukModel? produk;

  const ProdukDetailView({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailViewState createState() => _ProdukDetailViewState();
}

class _ProdukDetailViewState extends State<ProdukDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://miro.medium.com/v2/resize:fit:640/format:webp/0*ObJbOfJnx4QIPUq9.png',
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Text(
              "Kode : ${widget.produk!.kodeproduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaproduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Harga : ${widget.produk!.hargaproduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            _buildTombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukView(produk: widget.produk!),
              ),
            );
          },
          child: const Text('Edit'),
        ),
        OutlinedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text("Yakin ingin hapus?"),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      ProdukBloc.deleteProduk(id: widget.produk!.id).then(
                        (_) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const ProdukViewList(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Ya"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Tidak"),
                  ),
                ],
              ),
            );
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
