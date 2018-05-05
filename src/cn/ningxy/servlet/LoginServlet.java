package cn.ningxy.servlet;

import cn.ningxy.bean.User;
import cn.ningxy.service.UserServer;

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

        User user = null;

        try {
            user = new UserServer().login(userName, userPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (user != null) {
            request.setAttribute("loginRes", "succeed");

            session.setAttribute("userName", userName);
            session.setAttribute("loginRes", "succeed");
            Cookie cookie = new Cookie("username", userName);
            System.out.println("isRemember = " + isRemember);
            if (isRemember != null && isRemember.equals("on")) {
                cookie.setMaxAge(3 * 60 * 60);
            } else {
                cookie.setMaxAge(10 * 60);
            }
            response.addCookie(cookie);
        } else {
            session.setAttribute("loginRes", "failed");
            request.setAttribute("loginRes", "failed");
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
