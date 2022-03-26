class DioClient{
  late String gender;

  DioClient();

  DioClient.female(){
    gender = "Female";
    print(gender);
  }

  DioClient.male(){
    gender = "Male";
    print(gender);
  }

  factory DioClient.createByGender({required Gender gender}){
    if(gender == Gender.MALE){
      return DioClient.male();
    }else{
      return DioClient.female();
    }
  }

}

enum Gender{
  MALE , FEMALE
}