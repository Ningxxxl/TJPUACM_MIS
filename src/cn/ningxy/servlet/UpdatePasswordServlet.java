package cn.ningxy.servlet;

import cn.ningxy.service.UserServer;
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
 * @Date: 2018-05-06 12:52
 **/
@WebServlet(name = "UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("updatePwdUserName");
        String oldPWD = request.getParameter("currentPassword");
        String newPWD = request.getParameter("newPassword");
        String newPWD1 = request.getParameter("newPassword1");

        System.out.println("UpdatePasswordServlet | userName = " + userName);
        System.out.println("UpdatePasswordServlet | newPWD = " + newPWD);

        if(userName == null) {
            request.setAttribute("updatePasswordRes", "userName_null");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if(newPWD.equals(newPWD1) == false) {
            request.setAttribute("updatePasswordRes", "newPasswordIllegal");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        oldPWD = MD5Util.MD5EncodeUtf8(oldPWD);
        newPWD = MD5Util.MD5EncodeUtf8(newPWD);

        boolean isUpdateSucceed = false;
        try {
            isUpdateSucceed = new UserServer().UpdateUserPassword(userName, oldPWD, newPWD);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isUpdateSucceed) {
            request.setAttribute("updatePasswordRes", "succeed");
            System.out.println("UpdatePasswordServlet | 密码修改成功");
        } else {
            request.setAttribute("updatePasswordRes", "failed");
            System.out.println("UpdatePasswordServlet | 密码修改失败");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
