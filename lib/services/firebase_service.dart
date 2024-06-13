import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getClientes() async {
  List clientes = [];
  CollectionReference collectionReferenceClientes = db.collection('cliente');

  QuerySnapshot querySnapshot = await collectionReferenceClientes.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map person = {
      "idcliente": data["idcliente"],
      "name": data["name"],
      "apellido": data["apellido"],
      "telefono": data["telefono"],
      "direccion": data["direccion"],
      "pago": data["pago"],
      "metodopago": data["metodopago"],
      "correo": data["correo"],
      "uid": doc.id,
    };

    clientes.add(person);
  }

  return clientes;
}

Future<void> addCliente(String id, String name, String ape, String tel,
    String dir, String pago, String metodo, String correo) async {
  await db.collection('cliente').add({
    "name": name,
    "idcliente": id,
    "apellido": ape,
    "telefono": tel,
    "direccion": dir,
    "pago": pago,
    "metodopago": metodo,
    "correo": correo
  });
}

Future<void> editCliente(String uid, String id, String name, String ape,
    String tel, String dir, String pago, String metodo, String correo) async {
  await db.collection('cliente').doc(uid).set({
    "name": name,
    "idcliente": id,
    "apellido": ape,
    "telefono": tel,
    "direccion": dir,
    "pago": pago,
    "metodopago": metodo,
    "correo": correo
  });
}

Future<void> deleteCliente(String uid) async {
  await db.collection("cliente").doc(uid).delete();
}

Future<List> getEmpleados() async {
  List empleados = [];
  CollectionReference collectionReferenceClientes = db.collection('empleado');

  QuerySnapshot querySnapshot = await collectionReferenceClientes.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map person = {
      "idempleado": data["idempleado"],
      "name": data["name"],
      "edad": data["edad"],
      "nummantenimientos": data["nummantenimientos"],
      "salario": data["salario"],
      "puesto": data["puesto"],
      "bonos": data["bonos"],
      "telefono": data["telefono"],
      "uid": doc.id,
    };

    empleados.add(person);
  }

  return empleados;
}

Future<void> addEmpleado(String id, String name, String edad, String mante,
    String salario, String puesto, String bonos, String telefono) async {
  await db.collection('empleado').add({
    "name": name,
    "idempleado": id,
    "edad": edad,
    "nummantenimientos": mante,
    "salario": salario,
    "puesto": puesto,
    "bonos": bonos,
    "telefono": telefono
  });
}

Future<void> editEmpleado(
    String uid,
    String id,
    String name,
    String edad,
    String mante,
    String salario,
    String puesto,
    String bonos,
    String telefono) async {
  await db.collection('empleado').doc(uid).set({
    "name": name,
    "idempleado": id,
    "edad": edad,
    "nummantenimientos": mante,
    "salario": salario,
    "puesto": puesto,
    "bonos": bonos,
    "telefono": telefono
  });
}

Future<void> deleteEmpleado(String uid) async {
  await db.collection("empleado").doc(uid).delete();
}

Future<List> getMantenimientos() async {
  List mantenimientos = [];
  CollectionReference collectionReferenceClientes =
      db.collection('mantenimientos');

  QuerySnapshot querySnapshot = await collectionReferenceClientes.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map person = {
      "idmantenimiento": data["idmantenimiento"],
      "idcliente": data["idcliente"],
      "idempleado": data["idempleado"],
      "idproducto": data["idproducto"],
      "nomproducto": data["nomproducto"],
      "hora": data["hora"],
      "costo": data["costo"],
      "iva": data["iva"],
      "uid": doc.id,
    };

    mantenimientos.add(person);
  }

  return mantenimientos;
}

Future<void> addMantenimiento(
    String id,
    String idcliente,
    String idempleado,
    String idproducto,
    String nomproducto,
    String hora,
    String costo,
    String iva) async {
  await db.collection('mantenimientos').add({
    "idcliente": idcliente,
    "idmantenimiento": id,
    "idempleado": idempleado,
    "idproducto": idproducto,
    "nomproducto": nomproducto,
    "hora": hora,
    "costo": costo,
    "iva": iva
  });
}

