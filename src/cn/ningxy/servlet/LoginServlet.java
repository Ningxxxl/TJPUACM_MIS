package cn.ningxy.servlet;

import cn.ningxy.bean.User;
import cn.ningxy.service.UserServer;
import cn.ningxy.util.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userName = request.getParameter("username");
        String userPassword = request.getParameter("passwd");
        String isRemember = request.getParameter("isRemember");
        String token;

        User user = null;

        try {
            user = new UserServer().login(userName, userPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (user != null) {
            request.setAttribute("loginRes", "succeed");

            System.out.println("isRemember = " + isRemember);

//            基于JWT登录
            try {
                token = JWTUtil.createJWT(userName, 3 * 60 * 60 * 1000);
                Cookie cookie = new Cookie("userToken", token);
                cookie.setMaxAge(20);
                response.addCookie(cookie);
                System.out.println("LoginServlet | [" + userName + "] Token = [" + token + "]");
                if (isRemember != null && isRemember.equals("on")) {
                    cookie.setMaxAge(3 * 60 * 60);
                } else {
                    cookie.setMaxAge(10 * 60);
                }
                response.addCookie(cookie);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            session.setAttribute("loginRes", "failed");
            request.setAttribute("loginRes", "failed");
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
