/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.user;

/**
 *
 * @author triet
 */
public class UserError {
    private String nameError;
    private String phoneNumError;
    private String addressError;

    public UserError() {
    }

    public UserError(String nameError, String phoneNumError, String addressError) {
        this.nameError = nameError;
        this.phoneNumError = phoneNumError;
        this.addressError = addressError;
    }

    public String getNameError() {
        return nameError;
    }

    public void setNameError(String nameError) {
        this.nameError = nameError;
    }

    public String getPhoneNumError() {
        return phoneNumError;
    }

    public void setPhoneNumError(String phoneNumError) {
        this.phoneNumError = phoneNumError;
    }

    public String getAddressError() {
        return addressError;
    }

    public void setAddressError(String addressError) {
        this.addressError = addressError;
    }
}
