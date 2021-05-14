<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>公告展示</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">


</head>

<body>

<div class="layui-card layadmin-header">
    <div class="layui-breadcrumb" lay-filter="breadcrumb">
        <a lay-href="">主页</a>
        <a><cite>组件</cite></a>
        <a><cite>流加载</cite></a>
    </div>
</div>

<div class="layui-fluid" id="LAY-flow-demo">

    <div class="layui-row" align="center" style="height: 40px">

        <form class="layui-form layui-col-md12 x-so" method="get" action="#">
            <input type="text" id="queryContent" name="content" style="width:50%;"  placeholder="请输入标题查找" value="${content}" autocomplete="off" class="layui-input" >
            <button type="button"   class="layui-btn" style="margin-top: -57px;margin-left: 46%" onclick="querys()" data-type="reload" id="queryRole"><i class="layui-icon">&#xe615;</i></button>
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



<div  id="addDiv0" style="display: none">
<div class="layui-col-xs6 list-wrap" style="padding-bottom:20px;overflow:auto; vertical-align: auto ;display:inline-block;">
            <div class="layui-card">
                <div class="layui-card-header" id="card-header"></div>
                <div class="layui-card-body">
                    <div style="height: 260px;cursor:pointer;overflow: hidden">
                        <img id="imgDisplay" onclick="dispalys(this)" value="" style="width: 90%;margin-left: 5%;" src="">
                    </div>
                    <div style="height: 150px;">
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



<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script>

    var limit = '${limit}'

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

                 $.get("${pageContext.request.contextPath}/notice/list?limit="+limit+"&page="+page+"&content="+content,function (res) {
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
            ,content: '${pageContext.request.contextPath}/notice/displayInfo?id='+$(e).attr('value')
            ,maxmin: true
            ,shadeClose: true
            ,area: ['80%', '100%']
            ,success : function(layero, index){

            }
        })
    }
    function querys() {

        var content = $("#queryContent").val()
        location.href = "${pageContext.request.contextPath}/notice/display?limit="+limit+"&page="+1+"&content="+content
   }

</script>
</body>
</html>

