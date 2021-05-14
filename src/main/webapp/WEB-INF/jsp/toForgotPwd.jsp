<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>忘记密码</title>
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

        #sendcode{
            color: #999999;
            cursor: pointer;
        }

        #sendcode:hover{
            color: #0b94ea;
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
                                <div style="width: 400px;margin: auto;" class="layadmin-user-login-box layadmin-user-login-body layui-form">

                                    <form method="post" class="layui-form" style="margin-top: 100px">
                                        <p style="color:#999999;">请通过输入 您 绑定的手机号码/邮箱重置您的帐号密码</p>

                                        <div class="layui-form-item" style="margin-top: 20px">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-email" for="LAY-user-login-cellphone"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="text"  name="phoneOReamail" id="LAY-user-login-cellphone" lay-verify="required" lay-reqText="请输入手机或邮箱" placeholder="手机或邮箱" class="layui-input">
                                        </div>

                                        <div class="layui-form-item" style="margin-top: 20px">

                                            <button type="button" class="layui-btn" style="width: 200px;margin-left: 20%"  lay-submit lay-filter="formStep">
                                                &emsp;找回密码&emsp;
                                            </button>
                                        </div>
                                    </form>
                                </div>
                           </div>

                            <%---/*************************************--%>

                            <%--用户注册表单--%>

                            <%---/*************************************--%>
                            <div style="padding-top: 15px;z-index: 999999;">

                                <div style="width: 400px;margin: auto" class="layadmin-user-login-box layadmin-user-login-body layui-form">

                                    <form class="layui-form" action=""  style="margin-top: 100px">

                                        <div class="layui-form-item" style="margin-top: 20px">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-key" for="LAY-user-login-cellphone"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="text"  name="verifycode" id="verifycode" lay-verify="required" lay-reqText="请输入验证码" placeholder="验证码" class="layui-input">
                                        </div>

                                        <div class="layui-form-item" style="margin-top: 20px">

                                            <button type="button" class="layui-btn" style="width: 200px;margin-left: 20%"  lay-submit lay-filter="formStep2">
                                                &emsp;验证&emsp;
                                            </button>
                                        </div>
                                        <div class="layui-form-item" style="margin-top: 20px"></div>

                                        <p><span id="sendCode" style="float: right;margin-top: 100px"></span></p>
                                    </form>
                                </div>


                            </div>

                            <div>
                                <div style="width: 400px;margin: auto" class="layadmin-user-login-box layadmin-user-login-body layui-form">

                                    <form method="post" class="layui-form" style="margin-top: 50px">
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-user" for="LAY-user-login-account"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="hidden" id="accountid" name="accountid">
                                            <input type="text" name="account" disabled id="LAY-user-login-account" lay-verify="required" placeholder="账号" class="layui-input">
                                        </div>
                                        <div class="layui-form-item" style="margin-top: 10px">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="新密码密码4到12位" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-repass"><span style="color: red;float: left;margin-left: -20px;font-size: 24px;line-height: 40px">*</span></label>
                                            <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input">
                                        </div>

                                        <div class="layui-form-item" style="margin-top: 20px">
                                            <button type="button" class="layui-btn" style="width: 200px;margin-left: 23%"  lay-submit lay-filter="formStep3">
                                                &emsp;修改密码&emsp;
                                            </button>
                                        </div>

                                    </form>
                                </div>



                            </div>


                            <div style="width: 100%;">
                                <div style="text-align: center;margin-top: 90px;">
                                    <i class="layui-icon layui-circle"
                                       style="color: white;font-size:30px;font-weight:bold;background: #52C41A;padding: 20px;line-height: 80px;">&#xe605;</i>
                                    <div style="font-size: 24px;color: #333;font-weight: 500;margin-top: 30px;">
                                        密码找回成功
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
                        <h4>请通过输入 您 绑定的手机号码/邮箱重置您的帐号密码</h4>
                        <p>如果密码无法找回可以尝试联系我们的boss,他的邮箱是1075512441@qq.com</p>
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
    var verifycode = "";
    var sceond = 90;
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
            pass: [/(.+){4,12}$/, '密码必须4到12位'],
        });


        step.render({
            elem: '#stepForm',
            filter: 'stepForm',
            width: '100%', //设置容器宽度
            stepWidth: '750px',
            height: '450px',
            stepItems: [{
                title: '身份验证'
            }, {
                title: '开启验证'
            }, {
                title: '修改秘码'
            }, {
                title: '密码找回成功'
            }]
        });
        form.on('submit(formStep)', function (obj) {
            var field=obj.field;
            console.log(field)

            var n = $("#LAY-user-login-cellphone").val()

            if (!/^1\d{10}$/.test(n) && !/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(n)){
                layer.msg("请输入正确的手机号码（支持澳门台湾）或邮箱");
                return  false;
            }
            var msg = "验证码已发送至你的手机，请注意查收"
            var way = "phone"
            if(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(n)){
                msg = "验证码已发送至你的邮箱，请注意查收"
                way = "email"
            }
            $.post('${pageContext.request.contextPath}/isexist', {phoneOReamail: n}, function (res) {
                  if(res === "false"){
                      layer.msg("验证失败，用户不存在",{icon: 2, shade: 0});
                  }else {
                      layer.msg(msg, {icon: 1, shade: 0})
                      $.post('${pageContext.request.contextPath}/getCode', {phoneOReamail: n,way:way}, function (data) {
                          verifycode = data
                          console.log(verifycode)
                       var interval = setInterval(function () {
                              //console.log(sceond)
                              $("#sendCode").html((sceond--)+" 后可重新发送")
                           if(sceond === 55){
                               $("#sendCode").html(`<a onclick="sendcode()" id="sendcode">没有收到验证码?点此重发</a>`)
                               sceond = 90
                               clearInterval(interval);
                           }

                          },1000)
                          step.next('#stepForm');
                      })
                  }
            })
            return false;
        });

        //用户提交表单监听
        form.on('submit(formStep2)', function (data) {
            var field  = data.field
            console.log(field)
            var n = $("#LAY-user-login-cellphone").val()

            if(field.verifycode === verifycode ){
                layer.msg("验证通过", {icon: 1, shade: 0})
                $.post('${pageContext.request.contextPath}/getAccountByPoe', {phoneOReamail: n}, function (data) {
                    $("#LAY-user-login-account").val(data.account)
                    $("#accountid").val(data.id)
                    console.log(data)

                })
                step.next('#stepForm');
            }else {
                layer.msg("验证码错误", {icon: 2, shade: 0})
                return false;
            }
            return false;
        });

        form.on('submit(formStep3)', function (data) {
            var field  = data.field
            console.log(field)

            if(field.password !== field.repass){
                layer.msg('两次密码输入不一致');
                return false;
            }

            $.post('${pageContext.request.contextPath}/users/rePassword', field, function (data) {
                console.log(typeof data)
                if(data){
                    layer.msg("修改成功", {icon: 1, shade: 0})
                    step.next('#stepForm');
                }else {
                    layer.msg("修改失败", {icon: 2, shade: 0})
                }

            })


            return false;
        });




        $('.pre').click(function () {
            step.pre('#stepForm');
        });

        $('.next').click(function () {
            step.next('#stepForm');
        });




    })


        function sendcode() {
           var n = $("#LAY-user-login-cellphone").val()

            var msg = "验证码已发送至你的手机，请注意查收"
            var way = "phone"
            if(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(n)){
                msg = "验证码已发送至你的邮箱，请注意查收"
                way = "email"
            }

            layer.msg(msg, {icon: 1, shade: 0})
            $.post('${pageContext.request.contextPath}/getCode', {phoneOReamail: n,way:way}, function (data) {
                verifycode = data
                var interval = setInterval(function () {

                    $("#sendCode").html((sceond--)+" 后可重新发送")
                    if(sceond === 55){
                        $("#sendCode").html(`<a onclick="sendcode()" id="sendcode">没有收到验证码?点此重发</a>`)
                        sceond = 90
                        clearInterval(interval);
                    }

                },1000)

            })
        }


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