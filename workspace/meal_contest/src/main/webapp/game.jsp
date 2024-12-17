<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>

<!-- DB 연결 확인 -->
<%
Connection conn = (Connection) session.getAttribute("con");
if (conn == null) {
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 연결이 초기화되지 않았습니다.");
    return;
}

// 라운드 수 가져오기
String round = request.getParameter("round");

//처음에는 세션에 round 값을 저장
if (round != null) {
 session.setAttribute("round", round);
} else {
 // round가 null일 경우, 세션에서 가져옴
 round = (String) session.getAttribute("round");
}

if (round == null) {
 // round 값이 여전히 null이라면 기본값 설정
 round = "8";
 session.setAttribute("round", round);
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

// DB에서 처음 데이터 불러오기
if (currentRound.isEmpty() && nextRound.isEmpty()) {
    String query = "SELECT * FROM ( " +
                   "    SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date, " +
                   "           LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names " +
                   "    FROM highschool_menu " +
                   "    GROUP BY TO_CHAR(menu_date, 'YYYYMMDD') " +
                   "    ORDER BY DBMS_RANDOM.VALUE " +
                   ") WHERE ROWNUM <= ?";

    try {
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, round);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String menuDate = rs.getString("menu_date");
            String menuNames = rs.getString("menu_names");
            currentRound.add(menuDate + ":" + menuNames);
        }
        rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    session.setAttribute("currentRound", currentRound);
}

// 현재 라운드 비어있으면 다음 라운드로 이동
if (currentRound.isEmpty()) {
    if (!nextRound.isEmpty()) {
        currentRound.addAll(nextRound);
        nextRound.clear();
    } else {
        // 게임 종료: 최종 우승 처리
        session.setAttribute("winner", nextRound.iterator().next());
        response.sendRedirect("result.jsp");
        return;
    }
}

// 선택된 후보 처리
String selected = request.getParameter("selected");
String unselected = request.getParameter("unselected");

if (selected != null) {
    nextRound.add(selected);
    currentRound.remove(selected);
    currentRound.remove(unselected);
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
}

// 라운드 종료 조건
if (currentRound.size() == 1) {
    nextRound.addAll(currentRound);
    //session.setAttribute("round",Integer.parseInt(round)/2);
    currentRound.clear();
}

// 최종 우승자 처리
if (currentRound.isEmpty() && nextRound.size() == 1) {
    session.setAttribute("winner", nextRound.iterator().next());
    session.removeAttribute("round"); // 세션에서 round 제거
    response.sendRedirect("result.jsp");
    return;
}

// 랜덤으로 두 후보 선택 (안전 검사)
if (currentRound.size() < 2) {
    nextRound.addAll(currentRound);
    currentRound.clear();
    session.setAttribute("currentRound", currentRound);
    session.setAttribute("nextRound", nextRound);
    response.sendRedirect("game.jsp");
    return;
}

// 후보 리스트 생성 및 랜덤 선택
List<String> currentList = new ArrayList<>(currentRound);
Random random = new Random();
int index1 = random.nextInt(currentList.size());
int index2;

do {
    index2 = random.nextInt(currentList.size());
} while (index1 == index2);

String[] candidate1Data = currentList.get(index1).split(":");
String[] candidate2Data = currentList.get(index2).split(":");

String candidate1Date = candidate1Data[0];
String candidate1Menu = candidate1Data[1];

String candidate2Date = candidate2Data[0];
String candidate2Menu = candidate2Data[1];

// 라운드 및 경기 표시
int totalRounds = Integer.parseInt(round); //n강
int totalMatches = totalRounds / 2; //   n/tatalMatches
int currentMatch = totalMatches - (currentRound.size() / 2) + 1;   //current

String matchDisplay;
matchDisplay = totalRounds + "강 " + currentMatch + "/" + totalMatches;

%>

<!DOCTYPE html>
<html>
<head>
    <title>이상형 월드컵</title>
    <link rel="stylesheet" href="assets/gameStyle.css">
</head>
<body>
    <form action="game.jsp" method="post" name="form">
        <div class="round">
            <span><%= matchDisplay %></span>
        </div>
        <section>
            <!-- 후보 1 -->
            <div id="leftContainer">
                <h3><%= candidate1Date.substring(0, 4) %>년 
                    <%= candidate1Date.substring(4, 6) %>월 
                    <%= candidate1Date.substring(6) %>일
                </h3>
                <button type="button" id="selected1" class="cBtn" 
                        value="<%= currentList.get(index1) %>" onclick="select(1)">
                    <img alt="후보 1" src="assets/images/<%= candidate1Date %>.jpg">
                </button>
                <div><%= candidate1Menu.replace(", ", "<br>") %></div>
            </div>

            <!-- VS -->
            <div id="centerContainer">
                <span>VS</span>
            </div>

            <!-- 후보 2 -->
            <div id="rightContainer">
                <h3><%= candidate2Date.substring(0, 4) %>년 
                    <%= candidate2Date.substring(4, 6) %>월 
                    <%= candidate2Date.substring(6) %>일
                </h3>
                <button type="button" id="selected2" class="cBtn" 
                        value="<%= currentList.get(index2) %>" onclick="select(2)">
                    <img alt="후보 2" src="assets/images/<%= candidate2Date %>.jpg">
                </button>
                <div><%= candidate2Menu.replace(", ", "<br>") %></div>
            </div>
        </section>

        <!-- 숨겨진 필드 -->
        <input type="hidden" id="selected" name="selected">
        <input type="hidden" id="unselected" name="unselected">
    </form>

    <script>
        function select(n) {
            let selected = document.getElementById('selected');
            let unselected = document.getElementById('unselected');
            let selected1 = document.getElementById('selected1');
            let selected2 = document.getElementById('selected2');

            if (n == 1) {
                selected.value = selected1.value;
                unselected.value = selected2.value;
            } else {
                selected.value = selected2.value;
                unselected.value = selected1.value;
            }
            document.form.submit();
        }
    </script>
</body>
</html>
