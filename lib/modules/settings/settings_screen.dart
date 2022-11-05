import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/login/shop_login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();

  SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        textEditingControllerName.text = cubit.userModel.data.name;
        textEditingControllerEmail.text = cubit.userModel.data.email;
        textEditingControllerPhone.text = cubit.userModel.data.phone;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateUserDataState) const LinearProgressIndicator(),
                const SizedBox(height: 20),
                buildTextFormField(
                  textEditingController: textEditingControllerName,
                  textInputType: TextInputType.text,
                  labelText: 'Name',
                  prefixIcon: Icons.person,
                  validator: (val) {
                    if(val.isEmpty) {return 'Name must not be empty';}
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  textEditingController: textEditingControllerEmail,
                  textInputType: TextInputType.emailAddress,
                  labelText: 'Email Address',
                  prefixIcon: Icons.email,
                  validator: (val) {
                    if(val.isEmpty) {return 'Email must not be empty';}
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  textEditingController: textEditingControllerPhone,
                  textInputType: TextInputType.phone,
                  labelText: 'Phone',
                  prefixIcon: Icons.phone,
                  validator: (val) {
                    if(val.isEmpty) {return 'Phone must not be empty';}
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                buildButton(
                  onPressed: () {
                    if(formKey.currentState.validate()) {
                      cubit.updateUserData(
                        name: textEditingControllerName.text,
                        email: textEditingControllerEmail.text,
                        phone: textEditingControllerPhone.text,
                      );
                    }
                  },
                  text: 'UPDATE'
                ),
                const SizedBox(height: 20),
                buildButton(
                  onPressed: () => signOut(context),
                  text: 'LOGOUT'
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void signOut(BuildContext context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if(value) {navigateTo(context, ShopLoginScreen(), true);}
    });
  }
}