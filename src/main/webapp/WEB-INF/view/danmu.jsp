<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
<head>
    <meta charset="utf-8">
    <title>弹幕</title>
    <link rel="stylesheet" href="<%= this.getServletContext().getContextPath() %>/css/base.css"  type="textcss" />
    <link rel="stylesheet" href="<%= this.getServletContext().getContextPath() %>/css/danmu.css"  type="textcss" />
    <script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/modernizr.custom.17774.js"></script>
    <script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/easeljs-0.8.0.min.js"></script>
    <script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/tweenjs-0.6.0.min.js"></script>
    <script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/jquery.transit.min.js"></script>
    <style>
        .danmu-box{
            padding: 20px;
            height: 100%;
        }

    </style>

    <script>
        var now=new Date().getTime();
        var danmuConfig = {
            domain: "wxscreen",
            msgUrl: "<%= this.getServletContext().getContextPath() %>/danmu/getmsg",
            canvas:  0 ,
            isDefaultStyle:  false };
        //if(window !== top) {
        //  delete danmuConfig.msgUrl;
        //}
    </script>
</head>

<body style="background:url(<%= this.getServletContext().getContextPath() %>/image/xuehua_bg.png) no-repeat;background-size:cover; ">
<div id="wrap">
    <div class="danmu-box">
        <div id="js_dRow0" class="danmu-row danmu-row1" style="top:20px;"></div>
        <div id="js_dRow1" class="danmu-row danmu-row2" style="top:100px;"></div>
        <div id="js_dRow2" class="danmu-row danmu-row3" style="top:180px;"></div>
        <div id="js_dRow3" class="danmu-row danmu-row4" style="top:260px;"></div>
        <div id="js_dRow4" class="danmu-row danmu-row5" style="top:340px;"></div>
        <div id="js_dRow5" class="danmu-row danmu-row6" style="top:420px;"></div>
        <div id="js_dRow6" class="danmu-row danmu-row7" style="top:500px;"></div>
        <div id="js_dRow7" class="danmu-row danmu-row8" style="top:580px;"></div>
        <div id="js_dRow8" class="danmu-row danmu-row9" style="top:660px;"></div>
        <div id="js_dRow9" class="danmu-row danmu-row10" style="top:740px;"></div>
        <div id="js_dRow10" class="danmu-row danmu-row11" style="top:820px;"></div>
        <div id="js_dRow11" class="danmu-row danmu-row12" style="top:900px;"></div>
        <div id="js_dRow12" class="danmu-row danmu-row13" style="top:980px;"></div>
        <div id="js_dRow13" class="danmu-row danmu-row14" style="top:1060px;"></div>
        <div id="js_dRow14" class="danmu-row danmu-row15" style="top:1140px;"></div>
        <div id="js_dRow15" class="danmu-row danmu-row16" style="top:1220px;"></div>
        <div id="js_dRow16" class="danmu-row danmu-row17" style="top:1300px;"></div>
        <div id="js_dRow17" class="danmu-row danmu-row18" style="top:1380px;"></div>
        <div id="js_dRow18" class="danmu-row danmu-row19" style="top:1460px;"></div>
        <div id="js_dRow19" class="danmu-row danmu-row20" style="top:1540px;"></div>
        <div id="js_dRow20" class="danmu-row danmu-row21" style="top:1620px;"></div>
        <div id="js_dRow21" class="danmu-row danmu-row22" style="top:1700px;"></div>
        <div id="js_dRow22" class="danmu-row danmu-row23" style="top:1780px;"></div>
        <div id="js_dRow23" class="danmu-row danmu-row24" style="top:1860px;"></div>
        <div id="js_dRow24" class="danmu-row danmu-row25" style="top:1940px;"></div>
        <div id="js_dRow25" class="danmu-row danmu-row26" style="top:2020px;"></div>
        <div id="js_dRow26" class="danmu-row danmu-row27" style="top:2100px;"></div>
        <div id="js_dRow27" class="danmu-row danmu-row28" style="top:2180px;"></div>
        <div id="js_dRow28" class="danmu-row danmu-row29" style="top:2260px;"></div>
        <div id="js_dRow29" class="danmu-row danmu-row30" style="top:2340px;"></div>
        <div id="js_dRow30" class="danmu-row danmu-row31" style="top:2420px;"></div>
        <div id="js_dRow31" class="danmu-row danmu-row32" style="top:2500px;"></div>
        <div id="js_dRow32" class="danmu-row danmu-row33" style="top:2580px;"></div>
        <div id="js_dRow33" class="danmu-row danmu-row34" style="top:2660px;"></div>
        <div id="js_dRow34" class="danmu-row danmu-row35" style="top:2740px;"></div>
        <div id="js_dRow35" class="danmu-row danmu-row36" style="top:2820px;"></div>
        <div id="js_dRow36" class="danmu-row danmu-row37" style="top:2900px;"></div>
        <div id="js_dRow37" class="danmu-row danmu-row38" style="top:2980px;"></div>
        <div id="js_dRow38" class="danmu-row danmu-row39" style="top:3060px;"></div>
        <div id="js_dRow39" class="danmu-row danmu-row40" style="top:3140px;"></div>
    </div>
    <div class="navbar" style="right: 20px;width:60px;height: 100px;margin-top: 50px;z-index:999;">

        <a class="navbaritem fullscreen" id="fullscreen" href="javascript:void(0);">
            <div class="icon"></div>
            <div class="label">全屏</div>
        </a>

    </div>

