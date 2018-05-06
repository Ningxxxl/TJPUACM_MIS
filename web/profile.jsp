<%@ page import="cn.ningxy.service.UserServer" %><%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/5/3
  Time: 下午8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人设置</title>

    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://cdn.bootcss.com/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<%
    //    获取当前用户
    String userNow = new UserServer().getUserNow(request);
    System.out.println("profile | " + userNow);
//    out.print("<script>userNow = '" + userNow + "';</script>");
%>

<script type="text/javascript">

    $(document).ready(function () {

        $.ajax({
            dataType: "json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;",
            type: "POST",
            url: "ShowProfileServlet",
            data: {userName: "<%=userNow%>"},
            statusCode: {
                404: function () {
                    alert('page not found');
                }
            },
            success: function (data) {
                $("#username").attr("value", data.userName);
                $("#updatePwdUserName").attr("value", data.userName);
                $("#real_name").attr("value", data.userRealName);
                $("#uemail").attr("value", data.userEmail);
                $("#user_no").attr("value", data.userNo);
                $("#school").attr("value", data.userSchool);
                $("#dept").attr("value", data.userDept);
                $("#major").attr("value", data.userMajor);
                $("#class").attr("value", data.userClass);
            }
        });
    });
</script>

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
                    <a class="nav-item nav-link" href="rank.jsp">Rank</a>
                    <a class="nav-item nav-link" href="about.jsp">About</a>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false" id="navbardrop">
                        <%--<span id="navbardrop_span">234234</span>--%>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right" id="dropdown-menu">
                        <%--<a class="dropdown-item" href="#">账户设置</a>--%>
                        <%--<a class="dropdown-item" href="#">后台管理</a>--%>
                        <a class="dropdown-item" href="profile.jsp">设置</a>
                        <%--<div class="dropdown-divider"></div>--%>
                        <%--<a class="dropdown-item" href="#" onclick="sendRequestByPost2()">登出</a>--%>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="container mt-4">
    <div class="row">
        <div class="col-md-2 md-2">
            <img src="..." class="img-fluid" alt="Responsive image">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active" id="v-pills-overview-tab" data-toggle="pill" href="#v-pills-overview" role="tab" aria-controls="v-pills-overview"
                   aria-selected="true">overview</a>
                <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile"
                   aria-selected="false">Profile</a>
                <a class="nav-link" id="v-pills-securty-tab" data-toggle="pill" href="#v-pills-securty" role="tab" aria-controls="v-pills-securty"
                   aria-selected="false">securty</a>
            </div>
        </div>
        <div class="col-md-10">
            <div class="tab-content" id="v-pills-tabContent">
                <div class="tab-pane fade show active" id="v-pills-overview" role="tabpanel" aria-labelledby="v-pills-overview-tab">
                    <div class="card">
                        <div class="card-body table-responsive" style="overflow-x: scroll;">
                            <h5 class="card-title">签到概览</h5>
                            <table class="table" >
                                <svg id="calendar-graph" xmlns="http://www.w3.org/2000/svg" width="768px">
                                </svg>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Avatar setting</h5>
                            <form>
                                <div class="row ">
                                    <div class="form-group col-md-6">
                                        占位符
                                    </div>
                                </div>
                            </form>
                            <h5 class="card-title">个人信息</h5>
                            <form role="form" action="UpdateProfileServlet" method="post">
                                <div class="row ">
                                    <div class="form-group col-md-6">
                                        <label for="username" class="col-form-label">账号</label>
                                        <input type="text" class="form-control" id="username" name="username" required readonly minlength="6" maxlength="20" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="uemail" class="col-form-label">邮箱</label>
                                        <input type="email" class="form-control" id="uemail" name="uemail" readonly required/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="real_name" class="col-form-label">姓名</label>
                                        <input type="text" class="form-control" id="real_name" name="real_name" required/>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="user_no" class="col-form-label">学号</label>
                                        <input type="tel" class="form-control" id="user_no" name="user_no" required onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                                               onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"
                                        />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="school" class="col-form-label">学校</label>
                                        <input type="text" class="form-control" id="school" name="school" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="dept" class="col-form-label">学院</label>
                                        <input type="text" class="form-control" id="dept" name="dept" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="major" class="col-form-label">专业</label>
                                        <input type="text" class="form-control" id="major" name="major" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="class" class="col-form-label">班级</label>
                                        <input type="text" class="form-control" id="class" name="class" />
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success btn-block" style="margin-top: 20px"
                                        onclick="return validate()">
                                    保存修改
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-securty" role="tabpanel" aria-labelledby="v-pills-securty-tab">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">安全设置</h5>
                            <div class="row">
                                <form class="col-lg-6" action="UpdatePasswordServlet" method="post">
                                    <input type="hidden" id="updatePwdUserName" name="updatePwdUserName">
                                    <h6 class="card-title">更改密码</h6>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="currentPassword">Current Password</label>
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="Password">
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="newPassword">New Password</label>
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Password">
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="newPassword1">Confrim New Password</label>
                                            <input type="password" class="form-control" id="newPassword1" name="newPassword1" placeholder="Password">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success"
                                            onclick="return validate1()">
                                        保存修改
                                    </button>
                                </form>
                                <form class="col-lg-6">
                                    <h6 class="card-title">更改邮箱</h6>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="password1">Current Password</label>
                                            <input type="password" class="form-control" id="password1" placeholder="Password">
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="email1">Current Email</label>
                                            <input type="email" class="form-control" id="email1" name="email1" autofocus disabled required/>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="password2">New Email</label>
                                            <input type="email" class="form-control" id="user_email2" placeholder="Enter email">
                                        </div>
                                    </div>
                                    <a href="#" class="btn btn-primary">提交</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="footer.jsp" %>
