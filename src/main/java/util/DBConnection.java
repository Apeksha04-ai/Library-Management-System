package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/library_mgmt_system";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        try {
            if (connection == null || connection.isClosed()) {
                System.out.println("Creating new database connection...");
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                if (connection != null) {
                    System.out.println("Database connected successfully!");
                    // Test the connection
                    if (connection.isValid(5)) {
                        System.out.println("Connection is valid");
                    }
                }
            } else {
                System.out.println("Reusing existing database connection");
            }
            return connection;
        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found: " + e.getMessage());
            throw new SQLException("Database driver not found", e);
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            throw e;
        }
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    System.out.println("Closing database connection...");
                    connection.close();
                    System.out.println("Database connection closed successfully");
                }
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
} 