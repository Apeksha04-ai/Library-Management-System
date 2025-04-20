-- Create Database
CREATE DATABASE IF NOT EXISTS library_mgmt_system;
USE library_mgmt_system;

-- Book Table
CREATE TABLE IF NOT EXISTS Book (
                                    book_ID INT AUTO_INCREMENT PRIMARY KEY,
                                    isbn VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    publication_date DATE,
    category VARCHAR(100),
    image_url VARCHAR(255),
    availability_status ENUM('Available', 'Unavailable') DEFAULT 'Available'

    );

-- Author Table
CREATE TABLE IF NOT EXISTS Author (
                                      author_ID INT AUTO_INCREMENT PRIMARY KEY,
                                      author_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    awards TEXT,
    biography TEXT
    );

-- Book_Author (junction table for many-to-many relationship)
CREATE TABLE IF NOT EXISTS Book_Author (
                                           book_ID INT,
                                           author_ID INT,
                                           PRIMARY KEY (book_ID, author_ID),
    FOREIGN KEY (book_ID) REFERENCES Book(book_ID) ON DELETE CASCADE,
    FOREIGN KEY (author_ID) REFERENCES Author(author_ID) ON DELETE CASCADE
    );

-- User Table with only Librarian and Student roles
CREATE TABLE IF NOT EXISTS User (
                                    user_ID INT AUTO_INCREMENT PRIMARY KEY,
                                    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    image_url VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    role ENUM('Librarian', 'Student') NOT NULL,
    last_login DATETIME
    );

-- Borrow Table
CREATE TABLE IF NOT EXISTS Borrow (
                                      borrow_ID INT AUTO_INCREMENT PRIMARY KEY,
                                      user_ID INT,
                                      borrow_date DATE DEFAULT CURRENT_DATE,
                                      FOREIGN KEY (user_ID) REFERENCES User(user_ID) ON DELETE CASCADE
    );

-- Fine Table (previously called Loan)
CREATE TABLE IF NOT EXISTS Fine (
                                    fine_ID INT AUTO_INCREMENT PRIMARY KEY,
                                    borrow_ID INT,
                                    book_ID INT,
                                    issue_date DATE NOT NULL,
                                    due_date DATE,
                                    return_date DATE,
                                    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (borrow_ID) REFERENCES Borrow(borrow_ID) ON DELETE CASCADE,
    FOREIGN KEY (book_ID) REFERENCES Book(book_ID) ON DELETE CASCADE
    );

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_book_title ON Book(title);
CREATE INDEX IF NOT EXISTS idx_book_isbn ON Book(isbn);
CREATE INDEX IF NOT EXISTS idx_author_name ON Author(author_name);
CREATE INDEX IF NOT EXISTS idx_user_email ON User(email);
CREATE INDEX IF NOT EXISTS idx_fine_due_date ON Fine(due_date);
CREATE INDEX IF NOT EXISTS idx_fine_return_date ON Fine(return_date);