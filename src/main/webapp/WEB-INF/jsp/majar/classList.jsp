<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>学院专业信息列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <style>
        .layui-table-cell {
            font-size:14px;
            padding:0 5px;
            height:auto;
            line-height:22px;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-all;
        }

        .layui-table-header .layui-table thead tr th{
            align-content: center;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">

            <div class="layui-card" style="padding-bottom: 20px">

                <div class="layui-card-body">

                    <div class="x-nav" style="margin-left: 20px;margin-right: 20px">
                    <span class="layui-breadcrumb">
                     <a>${majar.institute}</a>
                     <a><cite>${majar.majarname}</cite></a>
                    </span>
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
    var id = '${majarId}'

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
            ,url: '${pageContext.request.contextPath}/adminclass/classList?id='+id
            ,toolbar: 'default'
            ,cellMinWidth: 60
            ,title: '班级数据表'
            ,height : 'full-100'
            ,cols: [[
                {type: 'checkbox'}
                ,{field:'id', title:'ID',align:'center',width: 120 , unresize: true, sort: true}
                ,{field:'classnum',title:'行政班级',edit:"text"}
                ,{fixed: 'right', align:'center',title:'操作', toolbar: '#test-table-toolbar-barDemo',width: 200}
            ]]

            , id: 'reload' //用于绑定模糊查询条件等等
            , done:function(res){
                $('#layui-table-page1').attr('style','margin-left:300px')
                var data = res.data;


                parent.$('#queryRole').trigger("click");

            }
            , loading: false //请求数据时，是否显示loading
        });

        $('#queryRole').on('click', function(event,froms){
            //当编辑框关闭时，从edit的页面触发的查询方法来刷新table;
            //使用parent.location会是页面整个刷新，使用open弹框的end属性会关闭弹窗就刷新
            var  queryContent = $('#queryContent').val()
            if(froms){

                layer.msg('修改成功', {
                    offset: '15px'
                    ,icon: 1
                    ,time: 1000
                },function () {
                    tableIns.reload({
                        url:  '${pageContext.request.contextPath}/majar/list?content='+queryContent
                    })
                });
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/majar/list?content='+queryContent
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
                            }
                            $.each(checkedArr, function(k){
                                $(".layui-table-view .layui-table tbody tr[data-index="+checkedArr[k]+"]").remove();
                            });
                            $.post("${pageContext.request.contextPath}/adminclass/deleteIds",{ids}, (res) => {
                                var  queryContent = $('#queryContent').val()
                                tableIns.reload()
                                layer.msg('已删除!',{icon:1,time:1000});
                            })
                            layer.close(index);
                        });
                    }
                    break;
                case 'add':
                    layer.prompt({
                        formType: 2
                        ,title:'添加新班级'
                        ,area:['250px','80px']
                        ,value: ''
                        ,btn: ['提交','取消']
                    }, function(value, index){
                        $.get("${pageContext.request.contextPath}/adminclass/add?classnum="+value+"&majarId="+id);

                        layer.msg('已添加',{icon:1,time:1000},function () {
                            tableIns.reload()
                        });

                        layer.close(index);
                    });

                    break;
                case 'update':
                    var data = (checkStatus.data);

                    console.log(data)

                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.prompt({
                            formType: 2
                            ,title:'添加新班级'
                            ,area:['250px','80px']
                            ,value: data[0].classnum
                            ,btn: ['提交','取消']
                        }, function(value, index){
                            $.get("${pageContext.request.contextPath}/adminclass/add?classnum="+value+"&majarId="+id+"&id="+data[0].id);

                            layer.msg('已修改',{icon:1,time:1000},function () {
                                tableIns.reload()
                            });

                            layer.close(index);
                        });
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test-table-toolbar)', function(obj){
            var data = obj.data;
            console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('确定删除', function(index){
                    obj.del();
                    $.get("${pageContext.request.contextPath}/adminclass/delete?id="+data.id);
                    layer.msg('已删除!',{icon:1,time:1000});
                    tableIns.reload()
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){

                $.get("${pageContext.request.contextPath}/adminclass/add?classnum="+data.classnum+"&majarId="+id+"&id="+data.id);

                layer.msg('已修改',{icon:1,time:1000},function () {
                    tableIns.reload()
                });
            }

        });

    });

    function queryLable(typename){
        $('#queryContent').val(typename)
        $('#queryRole').click()
    }

</script>
</body>
</html>
