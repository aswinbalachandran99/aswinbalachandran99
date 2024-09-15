package com.example.dao;

import com.example.model.Todo;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class TodoDAO {
    private static List<Todo> todos = new ArrayList<>();
    private static int idCounter = 1;

    static {
        todos.add(new Todo(idCounter++, "A Sample Todo", false, LocalDate.now().plusDays(7), Todo.Priority.HIGH));
        
    }

    public List<Todo> getAllTodos() {
        return new ArrayList<>(todos);
    }

    public void addTodo(String task, LocalDate dueDate, Todo.Priority priority) {
        todos.add(new Todo(idCounter++, task, false, dueDate, priority));
    }

    public void toggleTodo(int id) {
        for (Todo todo : todos) {
            if (todo.getId() == id) {
                todo.setCompleted(!todo.isCompleted());
                break;
            }
        }
    }

    public void deleteTodo(int id) {
        todos.removeIf(todo -> todo.getId() == id);
    }

    public List<Todo> getFilteredTodos(String filter) {
        switch (filter) {
            case "completed":
                return todos.stream().filter(Todo::isCompleted).collect(Collectors.toList());
            case "active":
                return todos.stream().filter(todo -> !todo.isCompleted()).collect(Collectors.toList());
            case "high":
                return todos.stream().filter(todo -> todo.getPriority() == Todo.Priority.HIGH).collect(Collectors.toList());
            default:
                return getAllTodos();
        }
    }
}
