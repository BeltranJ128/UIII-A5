import 'package:flutter/material.dart';
import '../main.dart';
import 'package:beltranact5/services/firebase_service.dart';

class Editarm extends StatefulWidget {
  static const String routeName = '/editarm';
  const Editarm({super.key});
  @override
  State<Editarm> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarm> {
  TextEditingController clienteController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController empleadoController = TextEditingController(text: "");
  TextEditingController productoController = TextEditingController(text: "");
  TextEditingController nomprodController = TextEditingController(text: "");
  TextEditingController horaController = TextEditingController(text: "");
  TextEditingController costoController = TextEditingController(text: "");
  TextEditingController ivaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    clienteController.text = arguments['idcliente'];
    idController.text = arguments['idmantenimiento'];
    empleadoController.text = arguments['idempleado'];
    productoController.text = arguments['idproducto'];
    nomprodController.text = arguments['nomproducto'];
    horaController.text = arguments['hora'];
    costoController.text = arguments['costo'];
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
                    controller: clienteController,
                    decoration: InputDecoration(
                      hintText: "ID Cliente",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: empleadoController,
                    decoration: InputDecoration(
                      hintText: "ID Empleado",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: productoController,
                    decoration: InputDecoration(
                      hintText: "ID Producto",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: nomprodController,
                    decoration: InputDecoration(
                      hintText: "Nombre de Producto",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: horaController,
                    decoration: InputDecoration(
                      hintText: "Hora",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: costoController,
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
                      await editMantenimiento(
                              arguments['uid'],
                              idController.text,
                              clienteController.text,
                              empleadoController.text,
                              productoController.text,
                              nomprodController.text,
                              horaController.text,
                              costoController.text,
                              ivaController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, MiAplicacion.mante);
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
