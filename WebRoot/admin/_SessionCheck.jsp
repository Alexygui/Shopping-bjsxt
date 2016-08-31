
<%
	String admin = (String) session.getAttribute("admin");
	if(admin == null || !admin.equals("admin")) {
		response.sendRedirect("login.jsp");
		return;
	}
%>
