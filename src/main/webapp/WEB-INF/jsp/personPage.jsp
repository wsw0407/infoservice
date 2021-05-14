<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人主页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/template.css" media="all">

</head>
<body>
<div class="layui-fluid layadmin-homepage-fluid" >
    <div class="layui-row layui-col-space8 " style="width: 93%;margin: auto;">
        <div class="layui-col-md2" style="width: 20%">
            <div class="layadmin-homepage-panel layadmin-homepage-shadow" style="min-height: 650px;">
                <div class="layui-card text-center">
                    <div class="layui-card-body">
                        <div class="layadmin-homepage-pad-ver">
                            <img onclick="uploadIcon()" id="picPlay" class="layadmin-homepage-pad-img" title="点击修改头像" src="${pageContext.request.contextPath}${accountVo.pic == null ? '/images/001.gif':accountVo.pic}" width="100" height="100">
                        </div>
                        <h4 class="layadmin-homepage-font">${accountVo.realname}</h4>

                        <div class="layadmin-homepage-pad-ver">
                            <a href="javascript:;" class="layui-icon layui-icon-cellphone"></a>
                            <a href="javascript:;" class="layui-icon layui-icon-vercode"></a>
                            <a href="javascript:;" class="layui-icon layui-icon-login-wechat"></a>
                            <a href="javascript:;" class="layui-icon layui-icon-login-qq"></a>
                        </div>

                    </div>
                </div>
                <div style="padding-left: 10px">
                    <p class="layadmin-homepage-about">
                        关于我
                    </p>
                    <ul class="layadmin-homepage-list-group">
                        <li class="list-group-item"><i class="layui-icon layui-icon-location"></i>${accountVo.address}</li>
                        <li class="list-group-item"><i class="layui-icon layui-icon-cellphone"></i>${accountVo.phone}</li>
                        <li class="list-group-item"><i class="layui-icon layui-icon-email"></i>${accountVo.email}</li>

                    </ul>
                    <div class="layadmin-homepage-pad-hor" style="height: 100px;padding-top: 20px">
                        <mdall >暂无详细介绍</mdall>
                    </div>
                    <p class="layadmin-homepage-about">
                        个人爱好
                    </p>
                    <ul class="layadmin-homepage-list-inline">
                        <a href="javascript:;" class="layui-btn layui-btn-primary">足球</a>
                        <a href="javascript:;" class="layui-btn layui-btn-primary">电影</a>
                        <a href="javascript:;" class="layui-btn layui-btn-primary">摄影</a>
                        <a href="javascript:;" class="layui-btn layui-btn-primary">旅行</a>
                        <a href="javascript:;" class="layui-btn layui-btn-primary">热爱梦想</a>
                    </ul>
                </div>

            </div>
        </div>
        <div class="layui-col-md9" style="width: 80%">
            <div class="layadmin-homepage-panel layadmin-homepage-shadow" style="height: 650px;">
                <div class="layui-card">
                    <div class="layui-card-body">
                            基本资料
                    </div>
                </div>
                <div style="width: 300px;margin-left: 10%;" class="layadmin-user-login-box layadmin-user-login-body layui-form">
                    <%--    <h1 style="margin-bottom: 10px">修改用户账号信息</h1>--%>
                    <form id="myform" class="layui-form" action="${pageContext.request.contextPath}/users/personInfo" >

                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon" style="font-size: 10px" for="LAY-user-login-account">账号</label>
                            <input type="text" name="account" id="LAY-user-login-account" lay-verify="required" placeholder="账号" class="layui-input" value="${accountVo.account == null ? '未登录':accountVo.account}">

                        </div>

                        <div class="layui-form-item">
                            <input type="hidden" name="userid" id="userid" value="${accountVo.userid}">
                            <input type="hidden" name="id" id="id" value="${accountVo.id}">
                            <label class="layadmin-user-login-icon layui-icon" style="font-size: 10px" for="LAY-user-login-realname">姓名</label>
                            <input type="text"  name="realname" id="LAY-user-login-realname"  placeholder=姓名 class="layui-input" value="${accountVo.realname}">
                        </div>

                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon" style="font-size: 10px" for="LAY-user-login-username">昵称</label>
                            <input type="text" name="username" id="LAY-user-login-username"  placeholder=昵称 class="layui-input" value="${accountVo.username}">
                        </div>
                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-username"></label>
                            <input type="text" name="phone" id="LAY-user-login-phone" lay-verify="phone"  placeholder=手机号 class="layui-input" value="${accountVo.phone}">
                        </div>
                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-email" for="LAY-user-login-username"></label>
                            <input type="text" name="email" id="LAY-user-login-email" lay-verify="email" placeholder=邮箱 class="layui-input" value="${accountVo.email}">
                        </div>

                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-location" for="LAY-user-login-address"></label>
                            <input type="text" name="address"  id="LAY-user-login-address"  placeholder=住址 class="layui-input" value="${accountVo.address}">
                        </div>

                        <div class="layui-form-item" style="margin-left: -67px;margin-right: 5px">
                            <label class="layui-form-label" >性别</label>
                            <div class="layui-input-block">
                                <select id="sex"  name="sex"  lay-filter="majar">
                                    <option ${accountVo.sex == 1 ? "selected" : ""}  value="1">男</option>
                                    <option ${accountVo.sex == 2 ? "selected" : ""}  value="2">女</option>
                                </select>
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
                            <button type="button" id="personaInfo" class="layui-btn" lay-submit="" lay-filter="LAY-user-reg-submit">修改信息</button>

                        </div>


                    </form>


                </div>

            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

