class AddressModel {
  final String addressType;
  final String address;

  AddressModel(
    this.addressType,
    this.address,
  );

  factory AddressModel.fromJson(Map<String, dynamic> data) => AddressModel(data["address_type"], data["address"]);

  toMap() => {
        "address_type": addressType,
        "address": address,
      };
}
