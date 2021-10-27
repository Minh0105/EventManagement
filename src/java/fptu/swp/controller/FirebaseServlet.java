/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import fptu.swp.utils.firebaseBinding.firebase4j.model.CommentFirebaseDTO;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 *
 * @author admin
 */
@WebServlet(name = "FirebaseServlet", urlPatterns = {"/FirebaseServlet"})
public class FirebaseServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(FirebaseServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";

        try {

            // firebase get the value of comment in firebase
            FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
            Map<String, Object> mapData = firebase.getAllCommentAndReplyInFirebase();
            for (String key : mapData.keySet()) {
                System.out.println("Key : " + key);
                //System.out.println("        Data: " + (CommentFirebaseDTO) mapData.get(key));
            }
            request.setAttribute("mapData", mapData);
        } catch (FirebaseException ex) {
            LOGGER.error(ex);
        } catch (UnsupportedEncodingException ex) {
            LOGGER.error(ex);
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher("firebase.jsp");
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

    private void sendNotificationSource() throws FirebaseException, JacksonUtilityException, IOException {
        String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
            // Send Notification for one certain User
        FirebaseBindingSingleton firebaseBinding = FirebaseBindingSingleton.getInstance(linkToFirebase);
        boolean res = firebaseBinding.sendNotificationToUserID("test for notifi", 4);
    }

    // for add All the list of notificationDTO
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
//        
//        try {
//            
//            int notificationID = Integer.parseInt(request.getParameter("notificationID"));
//            int eventId = Integer.parseInt(request.getParameter("eventId"));
//            int studentId = Integer.parseInt(request.getParameter("studentId"));
//            String title = request.getParameter("title");
//            
//            Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
//            NotificationDTO notifi = new NotificationDTO(notificationID, title, eventId, studentId);
//            Map<Integer, NotificationDTO> mapNoti = new HashMap<>();
//            mapNoti.put(notifi.getId() ,notifi);
//            dataMap.put("notifications", mapNoti);
//            
//            boolean res = Demo.addAllNotification(linkToFirebase, dataMap);
//            
//            request.setAttribute("res", res);
//            
//        } catch (FirebaseException ex) {
//            LOGGER.info(ex.getMessage());
//        } catch (JacksonUtilityException ex) {
//            LOGGER.info(ex.getMessage());
//        } finally {
//            RequestDispatcher rd = request.getRequestDispatcher("firebase.jsp");
//            rd.forward(request, response);
//        }
//    }
    // Add All list for firebase of notifications 
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
//        
//        try {
//            
//            int notificationID = Integer.parseInt(request.getParameter("notificationID"));
//            int eventId = Integer.parseInt(request.getParameter("eventId"));
//            int studentId = Integer.parseInt(request.getParameter("studentId"));
//            String title = request.getParameter("title");
//            
//            NotificationDTO dto = new NotificationDTO(notificationID, title, eventId, studentId);
//            Map<String, Object> subData = new HashMap<>();
//            subData.put(Integer.toString(dto.getId()), dto);
//            
//            Map<String, Object> dataMap = new HashMap<>();
//            dataMap.put("notifications", subData);
//                    
//            
//            boolean res2 = Demo.addAllNotification(linkToFirebase, dataMap);
//            
//            request.setAttribute("res", res2);
//            
//        } catch (FirebaseException ex) {
//            LOGGER.info(ex.getMessage());
//        } catch (JacksonUtilityException ex) {
//            LOGGER.info(ex.getMessage());
//        } finally {
//            RequestDispatcher rd = request.getRequestDispatcher("firebase.jsp");
//            rd.forward(request, response);
//        }
//    }
}
