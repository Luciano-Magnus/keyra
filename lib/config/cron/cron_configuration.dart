import 'scheduler.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class CronConfiguration {
  @Bean()
  CronScheduler cronScheduler() {
    return CronScheduler();
  }
}
