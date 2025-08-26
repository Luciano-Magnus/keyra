import 'dart:async';
import 'cron_expression.dart';

typedef CronCallback = FutureOr<void> Function();

class CronJob {
  final String id;
  final CronCallback callback;
  final int maxRetries;
  final Duration retryBackoff;

  Timer? _timer;
  bool _isPaused = false;
  int _currentRetryAttempts = 0;

  late final CronExpression? _parsedExpression;
  late final Duration? _interval;

  CronJob({
    required String cron,
    required this.id,
    required this.callback,
    this.maxRetries = 0,
    this.retryBackoff = const Duration(seconds: 1),
  }) : _parsedExpression = CronExpression(cron),
       _interval = null;

  CronJob.interval({
    required Duration interval,
    required this.id,
    required this.callback,
    this.maxRetries = 0,
    this.retryBackoff = const Duration(seconds: 1),
  }) : _parsedExpression = null,
       _interval = interval;

  void start() {
    if (_isPaused) return;
    if (_interval != null) {
      _scheduleNextInterval();
    }
    if (_parsedExpression != null) {
      _scheduleNextCron();
    }
  }

  void _scheduleNextInterval() {
    if (_isPaused) return;
    _timer = Timer(_interval!, () async {
      await _executeCallback();
      if (!_isPaused) {
        _scheduleNextInterval();
      }
    });
  }

  void _scheduleNextCron() {
    if (_isPaused) return;
    final now = DateTime.now();

    final duration = _parsedExpression!.getNextDateTime(now).difference(now);

    _timer = Timer(duration, () async {
      await _executeCallback();
      if (!_isPaused) {
        _scheduleNextCron();
      }
    });
  }

  Future<void> _executeCallback() async {
    if (_isPaused) return;
    try {
      await callback();
      _currentRetryAttempts = 0;
    } catch (e) {
      print('Error on job "$id": $e');
      if (_currentRetryAttempts < maxRetries) {
        _currentRetryAttempts++;
        final backoffDelay = retryBackoff * (1 << (_currentRetryAttempts - 1));
        print(
          'Retrying in ${backoffDelay.inSeconds} seconds (RetryAttempts $_currentRetryAttempts of $maxRetries)',
        );
        Timer(backoffDelay, () async {
          await _executeCallback();
        });
      } else {
        print('Job "$id" failed after $maxRetries attempts.');
        _currentRetryAttempts = 0;
      }
    }
  }

  void pause() {
    _isPaused = true;
    _timer?.cancel();
    print('Pause job "$id".');
  }

  void resume() {
    if (!_isPaused) return;
    _isPaused = false;
    print('Resume job "$id".');
    start();
  }

  void stop() {
    _timer?.cancel();
    _isPaused = false;
  }

  bool get isRunning => _timer?.isActive ?? false;
  bool get isPaused => _isPaused;
}
