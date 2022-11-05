import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  ShopCubit cubit;

  ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.changeFavoritesModel.status) {
            showToast(message: state.changeFavoritesModel.message, toastState: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => builderWidget(cubit.homeModel, cubit.categoriesModel),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel homeModel, CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            )
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: categoriesModel.data.data.length
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Products', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.45,
              children: List.generate(homeModel.data.products.length, (index) => buildProductItem(homeModel.data.products[index]))
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel dataModel) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(dataModel.image),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(dataModel.name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
      )
    ],
  );

  Widget buildProductItem(ProductModel product) => Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: double.infinity,
                height: 200,
              ),
              if(product.discount != 0) Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: const Text('DISCOUNT', style: TextStyle(color: Colors.white, fontSize: 10)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Text('${product.price.round()}', style: TextStyle(color: defaultColor, fontSize: 12)),
                    const SizedBox(width: 5),
                    if(product.discount != 0) Text('${product.oldPrice.round()}', style: const TextStyle(color: Colors.grey, fontSize: 10, decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: cubit.favorites[product.id] ? defaultColor : Colors.grey,
                      child: IconButton(
                        onPressed: () {cubit.changeFavorite(product.id);},
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
    );
}