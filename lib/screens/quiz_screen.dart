import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final Country country;

  const QuizScreen({super.key, required this.country});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _hasCheckedAnswer = false;
  int _score = 0;
  bool _isQuizCompleted = false;

  void _onSelectOption(int index) {
    if (_hasCheckedAnswer) return;
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _checkAnswer() {
    if (_selectedOptionIndex == null || _hasCheckedAnswer) return;

    final question = widget.country.quiz[_currentQuestionIndex];
    final isCorrect = _selectedOptionIndex == question.correctIndex;

    setState(() {
      _hasCheckedAnswer = true;
      if (isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.country.quiz.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _hasCheckedAnswer = false;
      });
    } else {
      setState(() {
        _isQuizCompleted = true;
        widget.country.isStampCollected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isQuizCompleted) {
      return _buildCelebrationScreen();
    }

    final question = widget.country.quiz[_currentQuestionIndex];
    final totalQuestions = widget.country.quiz.length;
    final progress = (_currentQuestionIndex + 1) / totalQuestions;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.navyInk,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${widget.country.name} Culture Quiz',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.getText(context),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Eyebrow
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBorder : AppColors.coralLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'A LITTLE CULTURE CHECK ✦',
                  style: TextStyle(
                    color: AppColors.coral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Progress row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1} of $totalQuestions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.getText(context),
                    ),
                  ),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.coral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Coral Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                  valueColor: const AlwaysStoppedAnimation(AppColors.coral),
                ),
              ),

              const SizedBox(height: 28),

              // Question Prompt
              Text(
                question.question,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.getText(context),
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Options
              ...List.generate(question.options.length, (index) {
                final optionText = question.options[index];
                final isSelected = _selectedOptionIndex == index;
                final isCorrectOption = index == question.correctIndex;

                Color borderColor = isDark ? AppColors.darkCardBorder : AppColors.creamAccent;
                Color bgColor = isDark ? AppColors.darkCard : Colors.white;
                Color textColor = AppColors.getText(context);

                if (_hasCheckedAnswer) {
                  if (isCorrectOption) {
                    borderColor = AppColors.mint;
                    bgColor = isDark ? const Color(0xFF133B34) : AppColors.mintLight;
                    textColor = isDark ? const Color(0xFF5EEAD4) : const Color(0xFF1B6B5F);
                  } else if (isSelected && !isCorrectOption) {
                    borderColor = Colors.redAccent;
                    bgColor = isDark ? const Color(0xFF3B1A1A) : const Color(0xFFFFECE8);
                    textColor = Colors.redAccent;
                  }
                } else if (isSelected) {
                  borderColor = AppColors.coral;
                  bgColor = isDark ? AppColors.darkCardBorder : AppColors.coralLight;
                  textColor = AppColors.coral;
                }

                final optionLetter = String.fromCharCode(65 + index); // A, B, C, D

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => _onSelectOption(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: borderColor,
                          width: isSelected || (_hasCheckedAnswer && isCorrectOption) ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.2)
                                : AppColors.navyInk.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.coral
                                  : (isDark
                                      ? AppColors.darkCardBorder
                                      : AppColors.creamAccent.withValues(alpha: 0.6)),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                optionLetter,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected ? Colors.white : AppColors.getText(context),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              optionText,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                          ),
                          if (_hasCheckedAnswer && isCorrectOption)
                            const Icon(Icons.check_circle_rounded, color: AppColors.mint, size: 22)
                          else if (_hasCheckedAnswer && isSelected && !isCorrectOption)
                            const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 22),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Feedback Explanation Banner
              if (_hasCheckedAnswer) ...[
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _selectedOptionIndex == question.correctIndex
                        ? (isDark ? const Color(0xFF133B34) : AppColors.mintLight)
                        : (isDark ? const Color(0xFF3B1A1A) : const Color(0xFFFFF1F1)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _selectedOptionIndex == question.correctIndex
                          ? AppColors.mint.withValues(alpha: 0.4)
                          : Colors.redAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _selectedOptionIndex == question.correctIndex
                                ? '✨ That’s right! A little culture magic.'
                                : '💡 Good try! Here’s the story:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: _selectedOptionIndex == question.correctIndex
                                  ? (isDark ? const Color(0xFF5EEAD4) : const Color(0xFF1B6B5F))
                                  : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.explanation,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.getText(context),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Action Button (Check Answer vs Continue)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedOptionIndex == null
                      ? null
                      : (_hasCheckedAnswer ? _nextQuestion : _checkAnswer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coral,
                    disabledBackgroundColor: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    _hasCheckedAnswer
                        ? (_currentQuestionIndex == totalQuestions - 1
                            ? 'See My Results ➔'
                            : 'Continue ➔')
                        : 'Check Answer',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Celebration Screen
  Widget _buildCelebrationScreen() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Medallion celebration badge
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBorder : AppColors.coralLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.coral.withValues(alpha: 0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🎉', style: TextStyle(fontSize: 54)),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBorder : AppColors.coralLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'A LITTLE CELEBRATION ✦',
                  style: TextStyle(
                    color: AppColors.coral,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Text(
                'You’re a Culture\nExplorer!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.getText(context),
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'A few new stories. A whole lot of curiosity. ${widget.country.name} looks good in your journal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.getSubtext(context),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Score Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.3)
                          : AppColors.navyInk.withValues(alpha: 0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '$_score / ${widget.country.quiz.length}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.coral,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Little discoveries, well remembered ✦',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.getSubtext(context),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Add Country to Passport Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Text('🛂', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Stamp Collected! ${widget.country.name} ${widget.country.flagEmoji} added to your World Passport!',
                                style: const TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.mint,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_rounded, size: 20),
                  label: Text(
                    'Add ${widget.country.name} to Passport',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coral,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Keep exploring ${widget.country.name}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getSubtext(context),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
