<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改资源信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/login.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
</head>
<body>

<div style="width: 400px;margin-left:10px" class="layadmin-user-login-box layadmin-user-login-body layui-form">
    <h1 style="margin-bottom: 10px;margin-left: 70px">修改资源信息</h1>
    <form class="layui-form" method="POST" id="subForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/resources/edit">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="hidden" name="id"  id="id">
                <input type="hidden" name="oldcontent"  id="oldcontent">
                <input type="text" id="title" name="title" lay-verify="required" lay-reqtext="请填写标题" autocomplete="off" placeholder="请输入标题" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">资源类型</label>
            <div class="layui-input-block" style="padding-left: 20px" id="resourcesType">
            </div>
        </div>

        <div class="layui-form-item" >
            <label class="layui-form-label" >获取方式</label>
            <div class="layui-input-block">
                <select id="access" name="access" lay-verify="required" lay-reqtext="请选择方式">
                    <option value="">选择获取方式</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" id="upfile">
            <label for="file" class="layui-form-label">
                <span class="x-red">*</span>上传文件
            </label>
            <div class="layui-input-block">
                <input type="file" id="file" name="file"  >
               <p><span id="currfile"></span></p>
            </div>
        </div>

        <div class="layui-form-item" id="content">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <input type="text" id="contentinfo" name="content"  autocomplete="off" placeholder="请网盘链接或获取具体方式" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <textarea placeholder="描述资源信息" class="layui-textarea" id="remark" name="remark"></textarea>
            </div>
        </div>


        <div class="layui-form-item" style="margin-left: 145px">
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

        $.get("${pageContext.request.contextPath}/resources/editinfo?id="+${resId},function(data){

            var access = data.access
            var typelist = data.typelist

            $('#id').val(data.id)
            $('#title').val(data.title)
            $('#remark').val(data.remark)
            $('#contentinfo').val(data.content)


            $.get("${pageContext.request.contextPath}/resources/accessList",function(data){
                console.log("accessList")
                console.log(data)
                console.log(access)
                data.forEach(function(e){
                    var node = '<option value='+e.id+'>'+e.accessWay+'</option>'
                    if(access != null && e.id == access){
                        node = '<option selected value='+e.id+'>'+e.accessWay+'</option>'
                    }
                    $('#access').append($(node))
                });
                layui.form.render();
            });

            $.get("${pageContext.request.contextPath}/resourcestype/listAll",function(data){

                data.forEach(function(e){
                    var node = '<input type="checkbox" name="type" title="'+e.typename+'" value="'+e.id+'" lay-skin="primary">'
                    for (var type of typelist) {
                        if(e.id  ==  type.id){
                            node = '<input type="checkbox" checked name="type" title="'+e.typename+'" value="'+e.id+'" lay-skin="primary">'
                        }
                    }
                    $('#resourcesType').append($(node))
                    layui.form.render();
                });
            });

            if(access == 1){

                $("#upfile").show()
                $("#content").hide()
                $('#currfile').html("当前文件："+data.content)
            }else {
                $("#content").show()
                $("#upfile").hide()
            }
            layui.form.render();
        });


        //提交
        form.on('submit(LAY-user-reg-submit)', function(obj){
            var field = obj.field;
            console.log(field)

            $("#subForm").submit();

            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);//关闭当前弹窗页面
            parent.$('#queryRole').trigger("click","5");

            return false;
        });

        form.on('select()', function(data){
            if(data.value == 1){
                $("#upfile").show()
                $("#content").hide()
            }else {
                $("#content").show()
                $("#upfile").hide()
            }
        });
    });

</script>
</body>
</html>