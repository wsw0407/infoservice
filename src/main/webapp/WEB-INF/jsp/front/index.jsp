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
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/front/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/front/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front/assets/css/app.css">
</head>

<body id="blog" style="background: #F5F5F5;">
<img style="float: left;height: 80px;margin-left:20px;margin-top: -25px" src="${pageContext.request.contextPath}/earth/logo.png"/>

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
                    <li class="am-active"><a href="${pageContext.request.contextPath}/front/index">首页</a></li>

                    <li><a href="${pageContext.request.contextPath}/front/xyfc">校园风采</a></li>
                    <li><a href="${pageContext.request.contextPath}/front/notice">查看公告</a></li>
                    <li><a target="front" href="${pageContext.request.contextPath}/front/lypl">查看留言</a></li>
                    <li><a target="front" href="${pageContext.request.contextPath}/front/kcxx">课程信息</a></li>
                    <li><a href="${pageContext.request.contextPath}/front/yqsk">疫情实况</a></li>
                </ul>
            </div>

        </div>


    </nav>
</div>

<hr>
<!-- nav end -->
<!-- banner start -->
<div style="width: 85%;margin:auto;" class="">
    <div data-am-widget="slider" class="am-slider am-slider-b1" data-am-slider='{&quot;controlNav&quot;:false}' >
        <ul class="am-slides">
            <li>
                <img src="${pageContext.request.contextPath}/front/assets/i/b1.jpg">
                <div class="blog-slider-desc am-slider-desc ">
                    <div class="blog-text-center blog-slider-con">
                        <span><a href="" class="blog-color">Article &nbsp;</a></span>
                        <h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
                        <p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
                        </p>
                        <span class="blog-bor">2021/04/07</span>
                        <br><br><br><br><br><br><br>
                    </div>
                </div>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/front/assets/i/b2.jpg">
                <div class="am-slider-desc blog-slider-desc">
                    <div class="blog-text-center blog-slider-con">
                        <span><a href="" class="blog-color">Article &nbsp;</a></span>
                        <h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
                        <p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
                        </p>
                        <span>2021/04/07</span>
                    </div>
                </div>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/front/assets/i/b3.jpg">
                <div class="am-slider-desc blog-slider-desc">
                    <div class="blog-text-center blog-slider-con">
                        <span><a href="" class="blog-color">Article &nbsp;</a></span>
                        <h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
                        <p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
                        </p>
                        <span>2021/04/07</span>
                    </div>
                </div>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/front/assets/i/b2.jpg">
                <div class="am-slider-desc blog-slider-desc">
                    <div class="blog-text-center blog-slider-con">
                        <span><a href="" class="blog-color">Article &nbsp;</a></span>
                        <h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
                        <p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
                        </p>
                        <span>2021/04/07</span>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<!-- banner end -->

<!-- content srart -->
<div style="width: 100% !important;margin:auto"  class="am-g  ">
    <div class="am-u-md-12 am-u-sm-12">
        <iframe name="front" src="${pageContext.request.contextPath}/洛阳理工学院历史.html" frameborder="0" scrolling="no" style="width: 100%" id="external-frame" onload="setIframeHeight(this)"></iframe>
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
</body>
</html>