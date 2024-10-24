import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/information_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/membership_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/transaction_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/data/repositories/information_repository_impl.dart';
import 'package:sims_ppob_roni_rusmayadi/data/repositories/membership_repository_impl.dart';
import 'package:sims_ppob_roni_rusmayadi/data/repositories/transaction_repository_impl.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/infomation_repository.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/membership_repository.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_balance.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_banner.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_history.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_services.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_login.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_register.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_topup.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_transaction.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile_image.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/banner_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/informations/services_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/auth_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/login_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/profile_detail_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_image_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/put_profile_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/memberships/register_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/balance_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/history_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/topup_notifier.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/providers/transactions/transaction_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider auth
  locator.registerFactory(() => AuthProvider());

  // provider membership
  locator.registerFactory(() => ProfileDetailNotifier(getProfile: locator()));
  locator.registerFactory(() => LoginNotifier(postLogin: locator()));
  locator.registerFactory(() => RegisterNotifier(postRegister: locator()));
  locator.registerFactory(() =>
      PutProfileNotifier(putProfile: locator(), putProfileImage: locator()));
  locator.registerFactory(
      () => PutProfileImageNotifier(putProfileImage: locator()));

  // provider information
  locator.registerFactory(() => BannerNotifier(getBanner: locator()));
  locator.registerFactory(() => ServicesNotifier(getServices: locator()));

  // provider transaction
  locator.registerFactory(() => BalanceNotifier(getBalance: locator()));
  locator.registerFactory(() => HistoryNotifier(getHistory: locator()));
  locator.registerFactory(() => TopUpNotifier(postTopUp: locator()));
  locator
      .registerFactory(() => TransactionNotifier(postTransaction: locator()));

  // use case membership
  locator.registerLazySingleton(() => GetProfile(locator()));
  locator.registerLazySingleton(() => PostLogin(locator()));
  locator.registerLazySingleton(() => PostRegister(locator()));
  locator.registerLazySingleton(() => PutProfileImage(locator()));
  locator.registerLazySingleton(() => PutProfile(locator()));

  // use case information
  locator.registerLazySingleton(() => GetBanner(locator()));
  locator.registerLazySingleton(() => GetServices(locator()));

  // use case information
  locator.registerLazySingleton(() => GetBalance(locator()));
  locator.registerLazySingleton(() => GetHistory(locator()));
  locator.registerLazySingleton(() => PostTopUp(locator()));
  locator.registerLazySingleton(() => PostTransaction(locator()));

  // repository membership
  locator.registerLazySingleton<MembershipRepository>(
    () => MembershipRepositoryImpl(membershipRemoteDataSource: locator()),
  );

  // repository information
  locator.registerLazySingleton<InformationRepository>(
    () => InformationRepositoryImpl(informationRemoteDataSource: locator()),
  );

  // repository transaction
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(transactionRemoteDataSource: locator()),
  );

  // data sources membership
  locator.registerLazySingleton<MembershipRemoteDataSource>(
      () => MembershipRemoteDataSourceImpl(client: locator()));

  // data sources information
  locator.registerLazySingleton<InformationRemoteDataSource>(
      () => InformationRemoteDataSourceImpl(client: locator()));

  // data sources membership
  locator.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
