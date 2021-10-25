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
import java.util.List;
import javax.servlet.RequestDispatcher;
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
public class FilterEventServlet extends HttpServlet {
static final Logger LOGGER = Logger.getLogger(FilterEventServlet.class);
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
        LOGGER.info("Begin FilterEventServlet");
        //declare var
        EventDAO eventDao = new EventDAO();
        
        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String MANAGE_BY_ADMIN_SERVLET = context.getInitParameter("MANAGE_BY_ADMIN_SERVLET");
        final String STUDENT_VIEW_EVENT_LIST_SERVLET = context.getInitParameter("STUDENT_VIEW_EVENT_LIST_SERVLET");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String MANAGE_BY_ADMIN_SERVLET_PATH = roadmap.get(MANAGE_BY_ADMIN_SERVLET);
        final String STUDENT_VIEW_EVENT_LIST_SERVLET_PATH = roadmap.get(STUDENT_VIEW_EVENT_LIST_SERVLET);
        String url = INVALID_PAGE_PATH;
        String idOrganizer = request.getParameter("idOrganizer");
        String eventStatus = request.getParameter("eventStatus");
        String organizerType = request.getParameter("organizerType");
        try{
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            int organizerId = (idOrganizer == null)? 0:Integer.parseInt(idOrganizer);
            int statusId = (eventStatus == null)? 0:Integer.parseInt(eventStatus);
            List<EventDetailDTO> listEvent = eventDao.filterEvent(organizerId, statusId);
            request.setAttribute("LIST_EVENT", listEvent);
            LOGGER.info("Request Attribute LIST_EVENT: " + listEvent);
            if("ADMIN".equals(loginUser.getRoleName())){
                url = MANAGE_BY_ADMIN_SERVLET_PATH + "?management=event";
            }
            if("STUDENT".equals(loginUser.getRoleName())){
                url = STUDENT_VIEW_EVENT_LIST_SERVLET_PATH + "?list=filterAll";
            }
        }catch(Exception ex){
            LOGGER.error(ex);
        }finally {
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
