/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import static fptu.swp.controller.UpdateEventStatusServlet.LOGGER;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.entity.user.UserDAO;
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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author triet
 */
@WebServlet(name = "SendEventNotificationServlet", urlPatterns = {"/SendEventNotificationServlet"})
public class SendEventNotificationServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SendEventNotificationServlet.class);

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
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        LOGGER.info("Begin SendEventNotificationServlet");
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
        String message = "";
        try {
            eventId = Integer.parseInt(request.getParameter("eventId"));
            message = request.getParameter("message");
            if (message != null) {
                EventDetailDTO detail = eventDao.getEventDetail(eventId);
                if (detail != null) {
                    String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
                    FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
                    List<Integer> listFollowers = userDao.getFollowersIdByEventId(eventId);
                    url = VIEW_EVENTDETAIL_SERVLET_PATH + "?eventId=" + eventId;
                    
                    for (int studentId : listFollowers) {
                        ScheduleDTO s = new ScheduleDTO();
                        s.setEventId(eventId);
                        s.setEventName(detail.getName());
                        s.setOrganizerAvatar(detail.getOrganizerAvatar());
                        s.setRunningTime(new Date());
                        s.setMessage(message);
                        s.setUserId(studentId);
                        firebase.sendNotificationToUserID(s);
                    }
                }
            }
        } catch (Exception ex) {
            LOGGER.error(ex);
        } catch (FirebaseException ex) {
            Logger.getLogger(SendEventNotificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JacksonUtilityException ex) {
            Logger.getLogger(SendEventNotificationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
