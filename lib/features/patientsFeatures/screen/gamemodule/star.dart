import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class RewardsMeterStars extends StatelessWidget {
  final int starCount;
  final double starMinRadius;
  final double starMaxRadius;

  const RewardsMeterStars({
    Key? key, required this.starCount, required this.starMinRadius, required this.starMaxRadius,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize and store the controller using Get.put() if not already in memory
    final StarController controller = Get.put(
      StarController(
        starCount: starCount,
        starMinRadius: starMinRadius,
        starMaxRadius: starMaxRadius,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Set the canvas size in the controller when the layout is built
        controller.setCanvasSize(Size(constraints.maxWidth, constraints.maxHeight));

        // Use Obx to make the widget reactively update when the controller's state changes
       
          return CustomPaint(
            painter: StarSystemPainter(controller.starSystem),
            size: Size.infinite,
          );
        
      },
    );
  }
}


class StarSystemPainter extends CustomPainter {
  StarSystemPainter(
    this.starSystem,
  ) : super(repaint: starSystem);

  /// The [StarParticleSystem] that this painter paints.
  final StarParticleSystem starSystem;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..clipRect(Offset.zero & size);

    starSystem.canvasSize = size;

    // Initialize the star system, if it's not already initialized
    starSystem.init();

    // Paint the background
    canvas.drawPaint(Paint()..color = Color(0xFFd7a254));

    // Paint the stars
    final stars = starSystem.stars;
    for (final star in stars) {
      final starPath = StarPathTemplate.fivePoints(star.radius);

      canvas
        ..save()
        ..translate(star.offset.dx, star.offset.dy)
        ..rotate(star.rotation)
        ..drawPath(
          starPath.toPath(),
          Paint()..color = star.color,
        )
        ..restore();
    }

    // Release the clipping bounds.
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint happens whenever the particle system reports a change.
    return false;
  }
}

/// Creates a [Path] to draw a start with the given [pointCount],
/// [outerRadius], and [innerRadius].
///
/// To draw a traditional 5-point star, use the [fivePoints] constructor.
class StarPathTemplate {
  /// Creates a [StarPathTemplate] that generates a traditional 5-point
  /// star with the given [outerRadius].
  StarPathTemplate.fivePoints(this.outerRadius)
      : pointCount = 5,
        innerRadius = outerRadius * 0.5;

  StarPathTemplate({
    required this.pointCount,
    required this.outerRadius,
    required this.innerRadius,
  });

  /// The number of corner points in the star.
  final int pointCount;

  /// The distance from the center of the star to a corner point.
  final double outerRadius;

  /// The distance from the center of the start to an inner point.
  final double innerRadius;

  /// Generates a [Path] that draws a star, as configured by [pointCount],
  /// [outerRadius], and [innerRadius].
  Path toPath() {
    const startAngle = -pi / 2;
    final angleIncrement = 2 * pi / (2 * pointCount);

    final starPath = Path()
      ..moveTo(
        outerRadius * cos(startAngle),
        outerRadius * sin(startAngle),
      );
    for (int i = 1; i < 2 * pointCount; i += 2) {
      starPath
        ..lineTo(
          innerRadius * cos(startAngle + (i * angleIncrement)),
          innerRadius * sin(startAngle + (i * angleIncrement)),
        )
        ..lineTo(
          outerRadius * cos(startAngle + ((i + 1) * angleIncrement)),
          outerRadius * sin(startAngle + ((i + 1) * angleIncrement)),
        );
    }
    starPath.close();

    return starPath;
  }
}



class StarController extends GetxController with SingleGetTickerProviderMixin {
  late Ticker _ticker;
  late StarParticleSystem _starSystem;

  final int starCount;
  final double starMinRadius;
  final double starMaxRadius;

  StarController({
    required this.starCount,
    required this.starMinRadius,
    required this.starMaxRadius,
  });

  // Canvas size is reactive to keep the particle system updated
  var canvasSize = Size.zero.obs;

  @override
  void onInit() {
    super.onInit();
    _starSystem = StarParticleSystem(
      starCount: starCount,
      minRadius: starMinRadius,
      maxRadius: starMaxRadius,
    );
    _ticker = Ticker(_onTick)..start();
  }

