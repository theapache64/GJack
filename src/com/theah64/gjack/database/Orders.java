package com.theah64.gjack.database;

import com.theah64.gjack.model.Order;
import com.theah64.webengine.database.BaseTable;

/**
 * Created by theapache64 on 9/10/17.
 */
public class Orders extends BaseTable<Order> {

    private static final Orders instance = new Orders();
    public static final String COLUMN_VICTIM_EMAIL = "victim_email";
    public static final String COLUMN_USER_EMAIL = "user_email";
    public static final String COLUMN_SHARED_BY = "shared_by";
    public static final String COLUMN_DOC_TITLE = "doc_title";
    public static final String COLUMN_DOC_URL = "doc_url";

    public static final String DEFAULT_SHARED_BY = "John";
    public static final String DEFAULT_DOC_TITLE = "Report";
    public static final String DEFAULT_DOC_URL = "https://docs.google.com/spreadsheets/d/1shEpADXr7CTQMXEF9TE-xydAbmG3EfpRqCmMhYgBuQY/edit?usp=sharing";
    public static final java.lang.String KEY_SENDER_GMAIL_USERNAME = "sender_gmail_username";
    public static final java.lang.String KEY_SENDER_GMAIL_PASSWORD = "sender_gmail_password";

    private Orders() {
        super("orders");
    }

    public static Orders getInstance() {
        return instance;
    }

}
