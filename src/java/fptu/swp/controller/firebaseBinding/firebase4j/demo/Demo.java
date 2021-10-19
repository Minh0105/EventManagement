package fptu.swp.controller.firebaseBinding.firebase4j.demo;

import fptu.swp.entity.notification.NotificationDTO;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;
import net.thegreshams.firebase4j.model.FirebaseResponse;
import net.thegreshams.firebase4j.service.Firebase;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;

public class Demo {
    
    public static FirebaseResponse getFirebaseDataJson(String filebaseLink) throws FirebaseException, JsonParseException, JsonMappingException, IOException, JacksonUtilityException {

        String your_firebase_workspace_url = filebaseLink;

        Firebase firebase = new Firebase(your_firebase_workspace_url);

        FirebaseResponse response = firebase.get();
        System.out.println(response);

        // alternatively, you can get a few details about the response
        response.getSuccess(); 	// true/false if method finished successfully
        response.getCode(); 	// http-code of method-request
        response.getBody();	// a map of the data returned
        response.getRawBody();	// the data returned in it's raw-form (ie: JSON)

        // another alternative, you can PUT/POST your own JSON if you want
//	response = firebase.put( "PUT2", "{ 'key': 'Some value' }" );
        return response;
    }

    public static boolean addAllNotification(String your_firebase_workspace_url, Map<String, Object> dataMap) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException {

        Firebase firebase = new Firebase(your_firebase_workspace_url);
        
        FirebaseResponse response = firebase.put(dataMap);
        
        return response.getSuccess();
    }
    
    public static boolean addOneNotification(String your_firebase_workspace_url, NotificationDTO dto ) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException {
        
        Firebase firebase = new Firebase(your_firebase_workspace_url);
        
        Map<String, Object> data = new HashMap<>();
        data.put( Integer.toString(dto.getId()), dto);
        FirebaseResponse response = firebase.post(data);
        
        return response.getSuccess();
    }

}
