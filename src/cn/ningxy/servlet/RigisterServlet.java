package cn.ningxy.servlet;

import cn.ningxy.bean.User;
import cn.ningxy.dao.UserDaoServer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-19 10:59
 **/
@WebServlet(name = "RigisterServlet")
public class RigisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userName = request.getParameter("username");
        String userPassword = request.getParameter("passwd1");
        String userEmail = request.getParameter("email");
        String userNo = request.getParameter("user_no");
        String userSchool = request.getParameter("school");
        String userDept = request.getParameter("dept");
        String userMajor = request.getParameter("major");
        String userClass = request.getParameter("class");
        String userRealName = request.getParameter("real_name");

        if (userName.length() < 6 || userName.length() > 20 || userPassword.length() < 6 || userPassword.length() > 20) {
            request.setAttribute("registerRes", "error");
            request.getRequestDispatcher("register.jsp").forward(request,response);
            return;
        }

        User user = new User(userName, userPassword, userRealName, userEmail, userNo, userSchool, userDept, userMajor, userClass);

//        System.out.println(userName);
//        System.out.println(userPassword);

        try {
//            user = new UserDaoServer().registerUser(userName, userPassword);
            user = new UserDaoServer().registerUser(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(user != null) {
            request.setAttribute("registerRes", "succeed");
        } else {
            request.setAttribute("registerRes", "exist");
        }
        request.getRequestDispatcher("register.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
