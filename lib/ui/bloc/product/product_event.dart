abstract class ProductEvent{}

class FetchProductEvent extends ProductEvent{
  int? categoryId;
  FetchProductEvent([this.categoryId]);
}