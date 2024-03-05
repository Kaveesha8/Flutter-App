class User {
  // Constructor of user
  const User(
      {required this.id, required this.name, required this.addresss});
 
  // Creaye an empty constructor - for find user
  const User.empty({
    this.id= 0,
    this.name ='',
    this.addresss= '',
  });
 
  final int id;
  final String name;
  final String addresss;
 
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        addresss: json['address'],
      );
 
  //json method to convert the user object to json format
 
  Map<String, dynamic> toJson() =>{
    "id": id,
    "name": name,
    "address": addresss,
  };
}