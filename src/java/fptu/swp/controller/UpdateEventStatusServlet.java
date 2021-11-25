/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author triet
 */
public class UpdateEventStatusServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(UpdateEventStatusServlet.class);

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
            throws ServletException, IOException, FirebaseException, JacksonUtilityException {
        response.setContentType("text/html;charset=UTF-8");
        LOGGER.info("Begin UpdateEventStatusServlet");
        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String VIEW_EVENTDETAIL_SERVLET = context.getInitParameter("VIEW_EVENTDETAIL_SERVLET");
        String VIEW_EVENTDETAIL_SERVLET_PATH = roadmap.get(VIEW_EVENTDETAIL_SERVLET);
        String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        String url = INVALID_PAGE_PATH;

        //declare var
        EventDAO eventDao = new EventDAO();
        UserDAO userDao = new UserDAO();
        int eventId = 0;
        int currentEventStatus = 0;

        try {
            eventId = Integer.parseInt(request.getParameter("eventId"));

            int loginUserId = ((UserDTO) request.getSession(false).getAttribute("USER")).getId();
            int organizerIdOfEvent = userDao.getOrganizerIdByEventId(eventId);

            if (loginUserId == organizerIdOfEvent) {

                EventDetailDTO detail = eventDao.getEventDetail(eventId);
                if (detail != null) {
                    currentEventStatus = detail.getStatusId();

                    String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
                    FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);

                    List<Integer> listFollowers = null;
                    List<LecturerBriefInfoDTO> listLec = null;
                    
                    if (currentEventStatus == 1 || currentEventStatus == 2) {
                        listFollowers = userDao.getFollowersIdByEventId(eventId);
                        listLec = userDao.getListLecturerBriefInfo(eventId);
                    }

                    if (currentEventStatus == 1) {
                        if (eventDao.updateEventStatus(eventId, 2)) {
                            url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + eventId;
                            for (int studentId : listFollowers) {
                                ScheduleDTO s = new ScheduleDTO();
                                s.setEventId(eventId);
                                s.setEventName(detail.getName());
                                s.setOrganizerAvatar(detail.getOrganizerAvatar());
                                s.setRunningTime(new Date());
                                String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã đóng đăng kí.";
                                s.setMessage(message);
                                s.setUserId(studentId);
                                firebase.sendNotificationToUserID(s);
                            }
                            for (LecturerBriefInfoDTO lec : listLec) {
                                ScheduleDTO s = new ScheduleDTO();
                                s.setEventId(eventId);
                                s.setEventName(detail.getName());
                                s.setOrganizerAvatar(detail.getOrganizerAvatar());
                                s.setRunningTime(new Date());
                                String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã đóng đăng kí.";
                                s.setMessage(message);
                                s.setUserId(lec.getId());
                                firebase.sendNotificationToUserID(s);
                            }
                        }
                    }
                    if (currentEventStatus == 2) {
                        if (eventDao.updateEventStatus(eventId, 1)) {
                            url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + eventId;
                            for (int studentId : listFollowers) {
                                ScheduleDTO s = new ScheduleDTO();
                                s.setEventId(eventId);
                                s.setEventName(detail.getName());
                                s.setOrganizerAvatar(detail.getOrganizerAvatar());
                                s.setRunningTime(new Date());
                                String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã mở đăng kí tiếp tục.";
                                s.setMessage(message);
                                s.setUserId(studentId);
                                firebase.sendNotificationToUserID(s);
                            }
                            for (LecturerBriefInfoDTO lec : listLec) {
                                ScheduleDTO s = new ScheduleDTO();
                                s.setEventId(eventId);
                                s.setEventName(detail.getName());
                                s.setOrganizerAvatar(detail.getOrganizerAvatar());
                                s.setRunningTime(new Date());
                                String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã mở đăng kí tiếp tục.";
                                s.setMessage(message);
                                s.setUserId(lec.getId());
                                firebase.sendNotificationToUserID(s);
                            }                          
                        }
                    }
                }
            }

        } catch (Exception ex) {
            LOGGER.error(ex);
        } finally {
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
        try {
            processRequest(request, response);
        } catch (FirebaseException ex) {
            Logger.getLogger(UpdateEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JacksonUtilityException ex) {
            Logger.getLogger(UpdateEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (FirebaseException ex) {
            Logger.getLogger(UpdateEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JacksonUtilityException ex) {
            Logger.getLogger(UpdateEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
