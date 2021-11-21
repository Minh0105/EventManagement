/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.user;

import java.io.Serializable;

/**
 *
 * @author admin
 */
public class UserDTO implements Serializable, Comparable<UserDTO> {

    private int id;
    private String email;
    private String name;
    private String avatar;
    private String address;
    private String phoneNum;
    private String roleName;
    private String status;
    private String description;
    private int numOfEvent;
    private String studentCode;

    public UserDTO() {
    }

    public UserDTO(String email, String name, String phoneNum) {
        this.email = email;
        this.name = name;
        this.phoneNum = phoneNum;
    }

    public UserDTO(int id, String email, String name, String avatar, String address, String phoneNum, String roleName) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.avatar = avatar;
        this.address = address;
        this.phoneNum = phoneNum;
        this.roleName = roleName;
    }

    public UserDTO(int id, String email, String name, String avatar, String address, String phoneNum, String roleName, String status) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.avatar = avatar;
        this.address = address;
        this.phoneNum = phoneNum;
        this.roleName = roleName;
        this.status = status;
    }

    public UserDTO(int id, String email, String name, String avatar, String address, String phoneNum, String roleName, String status, String description) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.avatar = avatar;
        this.address = address;
        this.phoneNum = phoneNum;
        this.roleName = roleName;
        this.status = status;
        this.description = description;
    }

    public UserDTO(int id, String email, String name, String avatar, String address, String phoneNum, String roleName, String status, String description, int numOfEvent) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.avatar = avatar;
        this.address = address;
        this.phoneNum = phoneNum;
        this.roleName = roleName;
        this.status = status;
        this.description = description;
        this.numOfEvent = numOfEvent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNumOfEvent() {
        return numOfEvent;
    }

    public void setNumOfEvent(int numOfEvent) {
        this.numOfEvent = numOfEvent;
    }

    public String getStudentCode() {
        if ("STUDENT".equals(getRoleName())) {
            int i = getEmail().indexOf("@");
            String studentCode = "";
            while (Character.isDigit(getEmail().charAt(--i))) {
                studentCode = getEmail().charAt(i) + studentCode;
            }
            studentCode = getEmail().charAt(i--) + studentCode;
            studentCode = getEmail().charAt(i) + studentCode;
            studentCode = studentCode.toUpperCase();
            return studentCode;
        }
        return "";
    }

    @Override
    public String toString() {
        return "UserDTO{" + "id=" + id + ", email=" + email + ", name=" + name + ", avatar=" + avatar + ", address=" + address + ", phoneNum=" + phoneNum + ", roleName=" + roleName + '}';
    }

    @Override
    public int compareTo(UserDTO t) {
        return t.getNumOfEvent() - this.getNumOfEvent();
    }
}
