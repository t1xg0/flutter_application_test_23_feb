import 'package:flutter/material.dart';

import '../models/lugar.dart';

class LugarDetailPage extends StatefulWidget {
  final Lugar lugar;
  final bool esFavoritoInicial;
  final ValueChanged<bool> onFavoritoChanged;

  const LugarDetailPage({
    super.key,
    required this.lugar,
    required this.esFavoritoInicial,
    required this.onFavoritoChanged,
  });

  @override
  State<LugarDetailPage> createState() => _LugarDetailPageState();
}

class _LugarDetailPageState extends State<LugarDetailPage> {
  late bool _esFavorito;

  @override
  void initState() {
    super.initState();
    _esFavorito = widget.esFavoritoInicial;
  }

  void _toggleFavorito() {
    setState(() {
      _esFavorito = !_esFavorito;
    });

    widget.onFavoritoChanged(_esFavorito);
  }

  @override
  Widget build(BuildContext context) {
    final lugar = widget.lugar;

    return Scaffold(
      appBar: AppBar(
        title: Text(lugar.nombre),
        actions: [
          IconButton(
            onPressed: _toggleFavorito,
            icon: Icon(
              _esFavorito ? Icons.star : Icons.star_border,
              color: _esFavorito ? Colors.amber : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              lugar.imagen,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 240,
                  alignment: Alignment.center,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported, size: 48),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      lugar.nombre,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorito,
                    icon: Icon(
                      _esFavorito ? Icons.star : Icons.star_border,
                      color: _esFavorito ? Colors.amber : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Chip(
                label: Text(lugar.categoria),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                lugar.descripcionLarga,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}