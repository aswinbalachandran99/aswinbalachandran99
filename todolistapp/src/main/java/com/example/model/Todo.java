package com.example.model;

import java.time.LocalDate;

public class Todo {
    private int id;
    private String task;
    private boolean completed;
    private LocalDate dueDate;
    private Priority priority;

    public enum Priority {
        LOW, MEDIUM, HIGH
    }

    public Todo(int id, String task, boolean completed, LocalDate dueDate, Priority priority) {
        this.id = id;
        this.task = task;
        this.completed = completed;
        this.dueDate = dueDate;
        this.priority = priority;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTask() { return task; }
    public void setTask(String task) { this.task = task; }
    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }
    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }
    public Priority getPriority() { return priority; }
    public void setPriority(Priority priority) { this.priority = priority; }
}
