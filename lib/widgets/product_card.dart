import 'package:flutter/material.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/main_screen.dart';
import 'package:tapak_jejak/screens/icons/details/product_detail_page.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback refreshCallback;
  final int likeCount;
  final ValueChanged<bool> onLike;

  const ProductCard({
    super.key,
    required this.product,
    required this.refreshCallback,
    required this.likeCount,
    required this.onLike,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

String formatPrice(double price) {
  String priceStr = price.toInt().toString();
  String result = '';
  int count = 0;
  for (int i = priceStr.length - 1; i >= 0; i--) {
    result = priceStr[i] + result;
    count++;
    if (count % 3 == 0 && i > 0) {
      result = '.$result';
    }
  }
  return result;
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: widget.product,
              refreshCallback: widget.refreshCallback,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text('Rp ${formatPrice(widget.product.pricePerDay)}/hari'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    widget.product.isWishlisted
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.product.isWishlisted
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.product.isWishlisted =
                          !widget.product.isWishlisted;
                      if (widget.product.isWishlisted) {
                        MainScreen.wishlistItems.add(widget.product);
                        widget.onLike(true);
                      } else {
                        MainScreen.wishlistItems.removeWhere(
                          (p) => p.id == widget.product.id,
                        );
                        widget.onLike(false);
                      }
                    });
                    widget.refreshCallback();
                  },
                ),
                Text(
                  widget.likeCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
