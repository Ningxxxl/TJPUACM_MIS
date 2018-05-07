package cn.ningxy.dao;

import cn.ningxy.bean.User;
import cn.ningxy.util.MD5Util;
import com.sun.tools.javac.comp.Check;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.security.rsa.RSASignature;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: ningxy
 * @Description: 具体实现IUserDaoService接口
 * @Date: 2018-04-18 11:49
 **/
public class UserDaoServer implements IUserDaoService {

    @Override
    /**
     * @Author: ningxy
     * @Description: 列出已有的用户
     * @params: []
     * @return: java.util.List<cn.ningxy.bean.User>
     * @Date: 2018/4/18 上午11:55
     */
    public List<User> getAllUser() throws Exception {

        List<User> allUsers = new ArrayList<>();

//        获得数据库连接
        Connection connection = new ConnectDB().getConnection();
//        创建数据库操作的语句对象
        Statement statement = connection.createStatement();
//        查询数据库返回结果集
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users");

//        遍历结果集，封装用户数据
        while (resultSet.next()) {
//            创建用户对象
            User user = new User();
//            添加用户属性
            user.setUserName(resultSet.getString(2));
            user.setPassWord(resultSet.getString(3));
            allUsers.add(user);
        }

//        关闭连接
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

//        返回结果
        return allUsers;
    }

    /**
     * @Author: ningxy
     * @Description: 检查登录用户的合法性
     * @params: [userName, userPassword]
     * @return: cn.ningxy.bean.User
     * @Date: 2018/4/18 下午9:36
     */
    @Override
    public boolean isUserExist(String userName) throws Exception {

//        获得数据库连接
        Connection connection = new ConnectDB().getConnection();
//        创建数据库操作的语句对象
        Statement statement = connection.createStatement();
//        查询数据库返回结果集
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users");

        boolean isExist = false;

//        查找结果集看是否存在该用户名
        while (resultSet.next()) {
            if (userName.equals(resultSet.getString(2))) {
                isExist = true;
            }
        }

        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isExist;
    }

    /**
     * @Author: ningxy
     * @Description: 注册用户
     * @params: [userName, userPassword]
     * @return: cn.ningxy.bean.User
     * @Date: 2018/4/18 下午9:42
     */
    @Override
    public User registerUser(String userName, String userPassword) throws Exception {

        boolean isExist = isUserExist(userName);
        User user = null;

        if (isExist == true) {
            return null;
        }

        String sql = "INSERT INTO users (username, password) VALUES (?,?);";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, MD5Util.MD5EncodeUtf8(userName));
            preparedStatement.setString(2, MD5Util.MD5EncodeUtf8(userPassword));
            preparedStatement.executeUpdate();
            System.out.println("UserDaoServer获取到用户名 : " + userName);
            user = new User(userName, userPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection.close();
        }

