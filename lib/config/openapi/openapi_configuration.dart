import 'dart:convert';

import 'package:vaden/vaden.dart';
import 'package:vaden/vaden_openapi.dart';

@Configuration()
class OpenApiConfiguration {
  @Bean()
  OpenApi openApi(OpenApiConfig config) {
    return OpenApi(
      version: '3.0.0',
      info: Info(
        title: 'Keyra API',
        version: '1.0.0',
        description: 'A lightweight license management API. Create, validate and manage software licenses with ease.',
      ),
      servers: [
        config.localServer,
      ],
      tags: config.tags,
      paths: config.paths,
      externalDocs: ExternalDocs(
        description: 'Find out more about Keyra',
        url: 'https://keyra.dev',
      ),
      security: [
        Security(
          name: 'apiKey',
          scopes: [],
        ),
      ],
      components: Components(
        schemas: config.schemas,
        securitySchemes: {
          'apiKey': SecurityScheme.apiKey(
            name: 'X-API-Key',
            description: 'API key for accessing the API',
            location: ApiKeyLocation.header,
          ),
        },
      ),
    );
  }

  @Bean()
  SwaggerUI swaggerUI(OpenApi openApi) {
    return SwaggerUI(
      jsonEncode(openApi.toJson()),
      title: 'keyra API',
      docExpansion: DocExpansion.list,
      deepLink: true,
      persistAuthorization: false,
      syntaxHighlightTheme: SyntaxHighlightTheme.agate,
    );
  }
}

