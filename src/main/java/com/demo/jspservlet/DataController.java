package com.demo.jspservlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.jspservlet.Dao.StudentDao;
import com.demo.jspservlet.model.Student;

public class DataController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DataController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));

		Student st = new Student();
		st.setId(id);

//		StudentDao dao = new StudentDao();
//		Student st = dao.getData();
//
//		request.setAttribute("student", st);
//
//		RequestDispatcher rd = request.getRequestDispatcher("showStudent.jsp");
//
//		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		StudentDao dao = new StudentDao();
		boolean isActive;

		String name = request.getParameter("name");
		String tech = request.getParameter("tech");
		String isActiveString = request.getParameter("isActive");
		String idString = request.getParameter("id");
		String language = request.getParameter("language");

		String[] subjects = request.getParameterValues("subjects");

		if (isActiveString.equals("Yes")) {
			isActive = true;
			isActive = Boolean.parseBoolean("true");
		} else {
			isActive = false;
			isActive = Boolean.parseBoolean(isActiveString);

		}
//	=================================================================

		Student st = null;
		int id = 0;
		if (idString == null) {
			idString = "0";

			id = Integer.parseInt(idString);

			try {
				st = dao.postData(id, name, tech, language, isActive);
				dao.deleteSubjectData(id);

				for (int i = 0; i < subjects.length; i++) {

					dao.subjectData(subjects[i], name, tech);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {

			id = Integer.parseInt(idString);

			try {

				st = dao.postData(id, name, tech, language, isActive);
				dao.deleteSubjectData(id);

				for (int i = 0; i < subjects.length; i++) {

					dao.subjectDataUpdate(subjects[i], name, tech);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		request.setAttribute("student", st);

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");

		rd.forward(request, response);
	
	//	System.out.println("123");
	}

}
