package cn.ningxy.service;

import cn.ningxy.bean.User;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description: 定义各种用户操作的函数原型
 * @Date: 2018-04-18 12:32
 **/
public interface IUserService {

    /**
    * @Author: ningxy
    * @Description: 用户登录
    * @params: [userName, userPassword]
    * @return: cn.ningxy.bean.User
    * @Date: 2018/4/28 下午3:13
    */
    public User login(String userName, String userPassword) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 用户每日打卡
    * @params: [userName]
    * @return: boolean
    * @Date: 2018/4/28 下午3:15
    */
    public boolean checkin(String userName) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 检查是否今日已经打过卡
    * @params: [userName]
    * @return: boolean
    * @Date: 2018/4/28 下午9:53
    */
    public boolean isAlreadyCheckedin(String userName) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 获取当前登录用户
    * @params: [request]
    * @return: java.lang.String
    * @Date: 2018/4/30 下午7:41
    */
    public String getUserNow(HttpServletRequest request);

    /**
    * @Author: ningxy
    * @Description: 获取用户详细信息
    * @params: [userName]
    * @return: cn.ningxy.bean.User
    * @Date: 2018/5/3 下午9:51
    */
    public User getUserInfo(String userName) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 更新用户profile
    * @params: [user]
    * @return: boolean
    * @Date: 2018/5/5 下午1:10
    */
    public boolean UpdateUserProfile(User user) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 更新用户密码
    * @params: [userName, oldPWD, newPWD]
    * @return: boolean
    * @Date: 2018/5/6 下午12:24
    */
    public boolean UpdateUserPassword(String userName, String oldPWD, String newPWD) throws Exception;

    /**
    * @Author: ningxy
    * @Description:
    * @params: [userName, oldPWD, oldEmail, newEmail]
    * @return: boolean
    * @Date: 2018/5/6 下午2:48
    */
    public boolean UpdateUSerEmail(String userName, String oldPWD, String oldEmail, String newEmail) throws Exception;
}
