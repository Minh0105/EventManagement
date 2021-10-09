/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.location.LocationDTO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author triet
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class HandleMultipartServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(HandleMultipartServlet.class);

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
        response.setContentType("multipart/*");
        LOGGER.info("Begin HandleMultipartServlet");
        request.setCharacterEncoding("UTF-8");
        // declare var
        HttpSession session;
        String chosenDate = "";
        String chosenTimeRange = "";

        List<LocationDTO> chosenLocationList = null;
        UserDTO loginUser = null;
        String poster = "";
        String location = "";
        String organizerName = "";
        String organizerDescription = "";
        String organizerAvatar = "";
        String inputName = null;
        int i = 0;
        String eventName = "";
        String description = "";
        FileInputStream posterStream = null;

        int lecturerRemoveId = 0;
        int lecturerAddId = 0;

        String action = "";
        EventDetailDTO detail;
        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        //default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        final String REVIEW_EVENT_PAGE_LABEL = context.getInitParameter("REVIEW_EVENT_PAGE_LABEL");
        final String ADD_CHOSEN_LECTURER_SERVLET = context.getInitParameter("ADD_CHOSEN_LECTURER_SERVLET");
        final String REMOVE_CHOSEN_LECTURER_SERVLET = context.getInitParameter("REMOVE_CHOSEN_LECTURER_SERVLET");
        String INVALID_PAGE_PATH = roadmap.get(INVALID_PAGE_LABEL);
        String REVIEW_EVENT_PAGE_PATH = roadmap.get(REVIEW_EVENT_PAGE_LABEL);
        String ADD_CHOSEN_LECTURER_SERVLET_PATH = roadmap.get(ADD_CHOSEN_LECTURER_SERVLET);
        String REMOVE_CHOSEN_LECTURER_SERVLET_PATH = roadmap.get(REMOVE_CHOSEN_LECTURER_SERVLET);
        String url = INVALID_PAGE_PATH;

        try {
            session = request.getSession(false);
            loginUser = (UserDTO) session.getAttribute("USER");
            EventDAO eventDao = new EventDAO();
            UserDAO userDao = new UserDAO();
            organizerName = loginUser.getName();
            organizerDescription = userDao.getDescription(loginUser.getId());
            organizerAvatar = loginUser.getAvatar();
            chosenDate = (String) session.getAttribute("ChosenDate");
            chosenTimeRange = (String) session.getAttribute("ChosenTimeRange");
            chosenLocationList = (List<LocationDTO>) session.getAttribute("ChosenLocationList");
            detail = (EventDetailDTO) session.getAttribute("EVENT_DETAIL_REVIEW");
            

            for (i = 0; i < chosenLocationList.size() - 1; i++) {
                location += chosenLocationList.get(i).getName() + ", ";
            }
            location += chosenLocationList.get(i).getName();
            boolean isMutiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMutiPart) {
                LOGGER.info("No File Found");
            } else {
                LOGGER.info("Found a File");
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);   // List<FileItem>        
                } catch (org.apache.commons.fileupload.FileUploadException ex) {
                    LOGGER.error(ex);
                }
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                        inputName = (String) item.getFieldName();
                        if (inputName.equalsIgnoreCase("removeLec")) {
                            lecturerRemoveId = Integer.parseInt((String) item.getString());
                        }
                        if (inputName.equalsIgnoreCase("addLec")) {
                            lecturerAddId = Integer.parseInt((String) item.getString());
                        }
                        if (inputName.equalsIgnoreCase("action")) {
                            action = (String) item.getString();
                        }
                        if (inputName.equalsIgnoreCase("eventName")) {
                            eventName = (String) item.getString();
                            eventName = new String(eventName.getBytes("iso-8859-1"), "UTF-8");
                        }
                        if (inputName.equalsIgnoreCase("description")) {
                            description = (String) item.getString();
                            description = new String(description.getBytes("iso-8859-1"), "UTF-8");
                        }
                    } else {
                        try {
                            if (!"".equals((String) item.getString())) {
                                posterStream = (FileInputStream) item.getInputStream();
                                poster = Base64.getEncoder().encodeToString(item.get());
                            }else{
                                poster = detail.getPoster();
                                posterStream = (FileInputStream) session.getAttribute("EVENT_POSTER_STREAM");
                            }
                        } catch (Exception ex) {
                            LOGGER.error(ex);
                        }
                    }
                }
                EventDetailDTO review = new EventDetailDTO(0, eventName, poster, location, chosenDate,
                        chosenTimeRange, organizerName, 0, 0, description, organizerDescription, organizerAvatar, 1);
                LOGGER.info("Session attribute: EVENT_DETAIL_REVIEW: " + review);
                session.setAttribute("EVENT_DETAIL_REVIEW", review);
                LOGGER.info("Session attribute: EVENT_POSTER_STREAM: " + review);
                session.setAttribute("EVENT_POSTER_STREAM", posterStream);
                if ("Review".equals(action)) {
                    url = REVIEW_EVENT_PAGE_PATH;
                }
                if (lecturerRemoveId != 0) {
                    request.setAttribute("lecturerId", lecturerRemoveId);
                    url = REMOVE_CHOSEN_LECTURER_SERVLET_PATH;
                }
                if (lecturerAddId != 0) {
                    request.setAttribute("lecturerId", lecturerAddId);
                    url = ADD_CHOSEN_LECTURER_SERVLET_PATH;
                }
            }
        } catch (Exception ex) {
            LOGGER.error(ex);
        } finally {
            LOGGER.info("Forward from HandleMultipartServlet to" + url);
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
