<%--
  Created by IntelliJ IDEA.
  User: ningxy
  Date: 2018/4/18
  Time: 下午1:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录|Login</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/baiduTongji.js"></script>
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<%--<h4 style="color: red;"><%=session.getAttribute("msg")%></h4>--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">登录成功！</h4>
            </div>
            <div class="modal-body">按下 ESC 按钮退出。</div>
            <div class="modal-footer">
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                <a href="home.jsp"><button type="button" class="btn btn-primary">首页</button></a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel2">登录失败</h4>
            </div>
            <div class="modal-body">按下 ESC 按钮退出。</div>
            <div class="modal-footer">
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                <a href="login.jsp"><button type="button" class="btn btn-primary">重新登录</button></a>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--<h4 style="color: red;"><%=session.getAttribute("msg")%></h4>--%>
    <div class="row clearfix" style="margin-top: 30px">
        <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3" >
            <div class="page-header">
                <h1>
                    账户登录 <small>Login</small>
                </h1>
            </div>
            <form class="form-horizontal" role="form" action="LoginServlet" method="post">
                <div class="form-group" style="margin-top: 30px">
                    <label for="username" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" name="username" autofocus
                               placeholder="Username" required minlength="1" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="passwd" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="passwd" name="passwd"
                               placeholder="Password" required minlength="1" maxlength="20"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                            <label><input type="checkbox" name="isRemember"/>保持登录状态（3h）</label>
                            <a href="register.jsp">还没有账号？立即注册!</a>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-default btn-block" style="margin-top: 20px">立即登录</button>
            </form>

        </div>
    </div>
</div>
<script>
    var res = "<%=request.getAttribute("loginRes")%>";
    if(res == "failed")
    {
        $(function() {
            $('#myModal2').modal({
                keyboard: true
            })
        });
    }
    else if (res == "succeed") {
        $(function() {
            $('#myModal').modal({
                keyboard: true
            })
        });
    }

</script>
</body>
</html>

