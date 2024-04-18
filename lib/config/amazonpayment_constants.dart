import 'package:amazon_payfort/amazon_payfort.dart';

class AmazonPayConfigue {
  AmazonPayConfigue._();

  static const String merchantIdentifier = 'ac2f2fa1';

  static const String merchantIdentifierProduction = 'VgUKVecj';

  static const FortEnvironment testEnviroment = FortEnvironment.test;

  static const FortEnvironment productionEnviroment = FortEnvironment.production;

  // For Debit/Credit Card Test
  static const String accessCode = 'FvdREW0GwzxGp3uPFxFe';
  static const String shaType = 'SHA-256';
  static const String shaRequestPhrase = '47Qjf88KoIQOziU82Vdmqc[*';

  // For Debit/Credit Card Production
  static const String accessCodeProduction = '1bR1El3wdXMfipFzbqnl';
  static const String shaTypeProduction = 'SHA-256';
  static const String shaRequestPhraseProduction = '14v.D3tKXRZuFbZdJni9Yc[+';

  // For Apple Pay Test
  static const String applePayAccessCode = 't2pE9rHWkH2mXlbOR0BE';
  static const String applePayShaType = 'SHA-256';
  static const String applePayShaRequestPhrase = '95gcJqxhYHPhrCPGgo7ug3\$-';
  static const String applePayMerchantId = 'merchant.com.sanedny';

  // For Apple Pay Production
  static const String applePayAccessCodeProduction = 'WoZw96qIIp78lEGRmhTR';
  static const String applePayShaTypeProduction = 'SHA-256';
  static const String applePayShaRequestPhraseProduction = '929TODAV58BbCUHDRo2t7l}#';
  static const String applePayMerchantIdProduction = 'merchant.com.sanedny';
}