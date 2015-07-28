<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<% String basepath = this.getServletContext().getContextPath();%>
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
    <script type="text/javascript" src="<%=basepath%>/js/toast.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basepath%>/css/screen_lottery_free.css">
    <script src="<%=basepath%>/js/artDialog/jquery.artDialog.js?skin=default"></script>
    <script src="<%=basepath%>/js/artDialog/plugins/iframeTools.js"></script>
</head>
<body class="FUN WALL" style="background-image:url(<%=basepath%>/image/xuehua_bg.png);">
<div class="start_view" style="background-image:url(<%=basepath%>/image/start_bg.png);background-size:100% 768px;width: 100%;height: 768px">
    <img class="start_img" onclick="intolot()" style="right:100px;cursor:pointer; bottom: 50px;position: absolute;" src="<%=basepath%>/image/into_lot.png"/>
</div>

<div class="lottery_view" style="display: none">
<div class="Panel Top" style="top: 0px;">

        <img class="top_wenzi" src="<%=basepath%>/image/choujiang_wenzi.png">
</div>

<div class="Panel Lottery" style="display: block; opacity: 1;z-index:999">
    <div class="lottery-left">
        <div class="lottery-title"> <span class="title-label">抽奖</span><span
                class="usercount-label">共有<b>${userCount}</b>人参与</span></div>
        <div class="lottery-run">
            <div class="user" id="header">
                <span class="nick-name"></span>
            </div>
            <div class="control button-run" style="display: block;">开始抽奖</div>
            <div class="control button-stop" style="display: none;">停止</div>
            <!--
                        <div class="control button-nextround" style="display: none;">下一轮</div>-->
        </div>
        <div class="lottery-bottom">
            <div class="round-num">
                <div class="select-panel">奖项：
                    <div class="lottery_rank">
                    <select name="lottery_rank" id="prize_rank">
                        <option value="">请选择...</option>
                        <c:forEach var="prize" items="${prizes}">
                            <option value="${prize.id}">${prize.name}</option>
                        </c:forEach>
                    </select>
                    </div>
                    <div class="select-value">名额：<b id="prize_num"></b></div>
                </div>
            </div>

            <div class="button-reset" onclick="clear_users()"> 清空奖池</div>
            <div class="button-showresult" onclick="lottery_log()">查看奖品</div>
            <div class="button-save" onclick="showIntroDetail()">中奖记录</div>
        </div>
    </div>

    <script>
        var loadTime = 3000;
        var userinterval = '';
        var interval = '';
    </script>
    <script type="text/javascript" src="<%=basepath%>/js/scene_lottery.js" charset="utf-8"></script>
    <script>

        function intolot(){
            $('.start_img').hide();
            $('.lottery_view').fadeIn(3000);
            $(".start_view").animate({
                left:'250px',
                opacity:'0.5',
                height:'1px',
                width:'1px'});
        }
        function showIntroDetail(id) {
            art.dialog.open(
                    'http://123.124.196.233/index.php?g=User&m=Scene&a=show_plog&token=kshsth1436346812&id=${id}', {
                        lock: false,
                        title: '信息详情',
                        width: 1200,
                        height: 600,
                        yesText: '关闭',
                        background: '#000',
                        opacity: 0.87
                    }
            );
        }
        function lottery_log() {
            art.dialog.open(
                    'http://123.124.196.233/index.php?g=User&m=Scene&a=show_prize&token=kshsth1436346812&id=${id}', {
                        lock: false,
                        title: '信息详情',
                        width: 1200,
                        height: 600,
                        yesText: '关闭',
                        background: '#000',
                        opacity: 0.87
                    }
            );
        }

        function clear_users(){
            var url="/lottery/reShangQiang"
            $.ajax({
                url:url,
                type:"get",
                success:function (data) {
                    new Toast({context:$('.Top'),message:'开始抽奖吧'}).show();
                }
            });
        }
        function reload() {
            var url = '/lottery/resetPrize';
            var prize_id = $('#prize_rank').val();
            var ht= $(".prize-list").html();
            if(!ht||ht==""){
                new Toast({context:$('.Top'),message:'还没抽奖呢'}).show();
                return;
            }
            if (prize_id) {
                $.ajax({
                    url:url+"?pid="+prize_id,
                    type:"get",
                    success:function (data) {
                    if (data==0||data>0) {
                        $(".prize-list").html('');
                        var num=$('#prize_num').html();
                        $('#prize_num').html(parseInt(num)+parseInt(data));
                    } else {
                        new Toast({context:$('.Top'),message:'系统繁忙'}).show();
                    }
                }
                });
            } else {
                new Toast({context:$('.Top'),message:'请选择奖项'}).show();
            }
        }
    </script>
    <div class="lottery-right">
        <div class="lottery-title"> <span class="title-label">获奖名单</span></div>
        <div class="prize-list">

        </div>
        <div class="lottery-bottom">
            <div class="button-reload" onclick="reload()">重新抽奖</div>
        </div>
    </div>
</div>
<div class="Panel Bottom" style="bottom: 0px;height:210px;">
    <div class="helperpanel pulse">
        <img class="mp_account_codeimage" src="<%=basepath%>/image/qr_code.jpg">
        <img class="wenzi_code" src="<%=basepath%>/image/wenzi_chengshihui.png">

    </div>

</div>
<div id="leafContainer"></div>
<div style="display: none;" class="bigmpcodebar">
    <div class="closebutton"></div>
    <div class="label">微信扫一扫，发送<span class="acivity_key">“雪花啤酒”</span>即可参与</div>
    <img src="<%=basepath%>/image/qr_code.jpg">
</div>
<script>

    $('.mp_account_codeimage').click(function () {
        $('.bigmpcodebar').css('display', 'block');
    });

    $('.closebutton').click(function () {
        $('.bigmpcodebar').css('display', 'none');
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
</div>
<div class="bar111" style="position:absolute; right:30px;bottom: 200px; width:60px;height: 100px;z-index:999;">

    <a class="navbaritem fullscreen" id="fullscreen" href="javascript:void(0);">
        <div class="icon"><img id="img1" src="<%=basepath%>/image/fangda.png"></div>
    </a>
<script>

    $('#fullscreen').click(function () {

        if ($('#fullscreen').hasClass('in')) {
            exitFullscreen();
            $('#img1').attr('src','<%=basepath%>/image/fangda.png');
            $('#fullscreen').removeClass("in");
        } else {
            fullscreen();
            $('#img1').attr('src','<%=basepath%>/image/suoxiao.png');
            $('#fullscreen').addClass("in");
        }

    });

</script>
</div>
</body>
</html>