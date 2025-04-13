package model;

public class Borrow {
    private int borrowId;
    private int userId;
    private String borrowDate;

    public int getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(String borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Borrow(int borrowId, int userId, String borrowDate) {
        this.borrowId = borrowId;
        this.userId = userId;
        this.borrowDate = borrowDate;
    }
}
