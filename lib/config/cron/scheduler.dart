import 'cron_job.dart';

class CronScheduler {
  final Map<String, CronJob> _jobs = {};

  void addJob(CronJob job) {
    if (_jobs.containsKey(job.id)) {
      throw Exception('Job ${job.id} already exists.');
    }
    _jobs[job.id] = job;
    job.start();
  }

  void removeJob(String id) {
    final job = _jobs.remove(id);
    job?.stop();
  }

  void stopAll() {
    for (final job in _jobs.values) {
      job.stop();
    }
    _jobs.clear();
  }

  bool isJobRunning(String id) => _jobs[id]?.isRunning ?? false;
  List<String> get activeJobs => _jobs.keys.toList();

  void pauseJob(String id) {
    _jobs[id]?.pause();
  }

  void resumeJob(String id) {
    _jobs[id]?.resume();
  }

  void pauseAll() {
    for (final job in _jobs.values) {
      job.pause();
    }
  }

  void resumeAll() {
    for (final job in _jobs.values) {
      job.resume();
    }
  }
}
