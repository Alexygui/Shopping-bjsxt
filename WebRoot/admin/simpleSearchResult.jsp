<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.aaa.shopping.product.*"%>
<%@page import="com.aaa.shopping.util.*"%>

<%
	request.setCharacterEncoding("utf-8");
	//获取或设置当前页面的值
	String strCurrentPage = request.getParameter("currentPage");
	int currentPage = 1;
	if (strCurrentPage != null && !strCurrentPage.trim().equals("")) {
		try {
			currentPage = Integer.parseInt(strCurrentPage);
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		if (currentPage < 1) {
			currentPage = 1;
		}
	}
%>

<%
	String keyword = new String( request.getParameter("keyword").getBytes("8859_1"), "utf-8");
// System.out.println("keyword=" + keyword);		
 //取出所有的Procut的数据
	ProductManager productManager = new ProductManager();
	Page page2 = new Page(currentPage);
	List<Product> products = new ArrayList<Product>();
	products = productManager.simpleSearch(products, page2, keyword);
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

<title>My JSP 'simpleSearchResult.jsp' starting page</title>

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
			//int start = (page2.getCurrentPage() - 1) * page2.getPageSize();
			/* for (int i = 0; i < page2.getPageSize(); i++) {
				//防止数组溢出错误
				if (i >= page2.getTotalSize()){
					System.out.println("totalsize=" +page2.getTotalSize());
					break;
				} */
				for(Iterator<Product> it = products.iterator(); it.hasNext();) {
				Product p = it.next();
		%>

		<tr>
			<td><input type="checkbox" name="id" value="<%=p.getId()%>" /></td>
			<td><%=p.getId()%></td>
			<td><%=p.getName()%></td>
			<td><%=p.getDescr()%></td>
			<td><%=p.getNormalprice()%></td>
			<td><%=p.getMemberprice()%></td>
			<td><%=p.getPdate()%></td>
			<td><%=p.getCategoryid()%></td>
			<td><a href="admin/productModify.jsp?id=<%=p.getId()%>">修改</a> <a
				href="admin/productDelete.jsp?id=<%=p.getId()%>">删除</a></td>
		</tr>
		<%
			}
			/* 循环结束 */
		%>

		<tr>
			<td>第<%=currentPage%>页/共<%=page2.getTotalPages()%>页
			</td>
			<td>
				<%
					if (page2.isHasFirst()) {
				%> <a href="admin/simpleSearchResult.jsp?currentPage=1&keyword=<%=keyword%>">首页</a> <%
 	}
 %>
			</td>
			<td>
				<%
					if (page2.isHasPrevious()) {
				%> <a href="admin/simpleSearchResult.jsp?currentPage=<%=currentPage - 1%>&keyword=<%=keyword%>">前一页</a>
				<%
					}
				%>
			</td>
			<td>
				<%
					if (page2.isHasNext()) {
				%> <a href="admin/simpleSearchResult.jsp?currentPage=<%=currentPage + 1%>&keyword=<%=keyword%>">后一页</a>
				<%
					}
				%>
			</td>
			<td>
				<%
					if (page2.isHasLast()) {
				%> <a
				href="admin/simpleSearchResult.jsp?currentPage=<%=page2.getTotalPages()%>&keyword=<%=keyword%>">尾页</a>
				<%
					}
				%>
			</td>
		</tr>
	</table>
</body>
</html>
