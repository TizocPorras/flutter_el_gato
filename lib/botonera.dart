import 'package:flutter/material.dart';
import 'package:flutter_el_gato/config/config.dart';
import 'package:flutter_el_gato/widgets/celda.dart';

class Botonera extends StatefulWidget {
  const Botonera({super.key});

  @override
  State<Botonera> createState() => _BotoneraState();
}

class _BotoneraState extends State<Botonera>{
  double dimension = 0;
  double ancho = 0;
  EstadosCelda estadoInicial = EstadosCelda.cross;
  double cO = 0;
  double cX = 0;
  String an = '';
  int C = 0;
  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size.width;
    ancho = dimension / 3;
    return Builder(builder: (context) {
      return SizedBox(
        width: dimension,
        height: dimension,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: estados.length,
                itemBuilder: (context, index) {
                  return Celda(
                    ancho: ancho,
                    alto: ancho,
                    estado: estados[index],
                    callback: () => onPress(index),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
  void onPress(int index) {
    debugPrint('Clicked: $index');
    if (estados[index] == EstadosCelda.empty) {
      setState(() {
        estados[index] = estadoInicial;
      });
    }
    estadoInicial = estadoInicial == EstadosCelda.cross ? EstadosCelda.circle : EstadosCelda.cross;
    resultado = {
      EstadosCelda.circle: false,
      EstadosCelda.cross: false,
    };
    EstadosCelda ganador = buscarganador();
    if (ganador == EstadosCelda.empty) {
      C++;
      if (C == 9) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Empate'),
              content: Text(
                'X: $cX\nO: $cO',
              ),
              actions: [
                TextButton(
                  child: const Text('Continuar'),
                  onPressed: () {
                    reiniciarJuego();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Salir'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      if (ganador == EstadosCelda.circle) {
        an = 'O';
        cO++;
      } else if (ganador == EstadosCelda.cross) {
        an = 'X';
        cX++;
      } else {
        an = 'empate';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$an GANO',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'X: $cX',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'O: $cO',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Continuar'),
                onPressed: () {
                  reiniciarJuego();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Salir'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  EstadosCelda buscarganador() {
    for (var i = 0; i < estados.length; i += 3) {
      sonIguales(i, i + 1, i + 2);
    }
    for (var i = 0; i < 3; i++) {
      sonIguales(i, i + 3, i + 6);
    }
    sonIguales(0, 4, 8);
    sonIguales(2, 4, 6);

    if (resultado[EstadosCelda.circle] == true) {
      return EstadosCelda.circle;
    }
    if (resultado[EstadosCelda.cross] == true) {
      return EstadosCelda.cross;
    }
    return EstadosCelda.empty;
  }
  void sonIguales(int a, int b, int c) {
    if (estados[a] != EstadosCelda.empty) {
      if (estados[a] == estados[b] && estados[b] == estados[c]) {
        resultado[estados[a]] = true;
      }
    }
  }
  void reiniciarJuego() {
    setState(() {
      estados = List.filled(9, EstadosCelda.empty);
      C = 0;
    });
  }
}
//End Class.