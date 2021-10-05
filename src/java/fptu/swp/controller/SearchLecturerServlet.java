/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import static fptu.swp.controller.AppendEventDetailServlet.LOGGER;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
public class SearchLecturerServlet extends HttpServlet {
    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SearchLecturerServlet.class);
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
        LOGGER.info("Begin ReviewEventServlet");

        // declare var
        UserDAO userDao = new UserDAO();
        List<LecturerBriefInfoDTO> lecturerList;         
        HttpSession session;
        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String APPEND_EVENT_DETAIL_PAGE_LABEL = context.getInitParameter("APPEND_EVENT_DETAIL_PAGE");
        String APPEND_EVENT_DETAIL_PAGE_PATH = roadmap.get(APPEND_EVENT_DETAIL_PAGE_LABEL);
        String url = INVALID_PAGE_LABEL;

        // parameter
        String txtSearch = request.getParameter("search");
        try {
            session = request.getSession(false);
            lecturerList = userDao.getListLecturerBySearchName(txtSearch);
            LOGGER.info("Session Attribute - LecturerList : " + lecturerList);
            session.setAttribute("LecturerList", lecturerList);
            url = APPEND_EVENT_DETAIL_PAGE_PATH;
        } catch (Exception ex) {
            LOGGER.error(ex);
        }
        finally {
                LOGGER.info("Forward from SearchLecturerServlet to" + url);
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
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
