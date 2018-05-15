<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.ningxy.bean.CheckinData" %>
<%@ page import="cn.ningxy.service.CheckinServer" %>
<%@ page import="cn.ningxy.service.UserServer" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="cn.ningxy.bean.User" %>
<%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/4/28
  Time: 下午10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://cdn.bootcss.com/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>

    <title>TJPUACM Board</title>

    <script>

        function sendRequestByPost() {

            toastr.options.timeOut = '5000'; //展现时间
            toastr.options.extendedTimeOut = '10000';
            toastr.options.positionClass = 'toast-top-full-width'; //弹出窗的位置
            toastr.options.showMethod = 'slideDown';
            toastr.options.progressBar = true;

            //定义异步请求对象
            var xmlReq;
            //检测浏览器是否直接支持ajax
            if (window.XMLHttpRequest) {//直接支持ajax
                xmlReq = new XMLHttpRequest();
            } else {//不直接支持ajax
                xmlReq = new ActiveObject('Microsoft.XMLHTTP');
            }

            //设置回调函数
            xmlReq.onreadystatechange = function () {
                if (xmlReq.readyState == 4 && xmlReq.status == 200) {
                    //获取服务器的响应值
                    var result = xmlReq.responseText.toString();
                    //后续操作

                    if (result == "checkedin") {
                        toastr.info("今天已经打过卡了哦~");
                    } else if (result == "success") {
                        toastr.success("今日打卡成功！！！");
                    } else if (result == "notLogin") {
                        toastr.warning("登录信息过期，请刷新页面重新登录哟~");
                    } else if (result == "IPIllegal") {
                        toastr.warning("请连接实验室网络进行打卡哦~");
                    } else {
                        toastr.error("抱歉，我们遇到了错误。请联系管理员。");
                    }
                }
            }

            //创建异步Post请求
            var url = "CheckinServlet";
            // var url="LoginServlet";
            xmlReq.open("POST", url, true);
            xmlReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            //发送请求
            if (userNow != "null") {
                var data = "username=" + userNow;
                xmlReq.send(data);
            } else {
                toastr.warning("别着急嘛~ 先登录好嘛~");
            }
        }

        function sendRequestByPost2() {

            toastr.options.timeOut = '2000'; //展现时间
            toastr.options.extendedTimeOut = '1000';
            toastr.options.positionClass = 'toast-top-full-width'; //弹出窗的位置
            toastr.options.showMethod = 'slideDown';
            toastr.options.progressBar = false;

            //定义异步请求对象
            var xmlReq;
            //检测浏览器是否直接支持ajax
            if (window.XMLHttpRequest) {//直接支持ajax
                xmlReq = new XMLHttpRequest();
            } else {//不直接支持ajax
                xmlReq = new ActiveObject('Microsoft.XMLHTTP');
            }

            //设置回调函数
            xmlReq.onreadystatechange = function () {
                if (xmlReq.readyState == 4 && xmlReq.status == 200) {
                    //获取服务器的响应值
                    var result = xmlReq.responseText.toString();
                    //后续操作

                    if (result == "logoutSucceed") {
                        var url = "home.jsp";
                        var timeDelay = 1010;
                        toastr.info("退出成功");
                        setTimeout("top.location.href = '" + url + "'", timeDelay);
                    } else {
                        toastr.error("抱歉，我们遇到了错误。请联系管理员。");
                    }
                }
            };

            //创建异步Post请求
            var url = "LogoutServlet";
            // var url="LoginServlet";
            xmlReq.open("POST", url, true);
            xmlReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            //发送请求
            xmlReq.send(null);
        }
    </script>

