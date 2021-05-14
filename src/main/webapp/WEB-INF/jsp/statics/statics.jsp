<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>数据报表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style/admin.css" media="all">
    <script src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/china.js"></script>

</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">

        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">
                    访问量
                    <span class="layui-badge layui-bg-blue layuiadmin-badge">月</span>
                </div>
                <div class="layui-card-body layuiadmin-card-list">
                    <p class="layuiadmin-big-font">${visitCountMounth}</p>
                    <p>
                        总计访问量
                        <span class="layuiadmin-span-color">${visitCount}<i class="layui-inline layui-icon layui-icon-flag"></i></span>
                    </p>
                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">
                    资源
                    <span class="layui-badge layui-bg-cyan layuiadmin-badge">总</span>
                </div>
                <div class="layui-card-body layuiadmin-card-list">
                    <p class="layuiadmin-big-font">${resourcesCount}</p>
                    <p>
                        新资源
                        <span class="layuiadmin-span-color">${resourcesCountMounth}%<i class="layui-inline layui-icon layui-icon-face-smile-b"></i></span>
                    </p>
                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">
                    公告
                    <span class="layui-badge layui-bg-green layuiadmin-badge">总</span>
                </div>
                <div class="layui-card-body layuiadmin-card-list">

                    <p class="layuiadmin-big-font">${noticeCount}</p>
                    <p>
                        进行中公告
                        <span class="layuiadmin-span-color">${noticeCounting}%<i class="layui-inline layui-icon layui-icon-read"></i></span>
                    </p>
                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">
                    系统用户
                    <span class="layui-badge layui-bg-orange layuiadmin-badge">总</span>
                </div>
                <div class="layui-card-body layuiadmin-card-list">

                    <p class="layuiadmin-big-font">${accountCount}</p>
                    <p>
                        　　
                        <span class="layuiadmin-span-color">*** <i class="layui-inline layui-icon layui-icon-user"></i></span>
                    </p>
                </div>
            </div>
        </div>
        <div class="layui-col-sm12">
            <div class="layui-card">
                <div class="layui-card-header">
                    用户行为统计

                </div>
                <div class="layui-card-body">
                    <div class="layui-row">
                        <div class="layui-col-sm8">
                            <div class="layui-card-body">
                                <div id="visitChar" style="padding:5px; width:100%; height:400px;"></div>
                            </div>
                        </div>



                        <div class="layui-col-sm4">
                            <div class="layuiadmin-card-list" style="margin-top: 50px">
                                <p class="layuiadmin-normal-font">月访问量</p>
                                <span>同年占比</span>
                                <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                    <div class="layui-progress-bar" style="background: #FC5531;" lay-percent="${visitPercent}%"></div>
                                </div>
                            </div>
                            <div class="layuiadmin-card-list">
                                <p class="layuiadmin-normal-font">月发帖量</p>
                                <span>同年占比</span>
                                <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                    <div class="layui-progress-bar" style="background: #5C7BD9;" lay-percent="${topicsPercent}%"></div>
                                </div>
                            </div>
                            <div class="layuiadmin-card-list">
                                <p class="layuiadmin-normal-font">月上传资源量</p>
                                <span>同年占比</span>
                                <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                    <div class="layui-progress-bar" style="background: #15ac15;" lay-percent="${resourcesPercent}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <div class="layui-col-sm12" style="height: 300px">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-sm4">
                    <div class="layui-card">
                        <div class="layui-card-header">用户男女比例</div>
                        <div class="layui-card-body">
                                <div id="sexpiechart" style="border: 2px solid rosybrown; width:100%; height:400px;"></div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-sm8">
                    <div class="layui-card">
                        <div class="layui-card-header">用户全国分布</div>
                        <div class="layui-card-body">
                            <div id="distributionmap" style="border: 2px solid rosybrown; width:100%; height:400px;"></div>

                        </div>
                    </div>
                </div>


            </div>
        </div>

    </div>
</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

