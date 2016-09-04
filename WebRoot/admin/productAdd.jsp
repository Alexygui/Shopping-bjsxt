<%@page import="com.aaa.shopping.product.ProductMysqlDao"%>
<%@page import="com.aaa.shopping.product.ProductDao"%>
<%@page import="com.aaa.shopping.product.Product"%>
<%@page import="com.aaa.shopping.category.CategoryDao"%>
<%@page import="com.aaa.shopping.category.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	int categoryid = -1;
	String strCategoryId = request.getParameter("categoryid");
	if (strCategoryId != null && !strCategoryId.trim().equals("")) {
		categoryid = Integer.parseInt(strCategoryId);
	}

	String action = request.getParameter("action");
	if (action != null && action.equals("productAdd")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		double normalprice = Double.parseDouble(request.getParameter("normalprice"));
		double memberprice = Double.parseDouble(request.getParameter("memberprice"));

		Product product = new Product();
		product.setCategoryid(categoryid);
		product.setName(name);
		product.setDescr(descr);
		product.setNormalprice(normalprice);
		product.setMemberprice(memberprice);
		product.setPdate(new Date());

		ProductDao productDao = new ProductMysqlDao();
		productDao.addProduct(product);
		out.println("恭喜你添加产品成功");
		//return;
	}
%>
<script type="text/javascript">
<!-- parent.main.location.reload(); -->
</script>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'productAdd.jsp' starting page</title>

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
<!-- 验证表单中是否选择分类正确，并且返回categoryid的值 -->
	<script type="text/javascript">
	 function check() {
		var selectedCategory = document.form.categoryid.options[document.form.categoryid.selectedIndex];
		var selectedValue = selectedCategory.value;
		if(selectedValue.split("|")[1] == "1") {
			alert("请选择第二分类");
			document.form.categoryid.focus();
			return false;
		} else {
			selectedCategory.value = selectedValue.split("|")[0];
		}
	} 
  </script>

	<form name="form" action="admin/productAdd.jsp" method="post" onsubmit="return check()">
		<input type="hidden" name="action" value="productAdd" />
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">添加产品</td>
			</tr>
			<tr>
				<td>产品名称：</td>
				<td><input type=text name="name" size="30" maxlength="10">
				</td>
			</tr>

			<tr>
				<td>类别描述：</td>
				<td><textarea rows="12" cols="55" name="descr"></textarea></td>
			</tr>
			<tr>
				<td>市场价格：</td>
				<td><input type=text name="normalprice" size="30"
					maxlength="10"></td>
			</tr>
			<tr>
				<td>会员价格：</td>
				<td><input type=text name="memberprice" size="30"
					maxlength="10"></td>
			</tr>

			<!-- <tr>
				<td>类别名称：</td>
				<td><input type=text name="categoryid" size="30" maxlength="10">
				</td>
			</tr> -->
			<tr>
				<td>类别名称：</td>
				<td><select name="categoryid">
						<%
							List<Category> categories = new CategoryDao().getCategories();
							for (Iterator<Category> it = categories.iterator(); it.hasNext();) {
								Category category = it.next();
								//实现下次添加的时候类别显示上次同样的类别
								String selected = "";
								if(category.getId() == categoryid) selected = "selected";
								
								String preString = "";
								for (int i = 1; i < category.getGrade(); i++) {
									preString += "--";
								}
						%>
						<option value="<%=category.getId()%>|<%=category.getGrade()%>" <%=selected %>><%=preString + category.getName()%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="提交"></td>
			</tr>

		</table>
	</form>
</body>
</html>
