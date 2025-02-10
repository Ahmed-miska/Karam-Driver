import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../data/models/areas_list_model.dart';
import '../../logic/sign_up_controller.dart';


class SelectArea extends StatefulWidget {
  const SelectArea({super.key});

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  List<AreasItem> areasList = Get.find<SignUpController>().areasList;
  final ScrollController scrollController = ScrollController();
  Debouncerr debouncer = Debouncerr(milliseconds: 800);

  int page = 1;
  String keyword = '';
  bool isLoading = false;
  bool isLoadMore = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (isLoadMore) return;
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadMore = true;
      });
      page = page + 1;
      await Get.find<SignUpController>().getAreasList(page, keyword);
      setState(() {
        areasList = Get.find<SignUpController>().areasList;
      });
      setState(() {
        isLoadMore = false;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    Get.find<SignUpController>().areasList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${areasList.length}');
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            height: 350.h,
            width: 300.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffF9F9F9),
            ),
            child: Column(
              children: [
                AppTextFormField(
                    hintText: 'المنطقه',
                    onChanged: (p0) async {
                      debouncer.run(() async {
                        keyword = p0;
                        setState(() {
                          isLoading = true;
                        });
                        page = 1;
                        setState(() {
                          Get.find<SignUpController>().areasList.clear();
                          areasList = [];
                        });
                        await controller.getAreasList(page, keyword);
                        setState(() {
                          areasList = areasList + controller.areasList;
                        });
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    validator: (value) {
                      return null;
                    }),
                controller.error != ''
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(controller.error, style: AppStyles.font14Black400),
                        ),
                      )
                    : isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              itemCount: areasList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {
                                      controller.areaID = areasList[index].id.toString();
                                      controller.areaController.text = areasList[index].areaName!;
                                      Get.back();
                                    },
                                    child: Text(
                                      areasList[index].areaName!,
                                      style: AppStyles.font14Black400,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                isLoadMore ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
