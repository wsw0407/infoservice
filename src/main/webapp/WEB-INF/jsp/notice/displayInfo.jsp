<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>公告详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
</head>

<body>

    <div class="layui-col-xs10 layui-col-xs-offset1 list-wrap" style="padding-bottom:20px;overflow:auto; vertical-align: auto ;display:inline-block;">
        <div class="layui-card">
            <div class="layui-card-header" id="card-header" style="height: 70px;line-height: 70px">
                <h1>${notice.title}</h1>
                <p id="releasetime" style="float: right; margin-top: -20px;font-size:10px;color: #999999">发布时间：${notice.endtimeStr}</p>
            </div>
            <div class="layui-card-body">

                <div style="padding-bottom: 30px">
                    <p>来源链接： <a target="_blank" href="${notice.link}" style="color: #0b94ea" id="link">${notice.link}</a></p>

                    <p style="margin-top: 15px">${notice.content}</p>
                </div>
            </div>
        </div>
    </div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'flow'], function(){

    });


</script>
</body>
</html>

