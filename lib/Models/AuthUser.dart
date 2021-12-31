class AuthUser{
  late int id;
  late int roleId;
  late String name;
  late String role;
  late String token;


  void fill(int id,int roleId, String name, String role, String token){
    this.id = id;
    this.roleId = roleId;
    this.name = name;
    this.role = role;
    this.token = token;
  }
}

AuthUser authUser = new AuthUser();
