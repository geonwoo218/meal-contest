<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp" %>
<!-- DB 연결 -->
<%!
	boolean gameStart = false;
%>
<%
Connection conn = (Connection) session.getAttribute("con");
if (conn == null) {
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 연결이 초기화되지 않았습니다.");
    return;
}

// 현재 라운드와 다음 라운드 리스트 초기화
List<String> currentRound = (List<String>) session.getAttribute("currentRound");
List<String> nextRound = (List<String>) session.getAttribute("nextRound");

if (currentRound == null) {
    currentRound = new ArrayList<>();
    session.setAttribute("currentRound", currentRound);
}

if (nextRound == null) {
    nextRound = new ArrayList<>();
    session.setAttribute("nextRound", nextRound);
}

//DB에서 처음부터 데이터 불러오기
if(!gameStart) {
	
	String query = "SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date, " +
	            "LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names " +
	            "FROM highschool_menu " +
	            "GROUP BY TO_CHAR(menu_date, 'YYYYMMDD') " +
	            "ORDER BY menu_date";	
	
	try {
	 PreparedStatement pstmt = conn.prepareStatement(query);
	 ResultSet rs = pstmt.executeQuery();
	 while (rs.next()) {
	     String menuDate = rs.getString("menu_date");
	     String menuNames = rs.getString("menu_names");
	     currentRound.add(menuDate + ":" + menuNames);
	     System.out.println("added : " + menuDate + ":" + menuNames);
	 }
	 
	 session.setAttribute("currentRound", currentRound);
	 
	 rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	gameStart = true;
}

// 현재 라운드 리스트가 비어 있으면 다음 라운드로 이동
if (currentRound.isEmpty()) {
    if (!nextRound.isEmpty()) {
        currentRound.addAll(nextRound);
        nextRound.clear();
    }
    
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
}

// 선택된 후보 처리
String selected = request.getParameter("selected");
String unselected = request.getParameter("unselected");
if (selected != null) {
	
	System.out.println("SELECTED : " + selected);
	System.out.println("UNSELECTED : " + unselected);
    // 선택된 후보는 다음 라운드로 이동
    nextRound.add(selected);
    /*
    System.out.print("nextRound : ");
    for(String s : nextRound) {
    	System.out.print("," + s);
    }
    System.out.println();
    
    System.out.print("currentRound : ");
    for(String s : currentRound) {
    	System.out.print("," + s);
    }
    System.out.println();*/

    // 선택되지 않은 후보는 현재 라운드에서 삭제
    currentRound.removeIf(candidate -> candidate.equals(unselected));
    currentRound.removeIf(candidate -> candidate.equals(selected));

    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
    System.out.print("currentRound : ");
    for(String s : currentRound) {
    	System.out.print(s + ", ");
    }
    System.out.println();
    
    System.out.print("nextRound : ");
    for(String s : nextRound) {
    	System.out.print(s + ", ");
    }
    System.out.println();
}

// 게임 종료 조건
if (currentRound.size() == 1) {
    // 남은 후보가 1개면 부전승 처리
    nextRound.add(currentRound.get(0));
    currentRound.clear();
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
}

    // 최종 우승자 처리
if (currentRound.isEmpty() && nextRound.size() == 1) {
    session.setAttribute("winner", nextRound.get(0));
    response.sendRedirect("result.jsp");
    gameStart = false;
    return;
}

// 랜덤으로 두 후보 선택
if (currentRound.size() < 2) {
    // 후보가 한 명 이하라면 부전승 처리
    if (currentRound.size() == 1) {
        nextRound.add(currentRound.get(0));
    }
    currentRound.clear();
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
    response.sendRedirect("game.jsp"); // 다음 라운드로 이동
    return;
}

Random random = new Random();
int index1 = random.nextInt(currentRound.size());
int index2;
do {
    index2 = random.nextInt(currentRound.size());
} while (index1 == index2);

String[] candidate1Data = currentRound.get(index1).split(":");
String[] candidate2Data = currentRound.get(index2).split(":");

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
    <h1>이상형 월드컵</h1>
    <form action="game.jsp" method="get" name="form">
        <div class="choice">
            <!-- 첫 번째 후보 -->
            <div class="candidate">
                <h3><%= candidate1Date.substring(0, 4) %>년 <%= candidate1Date.substring(4, 6) %>월 <%= candidate1Date.substring(6) %>일</h3>
                <div>
                    <% 
                        String[] menuItems1 = candidate1Menu.split(", ");
                        for (String menu : menuItems1) {
                    %>
                        <p><%= menu %></p>
                    <% 
                        }
                    %>
                </div>
            </div>

            <!-- 두 번째 후보 -->
            <div class="candidate">
                <h3><%= candidate2Date.substring(0, 4) %>년 <%= candidate2Date.substring(4, 6) %>월 <%= candidate2Date.substring(6) %>일</h3>
                <div>
                    <% 
                        String[] menuItems2 = candidate2Menu.split(", ");
                        for (String menu : menuItems2) {
                    %>
                        <p><%= menu %></p>
                    <% 
                        }
                    %>
                </div>
            </div>
            <br>
            <!-- Form buttons -->
            <div class="buttons">
            	<input type="hidden" name="selected" id="selected">
            	<input type="hidden" name="unselected" id="unselected">
                <button type="button" id="selected1" value="<%=currentRound.get(index1)%>" onclick="select(1)">선택</button>
                <button type="button" id="selected2" value="<%=currentRound.get(index2)%>" onclick="select(2)">선택</button>
            </div>
        </div>
    </form>
    <script>
    
    	function select(n) {
    		let selected = document.getElementById('selected');
    		let unselected = document.getElementById('unselected');
    		let selected1 = document.getElementById('selected1');
    		let selected2 = document.getElementById('selected2');
    		if(n == 1) {
    			selected.value = selected1.value;
    			unselected.value = selected2.value;
    		} else {
    			selected.value = selected2.value;
    			unselected.value = selected1.value;
    		}
    		
    		form.submit();
    	}
    </script>
</body>
</html>
