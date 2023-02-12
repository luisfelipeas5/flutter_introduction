# flutter_introduction

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Directory structure

|- modules
    |- movie [module_name]
        |- dependency_injection
        |- data
            |- model
                |- movie_model.dart
            |- repositories
                |- movie_repository.dart (or movie_repository_impl.dart)
            |- data_sources
                |- movie_remote_data_source.dart
        |- domain
            |- entities
                |- movie.dart
            |- repositories
                |- i_movie_repository.dart (or movie_repository.dart)
            |- use_cases
                |- load_movies.dart
        |- presentation
            |- pages
                |- movies_pages.dart
            |- widgets
                |- movie_title.dart
            |- controllers
                |- movie_controller.dart
    |- shared    
        |- ...
|- feature_core
    |- network
    |- push_notification
    |- remote_config
    |- bugs_collector
    |- ...