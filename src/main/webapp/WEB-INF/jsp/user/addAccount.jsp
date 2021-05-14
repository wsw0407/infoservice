<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加账号</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
</head>
<body>

        <div style="width: 300px;margin-left:70px" class="layadmin-user-login-box layadmin-user-login-body layui-form">
           <h1 style="margin-bottom: 10px">添加账号</h1>
            <form method="post" class="layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-user" for="LAY-user-login-account"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                <input type="text" name="account" id="LAY-user-login-account" lay-verify="required" placeholder="账号" class="layui-input">

            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-repass"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-nickname"></label>
                <input type="text" name="username" id="LAY-user-login-nickname"  placeholder="昵称" class="layui-input">
            </div>

            <div class="layui-form-item" style="margin-left: 55px">
                <button class="layui-btn" type="button" lay-submit="" lay-filter="LAY-user-reg-submit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">　重置　</button>
            </div>


            </form>
        </div>




<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user'], function(){
        var $ = layui.$
            ,setter = layui.setter
            ,admin = layui.admin
            ,form = layui.form
            ,router = layui.router();

        form.render();

        /* 自定义验证规则 */
        form.verify({
           pass: [/(.+){4,12}$/, '密码必须4到12位']

        });

        //提交
        form.on('submit(LAY-user-reg-submit)', function(obj){
            var field = obj.field;
            //确认密码
            if(field.password !== field.repass){
                return layer.msg('两次密码输入不一致');
            }

            //请求接口
            admin.req({
                url: '${pageContext.request.contextPath}/users/addAccount'//实际使用请改成服务端真实接口
                ,data: field
                ,done: function(res){
                    console.log(res)
                    layer.msg('注册成功', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        location.href = '${pageContext.request.contextPath}/users/toaddUser?userid='+res.data.userid;
                    });
                }
            });
            return false;
        });
    });
</script>
</body>
</html>