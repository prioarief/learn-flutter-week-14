import 'package:flutter/material.dart';
import 'package:tokoumb/bloc/produk_bloc.dart';
import 'package:tokoumb/helper/user_info.dart';
import 'package:tokoumb/model/produkmodel.dart';
import 'package:tokoumb/ui/loginview.dart';
import 'package:tokoumb/ui/produkviewlist.dart';
import 'package:tokoumb/widget/warning_dialog.dart';

class ProdukView extends StatefulWidget {
  final ProdukModel? produk;

  ProdukView({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukViewState createState() => _ProdukViewState();
}

class _ProdukViewState extends State<ProdukView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late String judul;
  late String tombolSubmit;

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      judul = "UBAH PRODUK";
      tombolSubmit = "UBAH";
      _kodeProdukTextboxController.text = widget.produk!.kodeproduk!;
      _namaProdukTextboxController.text = widget.produk!.namaproduk!;
      _hargaProdukTextboxController.text =
          widget.produk!.hargaproduk.toString();
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/umb.jpg"),
                      fit: BoxFit.scaleDown)),
              child: Text(''),
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
              ),
              title: const Text('List Produk'),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const ProdukViewList()));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  labelText: "Kode Produk",
                  keyboardType: TextInputType.text,
                  controller: _kodeProdukTextboxController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kode Produk harus diisi";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: "Nama Produk",
                  keyboardType: TextInputType.text,
                  controller: _namaProdukTextboxController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Produk harus diisi";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: "Harga Produk",
                  keyboardType: TextInputType.number,
                  controller: _hargaProdukTextboxController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga Produk harus diisi";
                    }
                    return null;
                  },
                ),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextInputType keyboardType,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildSubmitButton() {
    return OutlinedButton(
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) {
          if (widget.produk != null) {
            _update();
          } else {
            _create();
          }
        }
      },
      child: Text(tombolSubmit),
    );
  }

  void _create() {
    setState(() {
      _isLoading = true;
    });
    ProdukModel createProduk = ProdukModel(id: null);
    createProduk.kodeproduk = _kodeProdukTextboxController.text;
    createProduk.namaproduk = _namaProdukTextboxController.text;
    createProduk.hargaproduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukViewList()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _update() {
    setState(() {
      _isLoading = true;
    });
    ProdukModel updateProduk = ProdukModel(id: null);
    updateProduk.id = widget.produk!.id;
    updateProduk.kodeproduk = _kodeProdukTextboxController.text;
    updateProduk.namaproduk = _namaProdukTextboxController.text;
    updateProduk.hargaproduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukViewList()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
