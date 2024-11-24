<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
String winner = (String) session.getAttribute("winner");
session.removeAttribute("candidates"); // 게임 데이터 초기화
if (winner == null) {
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "승자가 결정되지 않았습니다.");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>결과</title>
</head>
<body>
    <h1>이상형 월드컵 우승자</h1>
    <p>우승자는: <%= winner %></p>
    <a href="ranking.jsp">랭킹 보기</a>
    <a href="index.jsp">다시하기</a>
</body>
</html>
