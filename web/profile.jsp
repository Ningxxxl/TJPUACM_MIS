<%--
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
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/toastr.js/latest/toastr.min.js"></script>

</head>
<body>
<script type="text/javascript">
    function  sub(){
        $.ajax({
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;",
            type:"POST",
            url:"ShowProfileServlet",
            data:{userName:"sundehui"},
            statusCode: {404: function() {
                    alert('page not found'); }
            },
            success:function(data){
                $("#username").attr("placeholder",data.userName);
                $("#real_name").attr("value",data.userRealName);
                $("#email").attr("value",data.userEmail);
                $("#user_no").attr("value",data.userNo);
                $("#school").attr("value",data.userSchool);
                $("#dept").attr("value",data.userDept);
                $("#major").attr("value",data.userMajor);
                $("#class").attr("value",data.userClass);
            }
        });
    }
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
<input type="button" value="点击获取结果" id="btn" onclick="sub()">
<div class="container">
    <div class="row clearfix" style="margin-top: 30px">
        <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
            <div class="page-header">
                <h1>
                    修改个人信息
                    <small>Set your profile</small>
                </h1>
            </div>
            <form class="form-horizontal" role="form" action="RigisterServlet" method="post">
                <div class="form-group" style="margin-top: 30px">
                    <label for="username" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" name="username" required disabled minlength="6" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="email" name="email" autofocus disabled required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="real_name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="real_name" name="real_name" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="user_no" class="col-sm-2 control-label">学号</label>
                    <div class="col-sm-10">
                        <input type="tel" class="form-control" id="user_no" name="user_no" required
                               onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                               onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"
                        />
                    </div>
                </div>
                <%--<button type="button" class="btn btn-default btn-block" data-toggle="collapse"--%>
                        <%--data-target="#collapse_button" style="margin-bottom: 15px">--%>
                    <%--详细信息 Detailed Information--%>
                <%--</button>--%>
                <%--以下是非必填信息--%>
                <%--<div id="collapse_button" class="collapse">--%>
                    <div class="form-group">
                        <label for="school" class="col-sm-2 control-label">学校</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="school" name="school"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept" class="col-sm-2 control-label">学院</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="dept" name="dept"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="major" class="col-sm-2 control-label">专业</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="major" name="major"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="class" class="col-sm-2 control-label">班级</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="class" name="class"/>
                        </div>
                    </div>
                <%--</div>--%>
                <span id="warning" style="color: red">   </span>
                <button type="submit" class="btn btn-success btn-block" style="margin-top: 20px"
                        onclick="return validate()">
                    保存修改
                </button>
            </form>

        </div>
    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
