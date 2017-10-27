package com.theah64.gjack.database;

import com.theah64.gjack.model.Order;
import com.theah64.webengine.database.BaseTable;
import com.theah64.webengine.database.querybuilders.AddQueryBuilder;
import com.theah64.webengine.database.querybuilders.QueryBuilderException;
import com.theah64.webengine.database.querybuilders.SelectQueryBuilder;

import java.sql.SQLException;

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
    public static final String COLUMN_KEY = "_key";
    private static final String COLUMN_CONTENT = "content";
    private static final String COLUMN_IS_READ = "is_read";

    private Orders() {
        super("orders");
    }

    public static Orders getInstance() {
        return instance;
    }

    /**
     * String key, victimEmail, userEmail, sharedBy, docTitle, docUrl, content;
     * boolean isRead;
     *
     * @return
     * @throws SQLException
     */
    @Override
    public boolean add(Order order) throws SQLException {
        return new AddQueryBuilder.Builder(getTableName())
                .add(COLUMN_KEY, order.getKey())
                .add(COLUMN_VICTIM_EMAIL, order.getVictimEmail())
                .add(COLUMN_USER_EMAIL, order.getUserEmail())
                .add(COLUMN_SHARED_BY, order.getSharedBy())
                .add(COLUMN_DOC_TITLE, order.getDocTitle())
                .add(COLUMN_DOC_URL, order.getDocUrl())
                .add(COLUMN_CONTENT, order.getContent())
                .done();
    }


    /**
     * id, _key, victim_email, user_email, shared_by, doc_title,doc_url, is_read, content
     * String id, String key, String victimEmail, String userEmail, String sharedBy, String docTitle, String docUrl, String content, boolean isRead
     *
     * @param column
     * @param value
     * @return
     */
    @Override
    public Order get(String column, String value) {

        try {
            return new SelectQueryBuilder.Builder<>(getTableName(), rs -> new Order(
                    rs.getString(COLUMN_ID),
                    rs.getString(COLUMN_KEY),
                    rs.getString(COLUMN_VICTIM_EMAIL),
                    rs.getString(COLUMN_USER_EMAIL),
                    rs.getString(COLUMN_SHARED_BY),
                    rs.getString(COLUMN_DOC_TITLE),
                    rs.getString(COLUMN_DOC_URL),
                    rs.getString(COLUMN_CONTENT),
                    rs.getBoolean(COLUMN_IS_READ)
            ))
                    .select(new String[]{COLUMN_ID, COLUMN_KEY, COLUMN_VICTIM_EMAIL, COLUMN_IS_READ, COLUMN_USER_EMAIL, COLUMN_SHARED_BY, COLUMN_DOC_TITLE, COLUMN_DOC_URL, COLUMN_CONTENT})
                    .where(column, value)
                    .limit(1)
                    .orderBy(COLUMN_ID + " DESC")
                    .build()
                    .done();

        } catch (QueryBuilderException | SQLException e) {
            e.printStackTrace();
        }

        return null;

    }
}
