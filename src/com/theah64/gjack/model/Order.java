package com.theah64.gjack.model;

/**
 * Created by theapache64 on 9/10/17.
 */
public class Order {

    private final String key, victimEmail, userEmail, sharedBy, docTitle, docUrl, content;
    private final boolean isRead;

    public Order(String key, String victimEmail, String userEmail, String sharedBy, String docTitle, String docUrl, String content, boolean isRead) {
        this.key = key;
        this.victimEmail = victimEmail;
        this.userEmail = userEmail;
        this.sharedBy = sharedBy;
        this.docTitle = docTitle;
        this.docUrl = docUrl;
        this.content = content;
        this.isRead = isRead;
    }

    public boolean isRead() {
        return isRead;
    }

    public String getKey() {
        return key;
    }

    public String getVictimEmail() {
        return victimEmail;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getSharedBy() {
        return sharedBy;
    }

    public String getDocTitle() {
        return docTitle;
    }

    public String getDocUrl() {
        return docUrl;
    }


    public String getContent() {
        return content;
    }
}
