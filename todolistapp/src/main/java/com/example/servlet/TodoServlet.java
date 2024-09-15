/*package com.example.servlet;

import com.example.dao.TodoDAO;
import com.example.model.Todo;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/todo")
public class TodoServlet extends HttpServlet {
    private TodoDAO todoDAO = new TodoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filter = request.getParameter("filter");
        if (filter == null) {
            filter = "all";
        }
        request.setAttribute("todos", todoDAO.getFilteredTodos(filter));
        request.setAttribute("currentFilter", filter);
        request.getRequestDispatcher("/todo-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String task = request.getParameter("task");
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            Todo.Priority priority = Todo.Priority.valueOf(request.getParameter("priority"));
            todoDAO.addTodo(task, dueDate, priority);
        } else if ("toggle".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            todoDAO.toggleTodo(id);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            todoDAO.deleteTodo(id);
        }
        response.sendRedirect(request.getContextPath() + "/todo");
    }
}
*/

package com.example.servlet;

import com.example.dao.TodoDAO;
import com.example.model.Todo;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/todo")
public class TodoServlet extends HttpServlet {
    private TodoDAO todoDAO = new TodoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String filter = request.getParameter("filter");
        if (filter == null) {
            filter = "all";
        }
        request.setAttribute("todos", todoDAO.getFilteredTodos(filter));
        request.setAttribute("currentFilter", filter);
        request.getRequestDispatcher("/todo-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String task = request.getParameter("task");
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            Todo.Priority priority = Todo.Priority.valueOf(request.getParameter("priority"));
            todoDAO.addTodo(task, dueDate, priority);
        } else if ("toggle".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            todoDAO.toggleTodo(id);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            todoDAO.deleteTodo(id);
        }
        response.sendRedirect(request.getContextPath() + "/todo");
    }
}
