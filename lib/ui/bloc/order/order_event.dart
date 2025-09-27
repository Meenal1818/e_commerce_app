abstract class OrderEvent{}

//Create order
class CreateOrder extends OrderEvent{
  int productId;
  int status;
  CreateOrder({required this.productId,required this.status});
}

//Fetch order
class FetchOrders extends OrderEvent{}