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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>个人设置</title>

    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://cdn.bootcss.com/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <%--<script src="https://cdn.bootcss.com/jquery.form/4.2.2/jquery.form.min.js"></script>--%>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>
    <%--<link href="https://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">--%>
    <%--<script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>--%>
    <%--<script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/language/zh_CN.min.js"></script>--%>

</head>
<body>
<%
    //    获取当前用户
    String userNow = new UserServer().getUserNow(request);
    System.out.println("profile | " + userNow);
%>

<script type="text/javascript">

    $(document).ready(function showData() {

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
                $("#updateEmailUserName").attr("value", data.userName);
                $("#real_name").attr("value", data.userRealName);
                $("#uemail").attr("value", data.userEmail);
                $("#user_no").attr("value", data.userNo);
                $("#school").attr("value", data.userSchool);
                $("#dept").attr("value", data.userDept);
                $("#major").attr("value", data.userMajor);
                $("#class").attr("value", data.userClass);
            }
        });

        // $("#UpdatePasswordButton").on("click",function(){
        //     $("#UpdatePasswordForm").ajaxSubmit({
        //         url: 'UpdatePasswordServlet',
        //         type: 'post',
        //         dataType: 'json',
        //         beforeSubmit: function () {},
        //         success: function (data) {
        //             alert(data.updatePasswordRes);
        //             if(data.updatePasswordRes == "succeed") {
        //                 toastr.success("密码修改成功");
        //             } else {
        //                 toastr.warning("密码更新失败");
        //             }
        //         },
        //         clearForm: false,//禁止清除表单
        //         resetForm: false //禁止重置表单
        //     })
        // })

        var updatePasswordRes = "<%=request.getAttribute("updatePasswordRes")%>";
        var updateEmailRes = "<%=request.getAttribute("updateEmailRes")%>";
        var updateProfileRes = "<%=request.getAttribute("updateProfileRes")%>";

        if (updateProfileRes == "succeed") {
            toastr.success("资料修改成功");
        }
        if (updateEmailRes == "succeed") {
            toastr.success("邮箱修改成功");
        } else if (updateEmailRes == "failed") {
            toastr.warning("邮箱更新失败，请检查原密码/邮箱是否正确");
        }
        if (updatePasswordRes == "succeed") {
            toastr.success("密码修改成功");
        } else if (updatePasswordRes == "failed") {
            toastr.warning("密码更新失败，请检查原密码是否正确");
        }

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
                        <a class="dropdown-item" href="#" onclick="sendRequestByPost2()">登出</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="container mt-4">
    <div class="row">
        <div class="col-md-2 md-2">
            <img src="https://avatars3.githubusercontent.com/u/27630686?s=400&v=4" class="img-fluid md-2"
                 alt="Responsive image" style="-webkit-clip-path: circle(40% at center); clip-path: circle(40% at center);">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile"
                   aria-selected="true">Profile</a>
                <a class="nav-link" id="v-pills-securty-tab" data-toggle="pill" href="#v-pills-securty" role="tab" aria-controls="v-pills-securty"
                   aria-selected="false">securty</a>
            </div>
        </div>
        <div class="col-md-10">
            <div class="tab-content" id="v-pills-tabContent">
                <div class="tab-pane fade show active" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
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
                            <form role="form" action="UpdateProfileServlet" method="post" id="UpdateProfileForm">
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
                                        onclick="return validate()" id="UpdateProfileButton">
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
                                <form class="col-lg-6" action="UpdatePasswordServlet" method="post" id="UpdatePasswordForm">
                                    <input type="hidden" id="updatePwdUserName" name="updatePwdUserName">
                                    <h6 class="card-title">更改密码</h6>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="currentPassword">Current Password</label>
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword"
                                                   placeholder="Password" minlength="6" maxlength="20" required>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="newPassword">New Password</label>
                                            <input type="password" class="form-control" id="newPassword" name="newPassword"
                                                   placeholder="Password长度为6~20字符" minlength="6" maxlength="20" required>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="newPassword1">Confrim New Password</label>
                                            <input type="password" class="form-control" id="newPassword1" name="newPassword1"
                                                   placeholder="Password长度为6~20字符" minlength="6" maxlength="20" required>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success"
                                            onclick="return validate1()" id="UpdatePasswordButton">
                                        保存修改
                                    </button>
                                </form>
                                <form class="col-lg-6" action="UpdateEmailServlet" method="post">
                                    <input type="hidden" id="updateEmailUserName" name="updateEmailUserName">
                                    <h6 class="card-title">更改邮箱</h6>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="currentPassword1">Current Password</label>
                                            <input type="password" class="form-control" id="currentPassword1" name="currentPassword1"
                                                   placeholder="Password" minlength="6" maxlength="20" required>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="currentEmail">Current Email</label>
                                            <input type="email" class="form-control" id="currentEmail" name="currentEmail"
                                                   placeholder="Current Email" required/>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="form-group col-md-10">
                                            <label for="newEmail">New Email</label>
                                            <input type="email" class="form-control" id="newEmail" name="newEmail"
                                                   placeholder="Enter email" required>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success"
                                            onclick="return validate2()">
                                        保存修改
                                    </button>
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

    function validate2() {
        var currentPwd = document.getElementById("currentPassword1").value;
        var oldEmail = document.getElementById("currentEmail").value;
        var newEmail = document.getElementById("newEmail").value;
        if (currentPwd.length == 0) {
            alert("当前密码不能为空");
            return false;
        } else if (oldEmail.length == 0 || pwd2.length == 0) {
            alert("当前邮箱不能为空");
            return false;
        } else if (pwd1 != pwd2) {
            alert("新邮箱不能为空");
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

</script>

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
