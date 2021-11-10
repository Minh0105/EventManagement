/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author triet
 */
public class OrganizerRedirectServlet extends HttpServlet {
static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(OrganizerRedirectServlet.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LOGGER.info("Begin OrganizerRedirectServlet");
        // declare var
        HttpSession session = request.getSession();
        EventDAO eventDao = new EventDAO();

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");
        
        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String UPDATE_EVENT_PAGE_LABEL = context.getInitParameter("UPDATE_EVENT_PAGE_LABEL");
        final String UPDATE_EVENT_PAGE_PATH = roadmap.get(UPDATE_EVENT_PAGE_LABEL);
        final String UPDATE_FOLLOWUP_PAGE_LABEL = context.getInitParameter("UPDATE_FOLLOWUP_PAGE_LABEL");
        final String UPDATE_FOLLOWUP_PAGE_PATH = roadmap.get(UPDATE_FOLLOWUP_PAGE_LABEL);
        String url = INVALID_PAGE_PATH;
        
        try{
            String action = request.getParameter("action");
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDetailDTO detail = eventDao.getEventDetail(eventId);
            if(detail.getOrganizerName().equals(loginUser.getName())){
                request.setAttribute("UPDATING_EVENT", detail);
                if("updateInformation".equals((action))){
                    url=UPDATE_EVENT_PAGE_PATH;
                } else if("updateFollowUp".equals((action))){
                    url=UPDATE_FOLLOWUP_PAGE_PATH;
                }
                
            }
        }catch (Exception ex) {
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
