import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner.dart';

class BannerModel extends Equatable {
  final String? bannerName;
  final String? bannerImage;
  final String? description;

  const BannerModel({
    this.bannerName,
    this.bannerImage,
    this.description,
  });

  Banner toEntity() => Banner(
        bannerName: bannerName,
        bannerImage: bannerImage,
        description: description,
      );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "description": description,
      };

  @override
  List<Object?> get props => [
        bannerName,
        bannerImage,
        description,
      ];
}
