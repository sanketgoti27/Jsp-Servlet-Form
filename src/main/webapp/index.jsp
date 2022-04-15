<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.demo.jspservlet.model.Student"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<HEAD>
<TITLE>The View Of Database Table</TITLE>
</HEAD>

<body bgcolor="lightBlue">
	<H1>The View Of Database Table</H1>

	<%
	Student st = new Student();

	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root", "Admin@123$");

	Statement stmt = con.createStatement();

	ResultSet rs = stmt.executeQuery("select * from Student ");
	%>

	<table BORDER="1">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>tech</th>
			<th>language</th>
			<th>isActive</th>
			<th>Favorite Subjects</th>

		</tr>

		<%
		int id = 0;
		while (rs.next()) {
		%>
		<tr>

			<td><%=rs.getInt(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
 			<td><%=rs.getString(4)%></td>
			<td><%=rs.getBoolean(5)%></td>

			<%
			String query = " select sub.name from studentSubject as ss join student as st on ss.StudId = st.id join subject as sub on ss.subId = sub.id where st.id = "
					+ rs.getInt(1);
			Statement stmtSub = con.createStatement();
			ResultSet rsSub = stmtSub.executeQuery(query);

			List<String> list = new ArrayList<String>();

			while (rsSub.next()) {

				list.add(rsSub.getString(1));

				//		System.out.println(rsSub.getString(1));

				//		String sub = rsSub.getString(1);
			%>
			<%
			}
			%>
			<td><%=list%></td>


			<td><a href="addedStudent.jsp?id=<%=rs.getInt(1)%>">Edit</a></td>
		</tr>

		<%
		}
		%>

	</table>

	<h2>
		for add new Student click on below Button <a href="addedStudent.jsp">Add</a>
	</h2>

	<h1>list of inActive Students</h1>
	<%
	ResultSet rsInActive = stmt.executeQuery("select * from Student where isActive = false ");
	%>

	<table BORDER="1">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>tech</th>
			<th>language</th>
			<th>isActive</th>

		</tr>

		<%
		while (rsInActive.next()) {
		%>
		<tr>

			<td><%=rsInActive.getInt(1)%></td>
			<td><%=rsInActive.getString(2)%></td>
			<td><%=rsInActive.getString(3)%></td>
			<td><%=rsInActive.getString(4)%></td>
			<td><%=rsInActive.getBoolean(5)%></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>
