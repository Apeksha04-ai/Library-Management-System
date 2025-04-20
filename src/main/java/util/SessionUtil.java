package util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * Utility class for managing user sessions and cookies
 */
public class SessionUtil {
    
    // Session attribute names
    public static final String USER_SESSION = "user";
    public static final String USER_ID = "userId";
    public static final String USER_ROLE = "userRole";
    
    // Cookie names
    public static final String REMEMBER_ME_COOKIE = "rememberMe";
    public static final String USER_EMAIL_COOKIE = "userEmail";
    
    // Cookie max age (30 days in seconds)
    private static final int COOKIE_MAX_AGE = 30 * 24 * 60 * 60;
    
    /**
     * Create a new session for a user
     * @param request The HTTP request
     * @param user The authenticated user
     */
    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute(USER_SESSION, user);
        session.setAttribute(USER_ID, user.getUserID());
        session.setAttribute(USER_ROLE, user.getRole());
        
        // Set session timeout to 30 minutes
        session.setMaxInactiveInterval(30 * 60);
    }
    
    /**
     * Get the currently logged in user from the session
     * @param request The HTTP request
     * @return The user object or null if not logged in
     */
    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute(USER_SESSION);
        }
        return null;
    }
    
    /**
     * Check if a user is logged in
     * @param request The HTTP request
     * @return True if logged in, false otherwise
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getLoggedInUser(request) != null;
    }
    
    /**
     * Check if the current user has the specified role
     * @param request The HTTP request
     * @param role The role to check
     * @return True if the user has the role, false otherwise
     */
    public static boolean hasRole(HttpServletRequest request, String role) {
        User user = getLoggedInUser(request);
        return user != null && user.getRole().equals(role);
    }
    
    /**
     * Invalidate the current user session
     * @param request The HTTP request
     */
    public static void invalidateUserSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
    
    /**
     * Set remember me cookie for auto-login
     * @param response The HTTP response
     * @param user The user to remember
     * @param rememberMe Whether to remember the user
     */
    public static void setRememberMeCookie(HttpServletResponse response, User user, boolean rememberMe) {
        if (rememberMe) {
            // Create a cookie for the user email
            Cookie emailCookie = new Cookie(USER_EMAIL_COOKIE, user.getEmail());
            emailCookie.setMaxAge(COOKIE_MAX_AGE);
            emailCookie.setPath("/");
            response.addCookie(emailCookie);
            
            // Create a remember me cookie
            Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE, "true");
            rememberMeCookie.setMaxAge(COOKIE_MAX_AGE);
            rememberMeCookie.setPath("/");
            response.addCookie(rememberMeCookie);
        }
    }
    
    /**
     * Clear remember me cookies
     * @param request The HTTP request
     * @param response The HTTP response
     */
    public static void clearRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (REMEMBER_ME_COOKIE.equals(cookie.getName()) || USER_EMAIL_COOKIE.equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
    }
    
    /**
     * Get a cookie value by name
     * @param request The HTTP request
     * @param name The cookie name
     * @return The cookie value or null if not found
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
} 