<%@page import="com.aaa.shopping.product.ProductManager"%>
<%@page import="com.aaa.shopping.product.Product"%>
<%@page import="com.aaa.shopping.category.*" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String strId = request.getParameter("id");
	ProductManager productManager = new ProductManager();
	Product product = new Product();
	if (strId != null && !strId.trim().equals("")) {
		int id = Integer.parseInt(strId);
		product = productManager.getProductById(id);
	}
	
	String action = request.getParameter("action");
	if(action != null && action.equals("productModify")) {
		product.setId(Integer.parseInt(request.getParameter("id")));
		product.setName(request.getParameter("name"));
		product.setDescr(request.getParameter("descr"));
		product.setNormalprice(Double.parseDouble(request.getParameter("normalprice")));
		product.setMemberprice(Double.parseDouble(request.getParameter("memberprice")));
		product.setCategoryid(Integer.parseInt(request.getParameter("categoryid")));
		//日期也要更新
		product.setPdate(new Date());
		productManager.updateProduct(product);
		out.println("恭喜你数据更新成功");
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

<title>My JSP 'productModify.jsp' starting page</title>

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
			if (selectedValue.split("|")[1] == "1") {
				alert("请选择第二分类");
				document.form.categoryid.focus();
				return false;
			} else {
				selectedCategory.value = selectedValue.split("|")[0];
			}
		}
	</script>


	<form name="form" action="admin/productModify.jsp" method="post"
		onsubmit="return check()">
		<input type="hidden" name="action" value="productModify" />
		<input type="hidden" name="id" value="<%=product.getId()%>"/>
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">修改产品</td>
			</tr>
			<tr>
				<td>产品名称：</td>
				<td><input type=text name="name" size="30" maxlength="10" value="<%=product.getName()%>"></td>
			</tr>

			<tr>
				<td>产品描述：</td>
				<td><textarea rows="12" cols="55" name="descr"><%=product.getDescr()%>"</textarea></td>
			</tr>
			<tr>
				<td>市场价格：</td>
				<td><input type=text name="normalprice" size="30"
					maxlength="10" value="<%=product.getNormalprice()%>"></td>
			</tr>
			<tr>
				<td>会员价格：</td>
				<td><input type=text name="memberprice" size="30"
					maxlength="10" value="<%=product.getMemberprice()%>"></td>
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
								//用于默认选中product本来的categoryid
								String selected = "";
								if(product.getCategoryid() == category.getId()) {
									selected = "selected";
								}
								
								String preString = "";
								for (int i = 1; i < category.getGrade(); i++) {
									preString += "--";
								}
						%>
						<option value="<%=category.getId()%>|<%=category.getGrade()%>"
							<%=selected%>><%=preString + category.getName()%></option>
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
