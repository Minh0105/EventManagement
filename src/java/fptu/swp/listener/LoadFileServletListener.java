/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.listener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author DuongMH
 */
public class LoadFileServletListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        loadFileAuth(sce);
        loadFileRoadMap(sce);
    }
    
    private void loadFileRoadMap(ServletContextEvent sce) {
        Map<String, String> roadmap = new HashMap<>();

        ServletContext context = sce.getServletContext();
        String realPath = context.getRealPath("/") + "WEB-INF\\" + context.getInitParameter("ROAD_MAP_TXT_FILE_NAME");

        FileReader fr = null;
        BufferedReader bf = null;
        String line;
        final String TOKEN_SPLIT = context.getInitParameter("TOKEN_SPLIT");

        try {
            File f = new File(realPath);
            if (!f.exists()) {
                return;
            }
            fr = new FileReader(f);
            bf = new BufferedReader(fr);

            // read each line and load to map 
            while ((line = bf.readLine()) != null) {
                int IndexOfSeparator = line.indexOf(TOKEN_SPLIT);

                String name = line.substring(0, IndexOfSeparator);
                String value = line.substring(IndexOfSeparator + 1);

                // add into RoadMap
                roadmap.put(name, value);
            }
            context.setAttribute("ROADMAP", roadmap);

            roadmap.keySet().forEach((key) -> {
                System.out.println(key + ":" + roadmap.get(key));
            });

        } catch (NullPointerException | UnsupportedOperationException | IOException npe) {
            npe.printStackTrace();
        } finally {
            try {
                if (fr != null) {
                    fr.close();
                }
                if (bf != null) {
                    bf.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

    }

    private void loadFileAuth(ServletContextEvent sce) {
        Map<String, Set<String>> authMap = new HashMap<>();
        Set<String> setOfServletPermission;
        
        ServletContext context = sce.getServletContext();
        String realPath = context.getRealPath("/") + "WEB-INF\\" + context.getInitParameter("AUTH_FILE_NAME");

        FileReader fr = null;
        BufferedReader bf = null;
        String line;
        final String TOKEN_SPLIT = context.getInitParameter("TOKEN_SPLIT");

        try {
            File f = new File(realPath);
            if (!f.exists()) {
                return;
            }
            fr = new FileReader(f);
            bf = new BufferedReader(fr);

            // read each line and load to map 
            while ((line = bf.readLine()) != null) {
                int IndexOfSeparator = line.indexOf(TOKEN_SPLIT);

                String name = line.substring(0, IndexOfSeparator);
                
                String strOfPermission = line.substring(IndexOfSeparator + 1);
                setOfServletPermission = new HashSet<>(Arrays.asList(strOfPermission.split(",")));
                
                // add into RoadMap
                authMap.put(name, setOfServletPermission);
            }
            context.setAttribute("AUTH", authMap);

            authMap.keySet().forEach((key) -> {
                System.out.println(key + ":" + authMap.get(key));
            });

        } catch (NullPointerException | UnsupportedOperationException | IOException npe) {
            npe.printStackTrace();
        } finally {
            try {
                if (fr != null) {
                    fr.close();
                }
                if (bf != null) {
                    bf.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            ServletContext context = sce.getServletContext();
            context.removeAttribute("ROADMAP");
            context.removeAttribute("AUTH");
        } catch (UnsupportedOperationException ex) {
            ex.printStackTrace();
        }
    }
}
