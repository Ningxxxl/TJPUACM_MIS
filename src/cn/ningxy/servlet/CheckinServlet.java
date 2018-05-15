package cn.ningxy.servlet;

import cn.ningxy.dao.UserDaoServer;
import cn.ningxy.service.CheckinServer;
import cn.ningxy.service.UserServer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @Author: ningxy
 * @Description: 用户每日打卡
 * @Date: 2018-04-28 15:20
 **/
@WebServlet(name = "CheckinServlet")
public class CheckinServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String userName = request.getParameter("username");

        boolean isLogin = false;
        boolean isCheckinSuccess = false;
        boolean isAlreadyCheckedin = false;
        boolean isIPLegal = false;

        //    获取当前用户
        String userNow = new UserServer().getUserNow(request);
        System.out.println("CheckinServlet | " + userNow);

        if (userNow != null) {
            isLogin = true;
        }

        PrintWriter out = response.getWriter();

        try {
            isAlreadyCheckedin = new UserServer().isAlreadyCheckedin(userName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!isLogin) {
            out.print("notLogin");
        } else {
            if (isAlreadyCheckedin) {
                out.print("checkedin");
            } else {

                isIPLegal = new CheckinServer().CheckIPAddr(request);

                if (!isIPLegal) {
                    out.print("IPIllegal");
                } else {
                    try {
                        isCheckinSuccess = new UserServer().checkin(userName);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (isCheckinSuccess) {
                        out.print("success");
                    } else {
                        out.print("error");
                    }

                    try {
                        out.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
