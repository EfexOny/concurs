import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/app_export.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? keyValue;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final String? Function(String?)? validate;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool obsecureText;
  final bool border;
  final TextInputType keyboardType;
  final int maxLines;
  final Color? color;
  final List<TextInputFormatter>? inputFormatters;
  final RxString? errorMessage;

  const AppTextField({
    Key? key,
    this.keyValue = "1",
    this.hintText,
    this.initialValue,
    this.validate,
    this.onChange,
    this.obsecureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.color,
    this.border = false,
    this.prefixIcon,
    this.inputFormatters,
    this.controller,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            boxShadow: border
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.4,
                      ),
                      blurRadius: 1.20,
                      offset: const Offset(0.5, 0.6),
                    )
                  ],
            border: border
                ? Border.all(color: AppColors.containerBorderColor)
                : null,
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChange,
            inputFormatters: inputFormatters,
            cursorColor: AppColors.primaryColor,
            obscureText: obsecureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              //     ? Image.asset(
              //         suffixIcon!,
              //         height: 20,
              //       )
              //     : null,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 15.0, color: AppColors.subTextColor),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              focusedErrorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        errorMessage == null
            ? const SizedBox()
            : Obx(
                () => errorMessage!.value.isEmpty
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorMessage!.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
              ),
      ],
    );
  }
}

// class AppTextFieldauth extends StatelessWidget {
//   final String? keyValue;
//   final String? hintText;
//   final TextEditingController? controller;
//   final String? initialValue;
//   final String? leadingIcon;
//   final String? Function(String?)? validate;
//   final Function(String)? onChange;
//   final Function(String)? onFieldSubmitted;
//   final bool obsecureText;
//   final bool enabled;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType keyboardType;
//   final int maxLines;
//   final Color? color;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final RxString errorMessage;

//   const AppTextFieldauth({
//     Key? key,
//     this.keyValue = "1",
//     this.hintText,
//     this.controller,
//     this.initialValue,
//     this.validate,
//     this.onChange,
//     this.obsecureText = false,
//     this.enabled = true,
//     this.keyboardType = TextInputType.text,
//     this.maxLines = 1,
//     this.leadingIcon,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onFieldSubmitted,
//     this.color,
//     this.inputFormatters,
//     required this.errorMessage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           TextFormField(
//             textAlignVertical: TextAlignVertical.center,
//             cursorColor: AppColors.primaryColor,
//             initialValue: initialValue,
//             controller: controller,
//             obscureText: obsecureText,
//             onChanged: onChange,
//             maxLines: maxLines,
//             style: const TextStyle(fontSize: 15),
//             enableInteractiveSelection: kDebugMode ? true : false,
//             enabled: enabled,
//             inputFormatters: inputFormatters,
//             decoration: InputDecoration(
//               hintText: hintText,
//               isCollapsed: true,
//               contentPadding: const EdgeInsets.all(15),
//               fillColor: Colors.white,
//               filled: true,
//               hintStyle: TextStyle(
//                 fontSize: 15.0,
//                 color: errorMessage.value.isEmpty ? Colors.grey : Colors.black,
//               ),
//               prefixIcon: prefixIcon != null ? prefixIcon : null,
//               suffixIcon: suffixIcon != null ? suffixIcon : null,
//               border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               disabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               errorBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red.shade300),
//               ),
//               focusedErrorBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red.shade300),
//               ),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide:
//                     BorderSide(color: AppColors.primaryColor.withOpacity(0.6)),
//               ),
//             ),
//           ),
//           errorMessage.value.isEmpty
//               ? const SizedBox()
//               : Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     errorMessage.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
