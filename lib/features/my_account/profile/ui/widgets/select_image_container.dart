import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/theming/colors.dart';


class SelectImageContianer extends StatefulWidget {
  const SelectImageContianer({
    super.key,
  });

  @override
  State<SelectImageContianer> createState() => _SelectImageContianerState();
}

class _SelectImageContianerState extends State<SelectImageContianer> {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 5),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Container(
              height: 100.h,
              width: 100.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white2,
              ),
              child: selectedImage != null ? Image.file(selectedImage!, fit: BoxFit.cover) : SvgPicture.asset(AppAssets.logoSvg),
            ),
          ),
          Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.main,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: InkWell(
                onTap: () {
                  _pickImage();
                },
                child: const Icon(Icons.edit_outlined, color: AppColors.white)),
          )
        ],
      ),
    );
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      selectedImage = File(image.path);
    });
  }
}
