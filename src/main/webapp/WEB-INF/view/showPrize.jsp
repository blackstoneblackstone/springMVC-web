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
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>奖品</title>
    <link rel="stylesheet" type="text/css" href="<%=basepath%>/css/winner_list.css">
    <script type="text/javascript" src="jquery-2.0.3.min.js" charset="utf-8"></script>
    <style>
        .member-list span{width:190px;font-weight: bold;}
        .member-list li{margin-right:44px;}
        .member-avatar{width:190px}
        .member-avatar img {width:190px;}
        .member-list p{text-align: left;margin:0;height: 30px;line-height: 30px;overflow: hidden;}
    </style>
</head>
<body style="background-color:#0099cc;width:1200px;height:auto;>
<h1>奖品清单</h1>
<div class="member-list" style="height: 403px;">
    <ul class="clearfix">
        <c:forEach var="p" items="${ps}">
            <li>
                <span>${p.name}</span>
                <div class="member-avatar" style="background: #fff;"><img src="${p.pic}"></div>
                <p>奖品名称:${p.pname}</p>
                <p>奖励名额：${p.num}</p>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>