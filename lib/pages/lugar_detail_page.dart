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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              lugar.imagen,
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lugar.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      lugar.categoria,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lugar.descripcionLarga,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _toggleFavorito,
                      icon: Icon(
                        _esFavorito ? Icons.star : Icons.star_border,
                      ),
                      label: Text(
                        _esFavorito
                            ? 'Quitar de favoritos'
                            : 'Marcar como favorito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}