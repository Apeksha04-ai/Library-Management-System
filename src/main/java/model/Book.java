package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Book {
    private int id;
    private String isbn;
    private String title;
    private int authorId;
    private String category;
    private int quantity;
    private Date publicationDate;
    private String coverImage;
    private boolean available;
    
    private List<Author> authors;
    
    public Book() {
        this.authors = new ArrayList<>();
    }
    
    public Book(int bookID, String isbn, String title, Date publicationDate, 
                String imageUrl, String availabilityStatus) {
        this.id = bookID;
        this.isbn = isbn;
        this.title = title;
        this.publicationDate = publicationDate;
        this.coverImage = imageUrl;
        this.available = availabilityStatus.equals("Available");
        this.authors = new ArrayList<>();
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
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
    
    public int getAuthorId() {
        return authorId;
    }
    
    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public Date getPublicationDate() {
        return publicationDate;
    }
    
    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }
    
    public String getCoverImage() {
        return coverImage;
    }
    
    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }
    
    public boolean isAvailable() {
        return available;
    }
    
    public void setAvailable(boolean available) {
        this.available = available;
    }
    
    public List<Author> getAuthors() {
        return authors;
    }
    
    public void setAuthors(List<Author> authors) {
        this.authors = authors;
    }
    
    public void addAuthor(Author author) {
        this.authors.add(author);
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", isbn='" + isbn + '\'' +
                ", title='" + title + '\'' +
                ", authorId=" + authorId +
                ", category='" + category + '\'' +
                ", quantity=" + quantity +
                ", publicationDate=" + publicationDate +
                ", coverImage='" + coverImage + '\'' +
                ", available=" + available +
                '}';
    }
} 