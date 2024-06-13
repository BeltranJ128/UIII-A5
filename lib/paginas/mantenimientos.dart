import 'package:beltranact5/main.dart';
import 'package:beltranact5/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:beltranact5/drawer_menu.dart';

class Mantenimiento extends StatelessWidget {
  TextEditingController clienteController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController empleadoController = TextEditingController(text: "");
  TextEditingController productoController = TextEditingController(text: "");
  TextEditingController nomprodController = TextEditingController(text: "");
  TextEditingController horaController = TextEditingController(text: "");
  TextEditingController costoController = TextEditingController(text: "");
  TextEditingController ivaController = TextEditingController(text: "");
  static const String routeName = '/mantenimientos';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mantenimientos",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff24384e),
          bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.handyman,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.add_circle),
                )
              ]),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: getMantenimientos(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteMantenimiento(
                                snapshot.data?[index]['uid']);
                            snapshot.data?.removeAt(index);
                          },
                          confirmDismiss: (direction) async {
                            bool result = false;
                            result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "¿Estás seguro de eliminar este registro?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, false);
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, true);
                                        },
                                        child: Text("Si, estoy seguro"),
                                      ),
                                    ],
                                  );
                                });
                            return result;
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          direction: DismissDirection.endToStart,
                          key: Key(snapshot.data?[index]['uid']),
                          child: ListTile(
                            title: Text("ID Cliente: " +
                                snapshot.data?[index]['idcliente'] +
                                " ID Empleado: " +
                                snapshot.data?[index]['idempleado']),
                            subtitle: Text("ID Producto: " +
                                snapshot.data?[index]['idproducto'] +
                                " | " +
                                snapshot.data?[index]['nomproducto'] +
                                " Hora: " +
                                snapshot.data?[index]['hora']),
                            leading:
                                Text(snapshot.data?[index]['idmantenimiento']),
                            trailing: Text(snapshot.data?[index]['costo'] +
                                " " +
                                snapshot.data?[index]['iva']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiAplicacion.editarm,
                                arguments: {
                                  'idcliente': snapshot.data?[index]
                                      ["idcliente"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idmantenimiento': snapshot.data?[index]
                                      ["idmantenimiento"],
                                  'idempleado': snapshot.data?[index]
                                      ["idempleado"],
                                  'idproducto': snapshot.data?[index]
                                      ["idproducto"],
                                  'nomproducto': snapshot.data?[index]
                                      ["nomproducto"],
                                  'hora': snapshot.data?[index]["hora"],
                                  'costo': snapshot.data?[index]["costo"],
                                  'iva': snapshot.data?[index]["iva"],
                                },
                              ),
                            },
                          ));
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
            CustomScrollView(
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
                          hintText: "Nombre del Producto",
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
                          await addMantenimiento(
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
                        child: Text("Guardar"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 30),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Color(0xff24384e),
                            foregroundColor: Colors.white),
                      ),
                    ])))
              ],
            )
          ],
        ),
      ),
    );
  }
}
