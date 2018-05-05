package cn.ningxy.service;

import cn.ningxy.bean.User;
import cn.ningxy.dao.UserDaoServer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-18 13:00
 **/
public class UserServer implements IUserService {

    @Override
    /**
     * @Author: ningxy
     * @Description: login
     * @params: [request]
     * @return: cn.ningxy.bean.User
     * @Date: 2018/4/19 上午11:20
     */
    public User login(String userName, String userPassword) throws Exception {

        User user = new UserDaoServer().validateUser(userName, userPassword);

        if (user != null) {
            System.out.println("用户[" + userName + "]登录成功");
        } else {
            System.out.println("登录失败");
        }

        return user;
    }

    /**
     * @Author: ningxy
     * @Description: 用户每日打卡
     * @params: [user]
     * @return: boolean
     * @Date: 2018/4/28 下午3:15
     */
    @Override
    public boolean checkin(String userName) throws Exception {

        boolean isCheckinSuccess = false;

        try {
            isCheckinSuccess = new UserDaoServer().checkin(userName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isCheckinSuccess == true) {
            System.out.println("UserServer | 用户[" + userName + "]打卡成功");
        } else {
            System.out.println("UserDaoServer | 用户[" + userName + "]打卡失败");
        }

        return isCheckinSuccess;
    }

    /**
     * @param userName
     * @Author: ningxy
     * @Description: 检查是否今日已经打过卡
     * @params: [userName]
     * @return: boolean
     * @Date: 2018/4/28 下午9:53
     */
    @Override
    public boolean isAlreadyCheckedin(String userName) throws Exception {

        boolean result = false;

        try {
            result = new UserDaoServer().isAlreadyCheckedin(userName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * @Author: ningxy
     * @Description: 获取当前登录用户
     * @params: [request]
     * @return: java.lang.String
     * @Date: 2018/4/30 下午7:41
     */
    @Override
    public String getUserNow(HttpServletRequest request) {
        //    获取当前用户
        String userNow = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("username")) {
                    System.out.println("cookies = " + cookies[i].getValue());
                    userNow = cookies[i].getValue();
                }
            }
        }
        return userNow;
    }

    /**
     * @param userName
     * @Author: ningxy
     * @Description: 获取用户详细信息
     * @params: [userName]
     * @return: java.util.ArrayList<cn.ningxy.bean.User>
     * @Date: 2018/5/3 下午9:51
     */
    @Override
    public User getUserInfo(String userName) throws Exception {
        return new UserDaoServer().getUserInfo(userName);
    }

    /**
     * @param user
     * @Author: ningxy
     * @Description: 更新用户profile
     * @params: [user]
     * @return: boolean
     * @Date: 2018/5/5 下午1:10
     */
    @Override
    public boolean UpdateUserProfile(User user) throws Exception {
        return new UserDaoServer().UpdateUserProfile(user);
    }
}
