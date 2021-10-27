package fptu.swp.utils.firebaseBinding.firebase4j.demo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.JsonParseException;
import java.io.UnsupportedEncodingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import fptu.swp.entity.event.CommentDTO;
import fptu.swp.entity.schedule.ScheduleDTO;
import fptu.swp.utils.firebaseBinding.firebase4j.model.EventNotification;

import fptu.swp.utils.firebaseBinding.firebase4j.service.Firebase;
import java.io.IOException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import fptu.swp.utils.firebaseBinding.firebase4j.model.CommentFirebaseDTO;
import fptu.swp.utils.firebaseBinding.firebase4j.model.FirebaseResponse;
import fptu.swp.utils.firebaseBinding.firebase4j.model.ReplyFirebaseDTO;
import java.util.HashMap;
import java.util.Map;
import org.codehaus.jackson.map.JsonMappingException;

public class FirebaseBindingSingleton {

    private static FirebaseBindingSingleton INSTANCE;
    private static String FIREBASE_DATABASE_URL;
    private static String FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION = FIREBASE_DATABASE_URL + "notifications/event";
    private static String FIREBASE_DATABASE_LINK_EVENT_COMMENT = FIREBASE_DATABASE_URL + "comments";
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
        FIREBASE_DATABASE_LINK_EVENT_COMMENT = FIREBASE_DATABASE_URL + "comments";
        return INSTANCE;
    }

    private FirebaseBindingSingleton() {
    }

    public Map<String, CommentFirebaseDTO> getAllCommentAndReplyInFirebase() throws FirebaseException, UnsupportedEncodingException, JsonProcessingException, IOException {

        Firebase firebase = new Firebase(FIREBASE_DATABASE_LINK_EVENT_COMMENT);
        FirebaseResponse response = firebase.get();

        Map<String, Object> map = response.getBody();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, CommentFirebaseDTO> mapData = new HashMap<>();
        int eventId;
        for (String key : map.keySet()) {
            String jsonString = objectMapper.writeValueAsString(map.get(key));
            CommentFirebaseDTO comment = objectMapper.readValue(jsonString, CommentFirebaseDTO.class);
            eventId = comment.getEventId();
            if (comment.getReplyList() != null) {
                for (ReplyFirebaseDTO reply : comment.getReplyList().values()) {
                    reply.setEventId(eventId);
                }
            }

            mapData.put(key, comment);
        }

        return mapData;
    }

    // content is the content of message, and userID is the one who can recieved the message in notification card
    public boolean sendNotificationToUserID(ScheduleDTO dto) throws FirebaseException, JacksonUtilityException, UnsupportedEncodingException, IOException {

        System.out.println(FIREBASE_DATABASE_URL);
        Firebase firebase = new Firebase(FIREBASE_DATABASE_LINK_EVENT_NOTIFICATION);

//        Map<String, Object> data = new LinkedHashMap<>();
//        data.put("haha", "dcm");
        // id is null for auto-render unique ID in firebase
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(dto);
        FirebaseResponse response = firebase.post(json);
        return response.getSuccess();
    }

    // TEST FUNCTION FOR FIREBASE BINDING 
    // DON'T REMOVE
//    public FirebaseResponse getFirebaseDataJson(String filebaseLink) throws FirebaseException, JsonParseException, JsonMappingException, IOException, JacksonUtilityException {
//
//        Firebase firebase = new Firebase(FIREBASE_DATABASE_URL);
//
//        FirebaseResponse response = firebase.get();
//        System.out.println(response);
//
//        // alternatively, you can get a few details about the response
//        response.getSuccess(); 	// true/false if method finished successfully
//        response.getCode(); 	// http-code of method-request
//        response.getBody();	// a map of the data returned
//        response.getRawBody();	// the data returned in it's raw-form (ie: JSON)
//
//        // another alternative, you can PUT/POST your own JSON if you want
////	response = firebase.put( "PUT2", "{ 'key': 'Some value' }" );
//        return response;
//    }
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
