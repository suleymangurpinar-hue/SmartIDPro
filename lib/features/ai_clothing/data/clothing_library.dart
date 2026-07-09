import '../models/clothing_category.dart';
import '../models/clothing_item.dart';

class ClothingLibrary {
  static const List<ClothingItem> items = [
    ClothingItem(
      id: 'male-business-suit-01',
      title: 'Business Suit 01',
      gender: 'male',
      category: ClothingCategory.business,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'male-business-suit-02',
      title: 'Business Suit 02',
      gender: 'male',
      category: ClothingCategory.business,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'male-luxury-suit',
      title: 'Luxury Suit',
      gender: 'male',
      category: ClothingCategory.luxury,
      thumbnail: '',
      preview: '',
      premium: true,
      enabled: true,
    ),
    ClothingItem(
      id: 'male-shirt',
      title: 'Shirt',
      gender: 'male',
      category: ClothingCategory.casual,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'male-polo',
      title: 'Polo',
      gender: 'male',
      category: ClothingCategory.casual,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'female-business',
      title: 'Business',
      gender: 'female',
      category: ClothingCategory.business,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'female-formal',
      title: 'Formal',
      gender: 'female',
      category: ClothingCategory.formal,
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    ClothingItem(
      id: 'female-premium',
      title: 'Premium',
      gender: 'female',
      category: ClothingCategory.luxury,
      thumbnail: '',
      preview: '',
      premium: true,
      enabled: true,
    ),
  ];

  static List<ClothingItem> byGender(String gender) {
    return items.where((item) => item.gender == gender).toList();
  }
}
