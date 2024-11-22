import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Авторизация', style: TextStyle(fontSize: 32)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail',
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 14,
                    ),
                    prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6),
                        child: Icon(Icons.email)),
                    hintText: 'example@mail.com',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Пароль'),
                  const SizedBox(height: 10),
                  TextField(
                      decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 14,
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 14,
                    ),
                    prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6),
                        child: Icon(Icons.password)),
                    suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                          child: Icon(Icons.remove_red_eye),
                        )),
                    hintText: '6 bukv',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: Center(
                      child: Text(
                    'Войти',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('У вас нет аккаунта?'),
                  TextButton(
                      onPressed: () => context.go('/auth_routes/sign_up'),
                      child: Text(
                        'Зарегистрироваться',
                        style: TextStyle(color: Colors.lightBlue),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
