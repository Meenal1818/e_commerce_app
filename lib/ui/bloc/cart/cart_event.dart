abstract class CartEvent{}

class AddToCart extends CartEvent{
  int productId;
  int qty;
  AddToCart({required this.productId,required this.qty});
}

class FetchCart extends CartEvent{}

class DeleteCartItem extends CartEvent{
  int id;
  DeleteCartItem({required this.id});
}