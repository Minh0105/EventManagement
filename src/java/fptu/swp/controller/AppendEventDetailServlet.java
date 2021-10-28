/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.location.LocationDTO;
import fptu.swp.entity.range.RangeDAO;
import fptu.swp.entity.range.RangeDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author admin
 */
@WebServlet(name = "AppendEventDetailServlet", urlPatterns = {"/AppendEventDetailServlet"})
public class AppendEventDetailServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(AppendEventDetailServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // declare var
        List<LocationDTO> chosenLocationList = new ArrayList<>();
        HttpSession session;
        List<String> chosenSlotStringList;
        RangeDTO startSlot = new RangeDTO(Integer.MAX_VALUE);
        RangeDTO endSlot = new RangeDTO(Integer.MIN_VALUE);
        RangeDAO rangeDao = new RangeDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfOut = new SimpleDateFormat("EEEE, dd/MM/yyyy");
        Calendar caledar = Calendar.getInstance();
        UserDAO userDao = new UserDAO();
        List<LecturerBriefInfoDTO> lecturerList;

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        // default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String APPEND_EVENT_DETAIL_PAGE = context.getInitParameter("APPEND_EVENT_DETAIL_PAGE");
        String url = INVALID_PAGE_LABEL;

        // parameter 
        String[] chosenSlot = request.getParameterValues("chosenSlot");
        String[] chosenLocationId = request.getParameterValues("chosenLocationId");
        String startDayAndMonth = request.getParameter("startDate");

        // fake Data of Parameter 
//        String[] chosenSlot = new String[]{"1-2", "2-2", "3-2"};
//        String[] chosenLocationId = new String[]{"1-Hội Trường A", "2-Hội Trường B", "3-Hội Trường C"};
//        String startDayAndMonth = "2021-09-20";
        try {
            session = request.getSession(false);

            if (session != null) {

                // ChosenLocationList  [ {id:int, name:string},  {id:int, name:string}, ... ]
                for (String locationParam : Arrays.asList(chosenLocationId)) {
                    int index = locationParam.indexOf("-");
                    int locationId = Integer.parseInt(locationParam.substring(0, index));
                    String locationName = locationParam.substring(index + 1);
                    chosenLocationList.add(new LocationDTO(locationId, locationName));
                }
                LOGGER.info("Session Attribute - Chosen Location Id-Name List: " + chosenLocationList);
                session.setAttribute("ChosenLocationList", chosenLocationList);

                // ChosenTimeRange Attribute
                int dayId = 2;
                chosenSlotStringList = Arrays.asList(chosenSlot);
                for (String str : chosenSlotStringList) {
                    int slotId = Integer.parseInt(str.substring(0, 1));

                    if (slotId < startSlot.getId()) {
                        startSlot.setId(slotId);
                    }
                    if (slotId > endSlot.getId()) {
                        endSlot.setId(slotId);
                    }

                    dayId = Integer.parseInt(str.substring(2));
                }
                String chosenTimeRange = "";
                if (startSlot.getId() == endSlot.getId()) {
                    chosenTimeRange = startSlot.getId() + " (" + rangeDao.getDetailSlotById(startSlot.getId()) + ")";
                } else {
                    chosenTimeRange = startSlot.getId() + " - " + endSlot.getId()
                            + " (" + rangeDao.getDetailSlotById(startSlot.getId()).substring(0, 5) + " - " + rangeDao.getDetailSlotById(endSlot.getId()).substring(7) + ")";
                }
                session.setAttribute("ChosenTimeRange", chosenTimeRange);
                LOGGER.info("Session Attribute - ChosenTimeRange : " + chosenTimeRange);

                // ChosenDate Attribute
                caledar.setTime(sdf.parse(startDayAndMonth));
                caledar.add(Calendar.DATE, dayId - 2);  // number of days to add
                String chosenDate = sdfOut.format(caledar.getTime());  // dt is now the new date

                LOGGER.info("Session Attribute - ChosenDate : " + chosenDate);
                session.setAttribute("ChosenDate", chosenDate);

                // LecturerList Attribute
                lecturerList = userDao.getAllLecturer();

                LOGGER.info("Session Attribute - LecturerList : " + lecturerList);
                session.setAttribute("LecturerList", lecturerList);

                EventDetailDTO detail = (EventDetailDTO) session.getAttribute("EVENT_DETAIL_REVIEW");
                if (detail == null) {
                    InputStream is = null;
                    byte[] imageBytes = null;
                    URL fileDefaultPoster = new URL("https://daihoc.fpt.edu.vn/media/2020/06/banner04.png");
                    try {
                        is = fileDefaultPoster.openStream();
                        imageBytes = IOUtils.toByteArray(is);
                    } catch (IOException e) {
                        LOGGER.error("Failed while reading bytes from %s: %s" + fileDefaultPoster.toExternalForm() + e.getMessage());
                        e.printStackTrace();
                        // Perform any other exception handling that's appropriate.
                    } finally {
                        if (is != null) {
                            is.close();
                        }
                    }
                    if (imageBytes != null) {
                        String poster = Base64.getEncoder().encodeToString(imageBytes);
                        detail = new EventDetailDTO();
                        detail.setPoster(poster);
                        LOGGER.info("Session attribute: EVENT_DETAIL_REVIEW: " + detail);
                        session.setAttribute("EVENT_DETAIL_REVIEW", detail);
                    }

                }

                // URL for go to appendEventDetail
                url = APPEND_EVENT_DETAIL_PAGE;
            }

        } catch (NamingException ex) {
            LOGGER.error(ex);
        } catch (SQLException ex) {
            LOGGER.error(ex);
        } catch (ParseException ex) {
            LOGGER.error(ex);
        } finally {
            LOGGER.info("Forward from AppendEventDetailServlet to " + url);
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