<script>
    var majar = '${accountVo.majarId}'
    var classid = '${accountVo.inclass}'

        $.get("${pageContext.request.contextPath}/majar/listAll",function(data){
            data.forEach(function(e){
                var node = '<option value='+e.id+'>'+e.majarname+'</option>'
                if(majar == e.id){
                    node = '<option selected value='+e.id+'>'+e.majarname+'</option>'
                }
                $('#majarSelect').append($(node))
            });
            //layui.form.render("select");//重新渲染 固定写法
        });

    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user', 'table'], function(){
        var admin = layui.admin
            ,form = layui.form
            ,table = layui.table
            ,router = layui.router();

        form.on('select(majar)', function(data){
            var majarid = data.value
            classSelect(majarid)
        });

        form.on('submit(LAY-user-reg-submit)', function(obj){
            var field = obj.field;

            //$("#myform").submit();
            $.post("${pageContext.request.contextPath}/users/personInfo",field, (res) => {

                if(res){
                    layer.msg('修改成功,部分数据需要刷新加载', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        location.href = '${pageContext.request.contextPath}/users/personPage?id='+field.id; //跳转到登入页
                    });
                }else {
                    layer.msg('修改失败', {
                        offset: '15px'
                        ,icon: 2
                        ,time: 1000
                    });
                }

            })
            return false;
        });

        function classSelect(majarid){
            $.get("${pageContext.request.contextPath}/adminclass/listById?id="+majarid,function(data){
                console.log(data)
                $("#adminClass").empty();
                $('#adminClass').append($('<option value="">选择班级</option>'))
                if(data.length > 0){
                    data.forEach(function(e){
                        var node = '<option value='+e.id+'>'+e.classnum+'</option>'
                        if(classid == e.id){
                            node = '<option selected value='+e.id+'>'+e.classnum+'</option>'
                        }
                        $('#adminClass').append($(node))
                    });
                }else {
                    $('#adminClass').append($('<option value="0">本专业暂无班级</option>'))
                }
                layui.form.render("select");//重新渲染 固定写法
            });
        }

        classSelect(majar)

    })

    function uploadIcon(){
        layer.open({
            type: 2
            ,title: '上传头像'
            ,shadeClose: true
            ,content: '${pageContext.request.contextPath}/users/touploadIcon'
            ,maxmin: true
            ,area: ['500px', '550px']
            ,end:function () {

               //$("#picPlay").attr("src",'')
            }
            ,success : function(layero, index){

            }
        })
    }






</script>
</body>
</html>