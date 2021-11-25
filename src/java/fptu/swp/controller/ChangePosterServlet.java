/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.controller;

import static fptu.swp.controller.HandleMultipartServlet.LOGGER;
import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.event.EventDetailDTO;
import fptu.swp.entity.user.LecturerBriefInfoDTO;
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
public class ChangePosterServlet extends HttpServlet {
    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ChangePosterServlet.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("multipart/*");
        LOGGER.info("Begin ChangePosterServlet");
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
        String inputName = null;
        
        FileInputStream posterStream = null;
        
        EventDetailDTO detail = null;
        try{
            boolean isMutiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMutiPart) {
                LOGGER.info("No File Found");
                request.getSession(true).setAttribute("errorMessage", "Không thể xử lý dữ liệu!");
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
                        if (inputName.equalsIgnoreCase("eventId")) {
                            eventId = Integer.parseInt((String) item.getString());
                            detail = eventDao.getEventDetail(eventId);
                        }
                            
                    } else {
                        try {
                            if (!"".equals((String) item.getString())) {
                                posterStream = (FileInputStream) item.getInputStream();
                            }
                        } catch (Exception ex) {
                            LOGGER.error(ex);
                            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
                        }
                        if(posterStream != null && detail != null && userDao.getOrganizerIdByEventId(eventId) == ((UserDTO) request.getSession(false).getAttribute("USER")).getId()){
                            eventDao.updateEventPoster(eventId, posterStream);
                            url = VIEW_EVENTDETAIL_SERVLET_PATH+"?eventId=" + eventId;
                        }else{
                            request.getSession(true).setAttribute("errorMessage", "Không tìm thấy sự kiện hoặc bạn không phải là nhà tổ chức sự kiện của sự kiện này!");
                        }
                    }
                }
            }
        }catch(Exception ex){
            LOGGER.error(ex);
            request.getSession(true).setAttribute("errorMessage", "Something went wrong!!!");
        }finally {
            LOGGER.info("Forward from ChangePosterServlet to" + url);
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
