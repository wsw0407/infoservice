<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xm-select.js"></script>

</head>
<body>
<div id="demo1" class="xm-select-demo"></div>
<button class="btn" id="demo1-getValue">获取选中值</button>
<pre id="demo1-value"></pre>

<script>
    var demo1 = xmSelect.render({
        el: '#demo1',
        language: 'zn',
        tips: '你喜欢什么水果呢?',
        empty: '呀, 没有数据呢',
        filterable: true,
        theme: {
            color: '#0081ff',
        },
        toolbar: {show: true},
        data: [
            {name: '张三', value: 1,selected: true},
            {name: '李四', value: 2},
            {name: '王五', value: 3},
        ]
    })

    document.getElementById('demo1-getValue').onclick = function(){
        //获取当前多选选中的值
        var selectArr = demo1.getValue();
        document.getElementById('demo1-value').innerHTML = JSON.stringify(selectArr, null, 2);
    }
</script>
</body>
</html>
