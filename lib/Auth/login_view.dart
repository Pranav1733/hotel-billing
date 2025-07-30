import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../Controller/login_view_controller.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginViewController controller = Get.put(LoginViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: 1.sh,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Header Section
                _buildHeader(),

                SizedBox(height: 40.h),

                // Login Form Card
                _buildLoginCard(controller),

                const Spacer(),

                // Footer
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alpani Hotel',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '2972 Westheimer Rd, Santa Ana, Illinois 85486',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(LoginViewController controller) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Back Title
            Center(
              child: Column(
                children: [
                  Text(
                    'welcome back',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'please enter your details',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Username Field
            _buildUsernameField(controller),

            SizedBox(height: 20.h),

            // Password Field
            _buildPasswordField(controller),

            SizedBox(height: 16.h),

            // Remember Me & Forgot Password Row
            _buildOptionsRow(controller),

            SizedBox(height: 32.h),

            // Sign In Button
            _buildSignInButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField(LoginViewController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'username :',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: controller.usernameError.value.isNotEmpty
                      ? Colors.red.shade300
                      : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Given Username',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  errorStyle: const TextStyle(height: 0),
                ),
                onChanged: (value) {
                  // Real-time validation is handled in controller
                },
              ),
            )),
        // Error message
        Obx(
          () => controller.usernameError.value.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 6.h, left: 4.w),
                  child: Text(
                    controller.usernameError.value,
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildPasswordField(LoginViewController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'password :',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: controller.passwordError.value.isNotEmpty
                      ? Colors.red.shade300
                      : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: controller.togglePasswordVisibility,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      child: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey.shade600,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  errorStyle: const TextStyle(height: 0),
                ),
                onFieldSubmitted: (value) {
                  // Trigger sign in when user presses done
                  controller.signIn();
                },
              ),
            )),
        // Error message
        Obx(
          () => controller.passwordError.value.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 6.h, left: 4.w),
                  child: Text(
                    controller.passwordError.value,
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildOptionsRow(LoginViewController controller) {
    return Row(
      children: [
        // Remember Me Checkbox
        Obx(() => Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: controller.toggleRememberMe,
                    activeColor: Colors.blue.shade600,
                    checkColor: Colors.white,
                    side: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'remember me',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )),

        const Spacer(),

        // Forgot Password Link
        GestureDetector(
          onTap: controller.navigateToForgotPassword,
          child: Text(
            'forget password ?',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(LoginViewController controller) {
    return Obx(() => Container(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: controller.isLoading.value ? null : controller.signIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F7CFF),
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: controller.isLoading.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'sign in',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ));
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Container(
        width: 134.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(2.5.r),
        ),
      ),
    );
  }
}
