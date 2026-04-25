class ProductModel {
  bool? success;
  int? total;
  bool? canLoadMore;
  List<ProductData>? data;

  ProductModel({this.success, this.total, this.canLoadMore, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json['success'],
      total: json['total'],
      canLoadMore: json['can_load_more'],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ProductData.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'total': total,
      'can_load_more': canLoadMore,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}
class ProductData {
  int? id;
  String? name;
  String? description;
  String? brand;
  String? category;
  String? subCategory;
  int? price;
  List<VolumePrices>? volumePrices;
  String? status;
  List<String>? images;
  int? stock;
  dynamic variations;       // FIXED HERE
  int? isWishlist;
  String? createdAt;
  int? requiredPoint;
  int? increment_step;
  List<Sizes>? sizes;
  List<ColorData>? colors;

  ProductData({
    this.id,
    this.name,
    this.description,
    this.brand,
    this.category,
    this.subCategory,
    this.price,
    this.volumePrices,
    this.status,
    this.images,
    this.stock,
    this.variations,
    this.isWishlist,
    this.createdAt,
    this.requiredPoint,
    this.increment_step,
    this.sizes,
    this.colors,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brand = json['brand'];
    category = json['category'];
    subCategory = json['sub_category'];
    price = json['price'];

    if (json['volume_prices'] != null) {
      volumePrices = <VolumePrices>[];
      json['volume_prices'].forEach((v) {
        volumePrices!.add(VolumePrices.fromJson(v));
      });
    }

    status = json['status'];

    images = json['images'] != null
        ? List<String>.from(json['images'].map((e) => e))
        : [];

    stock = json['stock'];
    variations = json['variations'];
    isWishlist = json['is_wishlist'];
    createdAt = json['created_at'];
    requiredPoint = json['required_point'];
    increment_step = json['increment_step'];

    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }

    if (json['colors'] != null) {
      colors = <ColorData>[];
      json['colors'].forEach((v) {
        colors!.add(ColorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['brand'] = brand;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['price'] = price;

    if (volumePrices != null) {
      data['volume_prices'] = volumePrices!.map((v) => v.toJson()).toList();
    }

    data['status'] = status;
    data['images'] = images;
    data['stock'] = stock;
    data['variations'] = variations;
    data['is_wishlist'] = isWishlist;
    data['created_at'] = createdAt;
    data['required_point'] = requiredPoint;
    data['increment_step'] = increment_step;

    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }

    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class Sizes {
  int? id;
  String? name;

  Sizes({this.id, this.name});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ColorData {
  int? id;
  String? name;
  String? hex;

  ColorData({this.id, this.name, this.hex});

  ColorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hex = json['hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hex'] = this.hex;
    return data;
  }
}

class VolumePrices {
  int? id;
  int? productId;
  int? quantity;
  dynamic discountPrice;
  String? createdAt;
  String? updatedAt;

  VolumePrices({
    this.id,
    this.productId,
    this.quantity,
    this.discountPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory VolumePrices.fromJson(Map<String, dynamic> json) {
    return VolumePrices(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      discountPrice: json['discount_price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'discount_price': discountPrice,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}


class Options {
  int? id;
  String? name;
  int? quantity;
  int? price;

  Options({this.id, this.name, this.quantity, this.price});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'quantity': quantity, 'price': price};
  }
}



