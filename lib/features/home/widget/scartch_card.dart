import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;
import '../../../core/cubit/app_cubit.dart';
import '../../../core/entities/app_state.dart';

class ScratchCardDialog extends StatefulWidget {
  @override
  _ScratchCardDialogState createState() => _ScratchCardDialogState();
}

class _ScratchCardDialogState extends State<ScratchCardDialog> {
  List<Offset> _scratchedPoints = [];
  bool _isScratched = false;

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().scratchCard(); // Generate reward when dialog opens
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final reward = state.transactions.isNotEmpty
            ? state.transactions.last.amount
            : 0; // Get last reward

        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Scratch to Reveal Your Reward!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _isScratched ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🎉 You won $reward Coins!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!_isScratched)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ScratchMask(
                        onScratchComplete: () {
                          setState(() {
                            _isScratched = true;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () => Navigator.of(context).pop(),
          //     child: const Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }
}

class ScratchMask extends StatefulWidget {
  final VoidCallback onScratchComplete;

  ScratchMask({required this.onScratchComplete});

  @override
  _ScratchMaskState createState() => _ScratchMaskState();
}

class _ScratchMaskState extends State<ScratchMask> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(details.localPosition);
        });
        if (points.length > 150) {
          widget.onScratchComplete();
        }
      },
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(300, 200),
          painter: ScratchPainter(points: points),
        ),
      ),
    );
  }
}

class ScratchPainter extends CustomPainter {
  final List<Offset> points;

  ScratchPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..blendMode = BlendMode.clear;

    final recorder = ui.PictureRecorder();
    final scratchCanvas =
        Canvas(recorder, Rect.fromLTWH(0, 0, size.width, size.height));
    scratchCanvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.blue);

    for (var point in points) {
      scratchCanvas.drawCircle(point, 20.0, paint);
    }

    final picture = recorder.endRecording();
    final image = picture.toImageSync(size.width.toInt(), size.height.toInt());
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
