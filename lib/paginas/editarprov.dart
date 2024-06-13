import 'package:flutter/material.dart';
import '../main.dart';
import 'package:beltranact5/services/firebase_service.dart';

class Editarprov extends StatefulWidget {
  static const String routeName = '/editarprov';
  const Editarprov({super.key});
  @override
  State<Editarprov> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarprov> {
  TextEditingController codigoController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController servController = TextEditingController(text: "");
  TextEditingController ciudadController = TextEditingController(text: "");
  TextEditingController correoController = TextEditingController(text: "");
  TextEditingController direccionController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];
    idController.text = arguments['idproveedor'];
    codigoController.text = arguments['codigopostal'];
    servController.text = arguments['servicios'];
    ciudadController.text = arguments['ciudad'];
    correoController.text = arguments['correo'];
    direccionController.text = arguments['direccion'];
    telController.text = arguments['telefono'];

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
                      hintText: "ID Proveedor",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Nombre del Proveedor",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: codigoController,
                    decoration: InputDecoration(
                      hintText: "Codigo Postal",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: servController,
                    decoration: InputDecoration(
                      hintText: "Servicios",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: ciudadController,
                    decoration: InputDecoration(
                      hintText: "Ciudad",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: correoController,
                    decoration: InputDecoration(
                      hintText: "Correo",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: direccionController,
                    decoration: InputDecoration(
                      hintText: "Direccion",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: telController,
                    decoration: InputDecoration(
                      hintText: "Telefono",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {
                      await editProveedor(
                              arguments['uid'],
                              idController.text,
                              nameController.text,
                              codigoController.text,
                              servController.text,
                              ciudadController.text,
                              correoController.text,
                              direccionController.text,
                              telController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, MiAplicacion.prov);
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
