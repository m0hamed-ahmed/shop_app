import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/modules/register/shop_register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  ShopLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              CacheHelper.setData(key: 'token', value: state.shopLoginModel.data.token).then((value) {
                token = state.shopLoginModel.data.token;
                navigateTo(context, const ShopLayout(), true);
              });
            }
            else {
              showToast(message: state.shopLoginModel.message, toastState: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN', style: TextStyle(color: defaultColor, fontSize: 50)),
                        const SizedBox(height: 15),
                        const Text('Login now to browse our hot offers', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        const SizedBox(height: 30),
                        buildTextFormField(
                          textEditingController: textEditingControllerEmail,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validator: (val) {
                            if(val.isEmpty) {return 'Please enter your email address';}
                            return null;
                          }
                        ),
                        const SizedBox(height: 15),
                        buildTextFormField(
                          textEditingController: textEditingControllerPassword,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: cubit.obscureText,
                          suffixIcon: cubit.obscureText ? Icons.visibility : Icons.visibility_off,
                          suffixIconPressed: () => cubit.changeObscureText(),
                          validator: (val) {
                            if(val.isEmpty) {return 'Please enter your password';}
                            return null;
                          }
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => buildButton(
                            onPressed: () {
                              if(formKey.currentState.validate()) {
                                cubit.userLogin(
                                  email: textEditingControllerEmail.text,
                                  password: textEditingControllerPassword.text,
                                );
                              }
                            },
                            text: 'LOGIN'
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            const SizedBox(width: 5),
                            TextButton(
                                onPressed: () {navigateTo(context, ShopRegisterScreen(), false);},
                                child: Text('REGISTER NOW', style: TextStyle(color: defaultColor))
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}