/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.BufferedReader;
import java.io.IOException;

/**
 *
 * @author admin
 */
public class HttpUtil {
    
    private String value;
    
    public HttpUtil (String value) {
        this.value = value;
    }
    
    public <T> T toModel(Class<T> tClass) throws IOException {
        return new ObjectMapper().readValue(value, tClass);
    }
    
    public static HttpUtil of (BufferedReader reader) throws IOException {
        StringBuffer sb = new StringBuffer();
        
            String line;
            while((line = reader.readLine()) != null) {
                sb.append(line);
            }
        
        return new HttpUtil(sb.toString());      
    }
    
}
