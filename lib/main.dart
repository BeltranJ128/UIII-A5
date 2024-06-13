import 'dart:async';
import 'package:beltranact5/paginas/editarprov.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beltranact5/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'drawer_menu.dart';

import 'paginas/clientes.dart';
import 'paginas/editarc.dart';
import 'paginas/editare.dart';
import 'paginas/editarm.dart';
import 'paginas/editarp.dart';
import 'paginas/empleados.dart';
import 'paginas/mantenimientos.dart';
import 'paginas/productos.dart';
import 'paginas/proveedor.dart';
import 'paginas/referencias.dart';
import 'paginas/ubicacion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  static const String routeName = "/main";
  static const String inicio = PaginaInicio.routeName;
  static const String ubicacion = MapSample.routeName;
  static const String cliente = Cliente.routeName;
  static const String editarc = Editar.routeName;
  static const String editare = Editare.routeName;
  static const String editarm = Editarm.routeName;
  static const String editarp = Editarp.routeName;
  static const String editarprov = Editarprov.routeName;
  static const String empleado = Empleado.routeName;
  static const String mante = Mantenimiento.routeName;
  static const String prod = Producto.routeName;
  static const String prov = Proveedor.routeName;
  static const String referencias = Referencias.routeName;
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piscinas Poolman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaSesion(),
      routes: {
        inicio: (context) => PaginaInicio(),
        ubicacion: (context) => MapSample(),
        cliente: (context) => Cliente(),
        editarc: (context) => Editar(),
        editare: (context) => Editare(),
        editarm: (context) => Editarm(),
        editarp: (context) => Editarp(),
        editarprov: (context) => Editarprov(),
        empleado: (context) => Empleado(),
        mante: (context) => Mantenimiento(),
        prod: (context) => Producto(),
        prov: (context) => Proveedor(),
        referencias: (context) => Referencias(),
      },
    );
  }
}

class PaginaSesion extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: prefer_final_fields
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('usuario');

  PaginaSesion({super.key});

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot = await _usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: contrasena)
        .get();

    if (querySnapshot.size > 0) {
      // Inicio de sesión exitoso, redirigir a la página principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaInicio()),
      );
    } else {
      // Mostrar un diálogo de error en caso de inicio de sesión fallido
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content:
                const Text('Credenciales incorrectas. Inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _registro(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.size > 0) {
      // Mostrar un diálogo de error en caso de que el usuario ya esté registrado
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de registro'),
            content: const Text('El usuario ya está registrado.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Registrar al usuario en Firestore
      await _usersCollection.add({
        'email': email,
        'password': contrasena,
      });

      // Mostrar un diálogo de registro exitoso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registro exitoso'),
            content: const Text('El usuario ha sido registrado correctamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Piscinas Poolman',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff24384e),
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              "Inicio de sesión o registro",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2.5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff24384e),
              ),
              onPressed: () => _login(context),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Registrarse',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff24384e),
              ),
              onPressed: () => _registro(context),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaInicio extends StatelessWidget {
  static const String routeName = "/main";

  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Piscinas Poolman',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff24384e),
          elevation: 8,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(
                        "https://raw.githubusercontent.com/BeltranJ128/img_iOS/main/FlutterFlowA12/piscina1.jpg"),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Bienvenido a piscinas poolman, en esta app podrás enconctrar nuestra ubicacion, nuestras listas de clientes, empleados, mantenimientos, productos y proveedores.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Image(image: AssetImage("Assets/fotoficha.jfif"), width: 250),
                  Text("José Carlos Beltrán Gámez"),
                  Divider(),
                  Text(
                      "Mis conclusiones sobre este proyecto es que fue un gran reto al hacerlo con un estilo que tuve que crear en su mayoría desde 0 solo tomando como referencia trabajos pasados que realice en todo el semestre, al momento de hacer la aplicacion tuve muchas dificultades con las bases de datos y con la implementacion de google maps, pero al final consegui hacerlo y me queda un aprendizaje para el futuro.")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
