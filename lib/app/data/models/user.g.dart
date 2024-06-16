// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 7;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      seq: fields[0] as String,
      email: fields[1] as String,
      name: fields[2] as String,
      company_name: fields[3] as String,
      avatar_file: fields[4] as String,
      role: fields[5] as String,
      status: fields[6] as String,
      test: fields[7] as String,
      black: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.company_name)
      ..writeByte(4)
      ..write(obj.avatar_file)
      ..writeByte(5)
      ..write(obj.role)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.test)
      ..writeByte(8)
      ..write(obj.black);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      seq: json['seq'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      company_name: json['company_name'] as String,
      avatar_file: json['avatar_file'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      test: json['test'] as String,
      black: json['black'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'seq': instance.seq,
      'email': instance.email,
      'name': instance.name,
      'company_name': instance.company_name,
      'avatar_file': instance.avatar_file,
      'role': instance.role,
      'status': instance.status,
      'test': instance.test,
      'black': instance.black,
    };
