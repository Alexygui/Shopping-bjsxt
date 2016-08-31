<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String action = request.getParameter("action");
	if (action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (!username.equals("admin") || !password.equals("admin")) {
			out.println("用户名或者密码不正确");
			return;
		}
		session.setAttribute("admin", "admin");
		response.sendRedirect("index.jsp");
	}
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

<title>My JSP 'login.jsp' starting page</title>

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
	<form name="form" action="admin/login.jsp" method="post">
		<input type="hidden" name="action" value="login" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">管理员登录</td>
			</tr>
			<tr>
				<td>用户名：</td>
				<td><input type=text name="username" size="30" maxlength="10">
				</td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type=password name="password" size="15"
					maxlength="12"></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="提交"> <input
					type="reset" value="重置"></td>
			</tr>

		</table>
	</form>
</body>
</html>
