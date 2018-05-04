package cn.ningxy.bean;

/**
 * @Author: ningxy
 * @Description: 用户 实体类
 * @Date: 2018/4/17 上午10:19
 */
public class User {
    private String userName;
    private String passWord;
    private String userRealName;
    private String userEmail;
    private String userNo;
    private String userSchool;
    private String userDept;
    private String userMajor;
    private String userClass;

    @Override
    public String toString() {
        return "User{" +
                "userName='" + userName + '\'' +
                ", passWord='" + passWord + '\'' +
                ", userRealName='" + userRealName + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userNo='" + userNo + '\'' +
                ", userSchool='" + userSchool + '\'' +
                ", userDept='" + userDept + '\'' +
                ", userMajor='" + userMajor + '\'' +
                ", userClass='" + userClass + '\'' +
                '}';
    }

    public User() {
    }

    public User(String userName, String passWord) {
        this.userName = userName;
        this.passWord = passWord;
    }

    public User(String userName, String passWord, String userRealName, String userEmail, String userNo, String userSchool, String userDept, String userMajor, String userClass) {
        this.userName = userName;
        this.passWord = passWord;
        this.userRealName = userRealName;
        this.userEmail = userEmail;
        this.userNo = userNo;
        this.userSchool = userSchool;
        this.userDept = userDept;
        this.userMajor = userMajor;
        this.userClass = userClass;
    }

    public User(String userName, String userRealName, String userEmail, String userNo, String userSchool, String userDept, String userMajor, String userClass) {
        this.userName = userName;
        this.userRealName = userRealName;
        this.userEmail = userEmail;
        this.userNo = userNo;
        this.userSchool = userSchool;
        this.userDept = userDept;
        this.userMajor = userMajor;
        this.userClass = userClass;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getPassWord() {
        return passWord;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserNo() {
        return userNo;
    }

    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }

    public String getUserSchool() {
        return userSchool;
    }

    public void setUserSchool(String userSchool) {
        this.userSchool = userSchool;
    }

    public String getUserDept() {
        return userDept;
    }

    public void setUserDept(String userDept) {
        this.userDept = userDept;
    }

    public String getUserMajor() {
        return userMajor;
    }

    public void setUserMajor(String userMajor) {
        this.userMajor = userMajor;
    }

    public String getUserClass() {
        return userClass;
    }

    public void setUserClass(String userClass) {
        this.userClass = userClass;
    }

    public String getUserRealName() {
        return userRealName;
    }

    public void setUserRealName(String userRealName) {
        this.userRealName = userRealName;
    }
}
