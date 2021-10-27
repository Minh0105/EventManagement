/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.location.LocationDTO;
import fptu.swp.entity.schedule.Schedule;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDTO;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
public class CreateEventServlet extends HttpServlet {
        static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(CreateEventServlet.class);

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
        LOGGER.info("Begin CreateEventServlet");

        // declare var
        EventDAO eventDao = new EventDAO();
        UserDTO loginUser;
        List<LecturerBriefInfoDTO> chosenLecturerList = new ArrayList<>();
        List<LocationDTO> chosenLocationList = new ArrayList<>();
        String chosenDate;
        String chosenTimeRange;
        HttpSession session;
        LecturerBriefInfoDTO lecturer;
        int eventId;
        boolean checkInsertLecturersInEvent = false;
        boolean checkInsertDateTimeLocation = false;
        EventDetailDTO detail;
        FileInputStream posterStream;
        
        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String VIEW_NEWFEED_SERVLET = context.getInitParameter("VIEW_NEWFEED_SERVLET");
        String url = INVALID_PAGE_LABEL;
        
        try {
            session = request.getSession(false);
            chosenLecturerList = (List<LecturerBriefInfoDTO>) session.getAttribute("ChosenLecturerList");
            chosenLocationList = (List<LocationDTO>) session.getAttribute("ChosenLocationList");
            chosenDate = (String) session.getAttribute("ChosenDate");
            chosenTimeRange = (String) session.getAttribute("ChosenTimeRange");
            loginUser = (UserDTO) session.getAttribute("USER");
            if (chosenLecturerList == null) {
                chosenLecturerList = new ArrayList<>();
            }
            detail = (EventDetailDTO) session.getAttribute("EVENT_DETAIL_REVIEW");
            posterStream = (FileInputStream) session.getAttribute("EVENT_POSTER_STREAM");
            eventId = eventDao.insertNewEvent(detail, loginUser.getId(), posterStream);
            if (eventId > 0){
                if((checkInsertDateTimeLocation = eventDao.insertNewEventDateTimeLocation(chosenDate, chosenLocationList, chosenTimeRange, eventId)) 
                        && (checkInsertLecturersInEvent = eventDao.insertNewEventLecturer(chosenLecturerList, eventId))){
                    url = VIEW_NEWFEED_SERVLET;
                    Schedule.updateSchedule();
                    session.removeAttribute("ChosenLecturerList");
                    session.removeAttribute("ChosenLocationList");
                    session.removeAttribute("ChosenDate");
                    session.removeAttribute("ChosenTimeRange");
                    session.removeAttribute("EVENT_DETAIL_REVIEW");
                    session.removeAttribute("EVENT_POSTER_STREAM");
                }
                 
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            LOGGER.info("Redirect from CreateEventServlet to" + url);
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
