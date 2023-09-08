import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/models/user_model.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_application_pw17/screens/products_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final usernameController = TextEditingController();
  final usermailController = TextEditingController();
  final passwordController = TextEditingController();
  String? passwordHelper;
  String? usermailHelper;
  String wellcomeText = '';
  bool? isUserNotExists;

  @override
  void initState() {
    ref.read(backImgProvider.notifier).getImages();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    usermailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(backImgProvider);
    final username = ref.watch(usernameProvider);

    ref.watch(firebaseAuthProvider.notifier).addListener((state) {
      switch (state) {
        case '':
          wellcomeText = 'Wellcome';
          break;
        case 'exists':
          isUserNotExists = false;
          wellcomeText = 'Wellcome $username';
          break;
        case 'not-exists':
          isUserNotExists = true;
          wellcomeText = 'Please register';
          break;
        case 'ok':
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ProductsScreen(
                  user: UserModel(
                      userName: username, userEmail: usermailController.text),
                ),
              ),
              (route) => false);
          break;
        case 'wrong-password':
          passwordHelper = 'Wrong password';
          break;
        default:
          debugPrint(state);
          break;
      }
      if (state != 'ok') setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Flutter'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          images.isNotEmpty
              ? Positioned.fill(
                  child: Image.network(images[1], fit: BoxFit.cover),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 500
                  ? 500
                  : double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wellcomeText,
                    style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isUserNotExists == true)
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        controller: usernameController,
                      ),
                    ),
                  if (isUserNotExists == null || isUserNotExists == true)
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          helperText: usermailHelper,
                        ),
                        onEditingComplete: () {
                          ref
                              .read(firebaseAuthProvider.notifier)
                              .checkIfUserExists(usermailController.text, ref);
                        }, //tryAuth,
                        controller: usermailController,
                      ),
                    ),
                  if (isUserNotExists != null)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              helperText: passwordHelper,
                            ),
                            onChanged: (value) {
                              if (value.length < 6) {
                                passwordHelper = 'Weak password';
                              } else {
                                passwordHelper = null;
                              }
                              setState(() {});
                            },
                            controller: passwordController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (passwordController.text.length >= 6) {
                                  if (isUserNotExists == false) {
                                    ref
                                        .read(firebaseAuthProvider.notifier)
                                        .loginUser(usermailController.text,
                                            passwordController.text);
                                  } else if (isUserNotExists == true) {
                                    ref.read(usernameProvider.notifier).update(
                                        (state) => usernameController.text);
                                    ref
                                        .read(firebaseAuthProvider.notifier)
                                        .createUser(
                                            usermailController.text,
                                            passwordController.text,
                                            usernameController.text);
                                  }
                                  ref
                                      .read(usermailProvider.notifier)
                                      .update((ref) => usermailController.text);
                                }
                              }, //tryAuth,
                              child: Text(isUserNotExists == false
                                  ? 'Sign in'
                                  : 'Register'),
                            ),
                            TextButton(
                              onPressed: () {
                                wellcomeText = 'Wellcome';
                                isUserNotExists = null;
                                passwordController.text = '';
                                usernameController.text = '';
                                passwordHelper = null;
                                ref
                                    .read(firebaseAuthProvider.notifier)
                                    .switchUser();
                                setState(() {});
                              },
                              child: const Text(
                                'Switch user',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (isUserNotExists == null)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (EmailValidator.validate(
                                  usermailController.text)) {
                                usermailHelper = null;
                                ref
                                    .read(firebaseAuthProvider.notifier)
                                    .checkIfUserExists(
                                        usermailController.text, ref);
                              } else {
                                usermailHelper = 'Wrong email format';
                              }
                            });
                          },
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
