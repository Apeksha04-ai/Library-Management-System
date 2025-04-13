package model;

public class Author {
    private int authorId;
    private String name;
    private String nationality;
    private String biography;

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public Author(int authorId, String name, String nationality, String biography) {
        this.authorId = authorId;
        this.name = name;
        this.nationality = nationality;
        this.biography = biography;
    }
// Getters and Setters
}