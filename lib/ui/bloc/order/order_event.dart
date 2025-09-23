abstract class OrderEvent{}

class CreateOrder extends OrderEvent{
  int productId;
  int status;
  CreateOrder({required this.productId,required this.status});
}