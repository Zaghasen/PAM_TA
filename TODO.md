# Rename \_page.dart to \_screen.dart Task

## Information Gathered

- Main screen files to rename: all_products_page.dart, cart_page.dart, home_page.dart, login_page.dart, main_page.dart, membership_page.dart, profile_page.dart, wishlist_page.dart
- booking_page.dart has been deleted and replaced with pesanan_detail_page.dart
- Detail pages to rename: product_detail_page.dart, tiket_detail_page.dart, weather_detail_page.dart
- All import statements and class references need updating based on grep search results
- Total ~21 files reference these pages that need import updates

## Plan

1. Rename all main screen files (\_page.dart → \_screen.dart)
2. Rename detail page files (\_page.dart → \_screen.dart)
3. Update class names inside renamed files (Page → Screen)
4. Update all import statements in dependent files
5. Update navigation references (MaterialPageRoute builders)
6. Test compilation to ensure no errors

## Dependent Files to Edit

- lib/main.dart
- lib/screens/main_page.dart (will become main_screen.dart)
- lib/screens/home_page.dart (will become home_screen.dart)
- lib/screens/cart_page.dart (will become cart_screen.dart)
- lib/screens/wishlist_page.dart (will become wishlist_screen.dart)
- lib/screens/profile_page.dart (will become profile_screen.dart)
- lib/screens/login_page.dart (will become login_screen.dart)
- lib/screens/all_products_page.dart (will become all_products_screen.dart)
- lib/widgets/product_card.dart
- lib/screens/icons/\*.dart files
- lib/screens/icons/details/\*.dart files

## Followup Steps

- Run flutter analyze to check for errors
- Run flutter run to test functionality
- Verify all navigation still works
