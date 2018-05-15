package cn.ningxy.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-05-15 19:24
 **/
@WebFilter(filterName = "RankPageFilter")
public class RankPageFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) req;
        HttpServletResponse httpServletResponse = (HttpServletResponse) resp;
        String url = httpServletRequest.getRequestURI();
        if(url != null || url.endsWith("rank.jsp")) {
            System.out.println("RankPageFilter | 拦截到直接通过url访问rank.jsp");
            httpServletResponse.sendRedirect("home.jsp");
            return;
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
