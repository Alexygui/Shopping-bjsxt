<%@page import="com.aaa.shopping.user.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 用户登录的页面 --%>
<%
	response.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	User user = null;
	if(action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			user = User.checkUser(username, password);	
		} catch(UserNotFoundException e) {
			out.println("用户名不存在，请重新输入");	
			return;
		} catch(PasswordNotCorrectException e) {
			out.println("密码不正确，请检查您的大小写输入键是否开启");			
			return;
		}
	session.setAttribute("user", user);
	response.sendRedirect("selfService.jsp");
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

<title>用户登录</title>

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
	<form name="form" action="login.jsp" method="post">
		<input type="hidden" name="action" value="login" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">用户登录</td>
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
