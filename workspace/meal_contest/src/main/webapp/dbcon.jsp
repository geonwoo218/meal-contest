<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.servlet.http.HttpSession"%>
<html>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("oracle.jdbc.OracleDriver");
    String dbUser = "system";
    String dbPassword = "1234";
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", dbUser, dbPassword);
    session.setAttribute("con", con);

%>
</html>