import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // NOTE: Put your exact HuggingFace URL here (e.g., https://username-smartwatt.hf.space)
  static const String baseUrl = 'https://YOUR_HUGGINGFACE_SPACE_URL.hf.space';

  /// Sends the formatted household and appliance data to the FastAPI prediction endpoint
  static Future<Map<String, dynamic>> getPredictions(Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict_batch'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network Error connecting to HuggingFace: $e');
    }
  }

  /// Runs the what-if AI simulation
  static Future<Map<String, dynamic>> runSimulation(Map<String, dynamic> simulationData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/simulate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(simulationData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Simulation failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }
}
