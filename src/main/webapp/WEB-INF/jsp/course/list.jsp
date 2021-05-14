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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xm-select.js"></script>
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
<body style="background: #F2F2F2">

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">

        <form class="layui-form" action="" >

            <div class="layui-form-item">
                <div class="layui-inline" style="margin-right: 5px;width: 400px;">
                    <label class="layui-form-label" >学年学期</label>
                    <div class="layui-input-inline">
                        <div id="term" style="width: 250px" class="xm-select-demo"></div>
                    </div>
                </div>
                <div class="layui-inline" style="margin-right: 5px;width: 400px;">
                    <label class="layui-form-label" >行政班级</label>
                    <div class="layui-input-inline">
                        <div id="adminClass" style="width: 250px" class="xm-select-demo"></div>
                    </div>
                </div>

                <div class="layui-inline" style="margin-right: 5px;width: 100px;">
                    <div class="layui-input-inline">
                        <button type="button"  id="queryRole" class="layui-btn" ><i class="layui-icon">&#xe615;</i></button>
                    </div>
                </div>

            </div>

        </form>


        <div class="layui-col-md12" id="classTable" style="margin-top: -27px">
            <div class="layui-card" >
                <div class="layui-card-body">
                    <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>
                </div>
            </div>
        </div>
    </div>
</div>


<div style="position: absolute;top:10px;left: 0;z-index: -1" >

    <div class="layui-col-md12"  style="margin-top: -27px">
        <div class="layui-card" id="classimages">
            <div class="layui-card-body">
                <table class="layui-hide" id="images" lay-filter="test-table-toolbar"></table>
            </div>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
