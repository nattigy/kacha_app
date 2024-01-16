// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import '../../../constants/constants.dart';
// import '../../../utils/firebase_events_logger.dart';
// import '../../payments/bloc/payment_operations_bloc.dart';
// import '../../payments/dto/send_receipt.dart';
// import '../../payments/entities/payment.model.dart';
// import '../../tutor/model/tutor.model.dart';
// import '../buttons/custom_text_button.dart';
// import '../inputs/custom_text_form_field.dart';
//
// class CommissionDialog extends StatefulWidget {
//   const CommissionDialog({
//     Key? key,
//     this.name,
//     required this.tutor,
//     required this.paymentId,
//     this.monthName,
//     this.amount,
//     required this.payment,
//     this.description,
//     this.banks,
//   }) : super(key: key);
//
//   final String? name;
//   final String paymentId;
//   final Tutor tutor;
//   final Payment payment;
//   final String? monthName;
//   final int? amount;
//   final String? description;
//   final List<String>? banks;
//
//   @override
//   State<CommissionDialog> createState() => _CommissionDialogState();
// }
//
// class _CommissionDialogState extends State<CommissionDialog> {
//   String? dropdownValue = "CBE";
//   String? depositAccount = "1000355869532";
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _imageFile;
//
//   TextEditingController bankNameCont = TextEditingController();
//   TextEditingController paymentNotesCont = TextEditingController();
//   TextEditingController receiptCont = TextEditingController();
//   TextEditingController transactionsIdCont = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       contentPadding: const EdgeInsets.all(30),
//       content: SingleChildScrollView(
//         child: SizedBox(
//           width: 100,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               'Commission Fee Payment'.text.bold.xl.make(),
//               Text.rich(
//                 textAlign: TextAlign.center,
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                         text: 'Amount ',
//                         style: TextStyle(color: AppColor.greyTextColor)),
//                     TextSpan(
//                         text: "${widget.payment.payableCommission}",
//                         style: TextStyle(
//                             color: AppColor.primaryColor,
//                             fontWeight: FontWeight.bold))
//                   ],
//                 ),
//               ),
//               Text(
//                 "Deposit Account: ${depositAccount}",
//                 style: const TextStyle(fontSize: 12),
//               ),
//               const SizedBox(height: 5),
//               'Bank'.text.xl.color(AppColor.greyTextColor).make(),
//               DropdownButton(
//                   menuMaxHeight: 150.0,
//                   isExpanded: true,
//                   elevation: 1,
//                   icon: const Icon(
//                     FontAwesomeIcons.angleDown,
//                     size: 16,
//                   ),
//                   value: dropdownValue,
//                   hint: 'select Bank'.text.make(),
//                   items: widget.banks!.map((e) {
//                     return DropdownMenuItem(
//                       value: e,
//                       child: Row(
//                         children: [e.text.make()],
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (String? value) {
//                     setState(() {
//                       dropdownValue = value;
//                       bankNameCont.text = value ?? "CBE";
//                     });
//                   }),
//               const SizedBox(height: 5),
//               'Transaction Id'.text.xl.color(AppColor.greyTextColor).make(),
//               CustomTextFormField(
//                 hintText: 'Enter Transaction Id',
//                 textEditingController: transactionsIdCont,
//                 validator: (v) {
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 5),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   'Receipt Image'.text.xl.gray400.make(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                             color: AppColor.textFormFieldColor,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Column(
//                           children: [
//                             'Add receipt'
//                                 .text
//                                 .xs
//                                 .color(AppColor.greyTextColor)
//                                 .make(),
//                             IconButton(
//                               onPressed: () => setImage(ImageSource.gallery),
//                               icon: Icon(
//                                 FontAwesomeIcons.circlePlus,
//                                 color: AppColor.primaryColor,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 100,
//                         width: 100,
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                               color: AppColor.textFormFieldColor,
//                               borderRadius: BorderRadius.circular(5),
//                               image: DecorationImage(
//                                   image: _imageFile == null
//                                       ? const AssetImage(AppImages.receiptImg)
//                                       : FileImage(File(_imageFile!.path))
//                                           as ImageProvider)),
//                           // child:
//                         ).py12(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   'Amount'.text.xl.gray400.make(),
//                   CustomTextFormField(
//                     hintText: 'Enter Amount',
//                     keyboardType: TextInputType.number,
//                     validator: (v) {
//                       return null;
//                     },
//                   ).box.make(),
//                 ],
//               ),
//               Row(
//                 children: [
//                   'Description '.text.xl.gray400.make(),
//                   '(optional)'.text.sm.gray400.make(),
//                 ],
//               ),
//               CustomTextFormField(
//                 hintText: 'Enter description',
//                 textEditingController: paymentNotesCont,
//                 validator: (v) {
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 5),
//               CustomTextButton(
//                 height: 40,
//                 label: 'Submit',
//                 backgroundColor: AppColor.declineColor,
//                 onPressed: () {
//                   if (_imageFile != null) {
//                     SendPaymentReceiptInput sendPaymentReceiptInput =
//                         SendPaymentReceiptInput(
//                       bankName: bankNameCont.text,
//                       paymentId: widget.paymentId,
//                       paymentNotes: paymentNotesCont.text,
//                       receiptImage: "",
//                       transactionId: transactionsIdCont.text,
//                     );
//                     analyticsPaymentStatus(paymentStatus: "payment_proof_Sent");
//                     // context.read<PaymentsBloc>().sendPaymentReceipt(
//                     //       sendPaymentReceiptInput,
//                     //       _imageFile!,
//                     //       widget.tutor,
//                     //     );
//                     Navigator.pop(context);
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void setImage(ImageSource source) async {
//     final pickedImage =
//         await _imagePicker.pickImage(source: source, imageQuality: 25);
//     setState(() {
//       _imageFile = pickedImage;
//     });
//   }
// }
