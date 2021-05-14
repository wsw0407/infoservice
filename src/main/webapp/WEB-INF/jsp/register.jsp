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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/step-lay/step.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xm-select.js"></script>

    <style>
        #register_radio {
            position: absolute;
            left: 280px;
            top: 120px;
        }

        #radio_next {
            position: absolute;
            left: 240px;
            top: 300px;
        }

        #user_register {
            display: block;
            margin: 0 auto;
            max-width: 460px;
            padding-top: 40px;
        }

        html body{
            height: 100%;
        }
       .layui-anim-upbit{
            height: 255px;
           z-index: 11111111;
        }

    </style>

</head>
<body>

<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-fluid">
            <div class="layui-card">
                <div class="layui-card-body" style="padding-top: 40px;">
                    <div class="layui-carousel" id="stepForm" lay-filter="stepForm" style="margin: 0 auto;">
                        <div carousel-item style="overflow:visible !important">
                            <div>
                                <div style="width: 400px;margin: auto" class="layadmin-user-login-box layadmin-user-login-body layui-form">

                                    <form method="post" class="layui-form">
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-user" for="LAY-user-login-account"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="text" name="account" id="LAY-user-login-account" lay-verify="required" placeholder="账号" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-email" for="LAY-user-login-cellphone"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="text" name="phoneOReamail" id="LAY-user-login-cellphone" lay-verify="" placeholder="手机或邮箱" class="layui-input">
                                        </div>

                                        <div class="layui-form-item">
                                            <div class="layui-row">
                                                <div class="layui-col-xs7">
                                                    <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                                                           for="LAY-user-login-vercode"></label>
                                                    <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required"
                                                           placeholder="验证码" class="layui-input">
                                                </div>
                                                <div class="layui-col-xs5">
                                                    <div style="margin-left: 10px;">
                                                        <button type="button" class="layui-btn layui-btn-primary layui-btn-fluid"
                                                                id="LAY-user-getsmscode">获取验证码
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="layui-form-item" style="margin-top: 10px">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="密码4到12位" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-repass"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-nickname"></label>
                                            <input type="text" name="username" id="LAY-user-login-nickname"  placeholder="昵称" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <input type="checkbox" name="agreement" lay-skin="primary" title="同意用户协议" checked>
                                        </div>
                                        <div class="layui-form-item" id="radio_next" style="margin-left: 27%;margin-top: 60px">
                                            <div class="layui-input-block">
                                                <button class="layui-btn" lay-submit lay-filter="formStep">
                                                    &emsp;下一步&emsp;
                                                </button>
                                                <button type="reset" class="layui-btn layui-btn-primary">　重置　</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>



                            </div>

                            <%---/*************************************--%>

                            <%--用户注册表单--%>

                            <%---/*************************************--%>
                            <div style="padding-top: 15px;z-index: 999999;">

                                <div style="width: 400px;margin: auto" class="layadmin-user-login-box layadmin-user-login-body layui-form">

                                    <form class="layui-form" action="" >
                                        <div class="layui-form-item">
                                            <input type="hidden" id="userId" name="id" value="">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-realname"></label>
                                            <input type="text" name="realname" id="LAY-user-login-realname"  placeholder=姓名 class="layui-input">
                                        </div>

                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-location" for="LAY-user-login-address"></label>
                                            <input type="text" name="address" id="LAY-user-login-address" placeholder="住址" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">

                                            <label class="layadmin-user-login-icon layui-icon " for="LAY-user-login-realname"></label>
                                            <input type="text" name="age" id="LAY-user-login-age"  placeholder="年龄" class="layui-input">
                                        </div>

                                        <div class="layui-form-item" style="margin-left: -67px">
                                            <label class="layui-form-label">性别</label>
                                            <div class="layui-input-block">
                                                <input type="radio"  name="sex" value="1" title="男" checked="">
                                                <input type="radio" name="sex" value="2" title="女">
                                            </div>
                                        </div>


                                        <div class="layui-form-item" style="overflow:visible;margin-left: -67px;margin-right: 5px">
                                            <label class="layui-form-label" >专业</label>
                                            <div class="layui-input-block">
                                                <select id="majarSelect" style="height: 100px"  name="majarId"  lay-filter="majar">

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


                                        <div class="layui-form-item">
                                            <div class="layui-input-line" style="float: right">
                                                <button class="layui-btn" lay-submit lay-filter="formStep2">
                                                    &emsp;下一步&emsp;
                                                </button>
                                                <button type="reset" class="layui-btn layui-btn-primary">　重置　</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>


                            </div>

                            <div style="width: 100%;">
                                <div style="text-align: center;margin-top: 90px;">
                                    <i class="layui-icon layui-circle"
                                       style="color: white;font-size:30px;font-weight:bold;background: #52C41A;padding: 20px;line-height: 80px;">&#xe605;</i>
                                    <div style="font-size: 24px;color: #333;font-weight: 500;margin-top: 30px;">
                                        注册成功
                                    </div>
                                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/'" style="margin-top: 20px" class="layui-btn">
                                        &emsp;去登陆&emsp;
                                    </button>
                                </div>

                            </div>


                        </div>
                    </div>
                    <hr>
                    <div style="color: #666;margin-top: 30px;margin-bottom: 40px;padding-left: 30px;">
                        <h4>目前对管理员的注册功能暂时不开启</h4>
                        <p>如果想要成为管理员可以联系我们的boss,他的邮箱是1075512441@qq.com</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script>
    var userId = ""
    var myForm
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index', //主入口模块
        step:'step-lay/step'
    }).use(['form', 'step', 'laydate','index', 'user'], function () {
        var $ = layui.$,
            form = layui.form,
            admin = layui.admin,
            laydate = layui.laydate,
            step = layui.step;
        this.myForm = layui.form;

        laydate.render({
            elem: '#LAY-component-form-group-date',
            type: 'date',
            trigger: 'click'
        });

        laydate.render({
            elem: '#LAY-component-form-group-date2',
            type: 'date',
            trigger: 'click'
        });

        form.verify({
            pass: [/(.+){4,12}$/, '密码必须4到12位']

        });


        step.render({
            elem: '#stepForm',
            filter: 'stepForm',
            width: '100%', //设置容器宽度
            stepWidth: '750px',
            height: '490px',
            stepItems: [{
                title: '注册账号'
            }, {
                title: '完善信息'
            }, {
                title: '注册完成'
            }]
        });
        form.on('submit(formStep)', function (obj) {
            var field=obj.field;
            console.log(field)
            //确认密码
            if(!field.agreement){
                layer.msg('你必须同意用户协议才能注册');
                return false;
            }

            if(field.password !== field.repass){
                layer.msg('两次密码输入不一致');
                return false;
            }


            $.ajax({
                type:"post",
                data:field,
                dataType:"json",
                url:"${pageContext.request.contextPath}/users/registerAccount",
                success:function (data) {
                   if(!data.data){
                       layer.msg(data.msg, {icon: 2, shade: 0})
                   }else {
                       userId = data.data
                       $("#userId").val(userId)
                       step.next('#stepForm');
                   }
                }
            })
            return false;
        });
        //用户提交表单监听
        form.on('submit(formStep2)', function (data) {
            var field  = data.field
            console.log(field)

            admin.req({
                url: '${pageContext.request.contextPath}/users/registerUser'//实际使用请改成服务端真实接口
                ,data: field
                ,done: function(res){
                    //alert(res)
                    layer.msg('添加成功', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    }, function(){
                        step.next('#stepForm');
                    });
                }
            });

            return false;
        });




        $('.pre').click(function () {
            step.pre('#stepForm');
        });

        $('.next').click(function () {
            step.next('#stepForm');
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

        $.get("${pageContext.request.contextPath}/majar/listAll",function(data){
            data.forEach(function(e){
                var node = '<option value='+e.id+'>'+e.majarname+'</option>'
                $('#majarSelect').append($(node))
            });
            layui.form.render("select");//重新渲染 固定写法
        });
    })





    //以下代码搬进admin.js源码中了
 /*    var flag2 = 1 //标志位1代表此刻去获取了可用的验证码，并随着下面的倒计时结束，置成0，表示此验证码已经过期
        function getCode() {
            flag = 1 //把过期置成0的flag置成1
            var phone = $('#LAY-user-login-cellphone').val()
            $.post('/getCode', {phone: phone}, function (res) {
                setTimeout(function () {
                    flag = 0
                }, 60000)
            })
        }
*/
</script>

</body>
</html>