Future<void> editMantenimiento(
    String uid,
    String id,
    String idcliente,
    String idempleado,
    String idproducto,
    String nomproducto,
    String hora,
    String costo,
    String iva) async {
  await db.collection('mantenimientos').doc(uid).set({
    "idcliente": idcliente,
    "idmantenimiento": id,
    "idempleado": idempleado,
    "idproducto": idproducto,
    "nomproducto": nomproducto,
    "hora": hora,
    "costo": costo,
    "iva": iva
  });
}

Future<void> deleteMantenimiento(String uid) async {
  await db.collection("mantenimientos").doc(uid).delete();
}

Future<List> getProducto() async {
  List productos = [];
  CollectionReference collectionReferenceClientes = db.collection('producto');

  QuerySnapshot querySnapshot = await collectionReferenceClientes.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map person = {
      "idproducto": data["idproducto"],
      "name": data["name"],
      "descripcion": data["descripcion"],
      "precio": data["precio"],
      "existencias": data["existencias"],
      "tipoproducto": data["tipoproducto"],
      "marca": data["marca"],
      "iva": data["iva"],
      "uid": doc.id,
    };

    productos.add(person);
  }

  return productos;
}

Future<void> addProducto(
    String id,
    String name,
    String descripcion,
    String precio,
    String existencias,
    String tipoproducto,
    String marca,
    String iva) async {
  await db.collection('producto').add({
    "name": name,
    "idproducto": id,
    "descripcion": descripcion,
    "precio": precio,
    "existencias": existencias,
    "tipoproducto": tipoproducto,
    "marca": marca,
    "iva": iva
  });
}

Future<void> editProducto(
    String uid,
    String id,
    String name,
    String descripcion,
    String precio,
    String existencias,
    String tipoproducto,
    String marca,
    String iva) async {
  await db.collection('producto').doc(uid).set({
    "name": name,
    "idproducto": id,
    "descripcion": descripcion,
    "precio": precio,
    "existencias": existencias,
    "tipoproducto": tipoproducto,
    "marca": marca,
    "iva": iva
  });
}

Future<void> deleteProducto(String uid) async {
  await db.collection("producto").doc(uid).delete();
}

Future<List> getProveedor() async {
  List proveedor = [];
  CollectionReference collectionReferenceClientes = db.collection('proveedor');

  QuerySnapshot querySnapshot = await collectionReferenceClientes.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map person = {
      "idproveedor": data["idproveedor"],
      "name": data["name"],
      "codigopostal": data["codigopostal"],
      "servicios": data["servicios"],
      "ciudad": data["ciudad"],
      "correo": data["correo"],
      "direccion": data["direccion"],
      "telefono": data["telefono"],
      "uid": doc.id,
    };

    proveedor.add(person);
  }

  return proveedor;
}

Future<void> addProveedor(
    String id,
    String name,
    String codigopostal,
    String servicios,
    String ciudad,
    String correo,
    String direccion,
    String telefono) async {
  await db.collection('proveedor').add({
    "name": name,
    "idproveedor": id,
    "codigopostal": codigopostal,
    "servicios": servicios,
    "ciudad": ciudad,
    "correo": correo,
    "direccion": direccion,
    "telefono": telefono
  });
}

Future<void> editProveedor(
    String uid,
    String id,
    String name,
    String codigopostal,
    String servicios,
    String ciudad,
    String correo,
    String direccion,
    String telefono) async {
  await db.collection('proveedor').doc(uid).set({
    "name": name,
    "idproveedor": id,
    "codigopostal": codigopostal,
    "servicios": servicios,
    "ciudad": ciudad,
    "correo": correo,
    "direccion": direccion,
    "telefono": telefono
  });
}

Future<void> deleteProveedor(String uid) async {
  await db.collection("proveedor").doc(uid).delete();
}
