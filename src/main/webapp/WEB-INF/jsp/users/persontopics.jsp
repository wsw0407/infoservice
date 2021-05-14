<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>我的留言板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/template.css" media="all">

</head>
<body>


<div class="layui-fluid layadmin-message-fluid" >
    <div class="layui-row" >
        <div class="layui-col-md12">
            <div class="layui-tab layui-tab-brief caller-tab" style="margin: 15px 43px" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li class="${content == null ? 'layui-this':''}" onclick="querys()">全部</li>
                    <c:forEach items="${typelist}" var="type">
                        <li class="${type.typename == content  ? 'layui-this':''}" onclick="querys('${type.typename}')">${type.typename}</li>
                    </c:forEach>
                </ul>
            </div>
            <form class="layui-form" id="realsetopics" action="/topics/add" style="margin-top: -40px">
                <div class="layui-form-item layui-form-text">
                    <div class="layui-input-block">
                        <textarea name="comtent"  placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                    <div  class="layui-input-block" style="width: 200px">
                        <select name="topicType" style="z-index: 999 !important;height:20px !important;width: 250px !important">
                            <option style="height:20px !important;" value="">选择留言主题</option>
                            <c:forEach items="${typelist}" var="type">
                                <option style="height:20px !important;" value="${type.id}">${type.typename}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block layui-input-right">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">发表</button>
                    </div>
                    <div class="layadmin-messag-icon">

                        <a href="javascript:;"><i class="layui-icon layui-icon-face-smile-b"></i></a>
                        <a href="javascript:;"><i class="layui-icon layui-icon-picture"></i></a>
                        <a href="javascript:;"><i class="layui-icon layui-icon-link"></i></a>
                    </div>
                </div>
            </form>
        </div>


        <div class="layui-col-md12 layadmin-homepage-list-imgtxt message-content" style="margin-top: -30px;">
            <c:forEach items="${list}" var="info">
                <div id="${info.id}" class="media-body" style="margin-left: 20px;margin-bottom: 25px">
                    <a href="javascript:;" class="media-left" style="float: left;">
                        <img onclick="comments('${info.id}','${info.accountId}')" src="${pageContext.request.contextPath}${info.account.pic}" height="46px" width="46px">
                    </a>
                    <div class="pad-btm">
                        <p class="fontColor"><a href="javascript:;">${info.account.username}</a></p>
                        <p class="min-font">
                      <span class="layui-breadcrumb" lay-separator="-">
                        <a href="javascript:;" class="layui-icon layui-icon-username"></a>
                        <a href="javascript:;">发布时间</a>
                        <a href="javascript:;">${info.timeStr}</a>
                          <a href="javascript:;">评论数量：${info.conList.size()}</a>
                      </span>
                        </p>
                    </div>
                    <p class="message-text" style="margin-left: 40px;font-size: 18px">${info.comtent}</p>
                    <p class="min-font" style="float: right;margin-right: 50px">
                      <span class="layui-breadcrumb" lay-separator=" ">
                        <a onclick="comments('${info.id}','${info.accountId}')"  href="javascript:;">评论</a>
                        <a class="delRole" onclick="delTopics('${info.id}')"  href="javascript:;">删除</a>
                      </span>
                    </p>
                    <c:if test="${info.conList.size() != 0}">
                        <div style="margin-top: 20px;margin-left: 20px" class="layui-timeline-content layui-text">

                            <blockquote class="layui-elem-quote">
                                <c:forEach items="${info.conList}" var="comment">
                                    <p class="min-font" id="${comment.id}" >
                            <span class="layui-breadcrumb" lay-separator="">
                                <span>
                                    <a onclick="comments('${info.id}','${comment.fromAid}','${comment.fromUsername}')" href="javascript:;"style="text-decoration-line: none;font-size: 15px;">${comment.fromUsername}</a>
                                    <span style="font-size: 10px;color: orange">${comment.toUid == info.account.id? "评论":"回复"}</span>
                                    <a onclick="comments('${info.id}','${comment.toUid}','${comment.toUsername}')" href="javascript:;"style="text-decoration-line: none;font-size: 15px;">${comment.toUid == info.account.id? "":comment.toUsername} ：</a>
                                    <span style="color: orange"> ${comment.content}</span>
                                    <a onclick="delComment('${comment.id}')" style="float:right;text-decoration-line: none;margin-left: 10px"  class="delRole"  href="javascript:;">删除</a>
                                    <span style="float:right;text-decoration-line: none;font-size: 8px;color: #999999">${comment.timeStr}</span>
                                    <hr class="layui-border-blue" id="${comment.id}hr">
                                </span>
                            </span>
                                    </p>
                                </c:forEach>
                            </blockquote>
                        </div>
                    </c:if>
                    <div>
                    </div>
                </div>
            </c:forEach>

            <div id="pages"></div>
        </div>

    </div>
