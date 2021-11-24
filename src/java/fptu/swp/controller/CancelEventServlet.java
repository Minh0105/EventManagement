/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.email.EmailSender;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.schedule.Schedule;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author triet
 */
public class CancelEventServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(CancelEventServlet.class);

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
        LOGGER.info("Begin CancelEventServlet");

        // declare var
        EventDAO eventDao = new EventDAO();
        UserDAO userDao = new UserDAO();

        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default url
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String FILTER_EVENT_SERVLET = context.getInitParameter("FILTER_EVENT_SERVLET");
        final String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        final String FILTER_EVENT_SERVLET_PATH = roadmap.get(FILTER_EVENT_SERVLET);
        final String VIEW_NEWFEED_SERVLET = context.getInitParameter("VIEW_NEWFEED_SERVLET");
        final String VIEW_NEWFEED = roadmap.get(VIEW_NEWFEED_SERVLET);

        String url = INVALID_PAGE_PATH;
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDetailDTO detail = eventDao.getEventDetail(eventId);
            if (detail != null) {
                String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
                FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
                if (detail.getStatusId() == 1 || detail.getStatusId() == 2) {
                    String reason = request.getParameter("reason");
                    if (eventDao.cancelEvent(eventId)) {
                        List<Integer> listFollowers = userDao.getFollowersIdByEventId(eventId);
                        for (int studentId : listFollowers) {
                            ScheduleDTO s = new ScheduleDTO();
                            s.setEventId(eventId);
                            s.setEventName(detail.getName());
                            s.setOrganizerAvatar(detail.getOrganizerAvatar());
                            s.setRunningTime(new Date());
                            String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã bị hủy.";
                            s.setMessage(message);
                            s.setUserId(studentId);
                            System.out.println("Send noti of Cancel Event with Id: " + eventId + "  is " + firebase.sendNotificationToUserID(s));
                        }
                        List<LecturerBriefInfoDTO> listLec = userDao.getListLecturerBriefInfo(eventId);
                        for(LecturerBriefInfoDTO lec : listLec){
                            ScheduleDTO s = new ScheduleDTO();
                            s.setEventId(eventId);
                            s.setEventName(detail.getName());
                            s.setOrganizerAvatar(detail.getOrganizerAvatar());
                            s.setRunningTime(new Date());
                            String message = "Sự kiện <strong>" + detail.getName() + "</strong> đã bị hủy.";
                            s.setMessage(message);
                            s.setUserId(lec.getId());
                            System.out.println("Send noti of Cancel Event with Id: " + eventId + "  is " + firebase.sendNotificationToUserID(s));
                        }
                        
                        Schedule.updateSchedule();
                        if ("ADMIN".equals(loginUser.getRoleName())) {
                            url = FILTER_EVENT_SERVLET_PATH;
                        }
                        if ("DEPARTMENT'S MANAGER".equals(loginUser.getRoleName()) || "CLUB'S LEADER".equals(loginUser.getRoleName())) {
                            url = VIEW_NEWFEED;
                        }
                    }
                    if (reason != null && loginUser.getRoleName().equals("ADMIN")) {
                        UserDTO receiver = userDao.getUserById(userDao.getOrganizerIdByEventId(eventId));
                        String TO_USER_EMAIL = receiver.getEmail();
                        String FROM_USER_ACCESSTOKEN = (String) session.getAttribute("ACCESS_TOKEN");

                        //default oauth2
                        String SMTP_SERVER_HOST = "smtp.gmail.com";
                        String SMTP_SERVER_PORT = "587";

                        //mail's content
                        String SUBJECT = "Về sự kiện của bạn trên hệ thống FPT Event Management";
                        String BODY = "Chào bạn " + receiver.getName() + ",<br><br>Sự kiện của bạn trên hệ thống FPT Event Management đã <strong>bị hủy</strong>!<br>"
                                + "<br>Lí do: " + reason + ".<br><br>Mọi thắc mắc xin vui lòng liên hệ theo thông tin bên dưới."
                                + "<br>--<br>"
                                + "Phòng ban Quản lí sự kiện Đại học FPT"
                                + "<br>"
                                + "Liên hệ:<br>"
                                + "Email: fptuni.event.department@gmail.com"
                                + "<br>"
                                + "Tel: (+84) 123456789<br>"
                                + "________<br>"
                                + "FPT UNIVERSITY HCM E2a-7, D1 Street, Saigon Hi-tech Park, Tan Phu Ward, District 9, HCM City<br>"
                                + "Tel: (028) 7300 5588 | Website: hcmuni.fpt.edu.vn";

                        String FROM_USER_EMAIL = loginUser.getEmail();
                        String FROM_USER_FULLNAME = (String) session.getAttribute("EMAIL_NAME");

                        if (EmailSender.sendMail(SMTP_SERVER_HOST, SMTP_SERVER_PORT, FROM_USER_EMAIL, FROM_USER_ACCESSTOKEN, FROM_USER_EMAIL, FROM_USER_FULLNAME, TO_USER_EMAIL, SUBJECT, BODY)) {
                            //if (EmailSender.sendEmail(FROM_USER_EMAIL, loginUser, userDao.getUserById(userId), SUBJECT, BODY, FROM_USER_ACCESSTOKEN)){
                            request.setAttribute("NOTIFICATION", "Gửi mail thành công!");
                        } else {
                            request.setAttribute("NOTIFICATION", "Gửi mail không thành công!");

                        }
                    }

                }else{
                    request.getSession(true).setAttribute("errorMessage", "Sự kiện này đã kết thúc hoặc bị hủy!");
                }
            }else{
                request.getSession(true).setAttribute("errorMessage", "Không tìm thấy sự kiện");
            }
        } catch (Exception ex) {
            LOGGER.error(ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        } catch (FirebaseException ex) {
            Logger.getLogger(CancelEventServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        } catch (JacksonUtilityException ex) {
            Logger.getLogger(CancelEventServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
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
