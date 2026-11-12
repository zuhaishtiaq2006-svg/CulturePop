import 'dart:math';
import 'package:flutter/material.dart';
import 'main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  // Staggered entrance animation controller
  late AnimationController _entranceController;
  late Animation<double> _fadeHeader;
  late Animation<double> _scaleHero;
  late Animation<double> _fadeHero;
  late Animation<double> _popBubble;
  late Animation<double> _stampAnim;
  late Animation<Offset> _slideText;
  late Animation<double> _fadeText;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  // Continuous floating & breathing animation
  late AnimationController _floatingController;

  // Button pulse animation
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // 1. Entrance Controller
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeHeader = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );

    _scaleHero = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.55, curve: Curves.easeOutBack),
      ),
    );

    _fadeHero = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.1, 0.45, curve: Curves.easeOut),
    );

    _popBubble = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.40, 0.70, curve: Curves.elasticOut),
    );

    _stampAnim = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.50, 0.80, curve: Curves.elasticOut),
    );

    _slideText = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.50, 0.85, curve: Curves.easeOutCubic),
    ));

    _fadeText = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.50, 0.85, curve: Curves.easeOut),
    );

    _fadeButton = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );

    _slideButton = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
    ));

    // 2. Continuous Floating Controller (gentle bobbing)
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    // 3. Button Pulse Controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.028).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _entranceController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainNavigationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 550),
      ),
    );
  }

  void _onNextPressed() {
    if (_currentPage == 0) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    } else {
      _navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B0F19) : const Color(0xFFFBF8F2),
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP BRAND HEADER + SKIP ACTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: FadeTransition(
                opacity: _fadeHeader,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo + Title
                    Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE76F51),
                              width: 2.2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE76F51),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'CulturePop',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF161F38),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),

                    // Skip Button
                    GestureDetector(
                      onTap: _navigateToHome,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161F38).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. PAGEVIEW: 2 ONBOARDING SCREENS
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildScreenOne(size),
                  _buildScreenTwo(size),
                ],
              ),
            ),

            // 3. TWO INTERACTIVE DOTS (Active Pill + Inactive Dot)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      width: _currentPage == 0 ? 22 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _currentPage == 0
                            ? const Color(0xFFE76F51)
                            : const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      width: _currentPage == 1 ? 22 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _currentPage == 1
                            ? const Color(0xFFE76F51)
                            : const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. SUB-TAG (MADE FOR THE CURIOUS)
            Text(
              _currentPage == 0 ? 'MADE FOR THE CURIOUS' : 'YOUR PASSPORT AWAITS',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Color(0xFF94A3B8),
                letterSpacing: 2.2,
              ),
            ),
            const SizedBox(height: 16),

            // 5. PRIMARY ACTION BUTTON WITH GRADIENT & PULSE
            FadeTransition(
              opacity: _fadeButton,
              child: SlideTransition(
                position: _slideButton,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: ScaleTransition(
                    scale: _pulseScale,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE76F51), Color(0xFFF4A261)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE76F51).withValues(alpha: 0.38),
                              blurRadius: 18,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _onNextPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentPage == 0
                                    ? 'CONTINUE TOUR'
                                    : 'START YOUR WORLD TOUR',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 6. ACADEMIC CREDITS AT BOTTOM
            const Padding(
              padding: EdgeInsets.only(top: 14.0, bottom: 10.0),
              child: Text(
                'COMSATS University Islamabad • Sahiwal Campus',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFA0AEC0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SCREEN 1: THE WORLD & EXPLORATION (Exact match to prototype)
  // ============================================================
  Widget _buildScreenOne(Size size) {
    final heroSize = min(size.height * 0.33, min(size.width * 0.80, 290.0));
    return Column(
      children: [
        const Spacer(flex: 1),

        // Central Illustration with Floating Badges
        Center(
          child: SizedBox(
            width: heroSize,
            height: heroSize,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Soft background circular glow
                Container(
                  width: heroSize * 0.90,
                  height: heroSize * 0.90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFE8F1F5).withValues(alpha: 0.8),
                        const Color(0xFFFBECE6).withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                      radius: 0.75,
                    ),
                  ),
                ),

                // Floating 3D Globe Illustration
                AnimatedBuilder(
                  animation: _floatingController,
                  builder: (context, child) {
                    final floatOffset = sin(_floatingController.value * pi) * 6.5;
                    return Transform.translate(
                      offset: Offset(0, -floatOffset),
                      child: child,
                    );
                  },
                  child: FadeTransition(
                    opacity: _fadeHero,
                    child: ScaleTransition(
                      scale: _scaleHero,
                      child: Image.asset(
                        'assets_png/p2_0_X1.webp',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&w=800&q=80',
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Top-Right Speech Bubble: "Oh, the places! ✦"
                Positioned(
                  top: 14,
                  right: 8,
                  child: ScaleTransition(
                    scale: _popBubble,
                    child: const _SpeechBubbleBadge(
                      text: 'Oh, the places!',
                    ),
                  ),
                ),

                // Bottom-Left Tilted Stamp: "✦ BOUNDLESS CURIOSITY ✦"
                Positioned(
                  bottom: 26,
                  left: -6,
                  child: ScaleTransition(
                    scale: _stampAnim,
                    child: Transform.rotate(
                      angle: -0.15,
                      child: const _BoundlessCuriosityStamp(
                        text: 'BOUNDLESS CURIOSITY',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(flex: 1),

        // Typography Content
        FadeTransition(
          opacity: _fadeText,
          child: SlideTransition(
            position: _slideText,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                children: [
                  Text(
                    'CulturePop',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF161F38),
                      letterSpacing: -0.8,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore the world without\ntraveling',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF161F38),
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Little discoveries. Meaningful connections.\nA whole world to fall in love with.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  // ============================================================
  // SCREEN 2: PASSPORT, STORIES & TRADITIONS (New 2nd Screen)
  // ============================================================
  Widget _buildScreenTwo(Size size) {
    final heroSize = min(size.height * 0.33, min(size.width * 0.80, 290.0));
    return Column(
      children: [
        const Spacer(flex: 1),

        // Second Screen Hero: Scenic World Wonder with badges
        Center(
          child: SizedBox(
            width: heroSize,
            height: heroSize,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Soft background circular glow (lavender/sky)
                Container(
                  width: heroSize * 0.90,
                  height: heroSize * 0.90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF0F4FF).withValues(alpha: 0.9),
                        const Color(0xFFFFECE8).withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                      radius: 0.75,
                    ),
                  ),
                ),

                // Floating Scenic Circular Wonder
                AnimatedBuilder(
                  animation: _floatingController,
                  builder: (context, child) {
                    final floatOffset = sin((_floatingController.value + 0.5) * pi) * 6.5;
                    return Transform.translate(
                      offset: Offset(0, -floatOffset),
                      child: child,
                    );
                  },
                  child: Container(
                    width: heroSize * 0.78,
                    height: heroSize * 0.78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF161F38).withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets_png/p14_0_X1.webp',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=800&q=80',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Floating Stamp 1: Top-Right "Collect every story! ✦"
                const Positioned(
                  top: 14,
                  right: 4,
                  child: _SpeechBubbleBadge(
                    text: 'Collect every story!',
                  ),
                ),

                // Floating Stamp 2: Bottom-Left "✦ WORLD PASSPORT ✦"
                Positioned(
                  bottom: 24,
                  left: -6,
                  child: Transform.rotate(
                    angle: -0.14,
                    child: const _BoundlessCuriosityStamp(
                      text: 'WORLD PASSPORT',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(flex: 1),

        // Screen 2 Typography Content
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            children: [
              Text(
                'Cultural Journey',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF161F38),
                  letterSpacing: -0.8,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Collect stamps, taste flavors\n& master traditions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF161F38),
                  height: 1.25,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'From Tokyo to Rome, Istanbul to Rio de Janeiro.\nDiscover 9 iconic nations at your own pace.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

// ============================================================
// SPEECH BUBBLE BADGE: "Oh, the places! ✦"
// ============================================================

class _SpeechBubbleBadge extends StatelessWidget {
  final String text;

  const _SpeechBubbleBadge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9DB), // Soft pastel yellow/cream
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFEEA9F),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.14),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF161F38),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            '✦',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFFE76F51),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHED STAMP BADGE: "✦ BOUNDLESS CURIOSITY ✦"
// ============================================================

class _BoundlessCuriosityStamp extends StatelessWidget {
  final String text;

  const _BoundlessCuriosityStamp({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRectPainter(
        color: const Color(0xFFE76F51),
        strokeWidth: 1.2,
        dashLength: 4.0,
        dashSpace: 3.0,
        radius: 8.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.near_me_rounded,
              size: 13,
              color: Color(0xFFE76F51),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Color(0xFFE76F51),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashed border painter for postal stamp badges
class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashLength = 4.0,
    this.dashSpace = 3.0,
    this.radius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = min(distance + dashLength, metric.length);
        final segment = metric.extractPath(distance, next);
        canvas.drawPath(segment, paint);
        distance += dashLength + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) => false;
}
