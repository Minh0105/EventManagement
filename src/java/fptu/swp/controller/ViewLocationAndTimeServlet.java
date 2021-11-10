/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.datetimelocation.DateTimeLocationDAO;
import fptu.swp.entity.datetimelocation.RangeDateDTO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.naming.NamingException;
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
@WebServlet(name = "ViewLocationAndTimeServlet", urlPatterns = {"/ViewLocationAndTimeServlet"})
public class ViewLocationAndTimeServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ViewLocationAndTimeServlet.class);

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
        
        LOGGER.info("Begin ViewLocationAndTimeServlet");
        LOGGER.info("Beginning Start Date Param: " + request.getParameter("startDate"));
        // declare variable 
        DateTimeLocationDAO dao;
        Set<RangeDateDTO> listBusySlot = new HashSet<>();
        List<Integer> listLocationId = new ArrayList<>();
        List<RangeDateDTO> listBusySlotArrayList;
        HttpSession session = null;
        int eventId = -1;

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        // default URL
        final String SEARCH_LOCATION_SERVLET = context.getInitParameter("SEARCH_LOCATION_SERVLET");
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String url = roadmap.get(INVALID_PAGE_LABEL);

        // parameter
        String startDayAndMonth = request.getParameter("startDate");
        String[] chosenLocationListIdParam = request.getParameterValues("chosenLocationId");
        
        // check parameter for null
        if (startDayAndMonth == null || chosenLocationListIdParam == null) {
            LOGGER.error("Parameter 'startDate' or 'chosenLocationId' is null");
        }

        try {
            session = request.getSession(false);
            Integer changingEventId = (Integer) session.getAttribute("CHANGING_EVENT_ID");
            LOGGER.info("CHANGING EVENT ID: " + changingEventId);
            if(changingEventId != null){
                eventId = changingEventId;
            }
            LOGGER.info("Start Day: " + startDayAndMonth);
//            Date startDate = new Date(Integer.parseInt(startDayAndMonth.substring(0, 4)), Integer.parseInt(startDayAndMonth.substring(5, 7)), Integer.parseInt(startDayAndMonth.substring(8)));           
            Date startDate = Date.valueOf(startDayAndMonth);
            System.out.println(startDate.toString());
            dao = new DateTimeLocationDAO();
            
            for (String StrLocationId : chosenLocationListIdParam) {
                int index = StrLocationId.indexOf("-");
                int locationId = Integer.parseInt(StrLocationId.substring(0, index));
                // result of busy slot in week for each locationId
                LOGGER.info("List Busy slot of " + StrLocationId + " : " + dao.getFreeSlotByFirstDateOfWeek(locationId, startDate, eventId));
                
                listBusySlot.addAll(dao.getFreeSlotByFirstDateOfWeek(locationId, startDate, eventId));
            }
            
            LOGGER.info("List Busy Slot : " + listBusySlot);
            listBusySlotArrayList = new ArrayList<>(listBusySlot);          
            request.setAttribute("BusySlotList", listBusySlotArrayList); // BusySlot = [ {int slot, int dayOfWeek} , {int slot, int dayOfWeek} ] 
            // dayOfWeek [2 - 8] = [T2 - CN]
            // slot [1 - 8] = [slot 1 - slot 8]

            url = roadmap.get(SEARCH_LOCATION_SERVLET);
        }catch (NamingException ex) {
            LOGGER.error(ex);
        } catch (SQLException ex) {
            LOGGER.error(ex);
        }catch (Exception ex) {
            LOGGER.error(ex);
        }  finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            LOGGER.info("Forward from ViewLocationAndTimeServlet to " + url);
            LOGGER.info("Ending Start Date Param: " + request.getParameter("startDate"));
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
