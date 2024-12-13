<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
Class.forName("oracle.jdbc.OracleDriver");
    String dbUser = "system";
    String dbPassword = "1234";
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", dbUser, dbPassword);
%>
<body style="display: flex; flex-direction: column; align-items: center; text-align: center;">
	<h2>회원매출 조회</h2>
	<table border="1" width="500px">
		<tr>
			<th>회원번호</th>
			<th>회원성명</th>
			<th>거래건수</th>
			<th>고객등급</th>
			<th>매출</th>
		</tr>
		<%
		String sql = "select distinct custno,custname,decode(grade,'A','VIP','B','일반','직원'),"
				+ " count(*) over(partition by custno)||'건',"
				+ " to_char(sum(price) over(partition by custno),'999,999')"
				+ " from member_tbl join money_tbl using(custno)" + " order by 3,4";
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
		%>
		<tr>
		<td><%=rs.getString(1) %></td>
		<td><%=rs.getString(2) %></td>
		<td><%=rs.getString(3) %></td>
		<td><%=rs.getString(4) %></td>
		<td><%=rs.getString(5) %></td>
		</tr>
		<%		
		}
%>
	</table>
	Copyright&copy;2023 All right reserved CEMA
</body>
</html>