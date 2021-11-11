/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.email;

import fptu.swp.entity.user.UserDTO;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author triet
 */
public class EmailSender {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(EmailSender.class);

    public static boolean sendEmail(UserDTO sender, UserDTO receiver, String subject, String message, String password) throws AddressException, MessagingException {
        boolean check = false;
        String fullName = receiver.getName();
        String phoneNum = receiver.getPhoneNum();

        String to = receiver.getEmail();
        String from = sender.getEmail();
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");

 //           Session session = Session.getDefaultInstance(properties);
  //           creates a new session with an authenticator
                Authenticator auth = new Authenticator() {
                    public PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                };

                Session session = Session.getInstance(properties, auth);
            // creates a new e-mail message
            MimeMessage msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(from));
            InternetAddress[] toAddresses = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setSubject(subject, "utf-8");
            msg.setText(message,"utf-8");

            Transport.send(msg);

            check = true;
        } catch (Exception ex) {
            LOGGER.error("Error when sending email: " + ex);
        } finally {
            return check;
        }

    }
}
