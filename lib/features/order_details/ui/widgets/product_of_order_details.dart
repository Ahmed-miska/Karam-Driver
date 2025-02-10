import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../client_orders/data/model/order_details_response_model.dart';

class ProductOfOrderDetails extends StatelessWidget {
  final Item item;
  const ProductOfOrderDetails({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(item.quantity.toString(), style: AppStyles.font13Gray500),
            horizontalSpace(7),
            Text('العدد', style: AppStyles.font12Black400),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.itemName ?? '',
                style: AppStyles.font15Black500,
                textAlign: TextAlign.right,
              ),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('د.ع', style: AppStyles.font14Black400),
                  horizontalSpace(5),
                  Text(item.itemPrice.toString(), style: AppStyles.font14Main400),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
