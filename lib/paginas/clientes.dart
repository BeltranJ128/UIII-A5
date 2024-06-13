import 'package:beltranact5/main.dart';
import 'package:beltranact5/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:beltranact5/drawer_menu.dart';

class Cliente extends StatelessWidget {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController apeController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");
  TextEditingController dirController = TextEditingController(text: "");
  TextEditingController pagoController = TextEditingController(text: "");
  TextEditingController metodoController = TextEditingController(text: "");
  TextEditingController correoController = TextEditingController(text: "");
  static const String routeName = '/clientes';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Clientes",
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
                    Icons.groups,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.group_add),
                )
              ]),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: getClientes(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteCliente(snapshot.data?[index]['uid']);
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
                            title: Text(snapshot.data?[index]['name'] +
                                " " +
                                snapshot.data?[index]['apellido']),
                            subtitle: Text(snapshot.data?[index]['telefono'] +
                                " | " +
                                snapshot.data?[index]['direccion'] +
                                " " +
                                snapshot.data?[index]['correo']),
                            leading: Text(snapshot.data?[index]['idcliente']),
                            trailing: Text(snapshot.data?[index]['pago'] +
                                " " +
                                snapshot.data?[index]['metodopago']),
                            onTap: () => {
                              Navigator.pushNamed(context, MiAplicacion.editarc,
                                  arguments: {
                                    'name': snapshot.data?[index]["name"],
                                    'uid': snapshot.data?[index]["uid"],
                                    'idcliente': snapshot.data?[index]
                                        ["idcliente"],
                                    'apellido': snapshot.data?[index]
                                        ["apellido"],
                                    'telefono': snapshot.data?[index]
                                        ["telefono"],
                                    'direccion': snapshot.data?[index]
                                        ["direccion"],
                                    'pago': snapshot.data?[index]["pago"],
                                    'metodopago': snapshot.data?[index]
                                        ["metodopago"],
                                    'correo': snapshot.data?[index]["correo"],
                                  })
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
                          await addCliente(
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
