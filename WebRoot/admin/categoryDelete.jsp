<%@page import="com.aaa.shopping.category.CategoryDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_SessionCheck.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("id"));
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategoryById(id);
	out.println("恭喜你删除成功");
%>