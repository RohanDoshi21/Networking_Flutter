class UserDetails{
  static String? name;
  static String? description;
  static String? rollNo;
  static String? email;
  static String? phoneNo;
  static int? noOfClubs;
  static int? noOfEvents;
  static String? profilePhotoUrl;
  static DateTime? birthday;
  static Map<String, bool?>? clubList = {
    'PASC': false,
    'PISB': false,
    'CSI': false,
    'EDC': false,
    'DEBSOC': false,
    'MUN' : false,
  };
}