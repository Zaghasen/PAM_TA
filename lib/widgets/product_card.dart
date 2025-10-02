import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/models/product.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';
import 'package:tugas_akhir_097/screens/product_detail_page.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback refreshCallback;

  const ProductCard({
    super.key,
    required this.product,
    required this.refreshCallback,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
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
                  Text('Rp ${widget.product.pricePerDay.toInt()}/hari'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  widget.product.isWishlisted
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.product.isWishlisted ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    widget.product.isWishlisted = !widget.product.isWishlisted;
                    if (widget.product.isWishlisted) {
                      MainScreenState.wishlistItems.add(widget.product);
                    } else {
                      MainScreenState.wishlistItems.removeWhere(
                        (p) => p.id == widget.product.id,
                      );
                    }
                  });
                  widget.refreshCallback();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
