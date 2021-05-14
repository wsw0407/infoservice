<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
</head>
<body>

<div style="width: 400px;margin: auto" class="layadmin-user-login-box layadmin-user-login-body layui-form">

    <form method="post" class="layui-form" style="margin-top: 50px;">
        <div class="layui-form-item">
            <label class="layadmin-user-login-icon layui-icon layui-icon-user" for="LAY-user-login-account"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
            <input type="hidden" id="accountid" name="accountid" value="${ACCOUNT_SESSION.id}">
            <input type="text" name="account" disabled id="LAY-user-login-account" lay-verify="required" placeholder="账号" class="layui-input" value="${ACCOUNT_SESSION == null ? "未登录":ACCOUNT_SESSION.account}">
        </div>
        <div class="layui-form-item" style="margin-top: 10px">
            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
            <input type="password" name="oldpassword" id="LAY-user-login-oldpassword" lay-verify="pass" placeholder="原密码" class="layui-input" value="">
        </div>
        <div class="layui-form-item" style="margin-top: 10px">
            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
            <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="新密码密码4到12位" class="layui-input" >
        </div>
        <div class="layui-form-item">
            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-repass"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
            <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input">
        </div>

        <div class="layui-form-item" style="margin-top: 20px">
            <button type="button" class="layui-btn" style="width: 200px;margin-left: 23%"  lay-submit lay-filter="repassword">
                &emsp;修改密码&emsp;
            </button>
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
        form.on('submit(repassword)', function(obj){
            var field = obj.field;
            //确认密码
            console.log(field)

            if(field.account === "未登录"){
                layer.msg('　请先登录',{ icon: 2,time: 1000 });
                return false;
            }

            if(field.oldpassword !== field.password){
                layer.msg('原密码错误',{ icon: 2,time: 1000 });
                return false;
            }

            if(field.password !== field.repass){
                layer.msg('两次密码输入不一致');
                return false;
            }

            $.post('${pageContext.request.contextPath}/users/rePassword', field, function (data) {
                console.log(typeof data)
                if(data){
                    layer.msg("修改成功,请重新登录", {icon: 1, shade: 0, time: 1300},function () {
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);//关闭当前弹窗页面
                        parent.location.href= "${pageContext.request.contextPath}/loginOut"
                    })
                }else {
                    layer.msg("修改失败", {icon: 2, shade: 0})
                }

            })

            return false;
        });
    });
</script>
</body>
</html>