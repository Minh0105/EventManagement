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
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
public class ManageByAdminServlet extends HttpServlet {
    static final Logger LOGGER = Logger.getLogger(ManageByAdminServlet.class);
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
        LOGGER.info("Begin ManageByAdminServlet");
        //declare var
        UserDAO userDao = new UserDAO();
        EventDAO eventDao = new EventDAO();
        
        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");
        
        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String ADMIN_PAGE_LABEL = context.getInitParameter("ADMIN_PAGE");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String ADMIN_PAGE_PATH = roadmap.get(ADMIN_PAGE_LABEL);
        String url = INVALID_PAGE_PATH;
        
        //parameter
        String type = request.getParameter("management");
        try{
            if("organizer".equals(type)){
                List<UserDTO> listOrganizer = userDao.getAllOrganizerAndNumberOfEventByQuarter(new Date());
                Collections.sort(listOrganizer);
                request.setAttribute("LIST_ORGANIZER", listOrganizer);
                LOGGER.info("Request Attribute LIST_ORGANIZER: " + listOrganizer);
                url = ADMIN_PAGE_PATH;
            }else if("student".equals(type)){
                List<UserDTO> listStudent = userDao.getAllStudent();
                request.setAttribute("LIST_STUDENT", listStudent);
                LOGGER.info("Request Attribute LIST_STUDENT: " + listStudent);
                url = ADMIN_PAGE_PATH;
            }else if("lecturer".equals(type)){
                List<UserDTO> listLecturer = userDao.getAllLecturerForAdmin();
                request.setAttribute("LIST_LECTURER", listLecturer);
                LOGGER.info("Request Attribute LIST_LECTURER: " + listLecturer);
                url = ADMIN_PAGE_PATH;
            }else if("event".equals(type)){
                List<UserDTO> listOrganizer = userDao.getAllOrganizerForAdmin();
                request.setAttribute("LIST_ORGANIZER_EVENT", listOrganizer);
                List<EventDetailDTO> listEvent = (List<EventDetailDTO>) request.getAttribute("LIST_EVENT");
                request.setAttribute("LIST_EVENT", listEvent);
                LOGGER.info("Request Attribute LIST_EVENT: " + listEvent);
                LOGGER.info("Request Attribute LIST_ORGANIZER_EVENT: " + listOrganizer);
                url = ADMIN_PAGE_PATH;
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
