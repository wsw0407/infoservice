<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>留言主题列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">

</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15"  >
        <div class="layui-col-md12" >

            <div class="layui-card" style="height: 520px;padding-left: 20px;">

                <div class="x-nav" style="margin-left: 120px;margin-right: 20px">

                    <button type="button"  onclick="addType()" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:inherit;margin-left: -110px"  ><i class="layui-icon"></i>添加</button>
                    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="${pageContext.request.contextPath}/topictype/listpage" title="刷新">
                        <i class="layui-icon" style="line-height:30px">ဂ</i></a>

                </div>
                   <div style="width: 400px;margin: 40px">
                       <div id="testbox"></div>
                   </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

<script>

    layui.config({
        base: '${pageContext.request.contextPath}/assets/checkbox/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['checkbox', 'layer'], function () {
        var $ = layui.$
            , layer = layui.layer
            , checkbox = layui.checkbox;

        let nodes = [];

        $.ajax({
            method:'get',
            url:'${pageContext.request.contextPath}/topictype/list',
            dataType:'json',
            success:function(data){
                data.data.forEach((e) => {

                    var node = { "id": e.id, "name": e.typename, "type": "点击编辑","on":true}
                    nodes.push(node)
                })

                $("#testbox").children("li").remove();
                checkbox({
                    elem: "#testbox"
                    , nodes: nodes
                    , click: function (node) {
                        layer.prompt({
                             formType: 2
                            ,title:'编辑标签'
                            ,area:['250px','80px']
                            ,value: node.name
                            ,btn: ['提交','取消']
                        }, function(value, index){
                            $.get("${pageContext.request.contextPath}/topictype/edit?id="+node.id+"&typename="+value);
                            layer.msg('已修改!',{icon:1,time:1000},function () {
                                  location.href="${pageContext.request.contextPath}/topictype/listpage"
                            });
                            var newnode = ['<li class="mouses block on" value="'+value+'" onmouseout="layui.layer.closeAll(\'tips\');">'+value,'<i class="choice"><i class="triangle"></i><i class="right layui-icon layui-icon-ok"></i></i><i class="del"><i class="layui-icon layui-icon-delete"></i></i><span class="hide"><input type="hidden" name="'+value+'" value="点击编辑"></span></li>'].join('');

                            $("#testbox li[value='"+node.name+"']").replaceWith(newnode)
                            layer.close(index);

                        });

                    }
                    , del: function (node) {
                        $.get("${pageContext.request.contextPath}/topictype/delete?id="+node.id);
                        layer.msg('已删除!',{icon:1,time:1000});

                        return true;
                    }
                });
            }
        });




    });


    $(function () {
       setTimeout(function () {
           $(".mouses").on("mouseover",function (e) {
              layui.layer.tips('点击编辑',this,{tips:4})
               e.stopPropagation();
           })

           $(".del").on("mouseover",function (e) {
               e.stopPropagation();
               layui.layer.tips('删除',this,{tips:2})
           })

       },500);
    })

    function  addType(){
        layer.prompt({
            formType: 2
            ,title:'添加标签'
            ,area:['250px','80px']
            ,value: ''
            ,btn: ['提交','取消']
        }, function(value, index){
            $.get("${pageContext.request.contextPath}/topictype/add?typename="+value);

            layer.msg('已添加',{icon:1,time:1000},function () {
                location.href="${pageContext.request.contextPath}/topictype/listpage"
            });
            var newnode = $(['<li class="mouses block on" value="'+value+'" onmouseout="layui.layer.closeAll(\'tips\');">'+value,'<i class="choice"><i class="triangle"></i><i class="right layui-icon layui-icon-ok"></i></i><i class="del"><i class="layui-icon layui-icon-delete"></i></i><span class="hide"><input type="hidden" name="'+value+'" value="点击编辑"></span></li>'].join(''));

            $("#testbox").append(newnode);
            layer.close(index);
        });
    }

</script>
</body>
</html>
