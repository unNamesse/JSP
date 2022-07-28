<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("utf-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page" />
    <jsp:setProperty name="user" property="userID" />
    <jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹 사이드</title>
</head>
<body>
	<%
		//현재 세션상태를 체크한다
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		//이미로그인했으면 다시로그인할수없게한다
		if(userID !=null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미로그인이 되어있습니다')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		
		UserDAO userDAO =new UserDAO();
		int result=userDAO.login(user.getUserID(),user.getUserPassword());
		if(result==1){
			session.setAttribute("userID",user.getUserID());
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인성공')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else if(result==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result==-2){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>