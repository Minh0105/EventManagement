/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author triet
 */
public class RedirectListEventServlet extends HttpServlet {

    static final Logger LOGGER = Logger.getLogger(RedirectListEventServlet.class);

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
        LOGGER.info("Begin RedirectListEventServlet");

        //declare var
        UserDAO userDao = new UserDAO();
        EventDAO eventDao = new EventDAO();

        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String ALL_EVENT_PAGE_LABEL = context.getInitParameter("ALL_EVENT_PAGE_LABEL");
        final String RELEVANT_EVENT_PAGE_LABEL = context.getInitParameter("RELEVANT_EVENT_PAGE_LABEL");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String ALL_EVENT_PAGE_PATH = roadmap.get(ALL_EVENT_PAGE_LABEL);
        final String RELEVANT_EVENT_PAGE_PATH = roadmap.get(RELEVANT_EVENT_PAGE_LABEL);
        String url = INVALID_PAGE_PATH;
        try {
            String action = request.getParameter("action");
            if ("all".equals(action)) {
                List<UserDTO> listOrganizer = userDao.getListAllOrganizer();
                request.setAttribute("LIST_ORGANIZER_EVENT", listOrganizer);

                LOGGER.info("Request Attribute LIST_ORGANIZER_EVENT: " + listOrganizer);
                url = ALL_EVENT_PAGE_PATH;
            } else {
                HttpSession session = request.getSession(false);
                UserDTO loginUser = (UserDTO) session.getAttribute("USER");
                List<EventDetailDTO> listEvent = null;
                if ("joined".equals(action) && "STUDENT".equals(loginUser.getRoleName())) {
                    listEvent = eventDao.getListJoinedEventOfStudent(loginUser.getId());
                    request.setAttribute("LIST_EVENT", listEvent);
                    LOGGER.info("Request Attribute LIST_EVENT joined by this STUDENT: " + listEvent);
                    url = RELEVANT_EVENT_PAGE_PATH;
                }
                else if ("added".equals(action) && "LECTURER".equals(loginUser.getRoleName())) {
                    listEvent = eventDao.getListAddedEventOfLecturer(loginUser.getId());
                    request.setAttribute("LIST_EVENT", listEvent);
                    LOGGER.info("Request Attribute LIST_EVENT added to this LECTURER: " + listEvent);
                    url = RELEVANT_EVENT_PAGE_PATH;
                }
                
            }

        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
