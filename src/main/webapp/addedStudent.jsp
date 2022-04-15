<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.demo.jspservlet.model.Student"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student</title>
</head>
<style>
.center {
	margin: auto;
	width: 400px;
	border: 1px solid black;
}
</style>

<body bgcolor="lightgreen">



	<%
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root", "Admin@123$");

	if (request.getParameter("id") != null) {

		int id = Integer.parseInt(request.getParameter("id"));

		Student st = new Student();
		st.setId(id);

		if (id != 0) {
			String quaryValue = ("select * from Student where id = " + id);

			Statement stmtId = con.createStatement();
			ResultSet rs = stmtId.executeQuery(quaryValue);

			String name = null;
			String tech = null;
			String motherTongue = null;
			boolean isActive;

			while (rs.next()) {
	%>

	<div class="center">

		<form action="postData" method="post">

			<label for="name"><b>Name : </b></label> <input type="text"
				value=<%=name = rs.getString("name")%> name="name"
				required="required"> <br> <label for="tech"><b>
					Tech : </b> </label> <input type="text" value=<%=tech = rs.getString("tech")%>
				name="tech" required="required"> <br> <br>

			<table>
				<label for="Subjects"><b>Favorite subject</b></label>


				<%
				String query = ("select sub.name from studentSubject as ss join student as st on ss.StudId = st.id join subject as sub on ss.subId = sub.id where st.id = "
						+ id);

				Statement stmtSub = con.createStatement();
				ResultSet rsSub = stmtSub.executeQuery(query);

				List<String> list = new ArrayList();
				list.add("Maths");
				list.add("Science");
				list.add("English");

				while (rsSub.next()) {

					if (rsSub.getString(1).equals("Maths")) {
				%>
				<tr>
					<td><input type="checkbox" name="subjects" value="Maths"
						checked="checked" />Maths</td>
				</tr>
				<%
				//	rsSub.next();
				list.remove(new String("Maths"));
				}

				else if (rsSub.getString(1).equals("Science")) {
				%>
				<tr>
					<td><input type="checkbox" name="subjects" value="Science"
						checked="checked" />Science</td>
				</tr>
				<%
				//	rsSub.next();
				list.remove(new String("Science"));

				}

				else if (rsSub.getString(1).equals("English")) {
				%>
				<tr>
					<td><input type="checkbox" name="subjects" value="English"
						checked="checked" />English</td>
				</tr>
				<%
				//	rsSub.next();
				list.remove(new String("English"));

				}
				}
				for (int i = 0; i < list.size(); i++) {

				if (list.get(i).equals("Maths")) {
				%>
				<tr>
					<td><input type="checkbox" name="subjects" value="Maths" />Maths</td>
				</tr>
				<%
				} else if (list.get(i).equals("Science")) {
				%>
				<tr>
					<td><input type="checkbox" name="subjects" value="Science" />Science</td>
				</tr>
				<%
				} else if (list.get(i).equals("English")) {
				%><tr>
					<td><input type="checkbox" name="subjects" value="English" />English</td>
				</tr>
				<%
				}
				}
				%>






			</table>

			<br> <label for="language"><b>motherTongue</b></label> <select
				name="language" id="language">

				<%
				if (rs.getString("language").equals("Hindi")) {
				%>

				<option value="Hindi">Hindi</option>
				<option value="Gujarati">Gujarati</option>
				<option value="English">English</option>
			</select> <br> <br>

			<%
			} else if (rs.getString("language").equals("Gujarati")) {
			%>

			<option value="Gujarati">Gujarati</option>
			<option value="Hindi">Hindi</option>
			<option value="English">English</option>
			</select> <br> <br>

			<%
			} else if (rs.getString("language").equals("English")) {
			%>

			<option value="English">English</option>
			<option value="Gujarati">Gujarati</option>
			<option value="Hindi">Hindi</option>
			</select> <br> <br>

			<%
			}
			%>


			<label for="isActive"><b>isActive </b> </label>




			<%
			String queryAct = ("select isActive from Student where id = " + id);
			Statement stmtAct = con.createStatement();
			ResultSet rsAct = stmtAct.executeQuery(queryAct);

			while (rsAct.next()) {

				if (rsAct.getBoolean(1) == true) {
			%>
			<input type="radio" name="isActive" value="Yes" checked="checked">
			<label for="isActive">Yes</label> <input type="radio" name="isActive"
				value="No"> <label for="isActive">No</label>

			<%
			} else if (rsAct.getBoolean(1) == false) {
			%>
			<input type="radio" name="isActive" value="Yes"> <label
				for="isActive">Yes</label> <input type="radio" name="isActive"
				value="No" checked="checked"> <label for="isActive">No</label>


			<%
			}
			}
			%>

			<br> <input type="hidden" value=<%=id%> name="id"> <br>

			<div class="space">
				<input type="submit" onclick="myFunction()" value="Submit">
			</div>
			<script>
				function myFunction() {

					alert("saved ");
					
				
				}
			</script>
			<style>
.space {
	width: 4px;
	height: auto;
	display: inline-block;
}
</style>

		</form>


		<%
		}
		%>
	</div>


	<%
	}
	} else {
	%>

	<div class="center">



		<form action="postData" method="Post">


			<label for="name"><b> Name :</b></label> <input type="text"
				placeholder="Enter Name" name="name" required> <br> <label
				for="tech"><b> Tech :</b></label> <input type="text"
				placeholder="Enter Tech" name="tech" required><br> <br>


			<table>

				<label for="Subjects"><b>Favorite subject</b></label>

				<tr>
					<td><input type="checkbox" name="subjects" value="Maths" />
						Maths</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="subjects" value="Science" />
						Science</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="subjects" value="English" />
						English</td>
				</tr>
			</table>



			<br> <label for="language"><b> motherTongue</b></label> <select
				name="language" id="language">
				<option value="Hindi">Hindi</option>
				<option value="Gujarati">Gujarati</option>
				<option value="English">English</option>
			</select> <br> <br> <label for="isActive"><b>isActive </b> </label>
			<input type="radio" name="isActive" value="Yes" checked="checked">
			<label for="isActive">Yes</label> <input type="radio" name="isActive"
				value="No"> <label for="isActive">No</label><br> <br>


			<input type="submit" onclick="myFunction()" value="Submit">

			<script>
				function myFunction() {

					alert("Your Data  Successfully Saved successfully");
					 var txt;
					 txt =  
				}
			</script>
		</form>
	</div>

	<%
	}
	%>

	<p style="text-align: center;">click submit button to save data</p>

</body>
</html>