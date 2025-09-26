abstract class CartEvent{}

class AddToCart extends CartEvent{
  int productId;
  int qty;
  AddToCart({required this.productId,required this.qty});
}

class FetchCart extends CartEvent{}

class IncDecCartItem extends CartEvent{
  int productId;
  int qty;
  IncDecCartItem({required this.productId,required this.qty});
}

class DeleteCartItem extends CartEvent{
  int id;
  DeleteCartItem({required this.id});
}