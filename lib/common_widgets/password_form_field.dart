import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/obscure_provider.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.passwordController,
    required this.hintText,
  });

  final TextEditingController passwordController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final obscureProvider = ObscureProvider();
    return ChangeNotifierProvider.value(
      value: obscureProvider,
      child: Consumer<ObscureProvider>(
        builder: (context, obscureProvider, child) {
          final isObscure = obscureProvider.isObscure;
          return TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            // autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: regularTS(formHintColor, fontSize: 16),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: Utils.scrHeight * .001,
                      color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: Utils.scrHeight * .001,
                      color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Utils.scrHeight * .02,
                vertical: Utils.scrHeight * .012,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: Utils.scrHeight * .001,
                      color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
              suffixIcon: IconButton(
                onPressed: () {
                  obscureProvider.toggleVisibility();
                },
                icon: Icon(
                  isObscure
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                ),
                color: const Color(0xff1E1F20),
              ),
            ),
            obscureText: isObscure,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
