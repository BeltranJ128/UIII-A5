import 'package:flutter/material.dart';
import 'main.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  void _cerrarSesion(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaginaSesion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(""),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/BeltranJ128/img_iOS/main/FlutterFlowA12/fondo.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Inicio")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiAplicacion.inicio)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.groups),
                Padding(padding: EdgeInsets.all(10)),
                Text("Clientes")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiAplicacion.cliente)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.contact_emergency_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Empleados")
              ],
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(context, MiAplicacion.empleado)
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.handyman_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Mantenimientos")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiAplicacion.mante)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.science_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Productos")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiAplicacion.prod)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.handshake_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Proveedores")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiAplicacion.prov)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_pin),
                Padding(padding: EdgeInsets.all(10)),
                Text("Ubicacion")
              ],
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(context, MiAplicacion.ubicacion)
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.link),
                Padding(padding: EdgeInsets.all(10)),
                Text("Referencias")
              ],
            ),
            onTap: () => {
              Navigator.pushReplacementNamed(context, MiAplicacion.referencias)
            },
          ),
          Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 40),
              backgroundColor: const Color(0xff24384e),
            ),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
    );
  }
}
