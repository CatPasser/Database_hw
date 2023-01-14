class API{
  static const hostConnect = "http://192.168.0.145/api_hw";
  static const hostDepartment = "$hostConnect/Department";
  static const hostCourse = "$hostConnect/Course";
  static const hostStudent = "$hostConnect/Student";
  static const hostCourse_select = "$hostConnect/Course_select";

  //Department
  static const insert1 = "$hostConnect/Department/insert.php";
  static const update1 = "$hostConnect/Department/update.php";
  static const delete1= "$hostConnect/Department/delete.php";
  static const search1 = "$hostConnect/Department/search.php";

  //Course
  static const insert2 = "$hostConnect/Course/insert.php";
  static const update2 = "$hostConnect/Course/update.php";
  static const delete2 = "$hostConnect/Course/delete.php";
  static const search2 = "$hostConnect/Course/search.php";

  //Student
  static const insert3 = "$hostConnect/Student/insert.php";
  static const update3 = "$hostConnect/Student/update.php";
  static const delete3 = "$hostConnect/Student/delete.php";
  static const search3 = "$hostConnect/Student/search.php";

  //Course_select
  static const search4 = "$hostConnect/Course_select/search.php";
  static const insert4 = "$hostConnect/Course_select/insert.php";
  static const delete4 = "$hostConnect/Course_select/delete.php";
}