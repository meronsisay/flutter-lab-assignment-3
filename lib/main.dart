import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/presentation/blocs/album_event.dart';
import 'app/router.dart';
import 'presentation/blocs/album_bloc.dart';
import 'data/datasource/api_service.dart';
import 'data/repository/album_repository_impl.dart';
import './domain/album_repository.dart';

void main() {
  final apiService = ApiService();
  final repository = AlbumRepositoryImpl(apiService);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(repository)..add(FetchAlbums()),
      child: MaterialApp(
        title: 'Flutter Album App',
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
