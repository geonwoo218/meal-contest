<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <title>이상형 월드컵</title>
    <link rel="stylesheet" href="assets/indexStyle.css">
</head>
<body>
    <h1>학교 급식 이상형 월드컵</h1>
    <form action="game.jsp" method="post" name="startForm">
    <select name="round">
    <option value="">라운드 수를 선택해주세요.</option>
    <option value="8">8강</option>
    <option value="16">16강</option>
    <option value="32">32강</option>
    </select>
        <button type="button" onclick="start()">게임 시작</button>
    </form>
</body>
<script type="text/javascript">
function start() {
	if(startForm.round.value==""){
		alert("플레이할 라운드 수를 선택해주세요.");
		startForm.round.focus();
	}else{
		startForm.submit();
	}
}
</script>
</html>
