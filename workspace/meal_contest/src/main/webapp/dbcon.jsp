<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
try {
    // Oracle JDBC 드라이버 로드
    Class.forName("oracle.jdbc.OracleDriver");
    
    // DB 연결 설정
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "system";
    String dbPassword = "1234";
    
    // Connection 객체 생성
    Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    
    // 세션에 Connection 객체 저장
    session.setAttribute("con", con);
    
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    throw new ServletException("JDBC 드라이버 로드 실패", e);
} catch (SQLException e) {
    e.printStackTrace();
    throw new ServletException("DB 연결 실패", e);
}
%>
