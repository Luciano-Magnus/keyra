import 'package:keyra/src/shared/middlewares/api_token_middleware.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class AppConfiguration {

  @Bean()
  ApplicationSettings settings() {
    return ApplicationSettings.load('application.yaml');
  }

  @Bean()
  Pipeline globalMiddleware(ApplicationSettings settings) {
    return Pipeline() //
        .addMiddleware(
          cors(
            allowedOrigins: ['*'],
            allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
            allowHeaders: ['Authorization', 'Content-Type', 'X-Api-Key'],
          ),
        )
        .addVadenMiddleware(EnforceJsonContentType())
        .addVadenMiddleware(ApiTokenMiddleware())
        .addMiddleware(logRequests());
  }
}
