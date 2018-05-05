package cn.ningxy.servlet;

import cn.ningxy.bean.User;
import cn.ningxy.service.UserServer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: ningxy
 * @Description: 更新用户信息
 * @Date: 2018-05-04 21:43
 **/
@WebServlet(name = "UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("username");
        String userEmail = request.getParameter("uemail");
        String userNo = request.getParameter("user_no");
        String userSchool = request.getParameter("school");
        String userDept = request.getParameter("dept");
        String userMajor = request.getParameter("major");
        String userClass = request.getParameter("class");
        String userRealName = request.getParameter("real_name");

        User user = new User(userName, userRealName, userEmail, userNo, userSchool, userDept, userMajor, userClass);
        System.out.println("UpdateProfileServlet | " + user.toString());

        boolean result = false;
        try {
            result = new UserServer().UpdateUserProfile(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("UpdateProfileServlet | result = " + result);
        if (result) {
            request.setAttribute("updateProfileRes", "succeed");
        } else {
            request.setAttribute("updateProfileRes", "failed");
        }

        request.getRequestDispatcher("profile.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
