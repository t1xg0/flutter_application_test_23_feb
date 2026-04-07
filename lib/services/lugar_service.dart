import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/lugares_data.dart';
import '../models/lugar.dart';

class LugarService {
  final String baseUrl;
  final bool usarFallbackLocal;

  const LugarService({
    required this.baseUrl,
    this.usarFallbackLocal = true,
  });

  Future<List<Lugar>> obtenerLugares() async {
    try {
      final response = await http
                  .get(Uri.parse('$baseUrl/lugares'))
                  .timeout(const Duration(seconds: 3));

      if (response.statusCode != 200) {
        throw Exception('No se pudieron cargar los lugares');
      }

      final dynamic decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception('La respuesta no tiene el formato esperado');
      }

      return decoded
          .map((item) => Lugar.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (!usarFallbackLocal) rethrow;

      await Future.delayed(const Duration(seconds: 1));
      return lugares;
    }
  }
}