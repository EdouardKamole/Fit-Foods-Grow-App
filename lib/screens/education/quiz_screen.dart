import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  bool _quizCompleted = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the best time to water plants?',
      'options': ['Morning', 'Afternoon', 'Evening', 'Night'],
      'correctAnswer': 0,
    },
    {
      'question': 'Which nutrient is essential for leaf growth?',
      'options': ['Nitrogen', 'Phosphorus', 'Potassium', 'Calcium'],
      'correctAnswer': 0,
    },
    {
      'question': 'How often should you fertilize most plants?',
      'options': ['Daily', 'Weekly', 'Monthly', 'Yearly'],
      'correctAnswer': 2,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestion]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gardening Quiz'),
      ),
      body: _quizCompleted ? _buildResults() : _buildQuiz(),
    );
  }

  Widget _buildQuiz() {
    final question = _questions[_currentQuestion];
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentQuestion + 1) / _questions.length,
          ),
          const SizedBox(height: 16),
          Text(
            'Question ${_currentQuestion + 1}/${_questions.length}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            question['question'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ...List.generate(question['options'].length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(index),
                  child: Text(question['options'][index]),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _score == _questions.length ? Icons.emoji_events : Icons.celebration,
              size: 80,
              color: _score == _questions.length ? Colors.amber : Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'You scored $_score out of ${_questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _restartQuiz,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}