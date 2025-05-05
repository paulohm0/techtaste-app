import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/checkout/viewmodel/check_delivery_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

// gera um codigo do pedido diferente, sempre que o pedido for gerado
int generateTwoDigitNumber() {
  return Random().nextInt(90) + 10;
}

// gera um valor para ser usado como taxa de entrega
int generateDeliveryFee() {
  return Random().nextInt(20) + 10;
}

// gera um valor para ser usado como tempo de entrega
int generateDeliveryTime() {
  return Random().nextInt(30) + 20;
}

// pegar a hora exata do pedido para exibir nos detalhes do pedido
String getCurrentTime() {
  DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
}

// pegar a data exata do pedido para exibir nos detalhes do pedido
String getCurrentDate() {
  DateTime now = DateTime.now();
  return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
}

// abrir whatsapp com o pedido completo na mensagem
Future<void> openWhatsApp(BuildContext context,
    {required String phoneClient, required String orderMensage}) async {
  final mensagem = Uri.encodeComponent(orderMensage);
  final uri = Uri.parse("https://wa.me/55$phoneClient?text=$mensagem");

  // Captura o context antes do await
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  if (Platform.isAndroid) {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text('WhatsApp não está instalado no dispositivo.')),
      );
    }
  } else {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
          content: Text('Este recurso está disponível apenas no Android.')),
    );
  }
}

String generateOrderMessage(
  CheckDeliveryViewModel viewModel,
  BagProvider bagProvider,
) {
  final nameClient = viewModel.clientController.text;
  final address = viewModel.addressController.text;
  final order = viewModel.orderCode;
  final itensMap = bagProvider.getMapByAmount();
  final itens = itensMap.entries
      .map((entry) => "- ${entry.value}x ${entry.key.name}")
      .join("\n");
  final deliveryTime = viewModel.deliveryTime;
  final total = bagProvider.getSumPrices().toStringAsFixed(2);

  // para poder usar os emogis, na funcao de abrir o wpp
  // final mensagem = Uri.encodeComponent(orderMensage);
  // serve para converter o texto da sua mensagem (orderMensage)
  // em um formato seguro para usar em uma URL.
  return "Olá $nameClient! 👋\n"
      "\nSeu pedido nº$order foi finalizado com sucesso!"
      "\n\n📦 Itens:\n$itens"
      "\n💰 Total: R\$ $total"
      "\n📍 Entrega para: $address"
      "\n⏱️ Tempo de entrega estimado em $deliveryTime minutos"
      "\n\nObrigado por comprar com a gente! 😊";
}
