<%@ page import="cn.ningxy.service.UserServer" %><%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/4/30
  Time: 下午8:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>关于 | About</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="${pageContext.request.contextPath }/js/baidu_tongji.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://cdn.bootcss.com/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>
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
                    <a class=" nav-item nav-link" href="home.jsp">Home</a>
                    <a class="nav-item nav-link" href="ShowRank">Rank</a>
                    <a class="nav-item active nav-link" href="#">About</a>
                    <a class="nav-item nav-link" href="tools/jwpt_evaluate.html">Tools</a>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false" id="navbardrop">
                        Null
                    </button>
                    <div class="dropdown-menu dropdown-menu-right" id="dropdown-menu">
                        <%--<a class="dropdown-item" href="#">账户设置</a>--%>
                        <%--<a class="dropdown-item" href="#">后台管理</a>--%>
                        <%--<div class="dropdown-divider"></div>--%>
                        <a class="dropdown-item" href="profile.jsp">设置</a>
                        <a class="dropdown-item" href="#" onclick="sendRequestByPost2()">登出</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="container mt-4">
    <h1>关于</h1>
    <p>@ningxxxl</p>
    <p>@ctuu</p>
</main>

<%@include file="footer.jsp" %>

<%
    //    获取当前用户
    String userNow = new UserServer().getUserNow(request);
    System.out.println("home | " + userNow);
    out.print("<script>userNow = '" + userNow + "';</script>");
//    out.print("userNow = '"+ userNow +"';");

    if (userNow != null) {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"" + userNow + "\";</script>");
//        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"#\\\">设置</a>\";</script>");
//        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" onclick=\\\"sendRequestByPost2()\\\">登出</a>\";</script>");
    } else {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"未登录\";</script>");
        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"login.jsp\\\">登录</a><a class=\\\"dropdown-item\\\" href=\\\"register.jsp\\\">注册</a>\"</script>\n");
    }
%>

</body>
</html>
