import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobetoapp/bloc/catalog/catalog_event.dart';
import 'package:tobetoapp/bloc/catalog/catalog_state.dart';
import 'package:tobetoapp/repository/catalog_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository catalogRepository;

  CatalogBloc({required this.catalogRepository}) : super(CatalogInitial()) {
    on<LoadCatalog>((event, emit) async {
      emit(CatalogLoading());
      try {
        final catalogList = await catalogRepository.getCatalog();
        emit(CatalogLoaded(catalogs: catalogList));
      } catch (e) {
        emit(CatalogError());
      }
    });
  }
}
