<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_SessionCheck.jsp"%>
<%@ page import="com.aaa.shopping.category.*"%>

<%
	request.setCharacterEncoding("utf-8");
	int pid = Integer.parseInt(request.getParameter("pid"));
	int grade = Integer.parseInt(request.getParameter("grade"));

	//最多三层类别结构
	if (grade >= Category.MAX_GRADE) {
		out.println("不能再该节点下面添加子类别，层数超出了限制");
		return;
	}

	String action = request.getParameter("action");
	if (action != null && action.equals("categoryAddChild")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		Category category = new Category();
		CategoryDao categoryDao = new CategoryDao();
		category.setPid(pid);
		category.setName(name);
		category.setDescr(descr);
		category.setGrade(grade + 1);//grade要加一级
		categoryDao.add(category);
		out.println("恭喜你添加成功");
		return;
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

<title>My JSP 'categoryAddChild.jsp' starting page</title>

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
	<form name="form" action="admin/categoryAddChild.jsp" method="post">
		<input type="hidden" name="action" value="categoryAddChild" /> <input
			type="hidden" name="pid" value="<%=pid%>" /> <input type="hidden"
			name="grade" value="<%=grade%>" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">添加类别</td>
			</tr>
			<tr>
				<td>类别名称：</td>
				<td><input type=text name="name" size="30" maxlength="10">
				</td>
			</tr>

			<tr>
				<td>类别描述：</td>
				<td><textarea rows="12" cols="80" name="descr"></textarea></td>
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
