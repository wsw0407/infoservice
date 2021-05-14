<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>大学生校园服务信息后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- 导入jquery插件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/fkjava_timer.js"></script>
    <script type="text/javascript">

        $(function(){
            $("#nowTime").runTimer();
            var calendar = showCal();

            $("#currentDate").text("农历" + calendar);

        });

    </script>
</head>
<body class="layui-layout-body">

<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layadmin-flexible" lay-unselect>
                    <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" layadmin-event="refresh" title="刷新">
                        <i class="layui-icon layui-icon-refresh-3"></i>
                    </a>
                </li>
               <%-- <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords=">
                </li>--%>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <div class="left_open">
                        <p  style="color:white;margin-left: 130px">当前时间 ：<span id="nowTime"></span></p>
                    </div>

                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <div class="left_open">
                        <p  style="color:white;margin-left: -25px"><span id="currentDate"></span></p>
                    </div>
                </li>

            </ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">

                <li class="layui-nav-item" lay-unselect>
                    <a lay-href="#" layadmin-event="message" lay-text="消息中心">
                        <i class="layui-icon layui-icon-notice"></i>

                        <!-- 如果有新消息，则显示小圆点 -->
                       <%-- <span class="layui-badge-dot"></span>--%>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="theme">
                        <i class="layui-icon layui-icon-theme"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="note">
                        <i class="layui-icon layui-icon-note"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="fullscreen">
                        <i class="layui-icon layui-icon-screen-full"></i>
                    </a>
                </li>

                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;">
                        <img id="indexPic" onclick="uploadIcon()" src="${pageContext.request.contextPath}${ACCOUNT_SESSION == null ? "/images/001.gif":ACCOUNT_SESSION.pic}" title="点击头像上传" style="width: 40px;height: 37px" class="layui-nav-img"> <cite>${ACCOUNT_SESSION == null ? "未登录":ACCOUNT_SESSION.username}</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a target="_blank" href="${pageContext.request.contextPath}/front/index">去前台</a></dd>

                        <dd><a lay-href="${pageContext.request.contextPath}/users/personPage?id=${ACCOUNT_SESSION.id}">基本资料</a></dd>
                        <dd><a <%--lay-href=""--%> onclick="repassword()">修改密码</a></dd>
                        <hr class="layui-bg-red" style="margin-top: -3px;">
                        <dd  style="text-align: center;margin-top: -5px"><a href="${pageContext.request.contextPath}/loginOut">退出</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="about"><i class="layui-icon"></i></a>
                </li>

            </ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu">
            <div class="layui-side-scroll">
                <div class="layui-logo" lay-href="home/console.html">
                    <span><img style="width: 180px" src="${pageContext.request.contextPath}/images/logo.png"></span>
                </div>

                <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
                    <li data-name="home" class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;" lay-tips="首页" lay-direction="2">
                            <i class="layui-icon layui-icon-home"></i>
                            <cite>首页</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="elegan" class="layui-this">
                                <a lay-href="${pageContext.request.contextPath}/洛阳理工学院图册.html">校园风采</a>
                            </dd>
                            <dd data-name="culture">
                                <a lay-href="${pageContext.request.contextPath}/洛阳理工学院历史.html">文化历史</a>
                            </dd>

                        </dl>
                    </li>
                    <li data-name="user-manage" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="用户管理" lay-direction="2">
                            <i class="layui-icon layui-icon-component"></i>
                            <cite>用户管理</cite>
                        </a>
                        <dl class="layui-nav-child">

                            <dd data-name="uservisit">
                                <a lay-href="${pageContext.request.contextPath}/uservisit/listpage">用户访问信息</a>
                            </dd>

                            <dd data-name="userList">
                                <a lay-href="${pageContext.request.contextPath}/users/listpage">用户列表</a>
                            </dd>

                            <dd data-name="auxiliar">
                                <a lay-href="${pageContext.request.contextPath}/users/toaddAccount">添加用户</a>
                            </dd>

                        </dl>
                    </li>
                    <li data-name="resource" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="资源共享" lay-direction="2">
                            <i class="layui-icon layui-icon-template"></i>
                            <cite>资源共享</cite>
                        </a>
                        <dl class="layui-nav-child">

                            <dd><a lay-href="${pageContext.request.contextPath}/resources/listpage">资源列表</a></dd>
                            <dd><a lay-href="${pageContext.request.contextPath}/resources/toadd">共享资源</a></dd>
                            <dd><a lay-href="${pageContext.request.contextPath}/resourcestype/listpage">类别标签</a></dd>

                        </dl>
                    </li>
                    <li data-name="notice" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="活动公告" lay-direction="2">
                            <i class="layui-icon layui-icon-template-1"></i>
                            <cite>活动公告</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="${pageContext.request.contextPath}/notice/listPage">公告列表</a></dd>
                            <dd><a lay-href="${pageContext.request.contextPath}/notice/display">公告展示</a></dd>
                            <dd><a lay-href="${pageContext.request.contextPath}/notice/toadd">发布公告</a></dd>
                            <dd><a lay-href="${pageContext.request.contextPath}/noticetype/listpage">公告标签</a></dd>
                        </dl>
                    </li>
                    <li data-name="topic" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="留言评论" lay-direction="2">
                            <i class="layui-icon layui-icon-app"></i>
                            <cite>留言评论</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="topics">
                                <a lay-href="${pageContext.request.contextPath}/topics/listPage">留言列表</a>
                            </dd>
                            <dd>
                                <a lay-href="${pageContext.request.contextPath}/topics/diaplay">留言展示</a>
                            </dd>
                            <dd data-name="workorder">
                                <a lay-href="${pageContext.request.contextPath}/topictype/listpage">主题标签</a>
                            </dd>

                        </dl>
                    </li>
                    <li data-name="course_arrange" class="layui-nav-item">
                        <a href="javascript:;" lay-tips=" 教学排课" lay-direction="2">
                            <i class="layui-icon layui-icon-senior"></i>
                            <cite>课程信息</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a lay-href="${pageContext.request.contextPath}/classchedule/listpage">课程查询</a>
                            </dd>

                            <dd data-name="course_arrange">
                                <a href="javascript:;">课程管理</a>
                                <dl class="layui-nav-child">
                                    <dd>
                                        <a lay-href="${pageContext.request.contextPath}/term/listpage">学年学期</a>
                                    </dd>
                                    <dd>
                                        <a lay-href="${pageContext.request.contextPath}/majar/listpage">专业班级</a>
                                    </dd>
                                </dl>
                            </dd>


                        </dl>
                    </li>

                    <li data-name="news" class="layui-nav-item">
                        <a lay-href="${pageContext.request.contextPath}/yqhot" lay-tips="疫情实况" lay-direction="2">
                            <i class="layui-icon layui-icon-template"></i>
                            <cite>疫情实况</cite>
                        </a>

                    </li>
                    <li data-name="data_analysis" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="用户数据分析" lay-direction="2">
                            <i class="layui-icon layui-icon-chart-screen"></i>
                            <cite>用户数据分析</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a lay-href="${pageContext.request.contextPath}/statics/display">数据报表</a>
                            </dd>
                        </dl>
                    </li>
                    <li data-name="set" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="设置" lay-direction="2">
                            <i class="layui-icon layui-icon-set"></i>
                            <cite>设置</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd class="layui-nav-itemed">
                                <a href="javascript:;">我的设置</a>
                                <dl class="layui-nav-child">
                                    <dd><a lay-href="${pageContext.request.contextPath}/users/personPage?id=${ACCOUNT_SESSION.id}">基本资料</a></dd>
                                    <dd><a lay-href="${pageContext.request.contextPath}/torePassword">修改密码</a></dd>
                                </dl>
                            </dd>
                            <%--<dd class="layui-nav-itemed">
                                <a href="javascript:;">系统设置</a>
                                <dl class="layui-nav-child">
                                    <dd><a lay-href="set/system/website.html">网站设置</a></dd>
                                    <dd><a lay-href="set/system/email.html">邮件服务</a></dd>
                                </dl>
                            </dd>--%>

                        </dl>
                    </li>

                </ul>
            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect>
                        <a href="javascript:;"></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
            <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="home/console.html" lay-attr="${pageContext.request.contextPath}/洛阳理工学院图册.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
                </ul>
            </div>
        </div>


        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="${pageContext.request.contextPath}/洛阳理工学院图册.html" style="overflow-x : hidden;overflow-scrolling: inherit" frameborder="0" class="layadmin-iframe"></iframe>
            </div>
        </div>

        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index',function () {




    })

    function uploadIcon(){
        layer.open({
            type: 2
            ,title: '上传头像'
            ,shadeClose: true
            ,content: '${pageContext.request.contextPath}/users/touploadIcon'
            ,maxmin: true
            ,area: ['500px', '550px']
            ,success : function(layero, index){

            }
        })
    }

    function repassword() {
        layer.open({
            type: 2
            ,title: '修改密码'
            ,shadeClose: true
            ,content: '${pageContext.request.contextPath}/torePassword'
            ,maxmin: true
            ,area: ['50%', '60%']
            ,success : function(layero, index){

            }
        })
    }

</script>

</body>
</html>

