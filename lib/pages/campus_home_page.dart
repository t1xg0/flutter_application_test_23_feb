import 'package:flutter/material.dart';
import '../data/lugares_data.dart';
import '../pages/lugar_detail_page.dart';
import '../widgets/lugar_card.dart';

class CampusHomePage extends StatefulWidget {
  const CampusHomePage({super.key});

  @override
  State<CampusHomePage> createState() => _CampusHomePageState();
}

class _CampusHomePageState extends State<CampusHomePage> {
  final Set<int> _favoritos = {};

  void _actualizarFavorito(int lugarId, bool esFavorito) {
    setState(() {
      if (esFavorito) {
        _favoritos.add(lugarId);
      } else {
        _favoritos.remove(lugarId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares del Campus'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];
          final esFavorito = _favoritos.contains(lugar.id);

          return LugarCard(
            lugar: lugar,
            esFavorito: esFavorito,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LugarDetailPage(
                    lugar: lugar,
                    esFavoritoInicial: esFavorito,
                    onFavoritoChanged: (nuevoValor) {
                      _actualizarFavorito(lugar.id, nuevoValor);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}