<%@page import="com.aaa.shopping.category.CategoryDao"%>
<%@page import="com.aaa.shopping.category.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
List<Category> categories = new CategoryDao().getCategories();
%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>类别列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<table border="1" align="center">
		<tr>
			<td>类别编号</td>
			<td>类别名称</td>
			<td>描述</td>
			<td>PID</td>
			<td>代表数字串</td>
			<td>级别</td>
			<td>处理</td>
		</tr>
		<% for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
			Category c = it.next();
			String preString = "";
			for(int i=1; i < c.getGrade(); i++) {
				preString += "----";
			}
			%>

		<tr>
			<td><%=c.getId() %></td>
			<td><%=preString + c.getName() %></td>
			<td><%=c.getDescr() %></td>
			<td><%=c.getPid() %></td>
			<td><%=c.getCno() %></td>
			<td><%=c.getGrade() %></td>
			<td>
			<a href="admin/categoryModify.jsp?id=<%=c.getId()%>">修改</a>
				<%if(c.getGrade() < c.MAX_GRADE) { %> 
				<a href="admin/categoryAddChild.jsp?pid=<%=c.getId()%>&grade=<%=c.getGrade()%>">添加子类别</a>
				<%} %>
				<a href="admin/categoryDelete.jsp?id=<%=c.getId() %>">删除</a>
			</td>
		</tr>
		<% }%>
	</table>
</body>
</html>
