import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final String? bannerName;
  final String? bannerImage;
  final String? description;

  const Banner({
    this.bannerName,
    this.bannerImage,
    this.description,
  });

  @override
  List<Object?> get props => [bannerName, bannerImage, description];
}
