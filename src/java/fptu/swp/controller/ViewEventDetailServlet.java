/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.CommentDTO;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
public class ViewEventDetailServlet extends HttpServlet {

    static final Logger LOGGER = Logger.getLogger(ViewEventDetailServlet.class);

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
        LOGGER.info("Begin ViewEventDetailServlet");

        //declare var
        EventDAO eventDao = new EventDAO();
        UserDAO userDao = new UserDAO();
        
        //get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");
        String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String EVENTDETAIL_PAGE_LABEL = context.getInitParameter("EVENTDETAIL_PAGE_LABEL");
        String EVENTDETAIL_PAGE_PATH = roadmap.get(EVENTDETAIL_PAGE_LABEL);
        String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);

        //default url
        String url = INVALID_PAGE_PATH;

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");

            EventDetailDTO detail = eventDao.getEventDetail(eventId);
            int organizerId = userDao.getOrganizerIdByEventId(eventId);

            List<LecturerBriefInfoDTO> listLecturer = userDao.getListLecturerBriefInfo(eventId);
            List<CommentDTO> listComment = eventDao.getListCommentByEventId(eventId, false);
            List<CommentDTO> listQuestion = eventDao.getListCommentByEventId(eventId, true);

            LOGGER.info("Organizer Id: " + organizerId);
            request.setAttribute("ORGANIZER_ID", organizerId);
            
            LOGGER.info("Event detail: " + detail);
            request.setAttribute("EVENT_DETAIL", detail);

            LOGGER.info("List lecturer of event: " + listLecturer);
            request.setAttribute("LIST_LECTURER", listLecturer);

            LOGGER.info("List comment of detail: " + listComment);
            request.setAttribute("LIST_COMMENT", listComment);

            LOGGER.info("List question of detail: " + listQuestion);
            request.setAttribute("LIST_QUESTION", listQuestion);

            if ("STUDENT".equals(loginUser.getRoleName())) {
                boolean checkFollowed = eventDao.checkFollowed(loginUser.getId(), eventId);
                boolean checkJoining = eventDao.checkJoining(loginUser.getId(), eventId);
                request.setAttribute("IS_FOLLOWED", checkFollowed);
                request.setAttribute("IS_JOINING", checkJoining);
                LOGGER.info("This student is following: " + checkFollowed + " - is joining: " + checkJoining);
            }
            if ("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName())) {
                List<UserDTO> listFollowers = userDao.getFollowersByEventId(eventId);
                List<UserDTO> listParticipants = userDao.getParticipantsByEventId(eventId);
                request.setAttribute("LIST_FOLLOWERS", listFollowers);
                request.setAttribute("LIST_PARTICIPANTS", listParticipants);
                LOGGER.info("List Followers: " + listFollowers);
                LOGGER.info("List Participants: " + listParticipants);
            }

            url = EVENTDETAIL_PAGE_PATH;

        } catch (Exception e) {
            LOGGER.error(e);
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
