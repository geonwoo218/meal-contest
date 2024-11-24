<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>
<!-- DB 연결 -->

<%
/*
 * 1. 후보 데이터 가져오기
 */
String menuDate = request.getParameter("menu_date");
if (menuDate == null) {
    menuDate = "202410"; // Default to October 2024
    System.out.println("menuDate is null, defaulting to: " + menuDate);
} else {
    System.out.println("menuDate from request: " + menuDate);
}

Connection conn = (Connection) session.getAttribute("con");
if (conn == null) {
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 연결이 초기화되지 않았습니다.");
    return;
} else {
    System.out.println("DB연결 성공");
}

// 세션에서 후보 데이터를 확인하고 초기화
List<String> currentCandidates = (List<String>) session.getAttribute("candidates");
if (currentCandidates == null || currentCandidates.isEmpty()) {
    currentCandidates = new ArrayList<>();
    System.out.println("currentCandidates is empty. Fetching new candidates.");
    
    String query = "SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date, " +
                   "LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names " +
                   "FROM highschool_menu " +
                   "WHERE TO_CHAR(menu_date, 'YYYYMM') = ? " + // 2024년 10월 데이터만 선택
                   "GROUP BY TO_CHAR(menu_date, 'YYYYMMDD') " + // 날짜별로 그룹화
                   "ORDER BY menu_date";
    
    try {
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, menuDate); // 해당 월의 데이터 가져오기
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            String menuNames = rs.getString("menu_names");
            currentCandidates.add(menuNames);
            System.out.println("Added menu names: " + menuNames); // Add a debug log
        }
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 조회 중 오류가 발생했습니다.");
        return;
    }
    session.setAttribute("candidates", currentCandidates);
} else {
    System.out.println("currentCandidates: " + currentCandidates);
}

// Format menu_date to yyyy년 MM월 dd일
String formattedMenuDate = "";
try {
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
    Date date = inputFormat.parse(menuDate + "01"); // Adding "01" as a default day
    formattedMenuDate = outputFormat.format(date);
} catch (Exception e) {
    e.printStackTrace();
}

// 게임 종료 조건: 후보가 하나 남으면 결과 페이지로 리다이렉트
if (currentCandidates.size() <= 1) {
    if (currentCandidates.isEmpty()) {
        response.sendRedirect("result.jsp"); // 후보가 없으면 바로 결과 페이지로 리다이렉트
        return;
    }

    String winner = currentCandidates.get(0); // 최종 후보가 하나라면
    session.setAttribute("winner", winner); // 승자 저장

    // DB에 선택 횟수 반영
    String updateQuery = "UPDATE highschool_menu SET select_count = select_count + 1 WHERE menu_name = ?";
    try (PreparedStatement updatePstmt = conn.prepareStatement(updateQuery)) {
        updatePstmt.setString(1, winner);
        updatePstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    response.sendRedirect("result.jsp");
    return;
}

// 랜덤으로 두 후보 선택
Random random = new Random();
int index1 = random.nextInt(currentCandidates.size());
int index2;
do {
    index2 = random.nextInt(currentCandidates.size());
} while (index1 == index2);

String candidate1 = currentCandidates.get(index1);
String candidate2 = currentCandidates.get(index2);

// 선택된 후보 처리
String selected = request.getParameter("selected");
if (selected != null) {
    currentCandidates.removeIf(c -> !c.equals(selected)); // 선택된 후보만 남김
    session.setAttribute("candidates", currentCandidates);

    // DB에 선택 횟수 반영
    String updateQuery = "UPDATE highschool_menu SET select_count = select_count + 1 WHERE menu_name = ?";
    try (PreparedStatement updatePstmt = conn.prepareStatement(updateQuery)) {
        updatePstmt.setString(1, selected);
        updatePstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>이상형 월드컵</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h1>이상형 월드컵</h1>
    <form action="game.jsp" method="post">
        <div class="choice">
            <!-- 첫 번째 후보 -->
            <div class="candidate" style="background-image: url('images/<%=candidate1%>.jpg');">
                <h3><%= formattedMenuDate %></h3>
                <div>
                    <% 
                        String[] menuItems1 = candidate1.split(", ");
                        for (String menu : menuItems1) {
                    %>
                        <p><%= menu %></p>
                    <% 
                        }
                    %>
                </div>
            </div>

            <!-- 두 번째 후보 -->
            <div class="candidate" style="background-image: url('images/<%=candidate2%>.jpg');">
                <h3><%= formattedMenuDate %></h3>
                <div>
                    <% 
                        String[] menuItems2 = candidate2.split(", ");
                        for (String menu : menuItems2) {
                    %>
                        <p><%= menu %></p>
                    <% 
                        }
                    %>
                </div>
            </div>

            <!-- Form buttons -->
            <div class="buttons">
                <button type="submit" name="selected" value="<%=candidate1%>">선택</button>
                <button type="submit" name="selected" value="<%=candidate2%>">선택</button>
            </div>
        </div>
    </form>
</body>
</html>