<script>
    function validate() {
        var username = document.getElementById("username").value;
        var email = document.getElementById("email").value;
        var userNo = document.getElementById("user_no").value;
        var realname = document.getElementById("real_name").value;
        if (username.length == 0) {
            alert("用户名不能为空");
            return false;
        } else if (email.length == 0) {
            alert("邮箱不能为空");
            return false;
        } else if (userNo.length == 0) {
            alert("学号不能为空");
            return false;
        } else if (realname.length == 0) {
            alert("姓名不能为空");
            return false;
        }
        return true;
    }

    function validate1() {
        var currentPwd = document.getElementById("currentPassword").value;
        var pwd1 = document.getElementById("newPassword").value;
        var pwd2 = document.getElementById("newPassword1").value;
        if (currentPwd.length == 0) {
            alert("当前密码不能为空");
            return false;
        } else if (pwd1.length == 0 || pwd2.length == 0) {
            alert("新密码不能为空");
            return false;
        } else if (pwd1 != pwd2) {
            alert("新密码不一致");
            return false;
        }
        return true;
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
                    setTimeout("top.location.href = '" + url + "'",timeDelay);
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

    var res = "<%=request.getAttribute("updateProfileRes")%>";

    if (res == "succeed") {
        toastr.success("资料保存成功！");
    } else if (res == "failed") {
        toastr.error("抱歉，我们遇到了错误。请联系管理员。");
    }

</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/profile_calendar.js"></script>

<%
    if (userNow != null) {

        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"" + userNow + "\";</script>");
        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"profile.jsp\\\">设置</a>\";</script>");
//        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" onclick=\\\"sendRequestByPost2()\\\">登出</a>\";</script>");
    } else {
        out.println("<script>document.getElementById(\"navbardrop\").innerHTML=\"未登录\";</script>");
        out.println("<script>document.getElementById(\"dropdown-menu\").innerHTML = \"<a class=\\\"dropdown-item\\\" href=\\\"login.jsp\\\">登录</a><a class=\\\"dropdown-item\\\" href=\\\"register.jsp\\\">注册</a>\"</script>\n");
    }
%>

</body>
</html>
