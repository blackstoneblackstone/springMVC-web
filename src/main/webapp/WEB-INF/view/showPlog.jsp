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
<!-- saved from url=(0078)http://wxsyb.bama555.com/activity/free_vote/result_list/?id=23839&rotate_id=58 -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>中奖纪录</title>
    <link rel="stylesheet" type="text/css" href="<%=basepath%>/css/winner_list.css">
</head>
<body style="background-color:#0099cc;width:1200px;min-height:550px;text-align:center;">
<h1>中奖记录</h1>
<ul class="rotate-tab clearfix">
    <c:forEach var="p" items="${ps}">
        <c:if test="${p.id==pid}">
            <li class="active">
        </c:if>
        <c:if test="${p.id!=pid}">
            <li class="">
        </c:if>
        <a href="<%=basepath%>/lottery/showPlog?pid=${p.id}">${p.name}</a>
        </li>
    </c:forEach>
    <span class="clear"></span>
</ul>
<div class="member-list" style="height: 100%">
    <ul class="clearfix">
        <ul class="clearfix">
            <c:forEach var="psrr" items="${psr}">
                <li>
                    <div class="member-avatar"><img src="${psrr.portrait}"></div>
                    <span>${psrr.nickname}</span>
                </li>
            </c:forEach>
        </ul>
    </ul>
</div>
</body>
</html>