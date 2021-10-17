/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author triet
 */
public class ManageUserByAdminServlet extends HttpServlet {

    static final Logger LOGGER = Logger.getLogger(ManageUserByAdminServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LOGGER.info("Begin ManageEventByAdminServlet");
        //declare var
        UserDAO userDao = new UserDAO();

        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String MANAGE_BY_ADMIN_SERVLET = context.getInitParameter("MANAGE_BY_ADMIN_SERVLET");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String MANAGE_BY_ADMIN_SERVLET_PATH = roadmap.get(MANAGE_BY_ADMIN_SERVLET);
        String url = INVALID_PAGE_PATH;
        String searchTxt = request.getParameter("searchTxt");
        String action = request.getParameter("action");

        try {
            if ("Deactivate".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                if (userDao.deactivateUser(userId)) {
                    int roleId = userDao.getUserRoleId(userId);
                    String role = "";
                    if (roleId == 1) {
                        role = "student";
                    } else if (roleId == 2) {
                        role = "lecturer";
                    } else if (roleId == 3 || roleId == 4) {
                        role = "organizer";
                    }
                    url = MANAGE_BY_ADMIN_SERVLET_PATH + "?management=" + role;
                    request.setAttribute("TEXT_SEARCH", searchTxt);
                }
            } else if ("Reactivate".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                if (userDao.reactivateUser(userId)) {
                    int roleId = userDao.getUserRoleId(userId);
                    String role = "";
                    if (roleId == 1) {
                        role = "student";
                    } else if (roleId == 2) {
                        role = "lecturer";
                    } else if (roleId == 3 || roleId == 4) {
                        role = "organizer";
                    }
                    url = MANAGE_BY_ADMIN_SERVLET_PATH + "?management=" + role;
                    request.setAttribute("TEXT_SEARCH", searchTxt);
                }
            } else if ("Create".equals(action)) {
                String defaultAvatar = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwbGozsS9QP10p16rZiCrQD0koXVkI4c7LwUHab9dkmFRcN0VqCkB37f2y0EnySItwykg&usqp=CAU";
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                UserDTO newUser = userDao.getUserByEmail(email);
                if (newUser == null) {
                    newUser = new UserDTO();
                    newUser.setEmail(email);
                    newUser.setName(name);
                    newUser.setAvatar(defaultAvatar);
                    String role = "";
                    String defaultDescription = "";
                    if (roleId == 2) {
                        role = "lecturer";
                        defaultDescription = "Giảng viên: " + name;
                    } else if (roleId == 3 || roleId == 4) {
                        role = "organizer";
                        defaultDescription = "Nhà tổ chức sự kiện: " + name;
                    }
                    newUser.setDescription(defaultDescription);
                    if (userDao.insertOrganizerOrLecturer(newUser, roleId)) {
                        url = MANAGE_BY_ADMIN_SERVLET_PATH + "?management=" + role;
                        request.setAttribute("TEXT_SEARCH", searchTxt);
                    }
                }

            }
        } catch (Exception ex) {
            LOGGER.error(ex);
        } finally {
            RequestDispatcher dis = request.getRequestDispatcher(url);
            dis.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
