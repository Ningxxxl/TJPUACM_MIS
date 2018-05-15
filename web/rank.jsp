<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.ningxy.bean.CheckinData" %>
<%@ page import="cn.ningxy.service.CheckinServer" %>
<%@ page import="cn.ningxy.service.UserServer" %><%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/4/29
  Time: 下午5:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://cdn.bootcss.com/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>

    <title>TJPUACM Board | Rank</title>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-md navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">TJPU ACM Borad</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav mr-auto">
                    <a class=" nav-item nav-link" href="home.jsp">Home
                        <span class="sr-only">(current)</span>
                    </a>
                    <a class="nav-item active nav-link" href="#">Rank</a>
                    <a class="nav-item nav-link" href="about.jsp">About
                    </a>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false" id="navbardrop">
                        Null
                    </button>
                    <div class="dropdown-menu dropdown-menu-right" id="dropdown-menu">
                        <a class="dropdown-item" href="profile.jsp">设置</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" onclick="sendRequestByPost2()">登出</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>
<main class="container mt-4">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">排名</h5>
                    <h6 class="card-subtitle mb-2 text-muted">大佬别签啦我都跟不上啦</h6>
                    <div class="table-responsive">
                        <table class="table text-center table-hover">
                            <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">用户名</th>
                                <th scope="col">签到次数</th>
                            </tr>
                            </thead>
                            <tbody>

                            <%
                                ArrayList<CheckinData> checkinDataArrayList = (ArrayList<CheckinData>) request.getAttribute("rankList");
                                int rankPage = (int) request.getAttribute("rankPage");
                                int totPage = (int) request.getAttribute("totPage");
                                int pageSize = (int) request.getAttribute("pageSize");

                                int rank = (rankPage - 1) * pageSize;   //用户排名

                                if (checkinDataArrayList != null) {
                                    for (CheckinData checkinData : checkinDataArrayList) {
                                        rank += 1;

                                        String userName = checkinData.getUserName();        //用户名
                                        int frequency = checkinData.getCheckinFrequency();  //打卡次数

                                        out.print("" +
                                                "<tr>\n" +
                                                "    <th scope=\"row\">" + rank + "</th>\n" +
                                                "    <td>\n" +
                                                "        <a href=\"#\">" + userName + "</a>\n" +
                                                "    </td>\n" +
                                                "    <td>" + frequency + "</td>\n" +
                                                "</tr>");
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                        <nav>
                            <ul class="pagination">
                                <c:set var="totPage" value="<%=totPage%>"/>
                                <c:set var="rankPage" value="<%=rankPage%>"/>
                                <c:if test="${rankPage <= 1}">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="ShowRank?rankPage=<%=rankPage-1%>">Prev</a>
                                    </li>
                                </c:if>
                                <c:if test="${rankPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="ShowRank?rankPage=<%=rankPage-1%>">Prev</a>
                                    </li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totPage}">
                                    <c:if test="${rankPage == i}">
                                        <li class="page-item active">
                                            <a class="page-link" href="ShowRank?rankPage=${i}">${i}</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${rankPage != i}">
                                        <li class="page-item">
                                            <a class="page-link" href="ShowRank?rankPage=${i}">${i}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${rankPage >= totPage}">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="ShowRank?rankPage=<%=rankPage+1%>">Next</a>
                                    </li>
                                </c:if>
                                <c:if test="${rankPage < totPage}">
                                    <li class="page-item">
                                        <a class="page-link" href="ShowRank?rankPage=<%=rankPage+1%>">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<%@include file="footer.jsp" %>

<%
    //    获取当前用户
    String userNow = new UserServer().getUserNow(request);
    System.out.println("home | " + userNow);
    out.print("<script>userNow = '" + userNow + "';</script>");

    if (userNow != null) {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"" + userNow + "\";</script>");
    } else {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"未登录\";</script>");
        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"login.jsp\\\">登录</a><a class=\\\"dropdown-item\\\" href=\\\"register.jsp\\\">注册</a>\"</script>\n");
    }
%>

</body>
</html>