</div>
<div class="Panel Bottom" style="bottom: 0px;height:210px;">
    <div class="helperpanel pulse">
        <img class="mp_account_codeimage" src="<%=this.getServletContext().getContextPath() %>/image/qr_code.jpg">
        <img class="wenzi_code" src="<%=this.getServletContext().getContextPath() %>/image/wenzi_chengshihui.png">

    </div>

</div>
<div id="leafContainer"></div>
<div style="display: none;" class="bigmpcodebar">
    <div class="closebutton"></div>
    <div class="label">微信扫一扫，发送<span class="acivity_key">“雪花啤酒”</span>即可参与</div>
    <img src="<%= this.getServletContext().getContextPath()%>/image/qr_code.jpg">
</div>
<script type="text/javascript" src="<%= this.getServletContext().getContextPath() %>/js/danmu.min.js"></script>

<script>

    danmu.setConf(danmuConfig);
    $(function(){
        //if(danmuConfig.domain && window === top) {
        danmu.init();
        //if(window === top)
        danmu.play();
        //}
    });

    $('.mp_account_codeimage').click(function () {
        $('.bigmpcodebar').css('display', 'block');
    });

    $('.closebutton').click(function () {
        $('.bigmpcodebar').css('display', 'none');
    });

    $('#fullscreen').click(function () {

        if ($('#fullscreen').hasClass('in')) {
            exitFullscreen();
            $('#fullscreen').removeClass("in");
        } else {
            fullscreen();
            $('#fullscreen').addClass("in");
        }

    });

    function fullscreen() {
        elem = document.body;
        if (elem.webkitRequestFullScreen) {
            elem.webkitRequestFullScreen();
        } else if (elem.mozRequestFullScreen) {
            elem.mozRequestFullScreen();
        } else if (elem.requestFullScreen) {
            elem.requestFullscreen();
        } else {
            //浏览器不支持全屏API或已被禁用
        }
    }

    function exitFullscreen() {
        var elem = document;
        if (elem.webkitCancelFullScreen) {
            elem.webkitCancelFullScreen();
        } else if (elem.mozCancelFullScreen) {
            elem.mozCancelFullScreen();
        } else if (elem.cancelFullScreen) {
            elem.cancelFullScreen();
        } else if (elem.exitFullscreen) {
            elem.exitFullscreen();
        } else {
            //浏览器不支持全屏API或已被禁用
        }
    }
</script>
</body>
</html>