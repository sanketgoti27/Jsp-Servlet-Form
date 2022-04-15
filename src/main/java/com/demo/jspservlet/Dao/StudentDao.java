package com.demo.jspservlet.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.demo.jspservlet.model.Student;
import com.mysql.cj.xdevapi.Result;

public class StudentDao {

	Student st = new Student();

	public Student getData(int id) {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from Student where id=" + id);

			if (rs.next()) {
				st.setId(rs.getInt("id"));
				st.setName(rs.getString("name"));
				st.setTech(rs.getString("tech"));
			}

			con.close();
			rs.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return st;

	}

	public Student postData(int id, String name, String tech, String language, boolean isActive) throws Exception {

		StudentDao dao = new StudentDao();


		if (id != 0) {

			st.setId(id);
			dao.updateData(id, name, tech, language, isActive);

		} else {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");

			PreparedStatement pstmtAdd = con
					.prepareStatement("insert into Student (name , tech ,language ,isActive) values (?,?,?,?) ");
			pstmtAdd.setString(1, name);
			pstmtAdd.setString(2, tech);
			pstmtAdd.setString(3, language);
			pstmtAdd.setBoolean(4, isActive);

			pstmtAdd.executeUpdate();

			st.setName(name);
			st.setTech(tech);

			Statement stmtNewId = con.createStatement();
			ResultSet rsNew = stmtNewId.executeQuery(
					"select id from Student where name = " + "'" + name + "'" + " and tech = " + "'" + tech + "'");

			while (rsNew.next()) {
				int idPData = rsNew.getInt("id");
				st.setId(idPData);
			}
		}
		return st;
	}

	public Student updateData(int id, String name, String tech, String language, Boolean isActive) {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");


			String sql = "UPDATE Student set name = ? ,tech = ? , isActive = ? , language = ? where id = ? ";

			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, tech);
			pstmt.setBoolean(3, isActive);
			pstmt.setString(4, language);
			pstmt.setInt(5, id);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

	public Student subjectData(String subject, String name, String tech) {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");

			Statement stmtNewId = con.createStatement();
			ResultSet rsNew = stmtNewId.executeQuery(
					"select id from Student where name = " + "'" + name + "'" + " and tech = " + "'" + tech + "'");

			while (rsNew.next()) {
				int idPData = rsNew.getInt("id");
				st.setId(idPData);
			}

			int subjectId = 0;

			if (subject.equals("Maths"))
				subjectId = 1;
			else if (subject.equals("Science"))
				subjectId = 2;
			else
				subjectId = 3;

			String query = "insert into StudentSubject (StudId,subId) values (?,?)";
			PreparedStatement pstmt = con.prepareStatement(query);

			pstmt.setInt(1, st.getId());
			pstmt.setInt(2, subjectId);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return st;

	}

	boolean flag = true;

	public Student subjectDataUpdate(String subject, String name, String tech) {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");

			Statement stmtNewId = con.createStatement();
			ResultSet rsNew = stmtNewId.executeQuery(
					"select id from Student where name = " + "'" + name + "'" + " and tech = " + "'" + tech + "'");
			int idPData = 0;

			while (rsNew.next()) {
				idPData = rsNew.getInt("id");
				st.setId(idPData);
			}

			int id = 0;
			int subjectId = 0;

			if (subject.equals("Maths"))
				subjectId = 1;
			else if (subject.equals("Science"))
				subjectId = 2;
			else
				subjectId = 3;

			String query = ("insert into studentSubject (studId,subId) values (?,?)");
			PreparedStatement pstmt = con.prepareStatement(query);

			pstmt.setInt(1, idPData);
			pstmt.setInt(2, subjectId);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return st;

	}

	public void deleteSubjectData(int id) {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jspservlet", "root",
					"Admin@123$");

			Statement stmtPreviousSub = con.createStatement();
			stmtPreviousSub.executeUpdate("delete from studentSubject where StudId = " + id);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
