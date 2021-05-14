<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加专业</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
</head>
<body>

<div style="width: 500px;margin-left: 10px;margin-top: 20px" class="layadmin-user-login-box layadmin-user-login-body layui-form">

    <form class="layui-form" action="" >
        <div class="layui-form-item" style="width: 400px;">
            <label class="layui-form-label">学　　院</label>
            <div class="layui-input-block">
                <input type="hidden" name="id" value="${majar.id}">
                <input type="text" name="institute" autocomplete="off" placeholder="请输入学院" class="layui-input" value="${majar.institute}">
            </div>
        </div>

        <div class="layui-form-item" style="width: 400px;">
            <label class="layui-form-label">专　　业</label>
            <div class="layui-input-block">
                <input type="text" name="majarname" autocomplete="off" placeholder="请输入专业" class="layui-input" value="${majar.majarname}">
            </div>
        </div>

        <div class="layui-form-item" style="width: 400px;">
            <label class="layui-form-label">学院代码</label>
            <div class="layui-input-block">
                <input type="text" name="institnum" autocomplete="off" placeholder="请输入学院代码" class="layui-input" value="${majar.institnum}">
            </div>
        </div>

        <div class="layui-form-item" style="margin-left: 110px">
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


        //提交
        form.on('submit(LAY-user-reg-submit)', function(obj){
            var field = obj.field;
            console.log(field)
            //请求接口
            admin.req({
                url: '${pageContext.request.contextPath}/majar/add'//实际使用请改成服务端真实接口
                ,data: field
                ,done: function(res){
                    //alert(res)
                    layer.msg('操作成功', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        //let info = parent.layui.table
                        //console.log(info)
                        //parent.layui.table.reload();
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);//关闭当前弹窗页面
                        parent.$('#queryRole').trigger("click","5");
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