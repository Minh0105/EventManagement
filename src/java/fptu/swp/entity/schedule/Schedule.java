/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.schedule;

import fptu.swp.entity.event.EventDAO;
import fptu.swp.entity.user.UserDAO;
import fptu.swp.utils.firebaseBinding.firebase4j.demo.FirebaseBindingSingleton;
import fptu.swp.utils.firebaseBinding.firebase4j.error.FirebaseException;
import fptu.swp.utils.firebaseBinding.firebase4j.error.JacksonUtilityException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author triet
 */
public class Schedule {

    private static ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(Schedule.class);

    public static void initializeScheduler() {
        try {

            ScheduleDAO dao = new ScheduleDAO();
            List<ScheduleDTO> listTimingNoti = dao.getListTimingNoti();
            List<ScheduleDTO> listTimingFinish = dao.getListTimingFinish();

            UserDAO userDao = new UserDAO();
            EventDAO eventDao = new EventDAO();

            String linkToFirebase = "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/";
            FirebaseBindingSingleton firebase = FirebaseBindingSingleton.getInstance(linkToFirebase);
            Date now = new Date();
            System.out.println(listTimingNoti);
            if (listTimingNoti != null) {
                for (ScheduleDTO s : listTimingNoti) {
                    System.out.println(s.toString());
                    //Date halfMinBeforeNow = new Date(System.currentTimeMillis() - 30 * 1000); //CAI NAY DE TEST

                    Date oneHourAfterNow = new Date(System.currentTimeMillis() - 3600 * 1000);

                    //long remainingTime = now.getTime() - halfMinBeforeNow.getTime();  //CAI NAY DE TEST
                    long remainingTime = s.getRunningTime().getTime() - oneHourAfterNow.getTime(); //Con 1 gio nua bat dau su kien
                    if (remainingTime >= 0) {
                        System.out.println("Gui noti event: " + s.getEventName() + " sau: " + remainingTime + " miliseconds");
                        scheduler.schedule(()
                                -> {
                            try {
                                List<Integer> listUserId = userDao.getFollowersIdByEventId(s.getEventId());
                                //System.out.println(s.getEventId() + " - User ID da quan tam: " + listUserId.toString());
                                for (int userId : listUserId) {
                                    //push len firebase (s.getEventId, s.getOrganizerAvatar, s.getEVentName, userId, message "Con 1 tieng nua su kien..... bat dau")
                                    s.setUserId(userId);
                                    s.setMessage("Còn 1 giờ nữa là bắt đầu " + s.getEventName());
                                    System.out.println("Send noti of EventId: " + s.getEventId() + " is " + firebase.sendNotificationToUserID(s));
                                }
                            } catch (FirebaseException ex) {
                                LOGGER.error(ex);
                            } catch (JacksonUtilityException ex) {
                                LOGGER.error(ex);
                            } catch (Exception ex) {
                                LOGGER.error(ex);
                            }
                        }, remainingTime, TimeUnit.MILLISECONDS);
                    }

                }
            }
            if (listTimingFinish != null) {
                for (ScheduleDTO s : listTimingFinish) {
                    System.out.println(s.toString());
                    //Date halfMinBeforeNow = new Date(System.currentTimeMillis() - 30 * 1000); //CAI NAY DE TEST
                    //Date oneHourAfterNow = new Date(System.currentTimeMillis() - 3600 * 1000);
                    //long remainingTime = now.getTime() - halfMinBeforeNow.getTime();  //CAI NAY DE TEST
                    long remainingTime = s.getRunningTime().getTime() - now.getTime(); //Con 1 gio nua bat dau su kien
                    System.out.println("Event ket thuc sau: " + remainingTime + " miliseconds");
                    scheduler.schedule(()
                            -> {
                        try {
                            eventDao.updateEventStatus(s.getEventId(), 3);

                        } catch (Exception ex) {
                            //Chua biet ghi gi hmu
                        }
                    }, remainingTime, TimeUnit.MILLISECONDS);
                }
            }

        } catch (Exception ex) {
            //Chua biet ghi gi hmu
        }
    }

    public static void updateSchedule() {
        scheduler.shutdown();
        scheduler = Executors.newScheduledThreadPool(1);
        initializeScheduler();
    }

    public static void shutdownSchedule() {
        scheduler.shutdown();
    }

}
