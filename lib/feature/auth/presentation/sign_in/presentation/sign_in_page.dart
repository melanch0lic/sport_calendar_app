import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация', style: TextStyle(fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
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
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6), child: Icon(Icons.email)),
                  hintText: 'example@mail.com',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Пароль'),
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
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6), child: Icon(Icons.password)),
                  suffixIcon: GestureDetector(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16, right: 16),
                        child: Icon(Icons.remove_red_eye),
                      )),
                  hintText: '6 bukv',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 20),
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
                const Text('У вас нет аккаунта?'),
                TextButton(
                    onPressed: () => context.go('/auth_routes/sign_up'),
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(color: Colors.lightBlue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
