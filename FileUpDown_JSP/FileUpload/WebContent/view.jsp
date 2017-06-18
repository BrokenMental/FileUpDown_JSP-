<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view.jsp</title>
</head>
<body>
	<%
		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/mud";
		Class.forName(jdbc_driver);
		int num = Integer.parseInt(request.getParameter("num"));
		try {
			Connection conn = DriverManager.getConnection(jdbc_url, "root", "1234");
			Statement stmt = conn.createStatement();
			String sql = "select * from fileup where num=" + num;
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String writer = rs.getString(2);
				String port = rs.getString(3);
				String location = rs.getString(4);
				String date = rs.getString(5);
	%>
	<table><tr><td><audio controls src="upload/<%=location%>" type='audio/mp3'></audio></td></tr></table>
	<table border="1" style="border-collapse: collapse;">
		<tr>
			<td>번호</td>
			<td><%=num%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=writer%></td>
		</tr>
		<tr>
			<td>공유번호</td>
			<td><%=port%></td>
		</tr>
		<tr>
			<td>파일이름</td>
			<td><a href="upload/<%=location%>"><%=location%></a></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=date%></td>
		</tr>
		<tr>
			<td></td>
			<td align="right">
			<input type="button" value="수정" />
			<input type="button" value="삭제" />
			<input type="button" value="취소" onClick="history.back()" />
			</td>
		</tr>
	</table>
	<%
		}
		} catch (Exception e) {

		}
	%>
</body>
</html>