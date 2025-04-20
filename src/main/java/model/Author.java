package model;

import java.util.Date;

public class Author {
    private int id;
    private String authorName;
    private Date birthDate;
    private String nationality;
    private String awards;
    private String biography;

    // Default constructor
    public Author() {
    }

    // Constructor with all fields
    public Author(int id, String authorName, Date birthDate, String nationality, String awards, String biography) {
        this.id = id;
        this.authorName = authorName;
        this.birthDate = birthDate;
        this.nationality = nationality;
        this.awards = awards;
        this.biography = biography;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getAuthorName() {
        return authorName;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public String getNationality() {
        return nationality;
    }

    public String getAwards() {
        return awards;
    }

    public String getBiography() {
        return biography;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public void setAwards(String awards) {
        this.awards = awards;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    @Override
    public String toString() {
        return "Author{" +
                "id=" + id +
                ", authorName='" + authorName + '\'' +
                ", nationality='" + nationality + '\'' +
                '}';
    }
}