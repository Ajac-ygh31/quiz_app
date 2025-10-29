import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Educativo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SplashScreen(),
    );
  }
}

// ---------------------------------------------
// SPLASH SCREEN
// ---------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simular carga y pasar al menú después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CategoryPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.school, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Quiz Educativo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------
// MENU DE CATEGORÍAS
// ---------------------------------------------
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"name": "Matemáticas", "icon": Icons.calculate, "color": Colors.blue},
    {"name": "Sociales", "icon": Icons.public, "color": Colors.green},
    {"name": "Ciencias Naturales", "icon": Icons.science, "color": Colors.red},
    {"name": "Lengua y Literatura", "icon": Icons.menu_book, "color": Colors.orange},
    {"name": "Inglés", "icon": Icons.translate, "color": Colors.purple},
    {"name": "Historia", "icon": Icons.history_edu, "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona una categoría"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(category: category["name"]),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: category["color"].withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category["icon"], size: 50, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      category["name"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------
// PÁGINA DE QUIZ MEJORADA
// ---------------------------------------------
class QuizPage extends StatefulWidget {
  final String category;
  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;

  final Map<String, List<Map<String, Object>>> quizzes = {
    "Matemáticas": [
      {
        'question': '¿Cuánto es 12 × 8?',
        'answers': [
          {'text': '96', 'correct': true},
          {'text': '84', 'correct': false},
          {'text': '108', 'correct': false},
          {'text': '120', 'correct': false},
        ]
      },
      {
        'question': 'La raíz cuadrada de 144 es:',
        'answers': [
          {'text': '10', 'correct': false},
          {'text': '12', 'correct': true},
          {'text': '14', 'correct': false},
          {'text': '16', 'correct': false},
        ]
      },
    ],
    "Sociales": [
      {
        'question': '¿Quién fue el primer presidente de Nicaragua?',
        'answers': [
          {'text': 'José Santos Zelaya', 'correct': false},
          {'text': 'Fruto Chamorro', 'correct': true},
          {'text': 'Benjamín Zeledón', 'correct': false},
          {'text': 'Rubén Darío', 'correct': false},
        ]
      },
    ],
    "Ciencias Naturales": [
      {
        'question': '¿Cuál es el gas que las plantas absorben?',
        'answers': [
          {'text': 'Oxígeno', 'correct': false},
          {'text': 'Dióxido de carbono', 'correct': true},
          {'text': 'Nitrógeno', 'correct': false},
          {'text': 'Hidrógeno', 'correct': false},
        ]
      },
    ],
    "Lengua y Literatura": [
      {
        'question': '¿Quién escribió "La Odisea"?',
        'answers': [
          {'text': 'Homero', 'correct': true},
          {'text': 'Sófocles', 'correct': false},
          {'text': 'Virgilio', 'correct': false},
          {'text': 'Esquilo', 'correct': false},
        ]
      },
    ],
    "Inglés": [
      {
        'question': '¿Cómo se dice "perro" en inglés?',
        'answers': [
          {'text': 'Dog', 'correct': true},
          {'text': 'Cat', 'correct': false},
          {'text': 'Bird', 'correct': false},
          {'text': 'Fish', 'correct': false},
        ]
      },
    ],
    "Historia": [
      {
        'question': '¿En qué año descubrió Colón América?',
        'answers': [
          {'text': '1492', 'correct': true},
          {'text': '1500', 'correct': false},
          {'text': '1519', 'correct': false},
          {'text': '1485', 'correct': false},
        ]
      },
    ],
  };

  void answerQuestion(bool isCorrect) {
    if (isCorrect) score++;

    setState(() {
      if (currentQuestion < (quizzes[widget.category]?.length ?? 0) - 1) {
        currentQuestion++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
  showDialog(
    context: context,
    barrierDismissible: false, // evita que se cierre tocando fuera
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emoji o ícono divertido
            Text(
              score == (quizzes[widget.category]?.length ?? 0)
                  ? "🎉 ¡Excelente! 🎉"
                  : score >= ((quizzes[widget.category]?.length ?? 1) / 2)
                      ? "😊 ¡Muy bien! 😊"
                      : "😅 ¡Sigue intentando! 😅",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Tarjeta con puntaje
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Tu puntaje: $score de ${quizzes[widget.category]?.length}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Botón volver al menú
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.home, color: Colors.white),
              label: const Text(
                "Volver al menú",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context); // cerrar dialog
                Navigator.pop(context); // volver al menú
              },
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    var questionList = quizzes[widget.category] ?? [];
    if (questionList.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category)),
        body: const Center(child: Text("No hay preguntas disponibles.")),
      );
    }

    var question = questionList[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TARJETA DE PREGUNTA
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.indigo[50],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  question['question'] as String,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // OPCIONES
            Expanded(
              child: ListView(
                children:
                    (question['answers'] as List<Map<String, Object>>)
                        .map((answer) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.indigo[400],
                      ),
                      onPressed: () =>
                          answerQuestion(answer['correct'] as bool),
                      child: Text(
                        answer['text'] as String,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
