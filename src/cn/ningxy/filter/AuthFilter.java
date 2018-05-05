package cn.ningxy.filter;


import cn.ningxy.service.UserServer;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @Author: ningxy
 * @Description: 身份验证过滤器 Authentication Filters
 * @Date: 2018-04-26 09:49
 **/
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

//        将ServletRequest/ServeletResponse强转为HttpServletRequest/HttpServletResponse
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;

//        获取请求中的ServletPath
        String servletPath = httpServletRequest.getServletPath();
//        获取session对象，强转为String
        HttpSession httpServletRequestSession = httpServletRequest.getSession();
//        获取session中的loginRes值，强转为String
        String loginRes = (String) httpServletRequestSession.getAttribute("loginRes");

        System.out.println("AuthFilter | Test AuthFilter.");
        System.out.println("AuthFilter | loginRes : " + loginRes);
        System.out.println("AuthFilter | servletPath : " + servletPath);

//        从cookie中获取当前登录用户信息
        String userNow = new UserServer().getUserNow(httpServletRequest);

        System.out.println("AuthFilter | userNow : " + userNow);

        if (servletPath != null && servletPath.equals("/profile.jsp")) {
            if (loginRes != null && loginRes.equals("succeed") && userNow != null) {
                filterChain.doFilter(servletRequest, servletResponse);
            } else if (loginRes != null && loginRes.equals("failed")) {
                httpServletRequest.setAttribute("loginRes", "failed");
                httpServletRequest.setAttribute("returnURL", servletPath);
//                登录失败，跳转到login.jsp
                httpServletRequest.getRequestDispatcher("login.jsp").forward(httpServletRequest, httpServletResponse);
            } else {
                httpServletRequest.setAttribute("loginRes", "notLogin");
                httpServletRequest.setAttribute("retrunURL", servletPath);
//                未登录，跳转到login.jsp
                httpServletRequest.getRequestDispatcher("login.jsp").forward(httpServletRequest, httpServletResponse);
            }
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }
}
