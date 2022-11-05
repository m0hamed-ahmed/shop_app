import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_login_model.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel shopLoginModel;
  bool obscureText = true;

  void userLogin({String email, String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      }
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  changeObscureText() {
    obscureText = !obscureText;
    emit(ShopLoginChangeObscureTextState());
  }
}