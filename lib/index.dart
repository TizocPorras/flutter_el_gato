import 'package:flutter/material.dart';
import 'botonera.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'restart') {
                _mostrarDialogoReiniciar(context);
              } else if (value == 'exit') {
                _mostrarDialogoSalir(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'restart',
                  child: Text('Reiniciar'),
                ),
                const PopupMenuItem(
                  value: 'exit',
                  child:  Text('Salir'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset('imagenes/board.png'),
            const Botonera(),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoReiniciar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reiniciar'),
          content: const Text('¿Deseas reiniciar el juego?'),
          actions: [
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop();
                // Reiniciar el juego aquí
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoSalir(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salir'),
          content: const Text('¿Deseas salir del juego?'),
          actions: [
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
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
