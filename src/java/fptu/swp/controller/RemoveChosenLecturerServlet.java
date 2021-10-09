/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author triet
 */
public class RemoveChosenLecturerServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(RemoveChosenLecturerServlet.class);

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
        LOGGER.info("Begin RemoveChosenLecturerServlet");

        // declare var
        UserDAO userDao = new UserDAO();
        List<LecturerBriefInfoDTO> lecturerList = new ArrayList<>();
        List<LecturerBriefInfoDTO> chosenLecturerList = new ArrayList<>();
        HttpSession session;
        LecturerBriefInfoDTO lecturer;
        boolean check = false;
        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String APPEND_EVENT_DETAIL_PAGE_LABEL = context.getInitParameter("APPEND_EVENT_DETAIL_PAGE");
        String APPEND_EVENT_DETAIL_PAGE_PATH = roadmap.get(APPEND_EVENT_DETAIL_PAGE_LABEL);
        String url = INVALID_PAGE_LABEL;

        // parameter
        int lecturerId = (int) request.getAttribute("lecturerId");
        try {
            session = request.getSession(false);
            chosenLecturerList = (List<LecturerBriefInfoDTO>) session.getAttribute("ChosenLecturerList");
            lecturerList = (List<LecturerBriefInfoDTO>) session.getAttribute("LecturerList");
            if (lecturerList == null) {
                lecturerList = new ArrayList<>();
            }
            if (chosenLecturerList == null) {
                chosenLecturerList = new ArrayList<>();
            }
            lecturer = userDao.getLecturerById(lecturerId);
            if (chosenLecturerList.remove(lecturer)) {
                check = lecturerList.add(lecturer);
                if (check) {
                    LOGGER.info("Session Attribute - ChosenLecturerList : " + chosenLecturerList);
                    session.setAttribute("ChosenLecturerList", chosenLecturerList);
                    LOGGER.info("Session Attribute - LecturerList : " + lecturerList);
                    session.setAttribute("LecturerList", lecturerList);
                    url = APPEND_EVENT_DETAIL_PAGE_LABEL;
                }
            }

        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            LOGGER.info("Redirect from RemoveChosenLecturerServlet to" + url);
            response.sendRedirect(url);
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
