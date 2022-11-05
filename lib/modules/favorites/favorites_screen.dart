import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  ShopCubit cubit;

  FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => buildFavoriteItem(cubit.favoritesModel.data.data[index]),
              itemCount: cubit.favoritesModel.data.data.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavoriteItem(FavoritesData model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product.image),
                width: 120,
                height: 120,
              ),
              if(model.product.discount != 0) Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: const Text('DISCOUNT', style: TextStyle(color: Colors.white, fontSize: 10)),
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  children: [
                    Text('${model.product.price.round()}', style: TextStyle(color: defaultColor, fontSize: 12)),
                    const SizedBox(width: 5),
                    if(model.product.discount != 0) Text('${model.product.oldPrice.round()}', style: const TextStyle(color: Colors.grey, fontSize: 10, decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: cubit.favorites[model.product.id] ? defaultColor : Colors.grey,
                      child: IconButton(
                        onPressed: () {cubit.changeFavorite(model.product.id);},
                        icon: const Icon(Icons.favorite_border, color: Colors.white, size: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}