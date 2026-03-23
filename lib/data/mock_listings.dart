import 'package:eqqu/models/enums.dart';
import 'package:eqqu/models/listing.dart';
import 'package:eqqu/models/product.dart';

/// Centralised mock listing data for the seller's own listings.
class MockListings {
  MockListings._();

  static const listings = [
    Listing(
      id: '1',
      product: Product(
        title: 'Black GP type saddle',
        subtitle: 'No brand / Good / 17"',
        oldPrice: '140 €',
        newPrice: '159 €',
        imageAsset: 'assets/images/product_01.png',
        brand: 'No brand',
      ),
      status: ListingStatus.active,
    ),
    Listing(
      id: '2',
      product: Product(
        title: 'Green Mountain type saddle',
        subtitle: 'Rugged Brand / Very Good / 16"',
        oldPrice: '180 €',
        newPrice: '199 €',
        imageAsset: 'assets/images/product_02.png',
        brand: 'Rugged Brand',
      ),
      status: ListingStatus.sold,
    ),
    Listing(
      id: '3',
      product: Product(
        title: 'Red Racing type saddle',
        subtitle: 'Speedy Brand / Excellent / 15"',
        oldPrice: '200 €',
        newPrice: '230 €',
        imageAsset: 'assets/images/product_03.png',
        brand: 'Speedy Brand',
      ),
      status: ListingStatus.sold,
    ),
    Listing(
      id: '4',
      product: Product(
        title: 'Black GP type saddle',
        subtitle: 'No brand / Good / 17"',
        oldPrice: '140 €',
        newPrice: '159 €',
        imageAsset: 'assets/images/product_01.png',
        brand: 'No brand',
      ),
      status: ListingStatus.shipped,
    ),
    Listing(
      id: '5',
      product: Product(
        title: 'Red Racing type saddle',
        subtitle: 'Speedy Brand / Excellent / 15"',
        oldPrice: '200 €',
        newPrice: '230 €',
        imageAsset: 'assets/images/product_03.png',
        brand: 'Speedy Brand',
      ),
      status: ListingStatus.shipped,
    ),
    Listing(
      id: '6',
      product: Product(
        title: 'Green Mountain type saddle',
        subtitle: 'Rugged Brand / Very Good / 16"',
        oldPrice: '180 €',
        newPrice: '199 €',
        imageAsset: 'assets/images/product_02.png',
        brand: 'Rugged Brand',
      ),
      status: ListingStatus.shipped,
    ),
  ];
}
