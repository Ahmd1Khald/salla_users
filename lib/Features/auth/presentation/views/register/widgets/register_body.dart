import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salla_users/Core/utiles/constance/const_variable.dart';
import 'package:salla_users/Features/auth/presentation/views/register/widgets/register_button.dart';
import 'package:salla_users/Features/auth/presentation/views/register/widgets/register_title.dart';
import 'package:salla_users/Features/auth/presentation/views/register/widgets/repeat_password_textfield.dart';
import 'package:salla_users/Features/auth/presentation/views/register/widgets/show_alert_picker.dart';
import 'package:salla_users/Features/auth/presentation/views/register/widgets/sign_up.dart';

import '../../../../../../Core/utiles/widgets/alert_widget.dart';
import '../../../../../../Core/utiles/widgets/email_textfield.dart';
import '../../../../../../Core/utiles/widgets/password_textfield.dart';
import '../../../../../../Core/utiles/widgets/pick_image_widget.dart';
import 'name_textfield.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var repeatPassController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  XFile? pickedImage;
  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  void dispose() {
    widget.nameController.dispose();
    widget.emailController.dispose();
    widget.passController.dispose();
    widget.repeatPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++");
    print(widget.pickedImage);
    Future<void> localImagePicker() async {
      final ImagePicker picker = ImagePicker();
      await imagePickerDialog(
        context: context,
        cameraFCT: () async {
          widget.pickedImage =
              await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          widget.pickedImage =
              await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
          print("++++++++++++++++++");
          print(widget.pickedImage);
        },
        removeFCT: () {
          setState(() {
            widget.pickedImage = null;
          });
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const RegisterTitle(
                  title: 'Register to get started !',
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                    height: AppConst.size(context).width * 0.3,
                    width: AppConst.size(context).width * 0.3,
                    child: PickImageWidget(
                      pickedImage: widget.pickedImage,
                      function: () async {
                        await localImagePicker();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                NameTextField(
                  nameController: widget.nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                EmailTextField(emailController: widget.emailController),
                const SizedBox(
                  height: 20,
                ),
                PassTextField(
                  passController: widget.passController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RepeatPassTextField(
                  passController1: widget.repeatPassController,
                  passController2: widget.passController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: RegisterButton(
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        if (widget.pickedImage == null) {
                          print('+++++++++++++++++++++++++');
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertWidget(
                                  func1: () {
                                    Navigator.pop(context);
                                  },
                                  func2: () {
                                    Navigator.pop(context);
                                  },
                                  subTitle1: 'Cancel',
                                  subTitle2: 'Ok',
                                  title: 'Make sure to pick up an image',
                                );
                              });
                        } else {
                          print(widget.nameController.text);
                          print(widget.emailController.text);
                          print(widget.passController.text);
                          print(widget.repeatPassController.text);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                SignInWidget(
                  function: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}