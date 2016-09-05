<%@page import="com.aaa.shopping.category.CategoryDao"%>
<%@page import="com.aaa.shopping.category.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'productSearch.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<!-- 验证表单中是否选择分类正确，并且返回categoryid的值 -->
<script type="text/javascript">
	function check() {
		var selectedCategory = document.form.categoryid.options[document.form.categoryid.selectedIndex];
		var selectedValue = selectedCategory.value;
		if (selectedValue.split("|")[1] == "1") {
			alert("请选择第二分类");
			document.form.categoryid.focus();
			return false;
		} else {
			selectedCategory.value = selectedValue.split("|")[0];
		}
	}
</script>

</head>

<body>
	<center>
		简单搜索
		<form name="simple" action="admin/simpleSearchResult.jsp" method="get">
			<input type="text" size="10" name="keyword" /> <input type="submit"
				value="搜索" />
		</form>
		<br>

		<form action="complex" action="admin/complexSearchResult.jsp" method="post"
			onsubmit="return check()"></form>
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">高级搜索</td>
			</tr>
			<tr>
				<td>类别：</td>
				<td><select name="categoryid">
						<option selected="selected" value="-1">--所有商品--</option>
						<%
							List<Category> categories = new CategoryDao().getCategories();
							for (Iterator<Category> it = categories.iterator(); it.hasNext();) {
								Category category = it.next();
								String preString = "";
								for (int i = 1; i < category.getGrade(); i++) {
									preString += "--";
								}
						%>
						<option value="<%=category.getId()%>|<%=category.getGrade()%>"><%=preString + category.getName()%></option>
						<%
							}
						%>
				</select></td>
			</tr>

			<tr>
				<td>产品名：</td>
				<td><input type="text" name="name" size="15" maxlength="12"/></td>
			</tr>

			<tr>
				<td>市场价格：</td>
				<td>
				From:
				<input type="text" name="lowNormalprice" size="15" maxlength="12"/>
				to:
				<input type="text" name="highNormalprice" size="15" maxlength="12"/>
				</td>
			</tr>

			<tr>
				<td>会员价格：</td>
				<td>From:
				<input type="text" name="lowMemberprice" size="15" maxlength="12"/>
				to:
				<input type="text" name="highMemberprice" size="15" maxlength="12"/></td>
			</tr>

			<tr>
				<td>日期：</td>
				<td>From:
				<input type="text" name="startPdate" size="15" maxlength="12"/>
				to:
				<input type="text" name="endPdate" size="15" maxlength="12"/></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="提交" /><input type="reset" value="重置" /></td>
			</tr>

		</table>
	</center>
</body>
</html>












