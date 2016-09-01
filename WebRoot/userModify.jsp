<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.aaa.shopping.user.*" %>
<%
User user = (User)session.getAttribute("user");
if(user == null) {
	out.println("您尚未登录，请先登录");
	return;
}
%>
<%-- 修改用户数据的页面 --%>
<%
request.setCharacterEncoding("UTF-8");
String action = request.getParameter("action");
if(action != null & "modify".equals(action)) {
	String username = request.getParameter("username");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	user.setUsername(username);
	user.setPhone(phone);
	user.setAddr(addr);
	user.update();
	out.println("恭喜你，信息修改成功！");
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

<title>My JSP 'userModify.jsp' starting page</title>

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
	<form name="form" action="userModify.jsp" method="post">
		<input type="hidden" name="action" value="modify" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">用户信息修改</td>
			</tr>
			<tr>
				<td>用户名：</td>
				<td><input type=text name="username" value="<%=user.getUsername() %>"  size="30" maxlength="10">
				</td>
			</tr>
			
			<tr>
				<td>电话：</td>
				<td><input type=text name="phone" value="<%=user.getPhone() %>" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td>地址：</td>
				<td><textarea rows="12" cols="80"  name="addr"><%=user.getAddr() %></textarea></td>
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