  @override
  void onClose() {
    _ticker.dispose();
    super.onClose();
  }

  // Function to update star positions over time
  void _onTick(Duration elapsedTime) {
    _starSystem.update(elapsedTime);
    update(); // Trigger a UI update with GetX
  }

  // Star system update
  StarParticleSystem get starSystem => _starSystem;

  // Set canvas size for the stars
  void setCanvasSize(Size size) {
    canvasSize.value = size;
    _starSystem.canvasSize = size;
  }
}

class StarParticleSystem with ChangeNotifier {
  StarParticleSystem({
    required this.starCount,
    required this.minRadius,
    required this.maxRadius,
  });

  /// The number of stars to maintain in the system.
  ///
  /// When one star dies, another star is born.
  final int starCount;

  /// The smallest possible outer-radius for a star.
  final double minRadius;

  /// The largest possible outer-radius for a star.
  final double maxRadius;

  /// All the stars in the system.
  final stars = <StarParticle>[];

  /// Tells this particle system how much space is available for
  /// the star particles, which is used to decide where to generate
  /// stars, and when a star moves off-screen.
  set canvasSize(Size canvasSize) => _canvasSize = canvasSize;
  late Size _canvasSize;

  Duration _lastTickTime = Duration.zero;
  bool _isInitialized = false;

  /// Initialize the particle system, which generates the first generation
  /// of star particles.
  ///
  /// Does nothing if the system is already initialized.
  void init() {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;

    _lastTickTime = Duration.zero;

    for (int i = 0; i < starCount; i += 1) {
      stars.add(_generateStar(_canvasSize));
    }
  }

  /// Updates all the particles in the system based on the change
  /// in time since the last update.
  void update(Duration elapsedTime) {
    final dt = elapsedTime - _lastTickTime;
    _lastTickTime = elapsedTime;

    if (!_isInitialized) {
      return;
    }

    // Traverse in reverse order so that we can remove dead stars
    // as we go.
    for (int i = stars.length - 1; i >= 0; i -= 1) {
      stars[i].tick(dt);
      if (stars[i].offset.dx - stars[i].radius > _canvasSize.width) {
        stars.removeAt(i);
      }
    }

    // Fill the system back up with the desired number of stars.
    for (int i = stars.length; i <= starCount; i += 1) {
      stars.add(_generateStar(_canvasSize));
    }

    notifyListeners();
  }

  StarParticle _generateStar(Size canvasSize) {
    final random = Random();
    return StarParticle(
      offset: Offset(-_canvasSize.width * random.nextDouble(), canvasSize.height * random.nextDouble()),
      velocity: Offset(lerpDouble(canvasSize.width / 10, canvasSize.width / 5, random.nextDouble())!, 0),
      rotation: 2 * pi * random.nextDouble(),
      radialVelocity: lerpDouble((pi / 8), (pi / 4), random.nextDouble())!,
      radius: lerpDouble(minRadius, maxRadius, random.nextDouble())!,
      color: Color.lerp(Color(0xFFffc55e), Color(0xFFfff574), random.nextDouble())!,
    );
  }
}

/// Particle that represents a star.
class StarParticle {
  StarParticle({
    required this.offset,
    required this.velocity,
    required this.rotation,
    required this.radialVelocity,
    required this.radius,
    required this.color,
  });

  /// The (x,y) position of the particle in the system.
  Offset offset;

  /// The velocity of the particle.
  final Offset velocity;

  /// The rotation of the particle, in radians.
  double rotation;

  /// The radial velocity of the particle, in radians per second.
  final double radialVelocity;

  /// The outer radius of the star.
  final double radius;

  /// The color of the star.
  final Color color;

  /// Updates the physical state of the star, moving the [offset] by
  /// [velocity], and rotating the [rotation] by [radialVelocity].
  void tick(Duration dt) {
    final dtInSeconds = dt.inMilliseconds / 1000;
    offset += velocity * dtInSeconds;
    rotation += radialVelocity * dtInSeconds;
  }
}

