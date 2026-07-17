class UserModel{
  String id,email, password,name;
  DateTime cratedAt;

  UserModel(this.id,this.email,this.password,this.cratedAt,this.name);

  Map<String,dynamic> toMap() => {
    'id':id,
    'email':email,
    'password':password,
    'created_at':cratedAt.toString(),
    'name':name
  };

}