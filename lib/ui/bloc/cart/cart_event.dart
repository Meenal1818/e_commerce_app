abstract class CartEvent{}

//Add to  cart
class AddToCart extends CartEvent{
  int productId;
  int qty;
  AddToCart({required this.productId,required this.qty});
}

//Fetch Cart
class FetchCart extends CartEvent{}

//Decrement Cart Item
class IncDecCartItem extends CartEvent{
  int productId;
  int qty;
  IncDecCartItem({required this.productId,required this.qty});
}

//Delete Cart Item
class DeleteCartItem extends CartEvent{
  int id;
  DeleteCartItem({required this.id});
}