<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>demo</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">

</head>

<body>
<div id="testbox" style="background: red;width: 500px;height: 300px"></div>
<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
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
            url:'${pageContext.request.contextPath}/resourcestype/list',
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
                        console.log("点击", node);
                        var index = layer.confirm('确定点击 [node] 吗？', {
                            btn: ['删除','取消']
                        }, function(){
                            layer.close(index);

                        });
                    }
                    , del: function (node) {
                        console.log("删除", node);
                        return true;
                    }
                });
                console.log(nodes)
            }
        });
    });
</script>

</body>

</html>
