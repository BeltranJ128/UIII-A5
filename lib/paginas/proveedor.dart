import 'package:beltranact5/main.dart';
import 'package:beltranact5/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:beltranact5/drawer_menu.dart';

class Proveedor extends StatelessWidget {
  TextEditingController codigoController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController servController = TextEditingController(text: "");
  TextEditingController ciudadController = TextEditingController(text: "");
  TextEditingController correoController = TextEditingController(text: "");
  TextEditingController direccionController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");
  static const String routeName = '/proveedor';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Proveedores",
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
                    Icons.contact_emergency_outlined,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.person_add_outlined),
                )
              ]),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: getProveedor(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteProveedor(snapshot.data?[index]['uid']);
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
                                " | " +
                                snapshot.data?[index]['codigopostal']),
                            subtitle: Text(snapshot.data?[index]['servicios'] +
                                " | " +
                                snapshot.data?[index]['ciudad'] +
                                " " +
                                snapshot.data?[index]['direccion'] +
                                " " +
                                snapshot.data?[index]['correo'] +
                                " " +
                                snapshot.data?[index]['telefono']),
                            leading: Text(snapshot.data?[index]['idproveedor']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiAplicacion.editarprov,
                                arguments: {
                                  'name': snapshot.data?[index]["name"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idproveedor': snapshot.data?[index]
                                      ["idproveedor"],
                                  'codigopostal': snapshot.data?[index]
                                      ["codigopostal"],
                                  'servicios': snapshot.data?[index]
                                      ["servicios"],
                                  'ciudad': snapshot.data?[index]["ciudad"],
                                  'correo': snapshot.data?[index]["correo"],
                                  'direccion': snapshot.data?[index]
                                      ["direccion"],
                                  'telefono': snapshot.data?[index]["telefono"],
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
                          hintText: "ID Proveedor",
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Nombre del Proveedor",
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
                          await addProveedor(
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