</head>
<body>
<header>
    <nav class="navbar navbar-expand-md navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">TJPU ACM Borad</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav mr-auto">
                    <a class=" nav-item active nav-link" href="#">Home
                        <span class="sr-only">(current)</span>
                    </a>
                    <a class="nav-item nav-link" href="ShowRank">Rank</a>
                    <a class="nav-item nav-link" href="about.jsp">About
                    </a>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false" id="navbardrop">
                        Null
                    </button>
                    <div class="dropdown-menu dropdown-menu-right" id="dropdown-menu">
                        <%--<a class="dropdown-item" href="#">账户设置</a>--%>
                        <%--<a class="dropdown-item" href="#">后台管理</a>--%>
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
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-6">
                    <div class="card" style="width: 18rem;">
                        <div class="card-body">
                            <h5 class="card-title">每日打卡</h5>
                            <h6 class="card-subtitle mb-2 text-muted">
                                <%
                                    Date date = new Date();
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    TimeZone timeZone = TimeZone.getTimeZone("GMT+8");
                                    dateFormat.setTimeZone(timeZone);
                                    out.print(dateFormat.format(date));
                                %>
                            </h6>
                            <p class="card-text">
                                大佬别签啦我都跟不上啦
                            </p>
                            <a onclick="sendRequestByPost()" class="btn btn-primary text-light">点击签到</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col">
                    <div class="card">
                        <div class="card-body table-responsive">
                            <h5 class="card-title">个人签到概览
                                <small style="color: limegreen"> <span class="badge badge-primary">NEW</span></small>
                            </h5>
                            <table class="table">
                                <svg id="calendar-graph" xmlns="http://www.w3.org/2000/svg" width="768px" height="90px">
                                </svg>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            通知
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <div class="row">
                                        <a href="#" class="mr-auto">要期末啦T^T 更新会减速</a>
                                        <time>2018-04-23</time>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="row">
                                        <a href="#" class="mr-auto">个人签到概览功能上线！</a>
                                        <time>2018-05-07</time>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="row">
                                        <a href="#" class="mr-auto">新增加个人设置页面~（头像功能暂未开放）</a>
                                        <time>2018-05-06</time>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="row">
                                        <a href="#" class="mr-auto">TJPU首个ACM个人系统上线啦</a>
                                        <time>2018-05-01</time>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card" style="width: 18rem;">
                <div class="card-header">
                    统计
                </div>
                <div class="card-body">
                    <p class="card-text">
                        今日Top3：<br>
                        <%
                            String[] color = new String[3];
                            color[0] = "#FF230F";
                            color[1] = "#ff3c97";
                            color[2] = "D559FF";

                            ArrayList<CheckinData> checkinDataArrayList = null;
                            try {
                                checkinDataArrayList = new CheckinServer().getCheckinList();
                                if (checkinDataArrayList != null) {
                                    for (int i = 0; i < checkinDataArrayList.size() && i < 3; i++) {

                                        String checkinTop3 = null;
                                        String checkinListUserName = checkinDataArrayList.get(i).getUserName();
                                        String checkinListTime = checkinDataArrayList.get(i).getCheckinTime();

                                        checkinTop3 = String.format("No.%d %s    -> %s ", i + 1, checkinListUserName, checkinListTime);
                                        out.print("<p style=\"color: " + color[i] + "\">" + checkinTop3 + "</p>");
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </p>
                </div>
            </div>
        </div>
    </div>
</main>
<%@include file="footer.jsp" %>

<%
    //    获取当前用户
    String userNow = new UserServer().getUserNow(request);
    System.out.println("home | userNow = " + userNow);
    out.print("<script>userNow = '" + userNow + "';</script>");

    if (userNow != null) {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"" + userNow + "\";</script>");

//        获取用户打卡记录
        JSONArray jsonArray = null;
        try {
            jsonArray = new UserServer().getUserCheckinDateTime(userNow);
            out.println("<script> var dt = ");
            out.print(jsonArray.toString());
//            System.out.println(jsonArray.toString());
            out.println("</script>");
        } catch (Exception e) {
            e.printStackTrace();
        }

    } else {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"未登录\";</script>");
        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"login.jsp\\\">登录</a><a class=\\\"dropdown-item\\\" href=\\\"register.jsp\\\">注册</a>\"</script>\n");

        out.print("<script>var dt = [];</script>");
    }
%>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/profile_calendar.js"></script>
</body>

</html>
