import 'package:beltranact5/main.dart';
import 'package:beltranact5/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:beltranact5/drawer_menu.dart';

class Empleado extends StatelessWidget {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController edadController = TextEditingController(text: "");
  TextEditingController manteController = TextEditingController(text: "");
  TextEditingController salarioController = TextEditingController(text: "");
  TextEditingController puestoController = TextEditingController(text: "");
  TextEditingController bonosController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");
  static const String routeName = '/empleado';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Empleados",
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
              future: getEmpleados(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteEmpleado(snapshot.data?[index]['uid']);
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
                                snapshot.data?[index]['edad']),
                            subtitle: Text(snapshot.data?[index]['telefono'] +
                                " | " +
                                snapshot.data?[index]['puesto'] +
                                " " +
                                snapshot.data?[index]['nummantenimientos']),
                            leading: Text(snapshot.data?[index]['idempleado']),
                            trailing: Text(snapshot.data?[index]['salario'] +
                                " " +
                                snapshot.data?[index]['bonos']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiAplicacion.editare,
                                arguments: {
                                  'name': snapshot.data?[index]["name"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idempleado': snapshot.data?[index]
                                      ["idempleado"],
                                  'edad': snapshot.data?[index]["edad"],
                                  'telefono': snapshot.data?[index]["telefono"],
                                  'nummantenimientos': snapshot.data?[index]
                                      ["nummantenimientos"],
                                  'puesto': snapshot.data?[index]["puesto"],
                                  'salario': snapshot.data?[index]["salario"],
                                  'bonos': snapshot.data?[index]["bonos"],
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
                          await addEmpleado(
                                  idController.text,
                                  nameController.text,
                                  edadController.text,
                                  manteController.text,
                                  salarioController.text,
                                  puestoController.text,
                                  bonosController.text,
                                  telController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiAplicacion.empleado);
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
