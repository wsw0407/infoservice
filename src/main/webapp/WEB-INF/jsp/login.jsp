<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>大学生校园信息服务系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all"> <style>
    body{
        margin: 0;
        padding: 0;
    }
    html,body {
        height: 100%;
    }
    .goindex :hover{
        color: #0b94ea !important;
    }
</style>
</head>
<body style="background: #040D21;z-index:-100;">
<iframe style="z-index:10;height: 100%;" src="${pageContext.request.contextPath}/earth/ref/index_ref.html" frameborder="0" class="layadmin-iframe"></iframe>

<img style="position:absolute;right: 0;bottom:0;height: 300px;z-index: 1000" src="${pageContext.request.contextPath}/earth/astro-mona.svg">
<img style="position:absolute;top:0;height: 100px;z-index: 1000" src="${pageContext.request.contextPath}/earth/logo.png">

<div style="position:absolute;right:0;z-index:100;width: 60%;height: 100%;">

    <div class="layui-card" style ="float:right;margin-right:30%;margin-top:15%;width: 380px;border: 10px solid #ccc;background: rgba(255,255,255,0.9);height: 500px">
        <div class="layui-card-header" style="padding: 5px 10px" id="card-header">
            <h1 style="color: white">系统登录</h1>
            <div class="layui-trans layui-form-item layadmin-user-login-other" style="margin-top: -50px;">

                <a href="${pageContext.request.contextPath}/front/index" target="_blank" class="goindex"  style="float:right;color: #524141 !important;">去前台</a>
            </div>
        </div>
        <div class="layui-card-body">
            <div style="width: 300px;" class="layadmin-user-login-box layadmin-user-login-body layui-form">
                <form method="post" class="layui-form">
                    <div class="layui-form-item">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
                        <input type="text" name="account" id="LAY-user-login-username" lay-verify="required" placeholder="账号" class="layui-input" value="admin">
                    </div>
                    <div class="layui-form-item">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                        <input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码" class="layui-input" value="admin123">
                    </div>

                    <%--   <div class="layui-form-item">
                           <input type="radio" name="role" value="Admin" title="Admin">
                           <input type="radio" name="role" value="User" title="User" >
                       </div>--%>

                    <div class="layui-form-item">
                        <div id="slider"></div>
                    </div>

                    <div class="layui-form-item" style="height: 20px">
                        <input type="checkbox" name="remember" lay-skin="primary" title="记住密码">
                        <a href="${pageContext.request.contextPath}/toForgotPwd" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;">忘记密码？</a>                        </div>

                    <div class="layui-form-item">
                        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
                    </div>
                    <div class="layui-trans layui-form-item layadmin-user-login-other">

                        <a href="${pageContext.request.contextPath}/toregister" class="layadmin-user-jump-change layadmin-link">注册帐号</a>
                    </div>

                </form>
            </div>

        </div>
    </div>

</div>






<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script>

    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user','sliderVerify','jquery'], function(){
        var $ = layui.$
            ,setter = layui.setter
            ,admin = layui.admin
            ,form = layui.form
            ,router = layui.router()
            ,search = router.search
            ,sliderVerify=layui.sliderVerify;

        var slider = sliderVerify.render({
            elem: '#slider',
            onOk: function(){//当验证通过回调
                layer.msg("滑块验证通过");
            }
        })
        //监听提交
        form.on('submit()', function(data) {
            if(slider.isOk()){//用于表单验证是否已经滑动成功
                //layer.msg(JSON.stringify(data.field));
            }else{
                layer.msg("请先通过滑块验证");
            }
            return false;
        });

        form.render();

        //提交
        form.on('submit(LAY-user-login-submit)', function(obj){

            // if($('input:radio[name="role"]:checked').val()==null){
            //     layer.msg("请选择角色");
            //     return;
            // }
            //请求登入接口
            var data = obj.field
            console.log(data)
            $.post("${pageContext.request.contextPath}/login",data, (res) => {
                console.log(res)
                if(res.isExist == true){
                    //登入成功的提示与跳转
                    layer.msg('登入成功', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        if(res.role == "admin"){
                            location.href = '${pageContext.request.contextPath}/index'; //后台主页
                        }else {
                            location.href = '${pageContext.request.contextPath}/users/index'; //后台主页
                        }

                    });
                }  else{
                    //登入成功的提示与跳转
                    slider.reset();
                    layer.msg('账号或密码错误', {
                        offset: '10%'
                        ,icon: 2
                        ,time: 1000
                    }, function(){

                    });

                }

            })

            /*admin.req({
                 url: '/login'
                ,data: obj.field
                ,error: function () {
                    layer.msg('登入失败');
                }
                ,done: function(res){
                    if(res.data!=null){
                        //登入成功的提示与跳转
                        layer.msg('登入成功', {
                            offset: '15px'
                            ,icon: 1
                            ,time: 1000
                        }, function(){
                            location.href = '/index'; //后台主页
                        });
                    }  else{
                        //登入成功的提示与跳转
                        layer.msg('登入失败', {
                            offset: '15px'
                            ,icon: 2
                            ,time: 1000
                        }, function(){
                            location.href = '/'; //后台主页
                        });
                    }
                }
            });*/

        });

    });
</script>
</body>
</html>
