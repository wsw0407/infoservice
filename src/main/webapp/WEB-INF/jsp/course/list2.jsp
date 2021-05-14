<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>课程列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <style>

        .layui-table-header .layui-table thead tr th{
            background: #FFFFFF !important;
            align-content: center;
            text-align: center;
        }

        .layui-table-body .layui-table tbody tr {
            height: 100px !important;
        }


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

        textarea {

            resize: none;
        }

        .open-css{
            border: 1px solid #5FB878;
        }



    </style>

</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">

            <div class="layui-card" >
                <div class="layui-card-body">
                    <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>
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

        var tableIns = table.render({
            elem: '#test-table-toolbar'
            ,toolbar: 'default'
            ,url:'${pageContext.request.contextPath}/classchedule/course'
            ,title: '资源数据表'
            ,cols: [[
                {field:'space', align:'center',title:'',}
                ,{field:'monday', align:'center',title:'monday',edit: 'text', width:'15%'}
                ,{field:'tuesday',title:'tuesday', width:'15%', event:"cellClick"}
                ,{field:'wednesday', align:'center',title:'wednesday', width:'15%',edit: 'text'}
                ,{field:'thursday', align:'center',title:'thursday', width:'15%',edit: 'text'}
                ,{field:'friday', align:'center',title:'friday', width:'15%',edit: 'text'}
                ,{field:'saturday', align:'center',title:'saturday', width:'15%',edit: 'text'}

            ]]
            , done:function(res){
                $('#layui-table-page1').attr('style','margin-left:300px')
                var data = res.data;
            }
            ,page: true
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
                        url: '${pageContext.request.contextPath}/notice/list?content='+queryContent
                    })
                });
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/notice/list?content='+queryContent
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

                    console.log(layui.table.cache["test-table-toolbar"])

                    break;
                case 'add':

                    break;
                case 'update':

                    break;
            };
        });



        table.on('tool()', function(obj){
            switch(obj.event){
                case 'cellClick':
                    CellClick(this,obj);
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
                    $.get("${pageContext.request.contextPath}/notice/delete?id="+data.id);
                    layer.msg('已删除!',{icon:1,time:1000});
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                // var limit = tableIns.config.page.limit
                // var page = tableIns.config.page.curr
                // var  queryContent = $('#queryContent').val()
                // var pageInfo = queryContent+','+page+','+limit
                // console.log(pageInfo)
                // location.href = "/notice/toedit?id="+data.id+"&pageInfo="+pageInfo
                //
                layer.open({
                    type: 2
                    ,title: '修改用户'
                    ,content: '${pageContext.request.contextPath}/notice/toedit?id='+data.id
                    ,maxmin: true
                    ,shadeClose: true
                    ,area: ['100%', '100%']
                    ,success : function(layero, index){

                    }
                })


            }
        });

    });

    function queryLable(typename){
        $('#queryContent').val(typename)
        $('#queryRole').click()
    }

    $(".layui-table-body .layui-table tbody tr").on("",function () {
        alert($(':focus'))
    })

    // document.addEventListener("keyup",function(e){
    //     if(e.keyCode==13){
    //         var nodes = $(':focus')
    //         var value = nodes.val()
    //         nodes.val(value+"<br>")
    //     }
    // })

    function CellClick(that,obj){
        //当前点击字段
        var field = $(that).data("field");
        //判断是否需要添加编辑框
        if(field=="edit")return true;

        //当前行数据
        var data = obj.data;
        //当前单元格的值
        var value = data[field];

        //当前点击td的宽高
        var height = $(that)[0].offsetHeight,width = $(that)[0].offsetWidth;
        //当前点击td的坐标
        var top = $(that).offset().top,left = $(that).offset().left;

        //输入框 这里可以自定义表单内容
        var input = '<textarea  class="layui-input" id="'+field+'_input" data-field="'+field+'" style="width:'+width+'px;height:'+height+'px">';

        //弹出层
        layer.open({
            type: 1
            ,title:false
            ,page:true
            ,limit:1
            ,skin: 'open-css'
            ,closeBtn:0
            ,area: [width+"px", height+"px"]
            ,shade: [0.01, '#fff']
            ,shadeClose:true
            ,content: input //这里content是一个普通的String
            ,offset:[top,left]
            ,success:function(){
                //使弹出层相对浮动
                $(".layui-layer-page").css("position","absolute")

                //设置输入框的值
                var valueDisplay = null
                if(value != null){
                    valueDisplay = value.replaceAll('<br/>','\n');
                }
                console.log(valueDisplay)

                $("#"+field+"_input").val(valueDisplay);


                $("#"+field+"_input").blur(function(){
                    //同步更新缓存对应的值
                    var content = $(this).val().replaceAll('\n','<br/>');
                    data[field] = content
                    console.log(content)
                    console.log(data[field])
                    obj.update(data);
                })
            }
        });
    }


</script>
</body>
</html>
