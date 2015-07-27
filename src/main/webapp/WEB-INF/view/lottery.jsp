<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<% String basepath= this.getServletContext().getContextPath();%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>抽奖</title>
    <link rel="stylesheet" type="text/css" href="<%=basepath%>/css/base.css">
    <link rel="stylesheet" type="text/css" href="<%=basepath%>/css/zAlert.css">

    <script type="text/javascript" src="<%= basepath %>/js/jquery-1.9.1.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basepath%>/js/zAlert.js" charset="utf-8"></script>

<link rel="stylesheet" href="<%=basepath%>/css/screen_lottery_free.css">
<script src="<%=basepath%>/js/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="<%=basepath%>/js/artDialog/plugins/iframeTools.js"></script>
</head>
<body class="FUN WALL" style="background-image:url(<%=basepath%>/image/lottery_bg.png);" >
<div class="Panel Top" style="top: 0px;">
    <img class="activity_logo" src="">

    <if condition="$info.qrcode neq ''">
        <img class="mp_account_codeimage" src="<%=basepath%>/image/qr_code.jpg">
    </if>
</div>

<div class="Panel Lottery" style="display: block; opacity: 1;z-index:999">
    <div class="lottery-left">
        <div class="lottery-title"><span class="title-label">抽奖</span><span class="usercount-label">共有<b>${userCount}</b>人参与</span></div>
        <div class="lottery-run">
            <div class="user" id="header" style="background-image: url(<%=basepath%>/image/qr_code.jpg)">
                <span class="nick-name"></span>
            </div>
            <div class="control button-run" style="display: block;">开始抽奖</div>
            <div class="control button-stop" style="display: none;">停止</div><!--
            <div class="control button-nextround" style="display: none;">下一轮</div>-->
        </div>
        <div class="lottery-bottom">
            <div class="round-num">
                <div class="select-panel">奖项：
                    <select name="lottery_rank" id="prize_rank">
                        <option value="">请选择...</option>
                            <c:forEach var="prize" items="${prizes}">
                            <option value="${prize.id}">${prize.name}</option>
                            </c:forEach>
                    </select>

                    <div class="select-value">名额：<b id="prize_num"></b></div>
                </div>
            </div>

            <div class="button-reset">清空奖池</div>
            <div class="button-showresult" onclick="showIntroDetail({pigcms:$info.id})">查看奖品</div>
            <div class="button-reload">重新抽奖</div>
            <div class="button-save" onclick="lottery_log({pigcms:$info.id})">中奖记录</div>
        </div>
    </div>

    <script>
        var loadTime     = 3000;
        var userinterval = '';
        var interval     = '';
    </script>
    <script type="text/javascript" src="<%=basepath%>/js/scene_lottery.js" charset="utf-8"></script>
    <script>
        function showIntroDetail(id){
            art.dialog.open('{pigcms::U('Scene/show_prize',array('token'=>$token))}&id='+id,{lock:false,title:'信息详情',width:1200,height:600,yesText:'关闭',background: '#000',opacity: 0.87});
        }
        function lottery_log(id){
            art.dialog.open('{pigcms::U('Scene/show_plog',array('token'=>$token))}&id='+id,{lock:false,title:'信息详情',width:1200,height:600,yesText:'关闭',background: '#000',opacity: 0.87});
        }
    </script>
    <div class="lottery-right"></div>
</div>
<div class="Panel Bottom" style="bottom: 0px;height:210px;">
    <div class="helperpanel pulse" >

    </div>
    <div class="navbar" style="right: 20px;width:60px;height: 500px;top:0px;margin-top: -50px;z-index:999;">

        <a class="navbaritem fullscreen" id="fullscreen" href="javascript:void(0);">
            <div class="icon"></div>
            <div class="label">全屏</div>
        </a>

    </div>
</div>
<div id="leafContainer"></div>
<div style="display: none;" class="bigmpcodebar">
    <div class="closebutton"></div>
    <div class="label">微信扫一扫，发送<span class="acivity_key">城事汇</span>即可参与</div>
    <img src="<%=basepath%>/image/qr_code.jpg">
</div>
<script>

    $('.mp_account_codeimage').click(function(){
        $('.bigmpcodebar').css('display','block');
    });

    $('.closebutton').click(function(){
        $('.bigmpcodebar').css('display','none');
    });

    $('#fullscreen').click(function(){

        if($('#fullscreen').hasClass('in')){
            exitFullscreen();
            $('#fullscreen').removeClass("in");
        }else{
            fullscreen();
            $('#fullscreen').addClass("in");
        }

    });

    function fullscreen(){
        elem=document.body;
        if(elem.webkitRequestFullScreen){
            elem.webkitRequestFullScreen();
        }else if(elem.mozRequestFullScreen){
            elem.mozRequestFullScreen();
        }else if(elem.requestFullScreen){
            elem.requestFullscreen();
        }else{
            //浏览器不支持全屏API或已被禁用
        }
    }

    function exitFullscreen(){
        var elem=document;
        if(elem.webkitCancelFullScreen){
            elem.webkitCancelFullScreen();
        }else if(elem.mozCancelFullScreen){
            elem.mozCancelFullScreen();
        }else if(elem.cancelFullScreen){
            elem.cancelFullScreen();
        }else if(elem.exitFullscreen){
            elem.exitFullscreen();
        }else{
            //浏览器不支持全屏API或已被禁用
        }
    }
</script>
</body>
</html>