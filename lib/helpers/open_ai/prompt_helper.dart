class PromptHelper {
  static String generatePromptForOpenAI(String inputUser, String jsonData) {
    return '''
Você é um assistente de recomendação de comida. O usuário disse: "$inputUser".

Com base no seguinte JSON de restaurantes e pratos, diga quais restaurantes combinam mais com o que foi pedido.

Dados:
$jsonData

Retorne apenas os ids dos restaurantes mais relevantes em uma lista separada por vírgula. NUNCA ENVIE NADA
FORA DISSO, SEM SUJESTÕES, APENAS OS IDS. 
''';
  }
}
