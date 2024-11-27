<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="dbcon.jsp" %>
<%
String query = "SELECT TO_CHAR(h1.menu_date,'YYYY-mm-DD'), h1.menu_name, h1.select_count, " +
               "COUNT(*) OVER(PARTITION BY TO_CHAR(h1.menu_date,'YYYY-mm-DD')) AS menu_count, " +
               "AVG(h1.select_count) OVER(PARTITION BY TO_CHAR(h1.menu_date,'YYYY-mm-DD')) AS avg_select_count " +
               "FROM highschool_menu h1 " +
               "ORDER BY avg_select_count DESC, TO_CHAR(h1.menu_date,'YYYY-mm-DD'), h1.menu_name";
PreparedStatement pstmt = con.prepareStatement(query);
ResultSet rs = pstmt.executeQuery();

int rank = 1;
%>
<!DOCTYPE html>
<html>
<head>
    <title>랭킹</title>
    <link rel="stylesheet" href="assets/rankStyle.css">
</head>
<body>
    <h1>급식 랭킹</h1>
    <table border="1">
        <tr>
        	<th>랭킹</th>
            <th>날짜</th>
            <th>메뉴 이름</th>
            <th>선택 횟수</th>
            <th>사진 보기</th>
        </tr>
    <%
    String currentDate = "";
    int menuCount = 0;

    while (rs.next()) {
        String menuDate = rs.getString(1);
        String menuName = rs.getString("menu_name");
        int selectCount = rs.getInt("select_count");
        int countInDate = rs.getInt("menu_count");
        double avgSelectCount = rs.getDouble("avg_select_count");

        if (!menuDate.equals(currentDate)) {
            currentDate = menuDate;
            menuCount = countInDate; // 그룹의 메뉴 수 설정
    %>
        <tr>
        	<td rowspan="<%=menuCount %>"><%=rank %>등</td>
            <td rowspan="<%= menuCount %>"><%= currentDate %></td>
            <td class="menuname"><%= menuName %></td>
            <td rowspan="<%= menuCount %>"><%= selectCount %></td>
            <td rowspan="<%= menuCount %>">
                <button type="button">사진보기</button>
            </td>
        </tr>
    <%
    rank ++;
        } else {
    %>
        <tr>
            <td class="menuname"><%= menuName %></td>
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
if (rs != null) rs.close();
if (pstmt != null) pstmt.close();
%>
