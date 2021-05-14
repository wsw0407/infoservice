<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>实时疫情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <!-- 导入jquery插件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

</head>
<body class="layui-layout-body">


<div  id="LAY_app_body" style="" >
        <iframe id="iframepage"  src="https://voice.baidu.com/act/newpneumonia/newpneumonia/?from=osari_aladin_banner#tab1" style="z-index: -1 !important;overflow-x : hidden;overflow-scrolling: inherit" frameborder="0" class="layadmin-iframe"></iframe>
</div>




<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>

    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index',function () {

        layer.msg('信息来自百度,实时展示疫情实况', {
            offset: '100px'
            ,icon: 1
            ,time: 3000
        });

    })



    function setIframeHeight(iframe) {
        if (iframe) {
            var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
            if (iframeWin.document.body) {
                iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
            }
        }
    };

    window.onload = function () {
        setIframeHeight(document.getElementById('iframepage'));
    };



</script>

</body>
</html>


