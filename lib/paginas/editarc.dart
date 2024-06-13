import 'package:flutter/material.dart';
import '../main.dart';
import 'package:beltranact5/services/firebase_service.dart';

class Editar extends StatefulWidget {
  static const String routeName = '/editarc';
  const Editar({super.key});
  @override
  State<Editar> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editar> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController apeController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");
  TextEditingController dirController = TextEditingController(text: "");
  TextEditingController pagoController = TextEditingController(text: "");
  TextEditingController metodoController = TextEditingController(text: "");
  TextEditingController correoController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];
    idController.text = arguments['idcliente'];
    apeController.text = arguments['apellido'];
    telController.text = arguments['telefono'];
    dirController.text = arguments['direccion'];
    pagoController.text = arguments['pago'];
    metodoController.text = arguments['metodopago'];
    correoController.text = arguments['correo'];

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
                      hintText: "ID Cliente",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Nombre",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: apeController,
                    decoration: InputDecoration(
                      hintText: "Apellido",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: telController,
                    decoration: InputDecoration(
                      hintText: "Telefono",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: dirController,
                    decoration: InputDecoration(
                      hintText: "Direccion",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: pagoController,
                    decoration: InputDecoration(
                      hintText: "Pago",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: metodoController,
                    decoration: InputDecoration(
                      hintText: "Metodo de Pago",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: correoController,
                    decoration: InputDecoration(
                      hintText: "Correo",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {
                      await editCliente(
                              arguments['uid'],
                              idController.text,
                              nameController.text,
                              apeController.text,
                              telController.text,
                              dirController.text,
                              pagoController.text,
                              metodoController.text,
                              correoController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, MiAplicacion.cliente);
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