</div>
</div>


<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

<script>

    var msg = '${msg == null ? null:msg}'



    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'laypage','layer','form'], function(){
        var laypage = layui.laypage,layer = layui.layer;

        laypage.render({
            elem: 'pages' //注意，这里的 test1 是 ID，不用加 # 号
            ,count: '${count}' //数据总数，从服务端得到
            ,curr:'${pageNo}'
            ,limit:'${pageSize}'
            ,first:1
            ,last:'${pages}'
            ,layout:["first","prev","page","next","count","limit","skip","last"]
            ,limits:[5,10,15,20,15,30]
            ,jump: function(obj, first){

                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数

                //首次不执行
                if(!first){

                    var content = "${content}"
                    if(content != null && content != ''){
                        location.href ="${pageContext.request.contextPath}/topics/persondiaplay?page="+obj.curr+"&limit="+obj.limit+"&content="+content
                    }else {
                        location.href="${pageContext.request.contextPath}/topics/persondiaplay?page="+obj.curr+"&limit="+obj.limit
                    }

                }
            }
        });

        var form = layui.form;
        form.on('submit(formDemo)', function(data){
            //layer.msg(JSON.stringify(data.field));
            var topics = data.field
            //$("#realsetopics").submit()
            $.post("${pageContext.request.contextPath}/topics/add",topics,function (data) {
                console.log(data)
                if(data){
                    layer.msg("已发布")
                    setTimeout(function () {
                        location.href="${pageContext.request.contextPath}/topics/diaplay"
                    },500)
                }else {
                    layer.msg("请确认是否登录")

                }
            })

            return false;
        });

        if(msg === "未登录"){
            layer.msg('未登录', {
                offset: '115px'
                ,icon: 2
                ,time: 1000
            });
        }


    });


    function querys(content) {
        if(content){
            location.href="${pageContext.request.contextPath}/topics/persondiaplay?page=1&limit="+'${pageSize}'+"&content="+content
        }else {
            location.href="${pageContext.request.contextPath}/topics/persondiaplay?page=1&limit="+'${pageSize}'
        }
    }

    function delTopics(id) {

        layer.confirm('确定删除', function(index){
            $('#'+id).remove()
            $.get("${pageContext.request.contextPath}/topics/delete?id="+id,function (date) {
                layer.msg('已删除!',{icon:1,time:1000});
            })
            layer.close(index);
        });

    }

    function delComment(id) {

        layer.confirm('确定删除', function(index){
            $('#'+id).remove()
            $('#'+id+'hr').remove()
            $.get("${pageContext.request.contextPath}/comment/delete?id="+id,function (date) {
                layer.msg('已删除!',{icon:1,time:1000});
            })
            layer.close(index);
        })
    }


    function comments(tid,aId,username){
        var title= "说点什么吧"
        if(username){
            title="回复 "+username
        }


        layer.prompt({
            title: title
            ,formType: 2
            ,value: ''
        }, function(value, index){

            var comment = {
                topicId:tid
                ,toUid:aId
                ,content:value
            }
            $.post("${pageContext.request.contextPath}/comment/add",comment,function (data) {
                console.log(data)
                if(data){
                    location.href="${pageContext.request.contextPath}/topics/diaplay"
                }else {
                    layer.msg("请确认是否登录")
                }
            })

            layer.close(index);
        });
    }



</script>
</body>
</html>