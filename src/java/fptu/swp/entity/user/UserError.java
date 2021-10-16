/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.user;

import java.io.Serializable;

/**
 *
 * @author triet
 */
public class UserError implements Serializable {
    private String nameError;
    private String phoneNumError;
    private String addressError;
    private String descriptionError;

    public UserError() {
    }

    public UserError(String nameError, String phoneNumError, String addressError, String descriptionError) {
        this.nameError = nameError;
        this.phoneNumError = phoneNumError;
        this.addressError = addressError;
        this.descriptionError = descriptionError;
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

    public String getDescriptionError() {
        return descriptionError;
    }

    public void setDescriptionError(String descriptionError) {
        this.descriptionError = descriptionError;
    }
    
}
