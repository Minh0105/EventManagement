/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventCardDTO;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author triet
 */
@WebServlet(name = "NewfeedServlet", urlPatterns = {"/NewfeedServlet"})
public class NewfeedServlet extends HttpServlet {

    static final Logger LOGGER = Logger.getLogger(NewfeedServlet.class);

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
        LOGGER.info("Begin NewfeedServlet");
        //declare var
        List<EventCardDTO> listCard = null;
        List<EventCardDTO> listFollowing = null;
        List<EventCardDTO> listJoining = null;

        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String NEWFEED_PAGE_LABEL = context.getInitParameter("NEWFEED_PAGE_LABEL");
        String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        String NEWFEED_PAGE_PATH = roadmap.get(NEWFEED_PAGE_LABEL);
        String url = INVALID_PAGE_PATH;

        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDAO eventDao = new EventDAO();

            listCard = eventDao.getNewFeedEventList(loginUser);
            LOGGER.info("LIST EVENT CARD:" + listCard);
            request.setAttribute("LIST_CARD", listCard);

            //chi lay event co statusId  = 1
            if ("STUDENT".equals(loginUser.getRoleName())) {
                listFollowing = eventDao.getFollowedEventList(loginUser.getId());
                LOGGER.info("LIST FOLLOWING EVENT CARD:" + listFollowing);
                request.setAttribute("LIST_FOLLOWING_CARD", listFollowing);

                listJoining = eventDao.getJoiningEventList(loginUser.getId());
                LOGGER.info("LIST JOINING EVENT CARD:" + listJoining);
                request.setAttribute("LIST_JOINING_CARD", listJoining);
            }

            url = NEWFEED_PAGE_PATH;
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
