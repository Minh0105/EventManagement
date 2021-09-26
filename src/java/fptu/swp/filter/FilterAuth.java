/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.filter;

import fptu.swp.entity.user.UserDTO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.HashSet;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
public class FilterAuth implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public FilterAuth() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterAuth:DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterAuth:DoAfterProcessing");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");
        HashMap<String, HashSet<String>> auth = (HashMap<String, HashSet<String>>) context.getAttribute("AUTH");
        RequestDispatcher rd;

        final String INVALID_PAGE = context.getInitParameter("INVALID_PAGE");
        final String LOGIN_PAGE = context.getInitParameter("LOGIN_PAGE");

        String servletPath = httpRequest.getServletPath().substring(1);
        if (servletPath.length() == 0) {
            servletPath = LOGIN_PAGE;
        }

        // test Case Data, Delete when release
        UserDTO dto = new UserDTO(1, "haha@gmail.com", "Duong", "", "ORG");
        HttpSession session = httpRequest.getSession();
        session.setAttribute("USER", dto);
        // End Test Case

        String url = null;
        session = httpRequest.getSession(false);

        if (session != null) {
            UserDTO userDto = (UserDTO) session.getAttribute("USER");
            String roleName = userDto.getRoleName();

            boolean authorized = auth.get(roleName).contains(servletPath) || auth.get("").contains(servletPath);

            System.out.println("role Name : " + roleName + ", Servlet to go: " + servletPath + ", PERMISSION = " + authorized);
            if (servletPath.contains("resources")) {
                System.out.println("User need resource");
                chain.doFilter(request, response);
            } else if (authorized == false) {
                url = roadmap.get(INVALID_PAGE);
                rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                url = roadmap.get(servletPath);
                rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
//                return;
            }
        } else {
            url = roadmap.get(LOGIN_PAGE);
            rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }

    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("FilterAuth:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("FilterAuth()");
        }
        StringBuffer sb = new StringBuffer("FilterAuth(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
