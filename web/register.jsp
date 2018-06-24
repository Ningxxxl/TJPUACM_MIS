<%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/4/19
  Time: 下午1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册|Register</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="js/baidu_tongji.js"></script>
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">注册成功！</h4>
            </div>
            <div class="modal-body">按下 ESC 按钮退出。</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a href="login.jsp">
                    <button type="button" class="btn btn-primary">登录</button>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel2">用户名已存在！</h4>
            </div>
            <div class="modal-body">按下 ESC 按钮退出。</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a href="register.jsp">
                    <button type="button" class="btn btn-primary">重新注册</button>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row clearfix" style="margin-top: 30px">
        <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
            <div class="page-header">
                <h1>
                    账户注册
                    <small>Register</small>
                </h1>
            </div>
            <form class="form-horizontal" role="form" action="RigisterServlet" method="post">
                <div class="form-group" style="margin-top: 30px">
                    <label for="username" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" name="username"
                               placeholder="Username 长度6~20字符" required autofocus minlength="6" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="passwd1" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="passwd1" name="passwd1"
                               placeholder="Password 长度6~20字符" required minlength="6" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="passwd2" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="passwd2" name="passwd2"
                               placeholder="Confirm your password" required minlength="6" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="email" name="email"
                               placeholder="Email" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="real_name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="real_name" name="real_name"
                               placeholder="Real Name" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="user_no" class="col-sm-2 control-label">学号</label>
                    <div class="col-sm-10">
                        <input type="tel" class="form-control" id="user_no" name="user_no"
                               placeholder="Student ID" required
                               onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                               onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"
                        />
                    </div>
                </div>
                <button type="button" class="btn btn-default btn-block" data-toggle="collapse"
                        data-target="#collapse_button" style="margin-bottom: 15px">
                    详细信息 Detailed Information
                </button>
                <%--以下是非必填信息--%>
                <div id="collapse_button" class="collapse">
                    <div class="form-group">
                        <label for="school" class="col-sm-2 control-label">学校</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="school" name="school"
                                   placeholder="School"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept" class="col-sm-2 control-label">学院</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="dept" name="dept"
                                   placeholder="Department"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="major" class="col-sm-2 control-label">专业</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="major" name="major"
                                   placeholder="Major"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="class" class="col-sm-2 control-label">班级</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="class" name="class"
                                   placeholder="Class"/>
                        </div>
                    </div>
                </div>
                <span id="warning" style="color: red">   </span>
                <button type="submit" class="btn btn-success btn-block" style="margin-top: 20px"
                        onclick="return validate()">
                    立即注册 Register Now
                </button>
            </form>

        </div>
    </div>
</div>

<script>

    $("#passwd2").blur(
        function pre_validate_pwd() {
            var pwd1 = document.getElementById("passwd1").value;
            var pwd2 = document.getElementById("passwd2").value;

            if (pwd1 != pwd2 || pwd1.length == 0) {
                // document.getElementById("warning").innerHTML = "两次密码不一致或密码为空";
                document.getElementById("warning").innerHTML =
                    "<div id=\"myAlert\" class=\"alert alert-warning\">\n" +
                    "\t<a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                    "\t<strong>两次密码不一致或密码为空\n" +
                    "</div>";
            }
            else {
                document.getElementById("warning").innerHTML = "";
            }
        }
    );

    $("#email").blur(
        function pre_validate_email() {
            var email = document.getElementById("email").value;

            if (email.length == 0) {
                // document.getElementById("warning").innerHTML = "邮箱不能为空";
                document.getElementById("warning").innerHTML =
                    "<div id=\"myAlert\" class=\"alert alert-warning\">\n" +
                    "\t<a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                    "\t<strong>邮箱不能为空\n" +
                    "</div>";
            }
        }
    );

    $("#real_name").blur(
        function pre_validate_email() {
            var email = document.getElementById("email").value;

            if (email.length == 0) {
                // document.getElementById("warning").innerHTML = "姓名不能为空";
                document.getElementById("warning").innerHTML =
                    "<div id=\"myAlert\" class=\"alert alert-warning\">\n" +
                    "\t<a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                    "\t<strong>姓名不能为空\n" +
                    "</div>";
            }
        }
    );

    $("#user_no").blur(
        function pre_validate_email() {
            var userNo = document.getElementById("user_no").value;

            if (userNo.length == 0) {
                // document.getElementById("warning").innerHTML = "学号不能为空";
                document.getElementById("warning").innerHTML =
                    "<div id=\"myAlert\" class=\"alert alert-warning\">\n" +
                    "\t<a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                    "\t<strong>学号不能为空\n" +
                    "</div>";
            }
        }
    );

    function validate() {
        if (document.getElementById("username").value.length == 0) {
            alert("用户名不能为空");
            return false;
        }
        var pwd1 = document.getElementById("passwd1").value;
        var pwd2 = document.getElementById("passwd2").value;
        var email = document.getElementById("email").value;
        var userNo = document.getElementById("user_no").value;
        if (pwd1 != pwd2) {
            alert("两次密码不一致!");
            return false;
        }
        if (pwd.length == 0) {
            alert("密码不能为空");
            return false;
        }
        if (email.length == 0) {
            alert("邮箱不能为空");
            return false;
        }
        if (userNo.length == 0) {
            alert("学号不能为空");
            return false;
        }
    }

    var res = "<%=request.getAttribute("registerRes")%>";
    if (res != null && res == "exist") {
        $(function () {
            $('#myModal2').modal({
                keyboard: true
            })
        });
    }
    else if (res != null && res == "succeed") {
        $(function () {
            $('#myModal').modal({
                keyboard: true
            })
        });
    }
</script>
</body>
</html>
