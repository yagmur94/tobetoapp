abstract class CatalogEvent {}

class FetchCategoryLessons extends CatalogEvent {}

class ResetFetchLessons extends CatalogEvent {}

class LoadCatalog extends CatalogEvent {
  final String title;

  LoadCatalog({required this.title});
}
