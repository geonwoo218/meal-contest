<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>
<!-- DB 연결 -->
<%! boolean gameStart = false; %>
<%
Connection conn = (Connection) session.getAttribute("con");
if (conn == null) {
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 연결이 초기화되지 않았습니다.");
    return;
}

// 현재 라운드와 다음 라운드 Set 초기화
Set<String> currentRound = (Set<String>) session.getAttribute("currentRound");
Set<String> nextRound = (Set<String>) session.getAttribute("nextRound");

if (currentRound == null) {
    currentRound = new HashSet<>();
    session.setAttribute("currentRound", currentRound);
}

if (nextRound == null) {
    nextRound = new HashSet<>();
    session.setAttribute("nextRound", nextRound);
}

// DB에서 처음부터 데이터 불러오기
if (!gameStart) {
    String query = "SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date, "
            + "LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names "
            + "FROM highschool_menu "
            + "GROUP BY TO_CHAR(menu_date, 'YYYYMMDD') "
            + "ORDER BY menu_date";

    try {
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            String menuDate = rs.getString("menu_date");
            String menuNames = rs.getString("menu_names");
            currentRound.add(menuDate + ":" + menuNames);  // 중복 제거된 Set에 추가
        }
        session.setAttribute("currentRound", currentRound);
        rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    gameStart = true;
}

// 현재 라운드가 비어 있으면 다음 라운드로 이동
if (currentRound.isEmpty()) {
    if (!nextRound.isEmpty()) {
        currentRound.addAll(nextRound);  // Set에 추가하여 중복 제거
        nextRound.clear();
    }
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
}

// 선택된 후보 처리
String selected = request.getParameter("selected");
String unselected = request.getParameter("unselected");
if (selected != null) {
    nextRound.add(selected);  // 선택된 후보는 다음 라운드로 이동
    currentRound.remove(selected);  // 선택된 후보는 현재 라운드에서 제거
    currentRound.remove(unselected);  // 선택되지 않은 후보도 현재 라운드에서 제거
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
}

// 게임 종료 조건
if (currentRound.size() == 1) {
    nextRound.addAll(currentRound);  // 남은 후보를 부전승 처리
    currentRound.clear();
}

// 최종 우승자 처리
if (currentRound.isEmpty() && nextRound.size() == 1) {
    session.setAttribute("winner", nextRound.iterator().next());
    response.sendRedirect("result.jsp");
    gameStart = false;
    return;
}

// 랜덤으로 두 후보 선택
if (currentRound.size() < 2) {
    if (currentRound.size() == 1) {
        nextRound.addAll(currentRound);
    }
    currentRound.clear();
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
    response.sendRedirect("game.jsp");  // 다음 라운드로 이동
    return;
}

//Set을 List로 변환하여 랜덤으로 두 후보 선택
List<String> currentRoundList = new ArrayList<>(currentRound);
Random random = new Random();
int index1 = random.nextInt(currentRoundList.size());
int index2;
do {
    index2 = random.nextInt(currentRoundList.size());
} while (index1 == index2);

String[] candidate1Data = currentRoundList.get(index1).split(":");
String[] candidate2Data = currentRoundList.get(index2).split(":");

String candidate1Date = candidate1Data[0];
String candidate1Menu = candidate1Data[1];

String candidate2Date = candidate2Data[0];
String candidate2Menu = candidate2Data[1];
%>

<!DOCTYPE html>
<html>
<head>
<title>이상형 월드컵</title>
<link rel="stylesheet" href="assets/gameStyle.css">
</head>
<body>
	<form action="game.jsp" method="post" name="form">
		<section>
			<div id="leftContainer">
				<h3><%=candidate1Date.substring(0, 4)%>년
					<%=candidate1Date.substring(4, 6)%>월
					<%=candidate1Date.substring(6)%>일
				</h3>
				<button type="button" id="selected1" class="cBtn"
					value="<%=currentRoundList.get(index1)%>" onclick="select(1)">
				<img alt="후보 1" src="assets/images" >
				</button>
				<div class="menulist">
					<%
					String[] menuItems1 = candidate1Menu.split(", ");
					for (String menu : menuItems1) {
					%>
					<div><%=menu%></div>
					<%
					}
					%>
				</div>
			</div>
			<div id="centerContainer">
				<span>VS</span>
			</div>
			<div id="rightContainer">
				<h3><%=candidate2Date.substring(0, 4)%>년
					<%=candidate2Date.substring(4, 6)%>월
					<%=candidate2Date.substring(6)%>일
				</h3>
				<button type="button" id="selected2" class="cBtn"
					value="<%=currentRoundList.get(index2)%>" onclick="select(2)">
					<img alt="후보 2" src="assets/images">
					</button>
				<div class="menulist">
					<%
					String[] menuItems2 = candidate2Menu.split(", ");
					for (String menu : menuItems2) {
					%>
					<div><%=menu%></div>
					<%
					}
					%>
				</div>
			</div>
		</section>
		<input type="hidden" id="selected" name="selected">
		<input type="hidden" id="unselected" name="unselected">
	</form>

	<script>
		function select(n) {
			let selected = document.getElementById('selected');
			let unselected = document.getElementById('unselected');
			let selected1 = document.getElementById('selected1');
			let selected2 = document.getElementById('selected2');
			
			if(n == 1){
				selected.value = selected1.value;
				unselected.value = selected2.value;
			}else{
				selected.value = selected2.value;
				unselected.value = selected1.value;	
			}
			form.submit();
		}
	</script>
</body>
</html>
