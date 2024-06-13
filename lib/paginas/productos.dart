import 'package:beltranact5/main.dart';
import 'package:beltranact5/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:beltranact5/drawer_menu.dart';

class Producto extends StatelessWidget {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");
  TextEditingController existController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController marcaController = TextEditingController(text: "");
  TextEditingController ivaController = TextEditingController(text: "");
  static const String routeName = '/productos';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Productos",
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
              future: getProducto(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteProducto(snapshot.data?[index]['uid']);
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
                                snapshot.data?[index]['descripcion']),
                            subtitle: Text(snapshot.data?[index]
                                    ['existencias'] +
                                " | " +
                                snapshot.data?[index]['tipoproducto'] +
                                " " +
                                snapshot.data?[index]['marca']),
                            leading: Text(snapshot.data?[index]['idproducto']),
                            trailing: Text(snapshot.data?[index]['precio'] +
                                " " +
                                snapshot.data?[index]['iva']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiAplicacion.editarp,
                                arguments: {
                                  'name': snapshot.data?[index]["name"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idproducto': snapshot.data?[index]
                                      ["idproducto"],
                                  'descripcion': snapshot.data?[index]
                                      ["descripcion"],
                                  'precio': snapshot.data?[index]["precio"],
                                  'existencias': snapshot.data?[index]
                                      ["existencias"],
                                  'tipoproducto': snapshot.data?[index]
                                      ["tipoproducto"],
                                  'marca': snapshot.data?[index]["marca"],
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
                          hintText: "ID Producto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Nombre del Producto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          hintText: "Descripcion",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: precioController,
                        decoration: InputDecoration(
                          hintText: "Precio",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: existController,
                        decoration: InputDecoration(
                          hintText: "Existencias",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: tipoController,
                        decoration: InputDecoration(
                          hintText: "Tipo de Producto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: marcaController,
                        decoration: InputDecoration(
                          hintText: "Marca",
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
                          await addProducto(
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