<script src="${pageContext.request.contextPath}/assets/layui/layui.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/assets/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'sample']);

    var sexpiechart = echarts.init(document.getElementById('sexpiechart'));

    $.ajax({
        method:'post',
        url:'${pageContext.request.contextPath}/statics/sexStatis',
        dataType:'json',
        success:function(data) {
            console.log(data);
            var  option = {
                title: {
                    text: '用户男女比例',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                },
                series: [
                    {
                        name: '访问来源',
                        type: 'pie',
                        zoom: 2.2,

                        radius: '80%',
                        center: ['50%', '55%'],
                        data:data,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            sexpiechart.setOption(option)
        }
    })


    var visitChar = echarts.init(document.getElementById('visitChar'));

    $.ajax({
        method:'post',
        url:'${pageContext.request.contextPath}/statics/lineStatis',
        dataType:'json',
        success:function(data) {

            console.log(data)

            var option = {
                title: {
                    text: ''
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['访问量', '发帖量', '资源上传']
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['一月', '二月', '三月', '四月','五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: '访问量',
                        type: 'line',
                        stack: '总量1',
                        itemStyle : {
                            normal : {
                                color:'#FC5531',
                                lineStyle:{
                                    color:'#FC5531'
                                }
                            }
                        },
                        data: data.visitdata
                    },
                    {
                        name: '发帖量',
                        type: 'line',
                        stack: '总量2',
                        itemStyle : {
                            normal : {
                                color:'#5C7BD9',
                                lineStyle:{
                                    color:'#5C7BD9'
                                }
                            }
                        },
                        data: data.topicdata
                    },
                    {
                        name: '资源上传',
                        type: 'line',
                        stack: '总量3',
                        itemStyle : {
                            normal : {
                                color:'#15ac15',
                                lineStyle:{
                                    color:'#15ac15'
                                }
                            }
                        },
                        data:data.resourcedata
                    }

                ]
            };

            visitChar.setOption(option)
        }
    })



    var distributionmap = echarts.init(document.getElementById('distributionmap'));

    var citys = [
        {name: '北京',value: 0},
        {name: '天津',value: 0},
        {name: '上海',value: 0},
        {name: '重庆',value: 0},
        {name: '河北',value: 0},
        {name: '河南',value: 0},
        {name: '云南',value: 0},
        {name: '辽宁',value: 0},
        {name: '黑龙江',value: 0},
        {name: '湖南',value: 0},
        {name: '安徽',value: 0},
        {name: '山东',value: 0},
        {name: '新疆',value: 0},
        {name: '江苏',value: 0},
        {name: '浙江',value: 0},
        {name: '江西',value: 0},
        {name: '湖北',value: 0},
        {name: '广西',value: 0},
        {name: '甘肃',value: 0},
        {name: '山西',value: 0},
        {name: '内蒙古',value: 0},
        {name: '陕西',value: 0},
        {name: '吉林',value: 0},
        {name: '福建',value: 0},
        {name: '贵州',value: 0},
        {name: '广东',value: 0},
        {name: '青海',value: 0},
        {name: '西藏',value: 0},
        {name: '四川',value: 0},
        {name: '宁夏',value: 0},
        {name: '海南',value: 0},
        {name: '台湾',value: 0},
        {name: '香港',value: 0},
        {name: '澳门',value: 0}
    ];



    $.ajax({
        method:'post',
        url:'${pageContext.request.contextPath}/statics/personDistribut',
        dataType:'json',
        success:function(data) {

            console.log(data)
            data.forEach(function (e) {
                citys.forEach(function (city) {
                    if (city.name.startsWith(e.name)) {
                        city.value = e.value
                    }
                })
            })

            var option = {
                title : {
                    text: '用户分布',

                    x:'center'
                },
                tooltip : {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    x:'left',
                    data: ['人员']
                },
                dataRange: {
                    min: 0,
                    max: 2500,
                    x: 'left',
                    y: 'bottom',
                    text:['高','低'],           // 文本，默认为数值文本
                    calculable : true,
                    inRange: {
                        color: ['#e0ffff', '#58aaeb'],
                        symbolSize: [30, 100]
                    }
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    left: 'right',
                    top: 'center',
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                roamController: {
                    show: true,
                    x: 'right',
                    mapTypeControl: {
                        'china': true
                    }
                },
                series : [
                    {
                        name: '人员',
                        type: 'map',
                        mapType: 'china',
                        zoom:1.18,
                        roam: false,
                        itemStyle:{
                            normal:{label:{show:false},color:'#05518e'},
                            emphasis:{label:{show:true},
                                areaColor: 'red',
                                label: {
                                    show: true,
                                    textStyle: {
                                        color: '#000'
                                    }
                                }}
                        },
                        data:citys
                    }

                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            distributionmap.setOption(option);

        }
    })

</script>
</body>
</html>
