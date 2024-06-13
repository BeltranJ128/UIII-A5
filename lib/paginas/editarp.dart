import 'package:flutter/material.dart';
import '../main.dart';
import 'package:beltranact5/services/firebase_service.dart';

class Editarp extends StatefulWidget {
  static const String routeName = '/editarp';
  const Editarp({super.key});
  @override
  State<Editarp> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarp> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");
  TextEditingController existController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController marcaController = TextEditingController(text: "");
  TextEditingController ivaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];
    idController.text = arguments['idproducto'];
    descController.text = arguments['descripcion'];
    precioController.text = arguments['precio'];
    existController.text = arguments['existencias'];
    tipoController.text = arguments['tipoproducto'];
    marcaController.text = arguments['marca'];
    ivaController.text = arguments['iva'];

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff24384e),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: "ID Mantenimiento",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "ID Cliente",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: "ID Empleado",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: precioController,
                    decoration: InputDecoration(
                      hintText: "ID Producto",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: existController,
                    decoration: InputDecoration(
                      hintText: "Nombre de Producto",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: tipoController,
                    decoration: InputDecoration(
                      hintText: "Hora",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: marcaController,
                    decoration: InputDecoration(
                      hintText: "Costo",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: ivaController,
                    decoration: InputDecoration(
                      hintText: "IVA",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {
                      await editProducto(
                              arguments['uid'],
                              idController.text,
                              nameController.text,
                              descController.text,
                              precioController.text,
                              existController.text,
                              tipoController.text,
                              marcaController.text,
                              ivaController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, MiAplicacion.prod);
                      });
                    },
                    child: Text("Actualizar"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 30),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color(0xff24384e),
                        foregroundColor: Colors.white),
                  ),
                ])))
          ],
        ));
  }
}