        return user;
    }

    /**
     * @Author: ningxy
     * @Description: 检测用户名、密码是否匹配
     * @params: [userName, userPassword]
     * @return: cn.ningxy.bean.User
     * @Date: 2018/4/19 上午11:24
     */
    @Override
    public User validateUser(String userName, String userPassword) throws Exception {

//        加密
        userPassword = MD5Util.MD5EncodeUtf8(userPassword);

        Connection connection = new ConnectDB().getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users");

        User user = null;

        while (resultSet.next()) {
            if (userName.equals(resultSet.getString(2))
                    && userPassword.equals(resultSet.getString(3))) {
                user = new User(userName, userPassword);
            }
        }

        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    /**
     * @Author: ningxy
     * @Description: 注册用户
     * @params: [user] 传入封装好的User
     * @return: cn.ningxy.bean.User
     * @Date: 2018/4/25 下午8:27
     */
    @Override
    public User registerUser(User user) throws Exception {
        boolean isExist = isUserExist(user.getUserName());
        boolean isUpdateSuccess = false;
//        User user = null;

        if (isExist == true) {
            return null;
        }

        String sql = "INSERT INTO users (username, password) VALUES (?,?);";
        String sql2 = "INSERT INTO user_info (user_id, user_name, user_email, user_no, user_school, user_dept, user_major, user_class)" +
                " VALUES ((SELECT user_id FROM users WHERE username = ?),?,?,?,?,?,?,?);";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);

        try {
//            插入users表
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, MD5Util.MD5EncodeUtf8(user.getPassWord()));
            preparedStatement.executeUpdate();
            System.out.println("UserDaoServer获取到用户名 : " + user.getUserName());
//            插入user_info表
            preparedStatement2 = connection.prepareStatement(sql2);
            preparedStatement2.setString(1, user.getUserName());
            preparedStatement2.setString(2, user.getUserRealName());
            preparedStatement2.setString(3, user.getUserEmail());
            preparedStatement2.setString(4, user.getUserNo());
            preparedStatement2.setString(5, user.getUserSchool());
            preparedStatement2.setString(6, user.getUserDept());
            preparedStatement2.setString(7, user.getUserMajor());
            preparedStatement2.setString(8, user.getUserClass());
            preparedStatement2.executeUpdate();


            System.out.println("UserDaoServer | realName : " + user.getUserRealName());

            isUpdateSuccess = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
                preparedStatement2.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection.close();
        }

        if (isUpdateSuccess)
            return user;
        else return null;
    }

    /**
     * @Author: ningxy
     * @Description: 用户每日打卡
     * @params: [userName]
     * @return: int
     * @Date: 2018/4/28 下午1:52
     */
    @Override
    public boolean checkin(String userName) throws Exception {

        boolean isCheckinSuccuss = false;

        String sql = "INSERT INTO checkin (user_id, checkin_date, checkin_time) " +
                "VALUES ((SELECT user_id FROM users WHERE username = ?)," +
                "current_date, current_time)";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = null;

        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            preparedStatement.executeUpdate();

            isCheckinSuccuss = true;
            System.out.println("UserDaoServer | 用户[" + userName + "]打卡数据插入成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection.close();
        }

        return isCheckinSuccuss;
    }

    /**
     * @Author: ningxy
     * @Description: 检查用户今日是否已经打过卡
     * @params: [userName]
     * @return: boolean
     * @Date: 2018/4/28 下午8:35
     */
    @Override
    public boolean isAlreadyCheckedin(String userName) throws Exception {
        boolean result = false;

        String sql = "SELECT COUNT(*) FROM checkin WHERE checkin_date = CURRENT_DATE" +
                " AND user_id = (SELECT user_id FROM users WHERE username = ?);";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = null;

        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            preparedStatement.executeQuery();

            ResultSet resultSet = preparedStatement.getResultSet();
            resultSet.next();

            if (Integer.valueOf(resultSet.getString(1)) > 0) {
                result = true;
            } else {
                result = false;
            }

            System.out.println("UserDaoServer | 用户[" + userName + "]打卡数据查询成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection.close();
        }

        return result;
    }

    /**
     * @Author: ningxy
     * @Description:
     * @params: [userName]
     * @return: cn.ningxy.bean.User
     * @Date: 2018/5/3 下午9:18
     */
    @Override
    public User getUserInfo(String userName) throws Exception {

        String sql = "SELECT\n" +
                "\tusername,\n" +
                "\tuser_name,\n" +
                "\tuser_email,\n" +
                "\tuser_no,\n" +
                "\tuser_school,\n" +
                "\tuser_dept,\n" +
                "\tuser_major,\n" +
                "\tuser_class \n" +
                "FROM\n" +
                "\tusers\n" +
                "\tINNER JOIN user_info \n" +
                "\tON users.user_id = user_info.user_id \n" +
                "WHERE\n" +
                "\tusername = ?";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, userName);

        User userInfo = new User();

        try {
            preparedStatement.executeQuery();
            ResultSet resultSet = preparedStatement.getResultSet();

            resultSet.next();
            String userName1 = resultSet.getString(1);
            String userRealName = resultSet.getString(2);
            String userEmail = resultSet.getString(3);
            String userNo = resultSet.getString(4);
            String userSchool = resultSet.getString(5);
            String userDept = resultSet.getString(6);
            String userMajor = resultSet.getString(7);
            String userClass = resultSet.getString(8);

            userInfo = new User(userName1, userRealName, userEmail, userNo, userSchool, userDept, userMajor, userClass);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userInfo;
    }

    /**
     * @Author: ningxy
     * @Description: 更新profile
     * @params: [user]
     * @return: boolean
     * @Date: 2018/5/5 下午12:35
     */
    @Override
    public boolean UpdateUserProfile(User user) throws Exception {
        String sql = "UPDATE user_info, users\n" +
                "SET user_name = ?,\n" +
                "user_email = ?,\n" +
                "user_no = ?,\n" +
                "user_school = ?,\n" +
                "user_dept = ?,\n" +
                "user_major = ?,\n" +
                "user_class = ?\n" +
                "WHERE users.user_id = user_info.user_id\n" +
                "AND users.username = ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, user.getUserRealName());
        preparedStatement.setString(2, user.getUserEmail());
        preparedStatement.setString(3, user.getUserNo());
        preparedStatement.setString(4, user.getUserSchool());
        preparedStatement.setString(5, user.getUserDept());
        preparedStatement.setString(6, user.getUserMajor());
        preparedStatement.setString(7, user.getUserClass());
        preparedStatement.setString(8, user.getUserName());

        int res =  preparedStatement.executeUpdate();

        if (res != 0) {
            System.out.println("UserDaoServer | [" + user.getUserName() + "] profile更新成功");
            return true;
        } else {
            System.out.println("UserDaoServer | [" + user.getUserName() + "] profile更新失败");
            return false;
        }
    }

    /**
     * @Author: ningxy
     * @Description: 更新用户密码
     * @params: [userName, oldPWD, newPWD]
     * @return: boolean
     * @Date: 2018/5/6 下午12:25
     */
    @Override
    public boolean UpdateUserPassword(String userName, String oldPWD, String newPWD) throws Exception {

        boolean isPassWordIllegal = isPasswrdIllegal(userName, oldPWD);

        if(isPassWordIllegal == false) return false;

        String sql = "UPDATE users SET users.password = ? WHERE users.username = ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, newPWD);
        preparedStatement.setString(2, userName);

        int row = preparedStatement.executeUpdate();

        if (row != 0) {
            return true;
        } else {
            return false;
        }

    }

    /**
     * @Author: ningxy
     * @Description: 验证用户当前使用密码是否正确
     * @params: [userName, oidPWD]
     * @return: boolean
     * @Date: 2018/5/6 下午12:28
     */
    @Override
    public boolean isPasswrdIllegal(String userName, String oldPWD) throws Exception {
        String sql = "SELECT users.password FROM users WHERE users.username = ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, userName);

        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();

        resultSet.next();

        String correctPWD = resultSet.getString(1);

        if (correctPWD.equals(oldPWD)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @Author: ningxy
     * @Description: 验证用户当前使用邮箱是否正确
     * @params: [userName, oldEmail]
     * @return: boolean
     * @Date: 2018/5/6 下午2:25
     */
    @Override
    public boolean isEmailLeggal(String userName, String oldEmail) throws Exception {
        String sql = "SELECT user_info.user_email\n" +
                "FROM users INNER JOIN user_info\n" +
                "ON users.user_id = user_info.user_id\n" +
                "WHERE users.username = ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, userName);

        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();

        resultSet.next();

        String correctEmail = resultSet.getString(1);

        if (correctEmail.equals(oldEmail)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @Author: ningxy
     * @Description: 更新用户邮箱
     * @params: [userName, oldPWD, oldEmail, newEmail]
     * @return: boolean
     * @Date: 2018/5/6 下午2:35
     */
    @Override
    public boolean UpdateUserEmail(String userName, String oldPWD, String oldEmail, String newEmail) throws Exception {
        boolean isEmailLeggal = isEmailLeggal(userName, oldEmail);
        boolean isPasswordLeggal = isPasswrdIllegal(userName, oldPWD);
        if(isEmailLeggal == false || isPasswordLeggal == false) return false;

        String sql = "UPDATE users, user_info\n" +
                "SET user_info.user_email = ?\n" +
                "WHERE users.user_id = user_info.user_id\n" +
                "AND users.username = ?";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, newEmail);
        preparedStatement.setString(2, userName);

        int row = preparedStatement.executeUpdate();

        if (row != 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @Author: ningxy
     * @Description: 获取指定用户的打卡数据（日期+时间）
     * @params: [userName]
     * @return: net.sf.json.JSONArray
     * @Date: 2018/5/7 下午8:59
     */
    @Override
    public JSONArray getUserCheckinDateTime(String userName) throws Exception {
        String sql = "SELECT checkin_date, checkin_time FROM \n" +
                "users INNER JOIN checkin\n" +
                "ON users.user_id = checkin.user_id\n" +
                "WHERE users.username = ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, userName);

        ResultSet resultSet = preparedStatement.executeQuery();

        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();

        if (resultSet == null) return jsonArray;

        while(resultSet.next()) {
            String checkinDate = resultSet.getString(1);
            String checkinTime = resultSet.getString(2);

            jsonObject.put("date", checkinDate);
            jsonObject.put("time", checkinTime);

            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }
}
