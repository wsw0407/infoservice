<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户账号信息列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <style>
        html body{
            height: 100%;
            margin: 0; padding: 0;
        }
    </style>
</head>
<body>

<div class="layui-fluid"  >
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12" >

            <div class="layui-card">

                <div class="x-nav" style="margin-left: 20px;margin-right: 20px">
                    <span class="layui-breadcrumb">
                     <a href="">首页</a>
                    <a>
                    <cite>用户信息</cite></a>
                    </span>
                    <button type="button" id="adds"  onclick="location.href='${pageContext.request.contextPath}/users/toaddAccount'" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:inherit;margin-left:75%;;"  ><i class="layui-icon"></i>增加</button>
                    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="${pageContext.request.contextPath}/users/listpage" title="刷新">
                        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
                </div>


                <div class="layui-card-body">

                    <div class="layui-row" align="center" style="height: 40px">

                            <form class="layui-form layui-col-md12 x-so" method="get" action="#">
                                <input type="text" id="queryContent" name="content" style="width:50%;"  placeholder="请输入地址或专业查找用户" autocomplete="off" class="layui-input" >
                                <button type="button"   class="layui-btn" style="margin-top: -65px;margin-left: 50%"  data-type="reload" id="queryRole"><i class="layui-icon">&#xe615;</i></button>
                            </form>

                    </div>


                    <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>

                    <script type="text/html" id="test-table-toolbar-barDemo">
                        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                    </script>

                </div>


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
    }).use(['index', 'table'], function(){
        var admin = layui.admin
            ,form = layui.form
            ,table = layui.table;

        var tableIns= table.render({
            elem: '#test-table-toolbar'
            ,url: '${pageContext.request.contextPath}/users/list'
            ,toolbar: 'default'
            ,title: '用户数据表'
            ,height : 'full-133'
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'username', title:'用户昵称', width:100}
                ,{field:'realname', title:'姓名', width:100}
                ,{field:'email', title:'邮箱', width:180}
                ,{field:'phone', title:'手机号', width:120}
                ,{field:'sexname', title:'性别', width:70}
                ,{field:'address', title:'住址', width:100}
                ,{field:'classnum', title:'班级',width:100}
                ,{field:'majarname', title:'专业', width:150}
                ,{field:'account', title:'账号', width:120}
                ,{fixed: 'right', title:'操作', toolbar: '#test-table-toolbar-barDemo', width:150}
            ]]
            , page:{
                layout:["first","prev","page","next","count","limit","skip","last"]
                , limit: 10 //默认分页条数
                , limits: [1,2,3,5,10,15] //自定义分页数据选项
            }
            , id: 'reload' //用于绑定模糊查询条件等等
            , done:function(res){
                $('#layui-table-page1').attr('style','margin-left:300px')
                var data = res.data;
            }
            , loading: false //请求数据时，是否显示loading
        });

        $('#queryRole').on('click', function(event,froms){
            //当编辑框关闭时，从edit的页面触发的查询方法来刷新table;
            //使用parent.location会是页面整个刷新，使用open弹框的end属性会关闭弹窗就刷新
            var  queryContent = $('#queryContent').val()
            if(froms){
                tableIns.reload({
                    url: '${pageContext.request.contextPath}/users/list?content='+queryContent
                })
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/users/list?content='+queryContent
                ,page: {
                    curr:1
                }
            })
        });

        var checkedArr=[];
        table.on('checkbox(test-table-toolbar)', function(obj){
            if (obj.type=='all') {
                if(obj.checked){
                    checkedArr = []
                    var leng = ($(".layui-table-view .layui-table tbody tr td[data-field='id']").length)/2
                    for (var i=0; i<leng ; i++){
                        checkedArr.push(i+'');
                    }
                }else {
                    checkedArr = []
                }
                console.log(checkedArr)
                return;
            }

            if (obj.checked){
                checkedArr.push($(obj.tr).attr("data-index"));
            }
            else{
               // alert($(obj.tr).attr("data-index"))
                var num = $(obj.tr).attr("data-index")

                checkedArr.splice($.inArray(num,checkedArr),1);
            }
            console.log(checkedArr)
        });


        //头工具栏事件
        table.on('toolbar(test-table-toolbar)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);

            switch(obj.event){
                case 'delete':
                    var data = checkStatus.data;
                    var ids = []
                    data.forEach(function (e) {
                        ids.push(e.id)
                    })
                    if( ids=="" || ids==null){
                        layer.msg('请先选中数据',{icon:2,time:1000,offset: [100]});
                    }else {
                        console.log(checkStatus)
                        layer.confirm('确定删除'+ids.length+'数据', function(index){

                            if (checkStatus.isAll){
                                checkedArr = []
                                for (var i=0; i<data.length ; i++){
                                    checkedArr.push(i+'');
                                }
                                console.log(checkedArr)
                            }
                            $.each(checkedArr, function(k){
                                $(".layui-table-view .layui-table tbody tr[data-index="+checkedArr[k]+"]").remove();
                            });
                            $.post("${pageContext.request.contextPath}/users/deleteIds",{ids}, (res) => {
                                console.log(tableIns)
                                // var  queryContent = $('#queryContent').val()
                                // tableIns.reload({
                                //     url: 'http://localhost:8080/users/list?content='+queryContent
                                // })
                            })

                            layer.close(index);
                        });

                    }

                    break;
                case 'add':
                    $("#adds").click()
                    break;
                case 'update':
                    var data = (checkStatus.data)[0];

                    if((checkStatus.data).length === 0){
                        layer.msg('请选择一行');
                    } else if((checkStatus.data).length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {

                        var index = layer.open({
                            type: 2,
                            title: "修改用户账号信息",
                            area: ['450px', '500px'],
                            fix: false,
                            maxmin: true,//开启最大化最小化按钮
                            offset:["10px" ,"30%"],
                            shadeClose: true,
                            shade: 0.4,
                            skin: 'layui-layer-rim',
                            content: ["${pageContext.request.contextPath}/users/toedit", "no"],
                            end: function() {
                                //tableIns.reload({})
                            },
                            success : function(layero, index){
                                var body = layui.layer.getChildFrame('body', index);
                                if(data){

                                    body.find("#LAY-user-login-account").val(data.account)
                                    body.find("#LAY-user-login-realname").val(data.realname)
                                    body.find("#userid").val(data.userid)
                                    body.find("#id").val(data.id)
                                    body.find("#LAY-user-login-username").val(data.username)
                                    layer.load();
                                    //此处演示关闭
                                    setTimeout(function(){
                                        layer.closeAll('loading');
                                    }, 2000)
                                    //弹窗里的二级联动的触发，和赋值，数据从后台加载需要时间
                                    setTimeout(function () {
                                            body.find('select[name="majarId"]').next().find('.layui-anim').children('dd[lay-value="'+data.majarId+'"]').click();
                                            setTimeout(function () {
                                                body.find('select[name="inclass"]').next().find('.layui-anim').children('dd[lay-value="'+data.inclass+'"]').click();
                                            },230)
                                        }
                                        ,230)
                                    form.render();
                                }
                            }
                        });

                    }
                    break;
            };
        });

        // table.on('row(test-table-toolbar)', function (obj) {
        //     var data = obj.data;
        //     layer.alert(JSON.stringify(data));
        // });

        //监听行工具事件
        table.on('tool(test-table-toolbar)', function(obj){
            var data = obj.data;
            // console.log(data)
            console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('确定删除', function(index){
                    obj.del();
                    $.get("${pageContext.request.contextPath}/users/delete?id="+data.id);
                    layer.msg('已删除!',{icon:1,time:1000});
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                var index = layer.open({
                    type: 2,
                    title: "修改用户账号信息",
                    area: ['450px', '500px'],
                    fix: false,
                    maxmin: true,//开启最大化最小化按钮
                    offset:["10px" ,"30%"],
                    shadeClose: true,
                    shade: 0.4,
                    skin: 'layui-layer-rim',
                    content: ["${pageContext.request.contextPath}/users/toedit", "no"],
                    end: function() {
                        //tableIns.reload({})
                    },
                    success : function(layero, index){
                        var body = layui.layer.getChildFrame('body', index);
                        if(data){
                            body.find("#majarSelect").val(0)
                            body.find("#LAY-user-login-account").val(data.account)
                            body.find("#LAY-user-login-realname").val(data.realname)
                            body.find("#userid").val(data.userid)
                            body.find("#id").val(data.id)
                            body.find("#LAY-user-login-username").val(data.username)
                            layer.load();
                            //此处演示关闭
                            setTimeout(function(){
                                layer.closeAll('loading');
                            }, 2000)
                            //弹窗里的二级联动的触发，和赋值，数据从后台加载需要时间
                            setTimeout(function () {
                                     body.find('select[name="majarId"]').next().find('.layui-anim').children('dd[lay-value="'+data.majarId+'"]').click();
                                 setTimeout(function () {
                                     body.find('select[name="inclass"]').next().find('.layui-anim').children('dd[lay-value="'+data.inclass+'"]').click();
                                 },230)
                                }
                                ,230)
                            form.render();
                        }
                    }
                });
            }
        });

    });

</script>
</body>
</html>
