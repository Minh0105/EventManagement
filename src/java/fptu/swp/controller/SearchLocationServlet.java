/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.datetimelocation.RangeDateDTO;
import fptu.swp.entity.location.LocationDAO;
import fptu.swp.entity.location.LocationDTO;
import fptu.swp.entity.range.RangeDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(name = "SearchLocationServlet", urlPatterns = {"/SearchLocationServlet"})
public class SearchLocationServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SearchLocationServlet.class);

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

        LOGGER.info("Begin SearchLocationServlet");

        // declare var
        List<String> chosenSlotStringList;
        List<RangeDateDTO> chosenSlotList = new ArrayList();
        List<String> slotList;
        LocationDAO locationDao;
        RangeDAO rangeDao;

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        // default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String LOC_AND_TIME_PAGE_LABEL = context.getInitParameter("LOC_AND_TIME_PAGE_LABEL");
        String url = roadmap.get(INVALID_PAGE_LABEL);

        // parameter 
        String txtSearch = request.getParameter("txtSearch");
        String[] chosenSlot = request.getParameterValues("chosenSlot");

        try {
            if (txtSearch != null) {

                // list Slot to RangeDateDTO
                if (chosenSlot != null) {
                    chosenSlotStringList = Arrays.asList(chosenSlot);
                    chosenSlotStringList.forEach((str) -> {
                        int slotId = Integer.parseInt(str.substring(0, 1));
                        int dayId = Integer.parseInt(str.substring(2));
                        chosenSlotList.add(new RangeDateDTO(slotId, dayId));
                    });
                }
                LOGGER.info("Chosen Slot List: " + chosenSlotList);
                request.setAttribute("ChosenSlotList", chosenSlotList);

                locationDao = new LocationDAO();
                ArrayList<LocationDTO> listLocation = (ArrayList<LocationDTO>) locationDao.getLocationByName(txtSearch);
                LOGGER.info("Searched Location List: " + listLocation);
                request.setAttribute("SearchedLocationList", listLocation); // list = [ {int id, string name} ,  {int id, string name} ]

                rangeDao = new RangeDAO();
                slotList = rangeDao.getAllDetailSlot();
                LOGGER.info("Slot Detail List: " + slotList);
                request.setAttribute("SlotList", slotList);

                url = roadmap.get(LOC_AND_TIME_PAGE_LABEL);
            }
        } catch (NamingException ex) {
            LOGGER.error(ex);
        } catch (SQLException ex) {
            LOGGER.error(ex);
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            LOGGER.info("Forward from SearchLocationServlet to " + url);
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

    private void mockDataToTestUI(HttpServletRequest request) {
//        BUSY SLOT LIST
        ArrayList<RangeDateDTO> chosenSlotList = new ArrayList();
        chosenSlotList.add(new RangeDateDTO(2, 3));
        chosenSlotList.add(new RangeDateDTO(2, 4));
        chosenSlotList.add(new RangeDateDTO(3, 4));
        chosenSlotList.add(new RangeDateDTO(4, 5));
        request.setAttribute("BusySlotList", chosenSlotList);

//        CHOSEN LOCATION LIST
        ArrayList<LocationDTO> chosenLocationList = new ArrayList();
        chosenLocationList.add(new LocationDTO(1, "Hội trường A"));
        chosenLocationList.add(new LocationDTO(2, "Hội trường B"));
        chosenLocationList.add(new LocationDTO(3, "Thư viện tầng 1"));
        request.setAttribute("ChosenLocationList", chosenLocationList);

//        SEARCHED LOCATION LIST
//        request.setAttribute("SearchedLocationList", listLocation);
//        SLOT LIST 
        ArrayList<String> slotList = new ArrayList();
        slotList.add("07:00 - 8:30");
        slotList.add("08:45 - 10:15");
        slotList.add("10:30 - 12:00");
        slotList.add("12:30 - 14:00");
        slotList.add("14:15 - 15:45");
        slotList.add("16:00 - 17:30");
        slotList.add("17:45 - 19:15");
        slotList.add("19:30 - 21:00");
        request.setAttribute("SlotList", slotList);

    }

}
