<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.aaa.shopping.user.*"%>

<%
	//获取User列表
	List<User> users = UserManager.getUsers();
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

<title>金尚商城会员列表</title>

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
			<td>ID</td>
			<td>Username</td>
			<td>Phone</td>
			<td>Addr</td>
			<td>Rdate</td>
			<td>处理</td>
		</tr>
		<%
			for (Iterator<User> it = users.iterator(); it.hasNext();) {
				User user = it.next();
		%>
		<tr>
			<td><%=user.getId()%></td>
			<td><%=user.getUsername()%></td>
			<td><%=user.getPhone()%></td>
			<td><%=user.getAddr()%></td>
			<td><%=user.getRdate()%></td>
			<td><a href="admin/userdelete.jsp?id=<%=user.getId()%>">删除</a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>
