package cn.ningxy.servlet;

import cn.ningxy.bean.User;
import cn.ningxy.service.UserServer;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.logging.SocketHandler;

/**
 * @Author: ningxy
 * @Description: 显示用户信息
 * @Date: 2018-05-04 15:17
 **/
@WebServlet(name = "ShowProfileServlet")
public class ShowProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("userName");

        JSONObject jsonObject = new JSONObject();
//        JSONArray jsonArray = new JSONArray();

        try {
            User userInfo = new UserServer().getUserInfo(userName);
            jsonObject.put("userName", userInfo.getUserName());
            jsonObject.put("userRealName", userInfo.getUserRealName());
            jsonObject.put("userEmail", userInfo.getUserEmail());
            jsonObject.put("userNo", userInfo.getUserNo());
            jsonObject.put("userSchool", userInfo.getUserSchool());
            jsonObject.put("userDept", userInfo.getUserDept());
            jsonObject.put("userMajor", userInfo.getUserMajor());
            jsonObject.put("userClass", userInfo.getUserClass());

            System.out.println("ShowProfileServlet | 获取结果");
            System.out.println("ShowProfileServlet | " + userInfo.toString());

//            jsonArray.add(jsonObject);

            PrintWriter out = response.getWriter();

            out.print(jsonObject);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