<script>

    var term;
    var adminClass;
    var first = true;

    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table','form'], function(){
        var admin = layui.admin
            ,form = layui.form
            ,table = layui.table;

        var tableIns = table.render({
            elem: '#test-table-toolbar'
            ,defaultToolbar: [ {
                title: '导出图片' //标题
                ,layEvent: 'downImg' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon-picture' //图标类名
            },'filter', 'print', 'exports']
            ,toolbar: 'defaultToolbar'
            ,toolbar: 'default'
            ,url:'${pageContext.request.contextPath}/classchedule/course'
            ,title: '资源数据表'
            ,cols: [[
                {field:'space', align:'center',title:'',}
                ,{field:'monday',title:'monday',width:'15%',edit: 'textarea'}
                ,{field:'tuesday',title:'tuesday',width:'15%',edit: 'textarea'}
                ,{field:'wednesday',title:'wednesday',width:'15%',edit: 'textarea'}
                ,{field:'thursday',title:'thursday',width:'15%',edit: 'textarea'}
                ,{field:'friday',title:'friday',width:'15%',edit: 'textarea'}
                ,{field:'saturday',title:'saturday',width:'15%',edit: 'textarea'}

            ]]
            , done:(res) => {
                $('#layui-table-page1').attr('style','margin-left:300px')
                var data = res.data;
                if(!first){
                    layer.msg(res.msg)
                }
                console.log(res)
                first = true
            }
            , loading: true //请求数据时，是否显示loading
        });


        var tableIns01 = table.render({
            elem: '#images'
            ,defaultToolbar: [ {
                title: '导出图片' //标题
                ,layEvent: 'downImg' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon-picture' //图标类名
            },'filter', 'print', 'exports']
            ,toolbar: 'defaultToolbar'
            ,toolbar: 'default'
            ,url:'${pageContext.request.contextPath}/classchedule/course'
            ,title: '资源数据表'
            ,width:'1078'
            ,cols: [[
                {field:'space', align:'center',width:'50',title:'',}
                ,{field:'monday',title:'monday',width:'170',edit: 'textarea'}
                ,{field:'tuesday',title:'tuesday',width:'170',edit: 'textarea'}
                ,{field:'wednesday',title:'wednesday',width:'170',edit: 'textarea'}
                ,{field:'thursday',title:'thursday',width:'170',edit: 'textarea'}
                ,{field:'friday',title:'friday',width:'170',edit: 'textarea'}
                ,{field:'saturday',title:'saturday',width:'170',edit: 'textarea'}

            ]]
            , done:(res) => {
                $('#layui-table-page1').attr('style','margin-left:300px')
                var data = res.data;
                if(!first){
                    layer.msg(res.msg)
                }
                console.log(res)
                first = true
            }
            , loading: true //请求数据时，是否显示loading
        });


        form.render();
        layui.form.render();

        $('#queryRole').on('click', function(event,froms){
            //当编辑框关闭时，从edit的页面触发的查询方法来刷新table;
            //使用parent.location会是页面整个刷新，使用open弹框的end属性会关闭弹窗就刷新
            var termArr = term.getValue();
            console.log(termArr)
            var adminClassArr = adminClass.getValue();
            console.log(adminClassArr)

            if(termArr.length == 0){
                layer.msg('请先选择学期')
                return;
            }
            if(adminClassArr.length == 0){
                layer.msg('请先选择行政班级')
                return;
            }
            first = false
            tableIns.reload({
                url: '${pageContext.request.contextPath}/classchedule/course?term='+termArr[0].value+'&adminClass='+adminClassArr[0].value
            })

            tableIns01.reload({
                url: '${pageContext.request.contextPath}/classchedule/course?term='+termArr[0].value+'&adminClass='+adminClassArr[0].value
            })
        });

        //头工具栏事件
        table.on('toolbar(test-table-toolbar)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var termArr = term.getValue();
            console.log(termArr)
            var adminClassArr = adminClass.getValue();
            console.log(adminClassArr)




            console.log('res')
            var courseInfo = layui.table.cache["test-table-toolbar"]
            console.log(layui.table.cache["test-table-toolbar"])

            switch(obj.event){
                case 'delete':

                    if(termArr.length == 0){
                        layer.msg('请先选择学期')
                        return;
                    }
                    if(adminClassArr.length == 0){
                        layer.msg('请先选择行政班级')
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url: "${pageContext.request.contextPath}/classchedule/exist?term="+termArr[0].value+'&adminClass='+adminClassArr[0].value,
                        success:function(data){
                             if(data == 0){
                                 layer.msg("课程不存在")
                             }else {
                                 layer.confirm('课程存在，确定删除？', function(index){
                                     $.get("${pageContext.request.contextPath}/classchedule/delete?id="+data);
                                     layer.msg('已删除!',{icon:1,time:1000});
                                     tableIns.reload()
                                     tableIns01.reload()
                                     layer.close(index);

                                 });
                             }
                        }
                    });
                    break;
                case 'add':

                    if(termArr.length == 0){
                        layer.msg('请先选择学期')
                        return;
                    }
                    if(adminClassArr.length == 0){
                        layer.msg('请先选择行政班级')
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url: "${pageContext.request.contextPath}/classchedule/add?term="+termArr[0].value+'&adminClass='+adminClassArr[0].value,
                        dataType:"text",
                        contentType:"application/json", // 指定这个协议很重要
                        data:JSON.stringify(courseInfo), //只有这一个参数，json格式，后台解析为实体，后台可以直接用
                        success:function(data){
                            console.log('data')
                            layer.msg(data)
                            if(data = '添加成功'){
                                tableIns.reload()
                                tableIns01.reload()
                            }
                            console.log(data)
                        }
                    });

                    break;
                case 'update':

                    if(termArr.length == 0){
                        layer.msg('请先选择学期')
                        return;
                    }
                    if(adminClassArr.length == 0){
                        layer.msg('请先选择行政班级')
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url: "${pageContext.request.contextPath}/classchedule/edit?term="+termArr[0].value+'&adminClass='+adminClassArr[0].value,
                        dataType:"text",
                        contentType:"application/json", // 指定这个协议很重要
                        data:JSON.stringify(courseInfo), //只有这一个参数，json格式，后台解析为实体，后台可以直接用
                        success:function(data){
                            console.log('data')
                            layer.msg(data)
                            if(data = '修改成功'){
                                tableIns.reload()
                                tableIns01.reload()
                            }
                            console.log(data)
                        }
                    });
                    break;
                case 'downImg':
                    layer.msg('图片正在导出', {
                        offset: '15px'
                        ,icon: 1
                        ,time: 1000
                    });
                    initExportImage()
                    break;
            };
        });

    });



    $.get("${pageContext.request.contextPath}/term/listAll",(data) => {

        let datas = [];
        data.forEach(function(e){
            datas.push({ name:e.term , value:e.id})
        });
        console.log('datas')
        console.log(datas)

        this.term = xmSelect.render({
            el: '#term',
            language: 'zn',
            tips: '　　请选择学年学期',
            empty: '呀, 没有数据呢',
            max: 1,
            radio: true,
            clickClose: true,
            filterable: true,
            theme: {
                color: '#0081ff',
                maxColor: 'orange',
            },
            data: datas
        })

    });


    $.get("${pageContext.request.contextPath}/adminclass/listAll",function(data){

        let datas = [];
        data.forEach(function(e){
            datas.push({ name:e.classnum , value:e.id})
        });
        console.log('datas')
        console.log(datas)

        adminClass = xmSelect.render({
            el: '#adminClass',
            language: 'zn',
            tips: '　　请选择行政班级',
            empty: '呀, 没有数据呢',
            radio: true,
            clickClose: true,
            max: 1,
            filterable: true,
            theme: {
                color: '#0081ff',
                maxColor: 'orange',
            },
            data: datas
        })

    });

    function queryLable(typename){
        $('#queryContent').val(typename)
        $('#queryRole').click()
    }

    $(".layui-table-body .layui-table tbody tr").on("",function () {
        alert($(':focus'))
    })


   /* $("#imageExport").click(function () {
        alert('-------')
        initExportImage();

    });*/


    function initExportImage() {
        //要导出的html的内容
        var oDiv = document.getElementById("classimages");
        html2canvas(oDiv).then(function (canvas) {


            /* 1. 创建要导出的html的容器
              let htmlElement = document.createElement('div');
              htmlElement.id = 'imageExportDiv';
              htmlElement.style.display = 'none';
              document.body.appendChild(htmlElement);

              //把要导出的html转化为canvas,然后渲染到容器中，实际导出的图片就是我的容器中的canvas
              document.getElementById("imageExportDiv").appendChild(canvas);
              */
            /* var strDataURI = canvas.toDataURL('image/jpeg',0.1);//调小就可以了.图片太大总是发生网络错误的问题
             downLoadFn(strDataURI);*/

            /*2。下载图片，图片的大小比较小 推荐使用*/
            downloadFile(canvas.toDataURL('image/png',1),"课程信息导出.png")
        });
    }

    /*解码后转化为blob使用，可以把base64的大文件变为小文件，下载就不会出现错误了*/
    function downloadFile(content, fileName) { //下载base64图片
        var base64ToBlob = function(code) {
            let parts = code.split(';base64,');
            let contentType = parts[0].split(':')[1];
            let raw = window.atob(parts[1]);
            let rawLength = raw.length;
            let uInt8Array = new Uint8Array(rawLength);
            for(let i = 0; i < rawLength; ++i) {
                uInt8Array[i] = raw.charCodeAt(i);
            }
            return new Blob([uInt8Array], {
                type: contentType
            });
        };
        let aLink = document.createElement('a');
        let blob = base64ToBlob(content); //new Blob([content]);
        let evt = document.createEvent("HTMLEvents");
        evt.initEvent("click", true, true); //initEvent 不加后两个参数在FF下会报错  事件类型，是否冒泡，是否阻止浏览器的默认行为
        aLink.download = fileName;
        aLink.href = URL.createObjectURL(blob);
        //aLink.click();
        aLink.dispatchEvent(new MouseEvent('click', {bubbles: true, cancelable: true, view: window}));//兼容火狐
    };

    function downLoadFn(url) {
        if (myBrowser() === "IE" || myBrowser() === "Edge") {
            SaveAs5(url);
        }
        else { download(url); } }
    //判断浏览器类型

    function myBrowser() {
        var userAgent = navigator.userAgent;
        //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1;
        if (isOpera) { return "Opera" } ;
        //判断是否Opera浏览器
        if (userAgent.indexOf("Firefox") > -1) {
            return "FF"; }
        //判断是否Firefox浏览器
        if (userAgent.indexOf("Chrome") > -1)
        { return "Chrome"; }
        if (userAgent.indexOf("Safari") > -1)
        { return "Safari"; }
        //判断是否Safari浏览器
        if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera)
        { return "IE"; } ;
        //判断是否IE浏览器
        if (userAgent.indexOf("Trident") > -1)
        { return "Edge"; } //判断是否Edge浏览器
    }
    //IE浏览器图片保存本地
    function SaveAs5(imgURL) {
        var oPop = window.open(imgURL, "", "width=1, height=1, top=5000, left=5000");
        for (; oPop.document.readyState != "complete";)
        { if (oPop.document.readyState == "complete") break; }
        oPop.document.execCommand("SaveAs"); oPop.close(); }



    // chrome14+,firefox20+,pera15+,Edge 13+,Safari未实现


    function download(strDataURI) {
        //创建一个下载的a标签
        var link = document.createElement('a');
        //设置a标签的文字<a>下载</a>
        link.innerHTML = '导出';
        //下载的图片的名称
        link.download = 'coursePlan.png';
        link.id = 'aa';
        //a标签的点击事件
        link.addEventListener('click', function (ev) {
            link.href = strDataURI; }, false);
        $("#imageExport").html(link);
        //可以把创建的a标签放到指定的标签中 //直接下载，文件图片太大会出现问题,出现网络问题，下载出错
        link.dispatchEvent(new MouseEvent('click', {
            bubbles: true, cancelable: true, view: window}));
        //兼容火狐 //
        link.click();//直接点击也可
    };
</script>



</body>
</html>

