<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<%
	String fileName=request.getParameter("fileName");
	ServletContext context= getServletContext();
	String downloadPath=request.getRealPath("upload");
	String filePath=downloadPath+"\\"+fileName;
	File file=new File(filePath);
	
	String mimeType = getServletContext().getMimeType(filePath);
	   if (mimeType == null)
	      mimeType = "application/octet-stream";
	   response.setContentType(mimeType);
	   
	   
	String encoding=new String(fileName.getBytes("utf-8"),"8859_1");
	response.setHeader("Content-Disposition", "attachment; filename= " + encoding);
	
	FileInputStream in =new FileInputStream(file);
	ServletOutputStream outStream=response.getOutputStream();
	
	byte b[] =new byte[4096];
	int data=0;
	while((data=in.read(b,0,b.length))!=-1){
		outStream.write(b,0,data);
	}
	outStream.flush();
	outStream.close();
	in.close();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>