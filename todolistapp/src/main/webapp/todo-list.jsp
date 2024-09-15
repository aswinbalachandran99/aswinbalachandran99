<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Todo List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
</head>
<body>
    <h1>Todo List</h1>
    
    <div class="user-info">
        Welcome, ${sessionScope.username}! 
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
            <input type="submit" value="Logout">
        </form>
    </div>

    <div class="filter-options">
        <a href="${pageContext.request.contextPath}/todo?filter=all" class="${currentFilter == 'all' ? 'active' : ''}">All</a>
        <a href="${pageContext.request.contextPath}/todo?filter=active" class="${currentFilter == 'active' ? 'active' : ''}">Active</a>
        <a href="${pageContext.request.contextPath}/todo?filter=completed" class="${currentFilter == 'completed' ? 'active' : ''}">Completed</a>
        <a href="${pageContext.request.contextPath}/todo?filter=high" class="${currentFilter == 'high' ? 'active' : ''}">High Priority</a>
    </div>

    <form class="todo-form" action="${pageContext.request.contextPath}/todo" method="post">
        <input type="hidden" name="action" value="add">
        <input type="text" name="task" placeholder="Enter a new task" required>
        <input type="date" name="dueDate" required>
        <select name="priority" required>
            <option value="LOW">Low</option>
            <option value="MEDIUM">Medium</option>
            <option value="HIGH">High</option>
        </select>
        <input type="submit" value="Add Task">
    </form>

    <ul class="todo-list">
        <c:forEach var="todo" items="${todos}">
            <li class="todo-item ${todo.completed ? 'completed' : ''} priority-${todo.priority.toString().toLowerCase()}">
                <div class="todo-info">
                    <c:choose>
                        <c:when test="${todo.completed}">
                            <del>${todo.task}</del>
                        </c:when>
                        <c:otherwise>
                            ${todo.task}
                        </c:otherwise>
                    </c:choose>
                    <div class="due-date">Due: <fmt:parseDate value="${todo.dueDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                    <fmt:formatDate value="${parsedDate}" type="date" pattern="MMM dd, yyyy" /></div>
                </div>
                <div class="todo-actions">
                    <form action="${pageContext.request.contextPath}/todo" method="post">
                        <input type="hidden" name="action" value="toggle">
                        <input type="hidden" name="id" value="${todo.id}">
                        <input type="submit" class="toggle" value="${todo.completed ? 'Undo' : 'Complete'}">
                    </form>
                    <form action="${pageContext.request.contextPath}/todo" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${todo.id}">
                        <input type="submit" value="Delete">
                    </form>
                </div>
            </li>
        </c:forEach>
    </ul>
</body>
</html>
