package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt
 */
public class PasswordUtil {
    
    // The number of rounds to use for hashing (higher = more secure but slower)
    private static final int BCRYPT_ROUNDS = 12;
    
    private PasswordUtil() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Hash a password using BCrypt
     * 
     * @param plainTextPassword The plain text password to hash
     * @return The hashed password
     */
    public static String hashPassword(String plainTextPassword) {
        // Generate a salt with the specified number of rounds
        String salt = BCrypt.gensalt(BCRYPT_ROUNDS);
        
        // Hash the password with the salt
        return BCrypt.hashpw(plainTextPassword, salt);
    }
    
    /**
     * Check if a plain text password matches a hashed password
     * 
     * @param plainTextPassword The plain text password to check
     * @param hashedPassword The hashed password to check against
     * @return True if the passwords match, false otherwise
     */
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        // Check if the plain text password, when hashed, matches the stored hash
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
} 