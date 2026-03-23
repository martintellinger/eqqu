import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/models/order.dart';

/// Centralised mock order data.
///
/// When the backend is ready, screens will fetch this from repositories
/// instead. Keeping it here makes the transition straightforward.
class MockOrders {
  MockOrders._();

  static const purchases = [
    PurchaseOrder(
      id: '12345678',
      date: '23.06.2025',
      status: OrderStatus.active,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
    PurchaseOrder(
      id: '12345679',
      date: '23.06.2025',
      status: OrderStatus.completed,
      price: '418 €',
      images: ['assets/images/product_04.png', 'assets/images/product_05.png'],
    ),
    PurchaseOrder(
      id: '12345680',
      date: '23.06.2025',
      status: OrderStatus.cancelled,
      price: '159 €',
      images: ['assets/images/product_06.png'],
    ),
  ];

  static const sales = [
    SaleOrder(
      id: '12345678',
      date: '23.06.2025',
      status: SaleStatus.newOrder,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
    SaleOrder(
      id: '12345679',
      date: '23.06.2025',
      status: SaleStatus.processed,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
    SaleOrder(
      id: '12345680',
      date: '23.06.2025',
      status: SaleStatus.shipped,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
    SaleOrder(
      id: '12345681',
      date: '23.06.2025',
      status: SaleStatus.delivered,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
    SaleOrder(
      id: '12345682',
      date: '23.06.2025',
      status: SaleStatus.paidOut,
      price: '159 €',
      images: ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    ),
  ];

  static const orderDetailProducts = [
    CartItem(title: 'EquiEase Deluxe Saddle for professional riders in Benelux countries.', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_01.png'),
    CartItem(title: 'Blue Comfort type saddle', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_02.png'),
    CartItem(title: 'EquiEase Deluxe Saddle for professional riders in Benelux countries.', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_03.png'),
  ];

  static const defaultCartItems = [
    CartItem(title: 'EquiEase Deluxe Saddle for professional riders in Benelux countries.', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_01.png'),
    CartItem(title: 'Blue Comfort type saddle', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_02.png'),
    CartItem(title: 'EquiEase Deluxe Saddle for professional riders in Benelux countries.', price: '159 €', priceNum: 159, imageAsset: 'assets/images/product_03.png'),
  ];
}
