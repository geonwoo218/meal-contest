<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="dbcon.jsp" %>
<%
String winner = request.getParameter("winner");


try {
	String sql = "UPDATE HIGHSCHOOL_MENU SET SELECT_COUNT = SELECT_COUNT + 1 WHERE MENU_DATE = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, winner.split(":")[0]);
	pstmt.executeUpdate();
} catch(Exception e) {
	e.printStackTrace();
}

if (winner == null) {
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "승자가 결정되지 않았습니다.");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
   <title>결과</title>
    <link rel="stylesheet" href="assets/resultStyle.css">
</head>
<body>
    <section>
	<div id="winner">
	<%
	String menudate = winner.split(":")[0];
	String[] menulist = winner.split(":")[1].split(",");
	%>
	    <span>최종 우승 급식<br>
	    <span id="dateSpan"><%=menudate.substring(0, 4)%>년
	    <%=menudate.substring(4, 6)%>월
		<%=menudate.substring(6)%>일</span></span>
		<img alt="승자 이미지" src="assets/images/<%=menudate %>.jpg">
		<div id="menulist">
		<%
			for(String s : menulist){
			%>
			<div class="menu"><%=s %></div>
			<%
			}
		%>
		</div>
	</div>    
    <div id="buttons">
    	<button class="cBtn" id="rankBtn" onclick="window.location.href='ranking.jsp'" >
    	<img src="assets/images/rank.png"> <br><span>랭킹가기</span>
    	</button>
    	<button class="cBtn" id="homeBtn" onclick="window.location.href='index.jsp'" value="다시하기">
    	<img src="assets/images/back.png"> <br><span>다시하기</span>
    	 </button>
    </div>
    </section>
</body>
</html>
