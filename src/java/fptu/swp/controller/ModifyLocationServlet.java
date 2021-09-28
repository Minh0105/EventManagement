/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.location.LocationDAO;
import fptu.swp.entity.location.LocationDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
@WebServlet(name = "ModifyLocationServlet", urlPatterns = {"/ModifyLocationServlet"})
public class ModifyLocationServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ModifyLocationServlet.class);
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
        
        LOGGER.info("Begin ModifyLocationServlet");
        // declare var
        List<Integer> listLocationId = new ArrayList<>();
        List<LocationDTO> chosenLocationList = new ArrayList<>();
        LocationDAO locationDao = new LocationDAO();
        
        // declare roadmap 
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");
        
        // default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String VIEW_FREE_LOC_AND_TIME_SERVLET = context.getInitParameter("VIEW_FREE_LOC_AND_TIME_SERVLET");
        String url = roadmap.get(INVALID_PAGE_LABEL);
        
        // parameter 
        String[] chosenLocationId = request.getParameterValues("chosenLocationId");
               
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                
                for(String locationParam : Arrays.asList(chosenLocationId)) {
                    int index = locationParam.indexOf("-");
                    int locationId = Integer.parseInt(locationParam.substring(0, index));
                    String locationName = locationParam.substring(index + 1);
                    chosenLocationList.add(new LocationDTO(locationId, locationName));
                }
                LOGGER.info("Chosen Location Id-Name List: " + chosenLocationList);
                session.setAttribute("ChosenLocationList", chosenLocationList);               
                
                url = roadmap.get(VIEW_FREE_LOC_AND_TIME_SERVLET);
            }
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            LOGGER.info("Forward From ModifyLocationServlet to " + url);
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