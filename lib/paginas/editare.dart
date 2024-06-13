import 'package:flutter/material.dart';
import '../main.dart';
import 'package:beltranact5/services/firebase_service.dart';

class Editare extends StatefulWidget {
  static const String routeName = '/editare';
  const Editare({super.key});
  @override
  State<Editare> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editare> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController edadController = TextEditingController(text: "");
  TextEditingController manteController = TextEditingController(text: "");
  TextEditingController salarioController = TextEditingController(text: "");
  TextEditingController puestoController = TextEditingController(text: "");
  TextEditingController bonosController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];
    idController.text = arguments['idempleado'];
    edadController.text = arguments['edad'];
    manteController.text = arguments['nummantenimientos'];
    salarioController.text = arguments['salario'];
    puestoController.text = arguments['puesto'];
    bonosController.text = arguments['bonos'];
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
                      hintText: "ID Empleado",
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
                    controller: edadController,
                    decoration: InputDecoration(
                      hintText: "Edad",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: manteController,
                    decoration: InputDecoration(
                      hintText: "Numero de Mantenimientos",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: salarioController,
                    decoration: InputDecoration(
                      hintText: "Salario",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: puestoController,
                    decoration: InputDecoration(
                      hintText: "Puesto",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: bonosController,
                    decoration: InputDecoration(
                      hintText: "Bonos",
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
                      await editEmpleado(
                              arguments['uid'],
                              idController.text,
                              nameController.text,
                              edadController.text,
                              telController.text,
                              salarioController.text,
                              puestoController.text,
                              bonosController.text,
                              telController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, MiAplicacion.empleado);
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
