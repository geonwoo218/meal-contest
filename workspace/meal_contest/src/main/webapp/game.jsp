<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- DB 연결 확인 -->
<%@include file="dbcon.jsp"%>
<%
if (con == null) {
	response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 연결이 초기화되지 않았습니다.");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>이상형 월드컵</title>
<link rel="stylesheet" href="assets/gameStyle.css">
</head>
<body>
	<form action="game.jsp" method="post" name="form">
		<div class="round" id="matchDisplay"></div>

		<section>
			<!-- 후보 1 -->
			<div id="leftContainer">
				<h3 id="menudate1"></h3>
				<button type="button" id="selected1" class="cBtn" onclick="select(1)">
					<img alt="후보 1" id="img1">
				</button>
				<div id="menu1" class="menulist">
				</div>
			</div>

			<!-- VS -->
			<div id="centerContainer">
				<span>VS</span>
			</div>

			<!-- 후보 2 -->
			<div id="rightContainer">
				<h3 id="menudate2"></h3>
				<button type="button" id="selected2" class="cBtn" onclick="select(2)">
					<img alt="후보 2" id="img2">
				</button>
				<div id="menu2" class="menulist"></div>
			</div>
		</section>
	</form>

	<script>
    <%String round = request.getParameter("round");%>
    let currentRound = [];
    let nextRound = [];
    let round = <%=round%>;

    let roundDisplay = document.getElementById('matchDisplay');

  	// round강 c/back
    let c = 1; 
    let back = round / 2;

    let candidate1;
    let candidate2;

    window.onload = function () {
    	<%
    	String query = "SELECT * FROM (SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date, "
		+ "LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names "
		+ "FROM highschool_menu GROUP BY TO_CHAR(menu_date, 'YYYYMMDD') "
		+ "ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM <= ?";

		PreparedStatement pstmt = con.prepareStatement(query);
		pstmt.setString(1, round);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			String menudate = rs.getString("menu_date");
			String menuname = rs.getString("menu_names");
			String value = menudate + ":" + menuname;
			%>
		   	currentRound.push('<%=value%>');
			<%
		}%>
        setCandidate();
    }

    function setCandidate() { 
        if (currentRound.length < 2) {
            return;
        }

        candidate1data = currentRound[Math.floor(Math.random() * currentRound.length)];
        do {
            candidate2data = currentRound[Math.floor(Math.random() * currentRound.length)];
        } while (candidate1data == candidate2data);

        let candidate1Date = candidate1data.split(":")[0];
        let candidate1Menu = candidate1data.split(":")[1];
        let candidate1img = document.getElementById('img1');
        
        let candidate2Date = candidate2data.split(":")[0];
        let candidate2Menu = candidate2data.split(":")[1];
        let candidate2img = document.getElementById('img2');
        
        let menu1 = document.getElementById('menu1');
        let menu2 = document.getElementById('menu2');
        
        menu1.innerHTML = "";
        menu2.innerHTML = "";
        
        document.getElementById('menudate1').innerText = 
        	candidate1Date.substring(0,4)+ "년 "+
        	candidate1Date.substring(4,6)+ "월 "+
        	candidate1Date.substring(6,8)+"일";
        let menuList1 = candidate1Menu.split(", ");
        menuList1.forEach(function(v) {
        	let div = document.createElement("div");
        	div.textContent = v;
        	menu1.appendChild(div);
        }); 
        candidate1img.src = 'assets/images/'+candidate1Date+".jpg";
        
        document.getElementById('menudate2').innerText = 
        	candidate2Date.substring(0,4)+ "년 "+
        	candidate2Date.substring(4,6)+ "월 "+
        	candidate2Date.substring(6,8)+"일";
        let menuList2 = candidate2Menu.split(", ");
        menuList2.forEach(function(v) {
        	let div = document.createElement("div");
        	div.textContent = v;
        	menu2.appendChild(div);
        }); 
        candidate2img.src = 'assets/images/'+candidate2Date+".jpg";

     	roundDisplay.innerText = (back==1) ? "결승전" : back*2+"강 "+c + "/" + back;
    }

    function select(n) {
        c++;
        if (n == 1) {
            nextRound.push(candidate1data);
        } else if (n == 2) {
            nextRound.push(candidate2data);
        }

        currentRound = currentRound.filter(value => value !== candidate1data && value !== candidate2data);

        check();
    }

    function check() {
        if (currentRound.length == 0 && nextRound.length > 1) {
            changeRound();
        } else if (currentRound.length == 0 && nextRound.length == 1) {
           goResult(nextRound[0]);
        } else {
            setCandidate();
        }
    }

    function changeRound() {
        currentRound = [...nextRound];
        nextRound.length = 0;

        c = 1;
        back = back / 2;

        if (currentRound.length >= 2) {
            setCandidate();
        }
    }
    
    function goResult() {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'result.jsp';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'winner';
        input.value = nextRound[0];

        form.appendChild(input);
        document.body.appendChild(form);

        form.submit();
    }
    </script>
</body>
</html>
