import 'package:tobetoapp/models/catalog_model.dart';

abstract class CatalogState {}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Catalog> catalogs;

  CatalogLoaded({required this.catalogs});
}

class CatalogError extends CatalogState {}
