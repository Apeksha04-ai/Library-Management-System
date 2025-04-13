package model;

public class Book {
    private int bookId;
    private String isbn;
    private String title;
    private String publicationDate;
    private String availabilityStatus;

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public Book(int bookId, String isbn, String title, String publicationDate, String availabilityStatus) {
        this.bookId = bookId;
        this.isbn = isbn;
        this.title = title;
        this.publicationDate = publicationDate;
        this.availabilityStatus = availabilityStatus;
    }

}

