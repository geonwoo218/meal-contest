<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="dbcon.jsp" %>
<%
String rankQuery = "SELECT menu_name, select_count FROM highschool_menu WHERE menu_date LIKE '202410%' ORDER BY select_count DESC";
PreparedStatement rankPstmt = null;
ResultSet rankRs = null;

/*
try {
    rankPstmt = con.prepareStatement(rankQuery);
    rankRs = rankPstmt.executeQuery();
} catch (SQLException e) {
    e.printStackTrace();
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "랭킹 데이터를 가져오는 중 오류가 발생했습니다.");
}*/
%>
<!DOCTYPE html>
<html>
<head>
    <title>랭킹</title>
</head>
<body>
    <h1>2024년 10월 랭킹</h1>
    <table border="1">
        <tr>
            <th>메뉴 이름</th>
            <th>선택 횟수</th>
        </tr>
        <% 
        if (rankRs != null) {
            while (rankRs.next()) { 
        %>
            <tr>
                <td><%= rankRs.getString("menu_name") %></td>
                <td><%= rankRs.getInt("select_count") %></td>
            </tr>
        <% 
            } 
        } 
        %>
    </table>
    <a href="index.jsp">메인으로</a>
</body>
</html>
<%
if (rankRs != null) rankRs.close();
if (rankPstmt != null) rankPstmt.close();
%>
