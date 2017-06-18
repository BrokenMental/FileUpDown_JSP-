<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>list.jsp</title>
</head>
<body>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/mud";
		int total = 0;

		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "1234");
			Statement stmt = conn.createStatement();

			String sqlTotal = "select count(*) from fileup";
			ResultSet rs = stmt.executeQuery(sqlTotal);

			while (rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();

			String sql = "select * from fileup order by num desc";
			rs = stmt.executeQuery(sql);
	%>
	<h1>게시글 리스트</h1>
	<table border="1" style="border-collapse: collapse;">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>공유번호</th>
			<th>파일명</th>
			<th>날짜</th>
		</tr>
		</table>
	<%
		while (rs.next()) {
				int num = rs.getInt(1);
				String writer = rs.getString(2);
				String port = rs.getString(3);
				String location = rs.getString(4);
				String date = rs.getString(5);
	%>
		<table border="1" style="border-collapse: collapse;" onclick="location.href='view.jsp?num=<%=num %>'">
		<tr>
			<td><%=num%></td>
			<td><%=writer%></td>
			<td><%=port%></td>
			<td><%=location%></td>
			<td><%=date%></td>
		</tr>
	</table>
	<%
		}
	%>
	<a href="write.jsp">파일 추가하기</a>
	<%
		rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	%>
</body>
</html>