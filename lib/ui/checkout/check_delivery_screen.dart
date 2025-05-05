import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/helpers/order/order_helper.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';
import 'package:techtaste_app/ui/_core/widgets/app_bar.dart';
import 'package:techtaste_app/ui/checkout/order_finalized.dart';
import 'package:techtaste_app/ui/checkout/viewmodel/check_delivery_view_model.dart';
import 'package:techtaste_app/ui/checkout/widgets/box_delivery_details.dart';
import 'package:techtaste_app/ui/checkout/widgets/item_delivery.dart';

class CheckDeliveryScreen extends StatefulWidget {
  const CheckDeliveryScreen({super.key});

  @override
  State<CheckDeliveryScreen> createState() => CheckDeliveryScreenState();
}

class CheckDeliveryScreenState extends State<CheckDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckDeliveryViewModel>();
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    final dishMap = bagProvider.getMapByAmount();
    final dishList = dishMap.entries.toList();
    final subtotal = bagProvider.getSumPrices();

    return Scaffold(
      appBar: const CustomAppBar(
          showShopButton: false, title: 'Detalhes do Pedido'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxDeliveryDetails(
              titleBox: 'Pedido #${generateTwoDigitNumber().toString()}',
              widgetsBelow: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Horário ${getCurrentTime()}',
                          style: const TextStyle(color: AppColors.black),
                        ),
                        Text(
                          getCurrentDate(),
                          style: const TextStyle(color: AppColors.black),
                        ),
                      ],
                    ),
                    const Chip(
                      label: Text(
                        'Pendente',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    )
                  ],
                ),
              ],
            ),
            BoxDeliveryDetails(
              titleBox: 'Cliente',
              widgetsBelow: [
                TextField(
                  cursorColor: AppColors.transparent,
                  controller: viewModel.clientController,
                  keyboardType: TextInputType.text,
                  maxLength: 36,
                  style: const TextStyle(color: AppColors.black, fontSize: 16),
                  decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      hintStyle:
                          const TextStyle(color: AppColors.grey, fontSize: 14),
                      enabledBorder: viewModel.isEmptyClient
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey))
                          : InputBorder.none,
                      focusedBorder: viewModel.isEmptyClient
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )
                          : InputBorder.none,
                      hintText: "Digite o nome do cliente"),
                ),
                TextField(
                  cursorColor: AppColors.transparent,
                  controller: viewModel.phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  style: const TextStyle(color: Colors.indigo, fontSize: 16),
                  decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      enabledBorder: viewModel.isEmptyPhone
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey))
                          : InputBorder.none,
                      focusedBorder: viewModel.isEmptyPhone
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )
                          : InputBorder.none,
                      hintStyle:
                          const TextStyle(color: AppColors.grey, fontSize: 14),
                      hintText: "Digite o telefone DDD + numero"),
                ),
              ],
            ),
            BoxDeliveryDetails(
              titleBox: 'Endereço da Entrega',
              widgetsBelow: [
                TextField(
                  cursorColor: AppColors.transparent,
                  controller: viewModel.addressController,
                  keyboardType: TextInputType.text,
                  maxLength: 60,
                  minLines: 1,
                  maxLines: 2,
                  style: const TextStyle(color: AppColors.black, fontSize: 16),
                  decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      hintStyle:
                          const TextStyle(color: AppColors.grey, fontSize: 14),
                      enabledBorder: viewModel.isEmptyAddress
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey))
                          : InputBorder.none,
                      focusedBorder: viewModel.isEmptyAddress
                          ? const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )
                          : InputBorder.none,
                      hintText: "Digite o Endereço"),
                ),
              ],
            ),
            BoxDeliveryDetails(
              titleBox: 'Itens do Pedido',
              widgetsBelow: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dishList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8.0), // distancia de cada item
                    itemBuilder: (context, index) {
                      final dish = dishList[index].key;
                      final quantity = dishList[index].value;
                      final totalPrice = dish.price * quantity;

                      return itemDelivery(
                        context: context,
                        quantity: quantity,
                        orderedItem: dish.name,
                        itemPrice: totalPrice,
                      );
                    },
                  ),
                ),
              ],
            ),
            BoxDeliveryDetails(
              titleBox: 'Pagamento',
              widgetsBelow: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal',
                            style: TextStyle(color: AppColors.black)),
                        Text('R\$ ${subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(color: AppColors.black)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Taxa de Entrega',
                            style: TextStyle(color: AppColors.black)),
                        Text('R\$ ${viewModel.deliveryFee.toStringAsFixed(2)}',
                            style: const TextStyle(color: AppColors.black)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tempo de Entrega',
                            style: TextStyle(color: AppColors.black)),
                        Text('até ${viewModel.deliveryTime} minutos',
                            style: const TextStyle(color: AppColors.black)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TOTAL',
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        Text(
                            'R\$ ${(subtotal + viewModel.deliveryFee).toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            BoxDeliveryDetails(
              titleBox: 'Formas de Pagamento',
              widgetsBelow: [
                RadioListTile<int>(
                  activeColor: AppColors.mainColor,
                  visualDensity: VisualDensity.compact,
                  value: 0,
                  groupValue: viewModel.selectedPaymentMethod,
                  onChanged: (value) {
                    viewModel.setSelectedPaymentMethod(value!);
                  },
                  title: const Row(
                    children: [
                      Icon(Icons.credit_card, color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "Cartão de Crédito",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.black),
                      )
                    ],
                  ),
                ),
                RadioListTile<int>(
                  activeColor: AppColors.mainColor,
                  visualDensity: VisualDensity.compact,
                  value: 1,
                  groupValue: viewModel.selectedPaymentMethod,
                  onChanged: (value) {
                    viewModel.setSelectedPaymentMethod(value!);
                  },
                  title: const Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "Pix / Débito",
                        style: TextStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                RadioListTile<int>(
                  activeColor: AppColors.mainColor,
                  visualDensity: VisualDensity.compact,
                  value: 2,
                  groupValue: viewModel.selectedPaymentMethod,
                  onChanged: (value) {
                    viewModel.setSelectedPaymentMethod(value!);
                  },
                  title: const Row(
                    children: [
                      Icon(Icons.qr_code, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Boleto",
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                      Text(
                        "Desconto de 6%",
                        style: TextStyle(color: Colors.green, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const OrderFinalized();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle, color: AppColors.black),
                  label: const Text(
                    'Finalizar Compra',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
