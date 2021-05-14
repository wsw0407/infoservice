<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改公告信息</title>
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

<div style="margin-left:10px" class="layadmin-user-login-box layadmin-user-login-body layui-form">
    <h1 style="margin-bottom: 10px;margin-left: 70px">修改公告</h1>
    <form class="layui-form" method="POST" id="subForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/notice/edit">
        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">标　　题</label>
            <div class="layui-input-block">
                <input type="hidden" name="id" id="id" value="${notice.id}">
                <input type="hidden" name="pageInfo" value="${pageInfo}">
                <input type="text" name="title" value="${notice.title}" lay-verify="required" lay-reqtext="请填写标题" autocomplete="off" placeholder="请输入标题" class="layui-input" >
            </div>
        </div>

        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">公告类型</label>
            <div class="layui-input-block" style="padding-right: 2px" id="resourcesType">
                <div id="selectType" class="xm-select-demo"></div>
                <input type="hidden" name="types" id="selectValue">
            </div>
        </div>

        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">结束日期</label>
            <div class="layui-input-inline"  style="width: 390px;padding: 0;margin: 0">
                <input type="text" value="${notice.endtimeStr}" class="layui-input" name="endtime" lay-verify="required" lay-reqtext="请选择结束日期" id="test30" placeholder="yyyy-MM-dd HH:mm">

            </div>
        </div>

        <div class="layui-form-item" id="upfile" style="width: 500px;">
            <label for="test10" class="layui-form-label">上传图片</label>

            <div class="layui-upload-drag"  id="test10">
                <i class="layui-icon"></i>
                <p>点击上传，或将文件拖拽到此处</p>
                <div class="${notice.pic != null && notice.pic != '' ? '':'layui-hide'}" id="uploadDemoView">
                    <hr>
                    <img src="${notice.pic}" alt="展示图片" id="imagsPlay" style="max-width: 196px">

                    <input type="hidden" name="pic" id="pic" value="${notice.pic}">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">活动链接</label>
            <div class="layui-input-block">
                <input type="text" name="link" value="${notice.link}" autocomplete="off" placeholder="请输入连接" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">活动状态</label>
            <div class="layui-input-block">
                <select id="remark" name="remark" style="width: 300px;">
                    <c:forEach items="${status}" var="sta">
                        <option value="${sta.id}" ${sta.id == notice.remark ? "selected":""} >${sta.status}</option>
                    </c:forEach>
                </select>
            </div>

        </div>

        <div class="layui-form-item" id="content" >
            <label class="layui-form-label">内　　容</label>
        </div>
        <div style="width:95%;height:600px;margin-left: 40px">
            <textarea name="content" id="edit" placeholder="请在这里编写公告内容">${notice.content}</textarea>
        </div>

        <div class="layui-form-item" style="margin-left: 245px;margin-top: 20px">
            <button type="button"  id="uploadImg" class="layui-btn" style="display: none">上传图片</button>
            <button type="button" class="layui-btn" lay-submit="" id="submits" lay-filter="LAY-user-reg-submit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">　重置　</button>
        </div>

    </form>


</div>




<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>
    var selectType;
    var choose = false;
    var oldFile = '${notice.pic}'
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

        laydate.render({
            elem: '#test30'
            ,type:'datetime'
            ,theme: '#393D49'
        });

        upload.render({
             elem: '#test10'
            ,url: '${pageContext.request.contextPath}/notice/uploadEdit?oldFile='+oldFile //改成您自己的上传接口
            ,auto: false
            //,multiple: true
            ,bindAction: '#uploadImg'
            ,choose: function(obj){
                choose = true
                console.log('obj')
                console.log(obj)
                obj.preview(function (index,file,result) {
                     // $('#uploadDemoView').attr('src',file)
                    console.log(result)
                    layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', result);
                })
            }
            ,done: function(res){
                layer.msg('图片修改成功,公告发布');
                //layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.files.file);
                $('#pic').val("/img/"+res.data)

                $("#subForm").submit();

                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前弹窗页面
                parent.$('#queryRole').trigger("click","5");

                console.log(res)
            }
        });

        var edit = t.render({
            elem: "#edit"
            , height: 600

        },function(opt){
            //加载完成后回调
        });

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
            var typeids = []
            var selectArr = selectType.getValue();

            selectArr.forEach(function (e) {
                typeids.push(e.value)
            })

            $('#selectValue').val(typeids)
            console.log(typeids)

            if( !choose ){
                layer.msg('修改公告信息');
                setTimeout(function () {
                    $("#subForm").submit();

                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);//关闭当前弹窗页面
                    parent.$('#queryRole').trigger("click","5");


                },500)
                return;
            }

            $('#uploadImg').click()
            //$("#subForm").submit();
            return false;
        });

    });


    $.get("${pageContext.request.contextPath}/noticetype/listAll",function(data){

        var  typelist = ${typeList}
        console.log('typelist')
        console.log(typelist)
        let datas = [];
        data.forEach(function(e){
            // console.log(e.id +"="+typelist.includes(e.id))
            datas.push({ name:e.typename , value:e.id , selected:typelist.includes(e.id)})
        });
         console.log('datas')
         console.log(datas)

        selectType = xmSelect.render({
            el: '#selectType',
            language: 'zn',
            tips: '　　请选择类别',
            empty: '呀, 没有数据呢',
            max: 4,
            filterable: true,
            theme: {
                color: '#0081ff',
                maxColor: 'orange',
            },
            toolbar: {show: true},
            data: datas
        })

    });



</script>
</body>
</html>