import 'dart:convert';
import 'package:http/http.dart' as http;

class ConsensusAiService {
  static const String _functionUrl =
      'https://lmfhfllbnjkxklunmwcd.supabase.co/functions/v1/consensus-ai-chat';
  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxtZmhmbGxibmpreGtsdW5td2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIxOTgzOTQsImV4cCI6MjA3Nzc3NDM5NH0.WmfY1F1Ktxe6a3jBvvsgX9r-oNVZ-VW4PsmmKlk07Gk';

  Future<Map<String, dynamic>> invokeConsensusAiChat({
    required Map<String, dynamic> body,
    String? userAccessToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'apikey': _apiKey,
      };

      if (userAccessToken != null) {
        headers['Authorization'] = 'Bearer $userAccessToken';
      }

      final response = await http.post(
        Uri.parse(_functionUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error': 'Request failed with status: ${response.statusCode}',
          'message': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Exception occurred',
        'message': e.toString(),
      };
    }
  }
}
