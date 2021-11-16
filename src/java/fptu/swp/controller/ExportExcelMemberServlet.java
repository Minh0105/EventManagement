/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this tuserlate file, choose Tools | Tuserlates
 * and open the tuserlate in the editor.
 */
package fptu.swp.controller;

import fptu.swp.entity.user.UserDAO;
import fptu.swp.entity.user.UserDTO;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;

/**
 *
 * @author admin
 */
@WebServlet(name = "ExportExcelMemberServlet", urlPatterns = {"/ExportExcelMemberServlet"})
public class ExportExcelMemberServlet extends HttpServlet {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ExportExcelMemberServlet.class);

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

        // declare var
        ArrayList<UserDTO> list = new ArrayList<UserDTO>();


        // get roadmap
        ServletContext context = request.getServletContext();
        HashMap<String, String> roadmap = (HashMap<String, String>) context.getAttribute("ROADMAP");

        // default URL
        final String INVALID_PAGE_LABEL = context.getInitParameter("INVALID_PAGE_LABEL");
        String url = roadmap.get(INVALID_PAGE_LABEL);

        // parameter
        String strEventId = request.getParameter("eventId");
        String people = request.getParameter("people"); // "follower" , "participant", "all"

        try {
            int eventId = Integer.parseInt(strEventId);

            UserDAO userDao = new UserDAO();
            if ("follower".equals(people)) {
                list = (ArrayList<UserDTO>) userDao.getFollowersByEventId(eventId);
            } else if ("participant".equals(people)) {
                list = (ArrayList<UserDTO>) userDao.getParticipantsByEventId(eventId);
            } else {
                list = (ArrayList<UserDTO>) userDao.getUserByEventId(eventId);
            }
            
            writeToExcel(list);
            
        } catch (NamingException ex) {
            //LOGGER.error(ex);
            ex.printStackTrace();
        } catch (SQLException ex) {
            //LOGGER.error(ex);
            ex.printStackTrace();
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher("resources/guest.xls");
            rd.forward(request, response);
        }

    }

    private void writeToExcel(List<UserDTO> list) throws NamingException, SQLException, FileNotFoundException, IOException {
        String realPath = null;
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("userloyees sheet");
        
        
        LOGGER.info(list);
        LOGGER.info("length: " + list.size());

        int rownum = 0;
        Cell cell;
        Row row;
        //
        HSSFCellStyle style = createStyleForTitle(workbook);

        row = sheet.createRow(rownum);

        // userNo
        cell = row.createCell(0, CellType.STRING);
        cell.setCellValue("STT");
        cell.setCellStyle(style);
        // userName
        cell = row.createCell(1, CellType.STRING);
        cell.setCellValue("Name");
        cell.setCellStyle(style);
        // Salary
        cell = row.createCell(2, CellType.STRING);
        cell.setCellValue("Email");
        cell.setCellStyle(style);
        // Grade
        cell = row.createCell(3, CellType.STRING);
        cell.setCellValue("Số điện thoại");
        cell.setCellStyle(style);
        // Bonus
        cell = row.createCell(4, CellType.STRING);
        cell.setCellValue("Chữ ký");
        cell.setCellStyle(style);

        // Data
        for (UserDTO user : list) {
            rownum++;
            row = sheet.createRow(rownum);
            
            // userNo (A)
            cell = row.createCell(0, CellType.NUMERIC);
            cell.setCellValue(rownum);

            // userName (B)
            cell = row.createCell(1, CellType.STRING);
            cell.setCellValue(user.getName());

            // Salary (C)
            cell = row.createCell(2, CellType.STRING);
            cell.setCellValue(user.getEmail());

            // Grade (D)
            cell = row.createCell(3, CellType.STRING);
            cell.setCellValue(user.getPhoneNum());

            //
            cell = row.createCell(4, CellType.STRING);
            cell.setCellValue("");
            // Bonus (E)
//                String formula = "0.1*C" + (rownum + 1) + "*D" + (rownum + 1);
//                cell = row.createCell(4, CellType.FORMULA);
//                cell.setCellFormula(formula);

            
        }
        
        for(int colNum = 0; colNum<row.getLastCellNum();colNum++) workbook.getSheetAt(0).autoSizeColumn(colNum);
        realPath = getServletContext().getRealPath("/") + "resources/" + "guest.xls";

        File file = new File(realPath);
        //file.getParentFile().mkdirs();

        FileOutputStream outFile = new FileOutputStream(file);
        workbook.write(outFile);
        //LOGGER.info("Created file: " + file.getAbsolutePath());
        System.out.println("Created file: " + file.getAbsolutePath());
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

//    private HSSFCellStyle createStyleForBody(HSSFWorkbook workbook) {
//        HSSFFont font = workbook.createFont();
//        font.setBold(true);
//        HSSFCellStyle style = workbook.createCellStyle();
//        
//        return style;
//    }
    
    private HSSFCellStyle createStyleForTitle(HSSFWorkbook workbook) {
        HSSFFont font = workbook.createFont();
        font.setBold(true);
        HSSFCellStyle style = workbook.createCellStyle();
        style.setFont(font);
        return style;
    }

}
