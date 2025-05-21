package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Borrow {
    private int borrowID;
    private User user;
    private Book book;
    private Date borrowDate;
    private Date dueDate;
    private Date returnDate;
    private List<Fine> fines;
    
    public Borrow() {
        this.fines = new ArrayList<>();
    }
    
    public Borrow(int borrowID, User user, Book book, Date borrowDate, Date dueDate) {
        this.borrowID = borrowID;
        this.user = user;
        this.book = book;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.fines = new ArrayList<>();
    }
    
    // Getters and Setters
    public int getBorrowID() {
        return borrowID;
    }
    
    public void setBorrowID(int borrowID) {
        this.borrowID = borrowID;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Book getBook() {
        return book;
    }
    
    public void setBook(Book book) {
        this.book = book;
    }
    
    public Date getBorrowDate() {
        return borrowDate;
    }
    
    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }
    
    public Date getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
    public Date getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
    
    public List<Fine> getFines() {
        return fines;
    }
    
    public void setFines(List<Fine> fines) {
        this.fines = fines;
    }
    
    public void addFine(Fine fine) {
        this.fines.add(fine);
    }
} 