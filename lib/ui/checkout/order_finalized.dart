import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/helpers/order/order_helper.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';
import 'package:techtaste_app/ui/home/home_screen.dart';

import 'viewmodel/check_delivery_view_model.dart';

class OrderFinalized extends StatelessWidget {
  const OrderFinalized({super.key});

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    final viewModel = context.watch<CheckDeliveryViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/others/motoboy-image.png',
              scale: 2,
            ),
            ElevatedButton(
                onPressed: () {
                  viewModel.clearDataClient();
                  bagProvider.clearBag();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Pedido finalizado',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black))),
            const SizedBox(height: 16.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  const TextSpan(
                      text: 'Agora é só aguardar!\nVocê receberá no ',
                      style: TextStyle(color: AppColors.mainColor)),
                  TextSpan(
                    text: 'WhatsApp',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openWhatsApp(context,
                            phoneClient: viewModel.phoneController.text,
                            orderMensage:
                                generateOrderMessage(viewModel, bagProvider));
                        // cascade operator, permite configurar o objeto logo após criá-lo.
                        // se cria um objeto da classe TapGestureRecognizer e associa uma
                        // funcao ao gesto de toque.
                        // TapGestureRecognizer() -> cria um reconhecedor de toque
                        //  ..onTap = _openWhatsApp; -> define o que acontece quando tocam no texto
                        // Sem o .., teria que fazer:
                        // final recognizer = TapGestureRecognizer();
                        // recognizer.onTap = _openWhatsApp;
                        const TextSpan(
                            text: '\nos dados do seu pedido.',
                            style: TextStyle(color: AppColors.mainColor));
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
