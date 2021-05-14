<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Layui-Tinymce</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">


<body>
<div style="width: 90%;height:200px;background:red;margin: 15px auto;">
    <textarea name="" id="edit" >这里是<span style="color: #e03e2d;"><em>edit初始化</em></span>的内容</textarea>
    <hr />
    <div class="layui-btn-group" style="margin-top: 10px">
        <button class="layui-btn" lay-event="setContent">设置内容</button>
        <button class="layui-btn" lay-event="insertContent">插入内容</button>
        <button class="layui-btn" lay-event="getContent">获取内容</button>
        <button class="layui-btn" lay-event="getText">获取文本</button>
        <button class="layui-btn" lay-event="clearContent">清空内容</button>
        <button class="layui-btn" lay-event="reload">重载编辑器</button>
        <button class="layui-btn" lay-event="destroy">销毁编辑器</button>
        <button class="layui-btn" lay-event="render">加载编辑器</button>
    </div>
    <br /><hr />
    同时插入第二个编辑器，配置相互独立
    <hr />
    <textarea name="" id="edit2">这里是<span style="color: #e03e2d;"><em>edit2初始化</em></span>的内容</textarea>

</div>

</body>
<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>

    layui.config({
        base: '${pageContext.request.contextPath}/assets/tinymce/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['tinymce', 'util', 'layer'], function () {
        var t = layui.tinymce
        var util = layui.util;

        var edit = t.render({
            elem: "#edit"
            , height: 200
            // ...
            // 其余配置可参考官方文档
        },function(opt){
            //加载完成后回调
        });

        t.render({
            elem: "#edit2"
            , height: 200
        });

        util.event('lay-event', {
            getContent:function() {
                var content = t.get('#edit').getContent()
                layer.alert(content)
            },
            setContent:function() {
                t.get('#edit').setContent('点击按钮设置的内容：<span style="color: #e03e2d;">' + new Date()+'</span>')
            },
            clearContent:function() {
                t.get('#edit').setContent('')
            },
            insertContent:function() {
                t.get('#edit').insertContent('<b>插入内容</b>')
            },
            getText:function() {
                var text = t.get('#edit').getContent({format:'text'})
                layer.alert(text)
            },
            reload:function() {
                t.reload({
                    elem:'#edit'
                    // 所有参数都可以重新设置 ...
                },function(opt){
                    //重载完成后回调函数，会把所有参数回传，
                    //重载仅仅重新渲染编辑器，不会清空textarea，可手动清空或设置
                    t.get('#edit').setContent('')
                })
            },
            destroy:function(){
                t.get('#edit').destroy()
            },
            render:function(){
                t.render({elem:'#edit',height:'500px'})
            }
        });


    });
</script>
<style>
    .tox .tox-dialog{
        border: none;
    }

    .tox .tox-dialog,
    .tox .tox-button,
    .tox .tox-textarea,
    .tox .tox-textfield,
    .tox .tox-selectfield select,
    .tox .tox-toolbar-textfield{
        border-radius: 0;
    }
    .tox .tox-dialog-wrap__backdrop{
        background-color: rgba(0, 0, 0, .3);
    }
</style>
</html>
