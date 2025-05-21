package dao;

import model.User;
import util.DBConnection;
import util.PasswordUtil;

import java.sql.*;
import java.util.Date;

public class UserDAO {

    /**
     * Add a new user to the database (register)
     * @param user The user object to add
     * @return True if user added successfully, false otherwise
     */
    public boolean addUser(User user) {
        String query = "INSERT INTO User (name, email, phone, image_url, password, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getImageUrl());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated user ID
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setUserID(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error adding user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Authenticate a user by email and password
     *
     * @param email The user's email
     * @param password The user's password (plain text)
     * @return User object if authentication successful, null otherwise
     *
     * @deprecated Use getUserByEmail and PasswordUtil.checkPassword instead
     */
    @Deprecated
    public User authenticate(String email, String password) {
        // Get the user by email
        User user = getUserByEmail(email);

        // Check if user exists and password matches
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // Update last login time
            updateLastLogin(user.getUserID());
            return user;
        }

        return null;
    }

    /**
     * Get a user by their ID
     * @param userID The user ID
     * @return User object if found, null otherwise
     */
    public User getUserById(int userID) {
        String query = "SELECT * FROM User WHERE user_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("user_ID"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setImageUrl(rs.getString("image_url"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setLastLogin(rs.getTimestamp("last_login"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
        }

        return null;
    }

    /**
     * Get a user by their email
     * @param email The user's email
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM User WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("user_ID"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setImageUrl(rs.getString("image_url"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setLastLogin(rs.getTimestamp("last_login"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
        }

        return null;
    }

    /**
     * Update a user's last login time
     * @param userID The user ID
     * @return True if update successful, false otherwise
     */
    public boolean updateLastLogin(int userID) {
        String query = "UPDATE User SET last_login = CURRENT_TIMESTAMP WHERE user_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userID);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating last login: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if an email is already registered
     * @param email The email to check
     * @return True if email exists, false otherwise
     */
    public boolean emailExists(String email) {
        String query = "SELECT COUNT(*) FROM User WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking if email exists: " + e.getMessage());
        }

        return false;
    }

    /**
     * Update a user's information
     * @param user The user object with updated information
     * @return True if update successful, false otherwise
     */
    public boolean updateUser(User user) {
        String query = "UPDATE User SET name = ?, email = ?, phone = ? WHERE user_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getUserID());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update a user's password
     * @param userID The user ID
     * @param hashedPassword The new hashed password
     * @return True if update successful, false otherwise
     */
    public boolean updateUserPassword(int userID, String hashedPassword) {
        String query = "UPDATE User SET password = ? WHERE user_ID = ?";
        System.out.println("Executing password update query for user ID: " + userID);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userID);

            System.out.println("Executing SQL: " + query);
            System.out.println("Parameters: [hashedPassword=" + hashedPassword.substring(0, 10) + "..., userID=" + userID + "]");

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected by password update: " + rowsAffected);
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update a user's profile picture
     * @param userID The user ID
     * @param imageUrl The new image URL
     * @return True if update successful, false otherwise
     */
    public boolean updateUserImage(int userID, String imageUrl) {
        String query = "UPDATE User SET image_url = ? WHERE user_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, imageUrl);
            stmt.setInt(2, userID);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user image: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update a user's last activity time
     * @param userID The user ID
     * @param lastActivity The last activity timestamp
     * @return True if update successful, false otherwise
     */
    public boolean updateLastActivity(int userID, Date lastActivity) {
        String query = "UPDATE User SET last_activity = ? WHERE user_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setTimestamp(1, new java.sql.Timestamp(lastActivity.getTime()));
            stmt.setInt(2, userID);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating last activity: " + e.getMessage());
            return false;
        }
    }
}