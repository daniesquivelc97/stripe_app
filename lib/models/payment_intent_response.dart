// To parse this JSON data, do
//
//     final paymenyIntentResponse = paymenyIntentResponseFromJson(jsonString);

import 'dart:convert';

PaymenyIntentResponse paymenyIntentResponseFromJson(String str) =>
    PaymenyIntentResponse.fromJson(json.decode(str));

String paymenyIntentResponseToJson(PaymenyIntentResponse data) =>
    json.encode(data.toJson());

class PaymenyIntentResponse {
  PaymenyIntentResponse({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.charges,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
  });

  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  AmountDetails? amountDetails;
  int? amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic automaticPaymentMethods;
  dynamic canceledAt;
  dynamic cancellationReason;
  String? captureMethod;
  Charges? charges;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  dynamic customer;
  dynamic description;
  dynamic invoice;
  dynamic lastPaymentError;
  bool? livemode;
  Metadata? metadata;
  dynamic nextAction;
  dynamic onBehalfOf;
  dynamic paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic processing;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transferData;
  dynamic transferGroup;

  factory PaymenyIntentResponse.fromJson(Map<String, dynamic> json) =>
      PaymenyIntentResponse(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountDetails: AmountDetails.fromJson(json["amount_details"]),
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        automaticPaymentMethods: json["automatic_payment_methods"],
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        charges: Charges.fromJson(json["charges"]),
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        livemode: json["livemode"],
        metadata: Metadata.fromJson(json["metadata"]),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions:
            PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes:
            List<String>.from(json["payment_method_types"].map((x) => x)),
        processing: json["processing"],
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_details": amountDetails?.toJson(),
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "automatic_payment_methods": automaticPaymentMethods,
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "charges": charges?.toJson(),
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions?.toJson(),
        "payment_method_types":
            List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
        "processing": processing,
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };
}

class AmountDetails {
  AmountDetails({
    required this.tip,
  });

  Metadata tip;

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        tip: Metadata.fromJson(json["tip"]),
      );

  Map<String, dynamic> toJson() => {
        "tip": tip.toJson(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class Charges {
  Charges({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.totalCount,
    required this.url,
  });

  String object;
  List<dynamic> data;
  bool hasMore;
  int totalCount;
  String url;

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
        object: json["object"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    required this.card,
  });

  Card card;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "card": card.toJson(),
      };
}

class Card {
  Card({
    this.installments,
    this.mandateOptions,
    this.network,
    required this.requestThreeDSecure,
  });

  dynamic installments;
  dynamic mandateOptions;
  dynamic network;
  String requestThreeDSecure;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        installments: json["installments"],
        mandateOptions: json["mandate_options"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toJson() => {
        "installments": installments,
        "mandate_options": mandateOptions,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
      };
}
