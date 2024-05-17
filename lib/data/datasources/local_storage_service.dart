import 'package:objectbox/objectbox.dart';
import 'package:recipes_app/domain/models/models.dart';

@Entity()
class FavoriteRecipe {
  @Id(assignable: true)
  int id = 0;
  String title;
  String description;

  FavoriteRecipe({required this.title, required this.description});
}


late final Box<FavoriteRecipe> favoriteRecipeBox;

void setupObjectBox() {
  favoriteRecipeBox = Store(getObjectBoxModel()).box();
}