package com.theah64.gjack.model;

/**
 * Created by theapache64 on 27/10/17.
 */
public class Result {
    private final String id, orderId, username, password;

    public Result(String id, String orderId, String username, String password) {
        this.id = id;
        this.orderId = orderId;
        this.username = username;
        this.password = password;
    }

    public String getId() {
        return id;
    }

    public String getOrderId() {
        return orderId;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}
