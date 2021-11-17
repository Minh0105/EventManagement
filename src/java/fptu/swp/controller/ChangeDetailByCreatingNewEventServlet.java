/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.schedule.Schedule;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import fptu.swp.fakefileinputstream.FakeFileInputStream;
import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class ChangeDetailByCreatingNewEventServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ChangeDetailByCreatingNewEventServlet.class);

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
        LOGGER.info("Bengin ChangeDetailByCreatingNewEventServlet");

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String VIEW_EVENTDETAIL_SERVLET = context.getInitParameter("VIEW_EVENTDETAIL_SERVLET");
        String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        String CREATE_NEW_EVENT = "searchLocation?txtSearch=";
        String url = INVALID_PAGE_PATH;
        EventDAO eventDao = new EventDAO();
        UserDAO userDao = new UserDAO();

        try {
            String stage = request.getParameter("stage");
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            HttpSession session = request.getSession();

            int loginUserId = ((UserDTO) session.getAttribute("USER")).getId();
            int organizerIdOfEvent = userDao.getOrganizerIdByEventId(eventId);

            if (loginUserId == organizerIdOfEvent) {

                if ("start".equals(stage)) {//eventId khi stage = start => eventId can xoa
                    EventDetailDTO detail = eventDao.getEventDetail(eventId);
                    if (detail.getStatusId() == 1 || detail.getStatusId() == 2) {
                        List<LecturerBriefInfoDTO> chosenLecturerList = userDao.getListLecturerBriefInfo(eventId);
                        session.setAttribute("CHANGING_EVENT_ID", eventId);
                        LOGGER.info("Session attribute: EVENT_DETAIL_REVIEW: " + detail);
                        session.setAttribute("EVENT_DETAIL_REVIEW", detail);

                        byte[] posterBytes = Base64.getDecoder().decode(detail.getPoster());
                        InputStream posterInputStream = new ByteArrayInputStream(posterBytes);
                        FileInputStream posterStream = new FakeFileInputStream(posterInputStream);
                        LOGGER.info("Session attribute: EVENT_POSTER_STREAM: " + posterStream);
                        session.setAttribute("EVENT_POSTER_STREAM", posterStream);

                        LOGGER.info("Session attribute: ChosenLecturerList: " + chosenLecturerList);
                        session.setAttribute("ChosenLecturerList", chosenLecturerList);
                        url = CREATE_NEW_EVENT;
                    }
                } else if ("end".equals(stage)) { //eventId khi stage = end => eventId vua dc them
                    int oldEventId = (Integer) session.getAttribute("CHANGING_EVENT_ID");
                    session.removeAttribute("CHANGING_EVENT_ID");
                    boolean check = false;
                    System.out.println(eventId);
                    EventDetailDTO detail = eventDao.getEventDetail(oldEventId);
                    EventDetailDTO detailNew = eventDao.getEventDetail(eventId);

                    if (detail != null) {
                        String oldEventName = detail.getName();
                        String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
                        FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
                        if (detail.getStatusId() == 1 || detail.getStatusId() == 2) {
                            if (eventDao.cancelEvent(oldEventId)) {
                                check = true;
                                List<Integer> listFollowers = userDao.getFollowersIdByEventId(oldEventId);
                                for (int studentId : listFollowers) {
                                    if (eventDao.checkExistenceAndOrInsertStudentInEvent(eventId, studentId)) {
                                        if (eventDao.setFollowingStatus(eventId, studentId, true)) {
                                            ScheduleDTO s = new ScheduleDTO();
                                            s.setEventId(eventId);
                                            s.setEventName(detailNew.getName());
                                            s.setOrganizerAvatar(detailNew.getOrganizerAvatar());
                                            s.setRunningTime(new Date());
                                            String message = "Sự kiện " + oldEventName + " vừa được cập nhật thông tin." + (oldEventName.equals(detailNew.getName()) ? ("") : ("Sự kiện được đổi tên thành: " + detailNew.getName()));
                                            s.setMessage(message);
                                            s.setUserId(studentId);
                                            System.out.println("Send noti of Update Event with Id: " + oldEventId + " to new event with Id: " + eventId + "  is " + firebase.sendNotificationToUserID(s));
                                            check = true;
                                        } else {
                                            check = false;
                                        }
                                    }
                                }
                                Schedule.updateSchedule();
                                if (check) {
                                    url = VIEW_EVENTDETAIL_SERVLET + "?eventId=" + eventId;
                                }
                            }
                        }
                    }
                }

            }

        } catch (Exception ex) {
            LOGGER.error(ex);
        } catch (FirebaseException ex) {
            Logger.getLogger(ChangeDetailByCreatingNewEventServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JacksonUtilityException ex) {
            Logger.getLogger(ChangeDetailByCreatingNewEventServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            LOGGER.info("Forward from ChangeDetailByCreatingNewEventServlet to " + url);
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
