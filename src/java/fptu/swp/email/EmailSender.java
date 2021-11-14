/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.email;

import com.sun.mail.imap.IMAPSSLStore;
import com.sun.mail.smtp.SMTPTransport;
import com.sun.mail.util.BASE64EncoderStream;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import fptu.swp.entity.user.UserDTO;
//import java.util.Properties;
import javax.mail.Authenticator;
//import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.URLName;
import javax.mail.internet.AddressException;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;

/**
 *
 * @author triet
 */
public class EmailSender {

    static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(EmailSender.class);
//    
//        public static boolean sendEmail(UserDTO sender, UserDTO receiver, String subject, String message, String accessToken) throws AddressException, MessagingException {
//        boolean check = false;
//        String fullName = receiver.getName();
//        String phoneNum = receiver.getPhoneNum();
//
//        String to = receiver.getEmail();
//        String from = sender.getEmail();
//        try {
//            Properties properties = new Properties();
////            properties.put("mail.smtp.host", "smtp.gmail.com");
////            properties.put("mail.smtp.port", "587");
////            properties.put("mail.smtp.auth", "true");
////            properties.put("mail.smtp.starttls.enable", "true");
////            properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//
//            properties.put("mail.imap.ssl.enable", "true"); // required for Gmail
//            properties.put("mail.imap.auth.mechanisms", "XOAUTH2");
//            Session session = Session.getInstance(properties);
//            Store store = session.getStore("imap");
//            store.connect("imap.gmail.com", from, accessToken);
//            //           Session session = Session.getDefaultInstance(properties);
//            //           creates a new session with an authenticator
////            Authenticator auth = new Authenticator() {
////                public PasswordAuthentication getPasswordAuthentication() {
////                    return new PasswordAuthentication(from, password);
////                }
////            };
//
//            //Session session = Session.getInstance(properties, auth);
//            // creates a new e-mail message
//            MimeMessage msg = new MimeMessage(session);
//
//            msg.setFrom(new InternetAddress(from));
//            InternetAddress[] toAddresses = {new InternetAddress(to)};
//            msg.setRecipients(Message.RecipientType.TO, toAddresses);
//            msg.setSubject(subject, "utf-8");
//            msg.setText(message, "utf-8");
//
//            Transport.send(msg);
//
//            check = true;
//        } catch (Exception ex) {
//            LOGGER.error("Error when sending email: " + ex);
//        } finally {
//            return check;
//        }
//
//    }

    public static boolean sendEmail(String senderName, UserDTO sender, UserDTO receiver, String subject, String message, String accessToken) throws AddressException, MessagingException {
        boolean check = false;
        String fullName = receiver.getName();
        String phoneNum = receiver.getPhoneNum();

        String to = receiver.getEmail();
        String from = sender.getEmail();
        try {

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.enable", "true"); // required for Gmail
            props.put("mail.smtp.auth.mechanisms", "XOAUTH2");

            props.put("mail.smtp.socketFactory.fallback", "true"); // Should be true
//             Authenticator auth = new Authenticator() {
//                public PasswordAuthentication getPasswordAuthentication() {
//                    return new PasswordAuthentication(from, "fptu eventmanager");
//                }
//            };
//             Session session = Session.getInstance(props);
            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(sender.getEmail(), accessToken);
                }
            });
            session.setDebug(true);

            final String emptyPassword = "";

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", sender.getEmail(), accessToken);

            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] toAddresses = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setSubject(subject, "utf-8");
            msg.setText(message, "utf-8");

            transport.send(msg, msg.getAllRecipients());

            check = true;
        } catch (Exception ex) {
            LOGGER.error("Error when sending email: " + ex);
        } finally {
            return check;
        }

    }

    public static boolean sendMail(String smtpServerHost, String smtpServerPort, String smtpUserName, String smtpUserAccessToken, String fromUserEmail, String fromUserFullName, String toEmail, String subject, String body) {
        boolean check = false;
        try {
//            Properties props = System.getProperties();
//            props.put("mail.transport.protocol", "smtp");
//            props.put("mail.smtp.port", smtpServerPort);
//            props.put("mail.smtp.starttls.enable", "true");
//
//            Session session = Session.getInstance(props);
//            session.setDebug(true);

            OAuth2Authenticator.initialize();
            //SMTPTransport transport = OAuth2Authenticator.connectToSmtp(smtpServerHost, 587, fromUserEmail, smtpUserAccessToken, true);
            Properties props = new Properties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.sasl.enable", "true");
            props.put("mail.smtp.sasl.mechanisms", "XOAUTH2");
            props.put(OAuth2SaslClientFactory.OAUTH_TOKEN_PROP, smtpUserAccessToken);
            Session session = Session.getInstance(props);
            session.setDebug(true);

            int port = Integer.parseInt(smtpServerPort);
            
            final URLName unusedUrlName = null;
            SMTPTransport transport = new SMTPTransport(session, unusedUrlName);
            // If the password is non-null, SMTP tries to do AUTH LOGIN.
            final String emptyPassword = "";
            transport.connect(smtpServerHost, port, fromUserEmail, emptyPassword);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromUserEmail, fromUserFullName));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject(subject,"utf-8");
            msg.setContent(body, "text/html; charset=UTF-8");
//
//            //SMTPTransport transport = OAuth2Authenticator.connectToSmtp(smtpServerHost, Integer.parseInt(smtpServerPort), fromUserEmail, smtpUserAccessToken, true);
//            //transport.connect(smtpServerHost, smtpUserName, null);
//            //transport.issueCommand("AUTH XOAUTH2 " + new String(BASE64EncoderStream.encode(String.format("user=%s\1auth=Bearer %s\1\1", smtpUserName, smtpUserAccessToken).getBytes())), 235);
            transport.sendMessage(msg, msg.getAllRecipients());
            check = true;
        } catch (Exception ex) {
            LOGGER.error(ex);
        }
        return check;
    }

}
