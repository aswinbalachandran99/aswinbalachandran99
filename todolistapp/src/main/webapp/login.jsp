<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Todo List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
</head>
<body>
    <div class="login-container">
        <h1>Todo List</h1>
        <form class="login-form" action="${pageContext.request.contextPath}/login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">Invalid username or password</p>
        <% } %>
    </div>
</body>
</html>
