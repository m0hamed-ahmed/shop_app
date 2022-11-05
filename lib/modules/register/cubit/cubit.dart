import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_login_model.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel shopLoginModel;
  bool obscureText = true;

  void userRegister({String name, String email, String password, String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopLoginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  changeObscureText() {
    obscureText = !obscureText;
    emit(ShopRegisterChangeObscureTextState());
  }
}