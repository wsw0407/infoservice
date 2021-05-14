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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
</head>
<body>

<div style="width: 300px;margin-left: 70px" class="layadmin-user-login-box layadmin-user-login-body layui-form">
    <h1 style="margin-bottom: 10px">完善用户信息（选填）</h1>
    <form class="layui-form" action="" >
        <div class="layui-form-item">
            <input type="hidden" name="id" value="${userid}">
            <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-realname"></label>
            <input type="text" name="realname" id="LAY-user-login-realname"  placeholder=姓名 class="layui-input">
        </div>

        <div class="layui-form-item">
            <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-phone"></label>
            <input type="text" name="phone" id="LAY-user-login-phone" lay-verify="phone" placeholder="电话" class="layui-input">
        </div>

        <div class="layui-form-item">
            <label class="layadmin-user-login-icon layui-icon layui-icon-email" for="LAY-user-login-email"></label>
            <input type="text" name="email" id="LAY-user-login-email" lay-verify="email" placeholder="邮箱" class="layui-input">
        </div>

        <div class="layui-form-item">
            <label class="layadmin-user-login-icon layui-icon layui-icon-location" for="LAY-user-login-address"></label>
            <input type="text" name="address" id="LAY-user-login-address" placeholder="住址" class="layui-input">
        </div>


        <div class="layui-form-item" style="margin-left: -67px">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio"  name="sex" value="1" title="男" checked="">
                <input type="radio" name="sex" value="2" title="女">
            </div>
        </div>


        <div class="layui-form-item" style="margin-left: -67px;margin-right: 5px">
                <label class="layui-form-label" >专业</label>
                <div class="layui-input-block">
                    <select id="majarSelect"  name="majarId"  lay-filter="majar">
                        <option value="">选择专业</option>

                    </select>
                </div>
        </div>

        <div class="layui-form-item" style="margin-left: -67px;margin-right: 5px">
            <label class="layui-form-label" >班级</label>
            <div class="layui-input-block">
                <select id="adminClass" name="inclass">
                    <option value="">选择班级</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="margin-left: 55px">
            <button class="layui-btn" lay-submit="" lay-filter="LAY-user-reg-submit">立即提交</button>
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
        var admin = layui.admin
            ,form = layui.form
            ,router = layui.router();

        form.render();

        /* 自定义验证规则 */
        form.verify({
            pass: [/(.+){4,12}$/, '密码必须4到12位']
            ,phone:[/^$|^1d{10}$/,"请输入正确的手机号"]
            ,email:[/^$|^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,"邮箱格式不正确"]
        });

        form.on('select(majar)', function(data){

            var majarid = data.value
            $.get("${pageContext.request.contextPath}/adminclass/listById?id="+majarid,function(data){
                console.log(data)
                $("#adminClass").empty();
                $('#adminClass').append($('<option value="">选择班级</option>'))
                if(data.length > 0){
                    data.forEach(function(e){
                        var node = '<option value='+e.id+'>'+e.classnum+'</option>'
                        $('#adminClass').append($(node))
                    });
                }else {
                    $('#adminClass').append($('<option value="0">本专业暂无班级</option>'))
                }
                layui.form.render("select");//重新渲染 固定写法
            });
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
                url: '${pageContext.request.contextPath}/users/addUser'//实际使用请改成服务端真实接口
                ,data: field
                ,done: function(res){
                    //alert(res)
                    layer.msg('添加成功', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        location.href = '${pageContext.request.contextPath}/users/listpage'; //跳转到登入页
                    });
                }
            });
            return false;
        });
    });


    $.get("${pageContext.request.contextPath}/majar/listAll",function(data){

        data.forEach(function(e){
            var node = '<option value='+e.id+'>'+e.majarname+'</option>'
            $('#majarSelect').append($(node))
        });
        //layui.form.render("select");//重新渲染 固定写法
    });



</script>
</body>
</html>