<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>校园信息服务平台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!--
      <link rel="icon" type="image/png" href="assets/i/favicon.png">
    -->
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/front/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/front/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front/assets/css/app.css">
<%--
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
--%>

</head>

<body id="blog" style="background: #F5F5F5;">

<header class="am-g am-g-fixed blog-fixed blog-text-center blog-header">
    <div class="am-u-sm-8 am-u-sm-centered">
        <h2 class="am-hide-sm-only">校园信息服务平台</h2>
    </div>
</header>
<hr>
<!-- nav start -->
<div>
    <a href="${pageContext.request.contextPath}/" target="_blank">
        <span class="login"  style="cursor:pointer;float: right; padding:10px;margin-right: 60px;border-right: 1px solid #EEEEEE;border-left: 1px solid #EEEEEE">去登录</span>
    </a>
    <nav class="am-g am-g-fixed blog-fixed blog-nav" >
        <%--
                <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only blog-button" data-am-collapse="{target: '#blog-collapse'}" ><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
        --%>

        <div class="am-collapse am-topbar-collapse" id="blog-collapse">
            <div style="">
                <ul class="am-nav am-nav-pills am-topbar-nav">
                    <li><a href="${pageContext.request.contextPath}/front/index">首页</a></li>

                    <li><a href="${pageContext.request.contextPath}/front/xyfc">校园风采</a></li>
                    <li class="am-active"><a href="${pageContext.request.contextPath}/front/notice">查看公告</a></li>
                    <li><a target="front" href="${pageContext.request.contextPath}/front/lypl">查看留言</a></li>
                    <li><a target="front" href="${pageContext.request.contextPath}/front/kcxx">课程信息</a></li>
                    <li><a href="${pageContext.request.contextPath}/front/yqsk">疫情实况</a></li>
                </ul>
            </div>

        </div>


    </nav>
</div>

<hr>
<div>
    <img width="100%" src="${pageContext.request.contextPath}/images/slider.jpg"/>
</div>

<!-- content srart -->
<div style="width: 100% !important;margin:10px auto "  class="am-g  ">
    <div class="am-u-md-12 am-u-sm-12">


        <div class="layui-fluid" id="LAY-flow-demo">

            <div style="display: none"  class="layui-row" align="center" style="height: 40px">

                <form class="layui-form layui-col-md12 x-so" method="get" action="#">
                    <input type="text" id="queryContent" name="content" style="width:50%;"  placeholder="请输入标题查找" value="${content}" autocomplete="off" class="layui-input" >
                    <button type="button"   class="layui-btn" style="margin-top: -65px;margin-left: 46%" onclick="querys()" data-type="reload" id="queryRole"><i class="layui-icon">&#xe615;</i></button>
                </form>

            </div>
            <div class="layui-row list-body  layui-col-space18" style="width: 90%;margin-left: 5%" id="test-flow-auto">



                <%--        <c:forEach items="${list}" var="notice">--%>
                <%--        <div class="layui-col-xs6 list-wrap" style="padding-bottom:20px;overflow:auto; vertical-align: auto ;display:inline-block;">--%>
                <%--            <div class="layui-card">--%>
                <%--                <div class="layui-card-header">${notice.title}</div>--%>
                <%--                <div class="layui-card-body">--%>
                <%--                    <div style="height: 260px;cursor:pointer;overflow: hidden">--%>
                <%--                        <img style="width: 90%;margin-left: 5%;" src="${pageContext.request.contextPath}${notice.pic}">--%>
                <%--                    </div>--%>
                <%--                    <div style="height: 140px;">--%>
                <%--                        <p style="margin-top: 20px">标　　题： ${notice.title}</p>--%>
                <%--                        <p>状　　态： <span style="padding: 3px" class="${notice.remark == 1?'layui-bg-red':'layui-bg-green'}">${notice.status}</span></p>--%>
                <%--                        <p>结束时间： ${notice.endtimeStr}</p>--%>
                <%--                        <p>类　　别：--%>
                <%--                            <c:forEach items="${notice.typelist}" var="types">--%>
                <%--                             <span style="padding: 3px" class="layui-bg-orange">${types.typename}</span>--%>
                <%--                            </c:forEach>--%>
                <%--                        </p>--%>
                <%--                        <p style="float: right;margin-top:20px;font-size:10px;color: #999999">${notice.releasetimeStr}</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--            </div>--%>
                <%--        </div>--%>
                <%--        </c:forEach>--%>


            </div>
        </div>


    </div>
</div>
<!-- content end -->



