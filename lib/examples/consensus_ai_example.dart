import '../services/consensus_ai_service.dart';

Future<void> exampleUsage() async {
  final service = ConsensusAiService();

  final requestBody = {
    'message': 'What is the capital of France?',
  };

  final result = await service.invokeConsensusAiChat(
    body: requestBody,
  );

  if (result['success']) {
    print('Success: ${result['data']}');
  } else {
    print('Error: ${result['error']}');
    print('Message: ${result['message']}');
  }
}

Future<void> exampleWithUserToken() async {
  final service = ConsensusAiService();

  final requestBody = {
    'message': 'What is the capital of France?',
  };

  final result = await service.invokeConsensusAiChat(
    body: requestBody,
    userAccessToken: 'your_user_access_token_here',
  );

  if (result['success']) {
    print('Success: ${result['data']}');
  } else {
    print('Error: ${result['error']}');
    print('Message: ${result['message']}');
  }
}
