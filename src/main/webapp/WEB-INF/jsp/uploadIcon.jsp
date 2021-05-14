<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>上传头像</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xm-select.js"></script>

</head>
<body>

<div style="margin-left: 80px;" class="layadmin-user-login-box layadmin-user-login-body layui-form">

    <form class="layui-form" method="POST" id="subForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/notice/add">
        <div class="layui-form-item" id="upfile" >
            <div class="layui-upload-drag" style="width: 250px;min-height: 100px" id="test10">
                <i class="layui-icon"></i>
                <p>点击上传，或将图片拖拽到此处</p>
                <div class="${ACCOUNT_SESSION.pic == null ? 'layui-hide':''}" id="uploadDemoView">
                    <hr>
                    <img class="layui-nav-img" style="width: 250px;height: 250px" src="${pageContext.request.contextPath}${ACCOUNT_SESSION == null ? '':ACCOUNT_SESSION.pic}" alt="上传成功后渲染" id="imagsPlay">
                    <input type="hidden" name="pic" id="pic">
                </div>
            </div>
        </div>

        <div class="layui-form-item" style="margin-left: 90px;margin-top: 20px">
            <button type="button"  id="uploadImg" class="layui-btn">上传图片</button>
        </div>

    </form>


</div>




<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>
    var selectType;
    var basePath = "${pageContext.request.contextPath}"
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['tinymce','laydate','upload','util','index', 'user'], function(){
        var admin = layui.admin
            ,form = layui.form;
        var t = layui.tinymce
        var util = layui.util;
        var laydate = layui.laydate;
        var $ = layui.jquery
            ,upload = layui.upload;

        form.render();


        upload.render({
            elem: '#test10'
            ,url: '${pageContext.request.contextPath}/users/uploads' //改成您自己的上传接口
            ,auto: false
            //,multiple: true
            ,bindAction: '#uploadImg'
            ,choose: function(obj){

                obj.preview(function (index,file,result) {
                    // $('#uploadDemoView').attr('src',file)
                    //console.log(result)
                    layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', result);
                })
            }
            ,done: function(res){

                layer.msg(res.msg);
                //layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.files.file);
                //$('#pic').val("/img/"+res.data)
                if(res.msg == "未登录"){
                    return;
                }
                setTimeout(function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);//关闭当前弹窗页面
                    parent.$('#picPlay').attr("src",basePath+"/img/"+res.data)
                    parent.parent.$('#indexPic').attr("src",basePath+"/img/"+res.data)
                    parent.$('#indexPic').attr("src",basePath+"/img/"+res.data)

                },1300)

                //$("#subForm").submit();
                console.log(res)
            }
        });

        //提交
        /*form.on('submit(LAY-user-reg-submit)', function(obj){
            var field = obj.field;
            console.log(field)

            if($('#imagsPlay').attr('src') == ''){
                layer.msg('公告发布');
                setTimeout(function () {
                    $("#subForm").submit();
                },500)
                return;
            }

            $('#uploadImg').click()
            //$("#subForm").submit();
            return false;
        });
*/
    });





</script>
</body>
</html>