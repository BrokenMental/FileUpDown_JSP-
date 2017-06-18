<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.io.File, java.util.Enumeration, com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
    com.oreilly.servlet.MultipartRequest, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>write_ok.jsp</title>
</head>
<body>
<%
/*
out.print(request.getParameter("writer")+"<br/>");
out.print(request.getParameter("num")+"<br/>");
out.print(request.getParameter("filename")+"<br/>");
out.print(request.getParameter("date")+"<br/>");
*/

String jdbc_driver = "com.mysql.jdbc.Driver";
String jdbc_url = "jdbc:mysql://localhost/mud";
Class.forName(jdbc_driver);

try{
	
	String saveDir=application.getRealPath("/upload");
	int maxPostSize=1024*1024*20;
	
	MultipartRequest mr = new MultipartRequest(request,saveDir,maxPostSize,"utf-8",new DefaultFileRenamePolicy());
	//out.print("파일 저장 성공 <br/><br/>");
	
	String writer = mr.getParameter("writer");
	String port = mr.getParameter("port");
	String date = mr.getParameter("date");
	
	/*
	out.print("작성자 :" + writer+"<br/>");
	out.print("공유번호 :" + num+"<br/>");
	out.print("파일명 :" + +"<br/>");
	out.print("날짜 :" + date+"<br/>");
	*/
	
	Enumeration<?> files=mr.getFileNames();
	String filename = (String)files.nextElement();
	out.print("파일명: " + mr.getFilesystemName(filename));
	out.print("<br/>");
	out.print("원본파일명:" + mr.getOriginalFileName(filename));
	out.print("<br/>");
	
	File obj=mr.getFile(filename);
	if(obj.exists()){
		out.print("파일크기 : "+obj.length() +"<br/>");
		out.print("파일명 : "+obj.getName() +"<br/>");
		out.print("경로+파일명 : "+obj.getPath() +"<br/>");
	}
	%>
<form action = "list.jsp" method="post">
작성자 : <%=writer %><br/>
파일명 : <%=mr.getOriginalFileName(filename) %><br/>
공유번호 : <%=port %><br/>
날짜 : <%=date %><br/>
<input type="submit" value="확인"/>
</form>
	파일 다운로드 :
	<a href="upload/<%=obj.getName() %>"><%=obj.getName() %></a>
	
	<%
	Connection conn = DriverManager.getConnection(jdbc_url, "root", "1234");
	String sql = "insert into fileup(writer,port,location,date) values(?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, writer);
	pstmt.setString(2, port);
	pstmt.setString(3, obj.getName());
	pstmt.setString(4, date);
	
	pstmt.execute();
	pstmt.close();
	conn.close();
	
}catch(Exception e){
	out.print(e);
	out.print("<br/>파일저장 실패");
	out.print("<a href='javascript:history.back()'>[다시시도]</a>");
}
%>
</body>
</html>