<footer class="blog-footer">
    <div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-footer-padding">
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h3>模板简介</h3>
            <p class="am-text-sm">这是一个使用amazeUI做的简单的前端模板。<br> 博客/ 资讯类 前端模板 <br> 支持响应式，多种布局，包括主页、文章页、媒体页、分类页等<br>嗯嗯嗯，不知道说啥了。外面的世界真精彩<br><br>
                Amaze UI 使用 MIT 许可证发布，用户可以自由使用、复制、修改、合并、出版发行、散布、再授权及贩售 Amaze UI 及其副本。</p>
        </div>
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h3>社交账号</h3>
            <p>
                <a href=""><span class="am-icon-qq am-icon-fw am-primary blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-github am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-weibo am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-reddit am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-weixin am-icon-fw blog-icon blog-icon"></span></a>
            </p>
            <h3>Credits</h3>
            <p>我们追求卓越，然时间、经验、能力有限。Amaze UI 有很多不足的地方，希望大家包容、不吝赐教，给我们提意见、建议。感谢你们！</p>
        </div>
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h1>我们站在巨人的肩膀上</h1>
            <h3>Heroes</h3>
            <p>
            <ul>
                <li>jQuery</li>
                <li>Zepto.js</li>
                <li>Seajs</li>
                <li>LESS</li>
                <li>...</li>
            </ul>
            </p>
        </div>
    </div>
    <div class="blog-text-center">© 2015 AllMobilize, Inc. Licensed under MIT license. Made with love By LWXYFER</div>
</footer>

<div  id="addDiv0" style="display: none">
    <div class="layui-col-xs6 list-wrap" style="padding-bottom:20px;overflow:auto; vertical-align: auto ;display:inline-block;">
        <div class="layui-card">
            <div class="layui-card-header" id="card-header"></div>
            <div class="layui-card-body">
                <div style="height: 260px;cursor:pointer;overflow: hidden">
                    <img id="imgDisplay" onclick="dispalys(this)" value="" style="width: 90%;margin-left: 5%;" src="">
                </div>
                <div style="height: 180px;line-height: 16px">
                    <p style="margin-top: 20px">标　　题： <span id="title"></span></p>
                    <p>状　　态： <span style="padding: 3px" id="status" class="layui-bg-green"></span></p>
                    <p>结束时间： <span id="endtime"></span> </p>
                    <p>类　　别： <span id="typeList"></span></p>
                    <p>链　　接： <a target="_blank" id="link"></a></p>
                    <p id="releasetime" style="float: right;margin-top:10px;font-size:10px;color: #999999">2021-01-11</p>
                </div>
            </div>
        </div>
    </div>
</div>


<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/front/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/front/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/front/assets/js/amazeui.min.js"></script>
<script>

    function setIframeHeight(iframe) {
        if (iframe) {
            var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
            if (iframeWin.document.body) {
                iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
            }
        }
    };

    window.onload = function () {
        setIframeHeight(document.getElementById('external-frame'));
    };

</script>



<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script>

    var limit = ${limit == null ? 4:limit}

        layui.config({
            base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'flow'], function(){
            var flow = layui.flow;

            flow.load({
                elem: '#test-flow-auto' //流加载容器
                //,scrollElem: '#test-flow-auto' //滚动条所在元素，一般不用填，此处只是演示需要。
                ,end: `<p style="margin-bottom: 30px" class="layui-row">没有更多信息了</p>`
                ,done: function(page, next){ //执行下一页的回调

                    var content = $("#queryContent").val()

                    $.get("/notice/list?limit="+limit+"&page="+page+"&content="+content,function (res) {
                        console.log(page)
                        console.log(res.data)
                        var data = res.data


                        setTimeout(function(){
                            var lis = [];
                            data.forEach(function (e) {

                                $("#addDiv0 #card-header").html(e.title)
                                $("#addDiv0 #imgDisplay").attr("src","${pageContext.request.contextPath}"+e.pic)
                                $("#addDiv0 #imgDisplay").attr("value",e.id)
                                $("#addDiv0 #title").html(e.title)
                                $("#addDiv0 #status").html(e.status)
                                console.log(e.remark)
                                if(e.remark === 1){
                                    $("#addDiv0 #status").attr("class",'layui-bg-red')
                                }else {
                                    $("#addDiv0 #status").attr("class",'layui-bg-green')
                                }
                                $("#addDiv0 #endtime").html(e.endtimeStr)
                                $("#addDiv0 #releasetime").html(e.releasetimeStr)

                                var typeNodes = ''
                                e.typelist.forEach(function (e1) {
                                    typeNodes = typeNodes+`<span style="padding: 3px;margin-right: 3px" class="layui-bg-orange">`+e1.typename+`</span>`
                                })
                                $("#addDiv0 #typeList").html(typeNodes)
                                $("#addDiv0 #link").attr("href",e.link)
                                $("#addDiv0 #link").html(e.link)

                                lis.push(document.getElementById('addDiv0').innerHTML)
                            })
                            next(lis.join(''), page < res.pageTotal); //假设总页数为 10
                        }, 500);

                    })
                }
            });
        });

    function dispalys(e) {

        layer.open({
            type: 2
            ,title: '修改用户'
            ,content: '/notice/displayInfo?id='+$(e).attr('value')
            ,maxmin: true
            ,shadeClose: true
            ,area: ['80%', '100%']
            ,success : function(layero, index){

            }
        })
    }
    function querys() {

        var content = $("#queryContent").val()
        location.href = "/notice/display?limit="+limit+"&page="+1+"&content="+content
    }

</script>

</body>
</html>