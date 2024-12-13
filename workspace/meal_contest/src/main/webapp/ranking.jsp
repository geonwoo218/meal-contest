<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>랭킹</title>
<style>
 
</style>
<link rel="stylesheet" href="assets/rankStyle.css">
</head>
<body>
<%@include file="dbcon.jsp" %>
<div id="rankBox">
<h1>랭킹</h1>
    <table>
        <tr>
            <th>순위</th>
            <th style="width: 80px;">이미지</th>
            <th>날짜</th>
            <th></th>
        </tr>
        <%
            String sql = "SELECT RANK() OVER (ORDER BY select_count DESC) AS rank, "+
            "TO_CHAR(menu_date, 'yyyymmdd') AS menu_date,  "+
            "LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names "+ 
            "FROM highschool_menu  "+
            "GROUP BY to_char(menu_date,'yyyymmdd'), select_count";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()){
            	String menudate = rs.getString(2);
        %>
        <tr class="menu-box">
            <td class="rank"><%=rs.getString(1) %></td>
            <td class="img"><img src="assets/images/<%=rs.getString(2) %>.jpg"></td>
            <td class="menu"><%=menudate.substring(0, 4)%>년 
            <%=menudate.substring(4, 6)%>월	<%=menudate.substring(6)%>일
            <Br> <span style="font-size: 12px;">(<%=rs.getString(3) %>)</span></td>
            <td><button type="button" class="ibtn" onclick="menuinfo('<%=rs.getString(2)%>', '<%=rs.getString(3)%>')">자세히보기</button></td> 
        </tr>
        <%
            }
        %>
    </table>
    <button class="homeBtn" id="homeBtn" onclick="window.location.href='index.jsp'">다시하기</button>
</div>

<!-- 팝업 및 커버 -->
<div id="cover" onclick="closePopup()"></div>
<div id="popup">
    	<img id="popup-img" src="" alt="">
    	<div id="popDate"></div>
    	<div id="menulist"></div>
</div>

<script type="text/javascript">
function menuinfo(menudate, menulist) {
	const imgSrc = "assets/images/"+menudate+".jpg";
	const formattedDate = menudate.substring(0, 4) + "년 " +
    	menudate.substring(4, 6) + "월 " +
    	menudate.substring(6) + "일";
	
    document.getElementById('popup-img').src = imgSrc;
    document.getElementById('popDate').innerText = formattedDate;
    document.getElementById('menulist').innerText = menulist;

    // 팝업과 커버 표시
    document.getElementById('cover').style.display = 'block';
    document.getElementById('popup').style.display = 'block';
}

function closePopup() {
    // 팝업과 커버 숨기기
    document.getElementById('cover').style.display = 'none';
    document.getElementById('popup').style.display = 'none';
}
</script>
</body>
</html>
