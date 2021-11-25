/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.CommentDTO;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
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
public class DeactivateQuestionAndReplyServlet extends HttpServlet {

    static final Logger LOGGER = Logger.getLogger(DeactivateQuestionAndReplyServlet.class);

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
        LOGGER.info("Begin DeactivateQuestionAndReplyServlet");
        // declare var
        EventDAO eventDao = new EventDAO();
        UserDAO userDao = new UserDAO();

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String VIEW_EVENTDETAIL_SERVLET = context.getInitParameter("VIEW_EVENTDETAIL_SERVLET");
        final String VIEW_EVENTDETAIL_SERVLET_PATH = roadmap.get(VIEW_EVENTDETAIL_SERVLET);
        final String MANAGE_BY_ADMIN_SERVLET = context.getInitParameter("MANAGE_BY_ADMIN_SERVLET");
        final String MANAGE_BY_ADMIN_SERVLET_PATH = roadmap.get(MANAGE_BY_ADMIN_SERVLET);
        String url = INVALID_PAGE_PATH;
        try {
            HttpSession session = request.getSession(false);
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            int commentId = Integer.parseInt(request.getParameter("commentId"));

            CommentDTO cmt = eventDao.getCommentByCommentId(commentId);
            System.out.println(cmt);

            if (loginUser.getRoleName().equals("STUDENT")) {
                if (cmt.getUserId() == loginUser.getId()) {
                    eventDao.deactivateQuestionAndReply(commentId);
                    url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + cmt.getEventId();
                    url += "&lastAction=askQuestion";
                }
            } else {
                String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
                FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
                EventDetailDTO detail = eventDao.getEventDetail(cmt.getEventId());
                if (loginUser.getRoleName().equals("ADMIN")) {
                    eventDao.deactivateQuestionAndReply(commentId);
                    url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + cmt.getEventId();
                    ScheduleDTO s = new ScheduleDTO();
                    s.setEventId(cmt.getEventId());
                    s.setEventName(detail.getName());
                    s.setOrganizerAvatar(detail.getOrganizerAvatar());
                    s.setRunningTime(new Date());
                    String message = "Câu hỏi của bạn trong sự kiện " + detail.getName() + " đã bị xóa.";
                    s.setMessage(message);
                    s.setUserId(cmt.getUserId());
                    System.out.println("Send noti when deactivate question of student: " + firebase.sendNotificationToUserID(s));
                    url = MANAGE_BY_ADMIN_SERVLET_PATH + "?management=question";
                } else if (loginUser.getRoleName().equals("CLUB'S LEADER") || loginUser.getRoleName().equals("DEPARTMENT'S MANAGER")) {

                    if (userDao.getOrganizerIdByEventId(cmt.getEventId()) == loginUser.getId()) {
                        eventDao.deactivateQuestionAndReply(commentId);
                        url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + cmt.getEventId();
                        url += "&lastAction=askQuestion";

                        ScheduleDTO s = new ScheduleDTO();

                        s.setEventId(cmt.getEventId());
                        s.setEventName(detail.getName());
                        s.setOrganizerAvatar(detail.getOrganizerAvatar());
                        s.setRunningTime(new Date());
                        String message = "Câu hỏi của bạn trong sự kiện " + detail.getName() + " đã bị xóa.";
                        s.setMessage(message);
                        s.setUserId(cmt.getUserId());
                        System.out.println("Send noti when deactivate question of student: " + firebase.sendNotificationToUserID(s));
                    }
                }
            }

        } catch (Exception e) {
            LOGGER.error(e);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        } catch (FirebaseException ex) {
            java.util.logging.Logger.getLogger(DeactivateQuestionAndReplyServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        } catch (JacksonUtilityException ex) {
            java.util.logging.Logger.getLogger(DeactivateQuestionAndReplyServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
