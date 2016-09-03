<%@page import="com.aaa.shopping.product.ProductMysqlDao"%>
<%@page import="com.aaa.shopping.product.ProductDao"%>
<%@page import="com.aaa.shopping.product.Product"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_SessionCheck.jsp" %>

<%
ProductDao productDao = new ProductMysqlDao();
List<Product> products = productDao.getProducts(); 
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

<title>My JSP 'productList.jsp' starting page</title>

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
			<td>选择</td>
			<td>产品ID</td>
			<td>产品名称</td>
			<td>产品描述</td>
			<td>市场价格</td>
			<td>会员价格</td>
			<td>上架时间</td>
			<td>所属类别</td>
			<td>处理</td>
		</tr>
		<%
		/* 循环开始 */
			for(Iterator<Product> it = products.iterator(); it.hasNext();) {
				Product p = it.next();
		%>

		<tr>
			<td><input type="checkbox" name="id" value="<%=p.getId()%>"/></td>
			<td><%=p.getId()%></td>
			<td><%=p.getName()%></td>
			<td><%=p.getDescr()%></td>
			<td><%=p.getNormalprice()%></td>
			<td><%=p.getMemberprice()%></td>
			<td><%=p.getPdate()%></td>
			<td><%=p.getCategoryid()%></td>
			<td>
			<a href="admin/productModify.jsp?id=<%=p.getId()%>">修改</a>

				<a href="admin/productDelete.jsp?id=<%=p.getId()%>">删除</a>
			</td>
		</tr>
		<%
			}
		/* 循环结束 */
		%>
	</table>
  </body>
</html>
