package model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class Borrow {
    private int borrowID;
    private User user;
    private Date borrowDate;
    private List<Fine> fines;

    public Borrow() {
        this.fines = new ArrayList<>();
    }

    public Borrow(int borrowID, User user, Date borrowDate) {
        this.borrowID = borrowID;
        this.user = user;
        this.borrowDate = borrowDate;
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

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
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