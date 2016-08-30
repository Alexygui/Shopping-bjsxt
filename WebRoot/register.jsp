<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.aaa.shopping.user.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	if(action != null & "register".equals(action)) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setPhone(phone);
		user.setAddr(addr);
		user.setRdate(new Date());//往rdate变量中赋值，不然保存到数据库中会出现空指针错误
		user.save();
		out.println("恭喜你，注册成功！");
		return; //终止程序，不执行以下的代码
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

<title>一个购物商城</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="script/regcheckdata.js"></script>
</head>

<body>
	<form name="form" action="register.jsp" method="post"
		onSubmit="return checkdata()" target="detail">
		<input type="hidden" name="action" value="register" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">用户注册</td>
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
				<td>密码确认：</td>
				<td><input type=password name="password2" size="15"
					maxlength="12"></td>
			</tr>
			<tr>
				<td>电话：</td>
				<td><input type=text name="phone" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td>地址：</td>
				<td><textarea rows="12" cols="80" name="addr"></textarea></td>
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
