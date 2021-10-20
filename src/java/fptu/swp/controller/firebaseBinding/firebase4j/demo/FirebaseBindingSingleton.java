package fptu.swp.utils.firebaseBinding.firebase4j.demo;

import com.google.gson.JsonParseException;
import java.io.UnsupportedEncodingException;
import com.fasterxml.jackson.databind.ObjectMapper; 
import com.fasterxml.jackson.databind.ObjectWriter; 


import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import fptu.swp.utils.firebaseBinding.firebase4j.model.EventNotification;
import fptu.swp.utils.firebaseBinding.firebase4j.model.FirebaseResponse;
import fptu.swp.utils.firebaseBinding.firebase4j.service.Firebase;
import java.io.IOException;
import org.codehaus.jackson.map.JsonMappingException;

public class FirebaseBindingSingleton {
    
    private static FirebaseBindingSingleton INSTANCE;
    private static String FIREBASE_DATABASE_URL;
    private static String FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION = FIREBASE_DATABASE_URL + "notifications/event";
    private static String FIREBASE_DATABASE_LINK_USER_BAN = FIREBASE_DATABASE_URL + "notifications/userban";
    private static String FIREBASE_DATABASE_LINK_USER_WARNING = FIREBASE_DATABASE_URL + "notifications/userwarning";
    
    static {
        try {
            INSTANCE = new FirebaseBindingSingleton();
        } catch (Exception ex) {
            throw new RuntimeException("Error in init the FirebaseBindingSingleton Instance");
        }
    }
    
    public static FirebaseBindingSingleton getInstance(String YOUR_FIREBASE_DATABASE_URL) {
        FIREBASE_DATABASE_URL = YOUR_FIREBASE_DATABASE_URL;
        FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION = FIREBASE_DATABASE_URL + "notifications/event";
        FIREBASE_DATABASE_LINK_USER_BAN = FIREBASE_DATABASE_URL + "notifications/userban";
        FIREBASE_DATABASE_LINK_USER_WARNING = FIREBASE_DATABASE_URL + "notifications/userwarning";
        return INSTANCE;
    }
    
    private FirebaseBindingSingleton() {
    }
    
    public boolean sendNotificationToUserID(String content, int userID) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException, IOException {
        
        String strUserID = Integer.toString(userID);
        System.out.println(FIREBASE_DATABASE_URL);
        Firebase firebase = new Firebase(FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION);
        
//        Map<String, Object> data = new LinkedHashMap<>();
        EventNotification eventNotification = new EventNotification(strUserID, content);
//        data.put("haha", "dcm");
        // id is null for auto-render unique ID in firebase
        
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(eventNotification);
        FirebaseResponse response = firebase.post(json);
        return response.getSuccess();
    }
    
    // TEST FUNCTION FOR FIREBASE BINDING 
    // DON'T REMOVE
    public FirebaseResponse getFirebaseDataJson(String filebaseLink) throws FirebaseException, JsonParseException, JsonMappingException, IOException, JacksonUtilityException {

        Firebase firebase = new Firebase(FIREBASE_DATABASE_URL);

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

//    public boolean addAllNotification(Map<String, Object> dataMap) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException {
//
//        Firebase firebase = new Firebase(FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION);
//        
//        FirebaseResponse response = firebase.put(dataMap);
//        
//        return response.getSuccess();
//    }
//    
//    public boolean addOneNotification(NotificationDTO dto ) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException {
//        
//        Firebase firebase = new Firebase(FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION);
//        
//        Map<String, Object> data = new HashMap<>();
//        data.put( Integer.toString(dto.getId()), dto);
//        FirebaseResponse response = firebase.post(data);
//        
//        return response.getSuccess();
//    }

}
