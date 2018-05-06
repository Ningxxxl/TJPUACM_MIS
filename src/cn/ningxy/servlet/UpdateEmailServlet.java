package cn.ningxy.servlet;

import cn.ningxy.dao.UserDaoServer;
import cn.ningxy.util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-05-06 14:52
 **/
@WebServlet(name = "UpdateEmailServlet")
public class UpdateEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("updateEmailUserName");
        String oldPWD = request.getParameter("currentPassword1");
        String oldEmail = request.getParameter("currentEmail");
        String newEmail = request.getParameter("newEmail");

        if (newEmail == null) {
            request.setAttribute("updateEmailRes", "newEmail_null");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if (userName == null) {
            request.setAttribute("updateEmailRes", "userName_null");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }

        oldPWD = MD5Util.MD5EncodeUtf8(oldPWD);

        boolean isUpdateEmailSucceed = false;

        try {
            isUpdateEmailSucceed = new UserDaoServer().UpdateUserEmail(userName, oldPWD, oldEmail, newEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isUpdateEmailSucceed) {
            request.setAttribute("updateEmailRes", "succeed");
            System.out.println("UpdateEmailServlet | 邮箱更新成功");
        } else {
            request.setAttribute("updateEmailRes", "failed");
            System.out.println("UpdateEmailServlet | 邮箱更新失败");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
