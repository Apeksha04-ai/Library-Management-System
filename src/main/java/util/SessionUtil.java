package util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.util.Date;
import java.util.UUID;

/**
 * Utility class for session management
 */
public class SessionUtil {

    // Constants for session attributes
    public static final String USER_SESSION = "user";
    public static final String USER_ID = "userID";
    public static final String USER_EMAIL = "userEmail";
    public static final String USER_ROLE = "userRole";
    public static final String LOGIN_TIME = "loginTime";
    public static final String LAST_ACTIVITY_TIME = "lastActivityTime";

    // Constants for cookies
    public static final String REMEMBER_ME_COOKIE = "rememberMe";
    public static final String USER_EMAIL_COOKIE = "userEmail";
    public static final String AUTH_TOKEN_COOKIE = "authToken";

    // Session timeout in seconds (30 minutes)
    public static final int SESSION_TIMEOUT = 30 * 60;

    // Cookie max age in seconds (30 days)
    public static final int COOKIE_MAX_AGE = 30 * 24 * 60 * 60;

    /**
     * Create a user session
     */
    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);

        // Set session attributes
        session.setAttribute(USER_SESSION, user);
        session.setAttribute(USER_ID, user.getUserID());
        session.setAttribute(USER_EMAIL, user.getEmail());
        session.setAttribute(USER_ROLE, user.getRole());

        // Set timing attributes
        Date currentTime = new Date();
        session.setAttribute(LOGIN_TIME, currentTime);
        session.setAttribute(LAST_ACTIVITY_TIME, currentTime);

        // Set session timeout
        session.setMaxInactiveInterval(SESSION_TIMEOUT);
    }

    /**
     * Update last activity time
     */
    public static void updateLastActivityTime(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute(LAST_ACTIVITY_TIME, new Date());
        }
    }

    /**
     * Check if user is logged in
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(USER_SESSION) != null;
    }

    /**
     * Get logged in user
     */
    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        System.out.println("SessionUtil.getLoggedInUser: session exists? " + (session != null));
        
        if (session != null) {
            User user = (User) session.getAttribute(USER_SESSION);
            System.out.println("SessionUtil.getLoggedInUser: user in session? " + (user != null));
            if (user != null) {
                System.out.println("SessionUtil.getLoggedInUser: user details - ID: " + user.getUserID() + ", Email: " + user.getEmail() + ", Role: " + user.getRole());
            }
            return user;
        }
        return null;
    }

    /**
     * Get logged in user role
     */
    public static String getLoggedInUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute(USER_ROLE);
        }
        return null;
    }

    /**
     * Invalidate user session
     */
    public static void invalidateUserSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Set remember me cookie
     */
    public static void setRememberMeCookie(HttpServletResponse response, User user, boolean rememberMe) {
        // Create authentication token
        String authToken = UUID.randomUUID().toString();

        // Set remember me cookie
        Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE, rememberMe ? "true" : "false");
        rememberMeCookie.setMaxAge(rememberMe ? COOKIE_MAX_AGE : 0);
        rememberMeCookie.setPath("/");
        rememberMeCookie.setHttpOnly(true);
        rememberMeCookie.setSecure(true); // Only send over HTTPS
        response.addCookie(rememberMeCookie);

        // Set user email cookie
        Cookie userEmailCookie = new Cookie(USER_EMAIL_COOKIE, user.getEmail());
        userEmailCookie.setMaxAge(rememberMe ? COOKIE_MAX_AGE : 0);
        userEmailCookie.setPath("/");
        userEmailCookie.setHttpOnly(true);
        userEmailCookie.setSecure(true); // Only send over HTTPS
        response.addCookie(userEmailCookie);

        // Set auth token cookie
        Cookie authTokenCookie = new Cookie(AUTH_TOKEN_COOKIE, authToken);
        authTokenCookie.setMaxAge(rememberMe ? COOKIE_MAX_AGE : 0);
        authTokenCookie.setPath("/");
        authTokenCookie.setHttpOnly(true);
        authTokenCookie.setSecure(true); // Only send over HTTPS
        response.addCookie(authTokenCookie);

        // Store auth token in database (requires implementation in UserDAO)
        // userDAO.saveAuthToken(user.getUserID(), authToken, new Date(System.currentTimeMillis() + COOKIE_MAX_AGE * 1000L));
    }

    /**
     * Clear remember me cookies
     */
    public static void clearRememberMeCookies(HttpServletResponse response) {
        // Clear remember me cookie
        Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE, null);
        rememberMeCookie.setMaxAge(0);
        rememberMeCookie.setPath("/");
        rememberMeCookie.setHttpOnly(true);
        rememberMeCookie.setSecure(true);
        response.addCookie(rememberMeCookie);

        // Clear user email cookie
        Cookie userEmailCookie = new Cookie(USER_EMAIL_COOKIE, null);
        userEmailCookie.setMaxAge(0);
        userEmailCookie.setPath("/");
        userEmailCookie.setHttpOnly(true);
        userEmailCookie.setSecure(true);
        response.addCookie(userEmailCookie);

        // Clear auth token cookie
        Cookie authTokenCookie = new Cookie(AUTH_TOKEN_COOKIE, null);
        authTokenCookie.setMaxAge(0);
        authTokenCookie.setPath("/");
        authTokenCookie.setHttpOnly(true);
        authTokenCookie.setSecure(true);
        response.addCookie(authTokenCookie);
    }

    /**
     * Get cookie value
     */
    public static String getCookieValue(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Get the current session or create a new one if needed
     * This ensures we handle sessions consistently across the application
     */
    public static HttpSession getOrCreateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        System.out.println("SessionUtil.getOrCreateSession: existing session? " + (session != null));
        
        if (session == null) {
            session = request.getSession(true);
            System.out.println("SessionUtil.getOrCreateSession: created new session");
        } else {
            System.out.println("SessionUtil.getOrCreateSession: using existing session, ID: " + session.getId());
        }
        
        return session;
    }
}