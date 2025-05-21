package model;

public class BookAuthor {
    private int bookID;
    private int authorID;
    
    public BookAuthor() {
    }
    
    public BookAuthor(int bookID, int authorID) {
        this.bookID = bookID;
        this.authorID = authorID;
    }
    
    // Getters and Setters
    public int getBookID() {
        return bookID;
    }
    
    public void setBookID(int bookID) {
        this.bookID = bookID;
    }
    
    public int getAuthorID() {
        return authorID;
    }
    
    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }
} 