package cn.ningxy.servlet;

import cn.ningxy.bean.CheckinData;
import cn.ningxy.service.CheckinServer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-05-10 21:31
 **/
@WebServlet(name = "ShowRankServlet")
public class ShowRankServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String pageString = request.getParameter("rankPage");

        if(pageString == null || "".equals(pageString.trim())) pageString = "1";

        int rankPage = Integer.parseInt(pageString);

        System.out.println("ShowRankServlet | rankPage = " + rankPage);

        try {
            int pageSize = 10;
            int rowCount = new CheckinServer().getCheckinQuantity();
            int totPage = (rowCount - 1) / pageSize + 1;

            if(rankPage < 1) rankPage = 1;
            if(rankPage > totPage) rankPage = totPage;

            ArrayList<CheckinData> checkinDataArrayList = new CheckinServer().getCheckinRank(rankPage, pageSize);

            request.setAttribute("rankList", checkinDataArrayList);
            request.setAttribute("rankPage", rankPage);     //当前页码
            request.setAttribute("totPage", totPage);     //总页数
            request.setAttribute("pageSize", pageSize);     //总页数
            request.setAttribute("validate", "OKOK");

            request.getRequestDispatcher("rank.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
