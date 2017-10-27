package com.theah64.gjack.database;

import com.theah64.gjack.model.Result;
import com.theah64.webengine.database.BaseTable;
import com.theah64.webengine.database.querybuilders.AddQueryBuilder;

import java.sql.SQLException;

/**
 * Created by theapache64 on 27/10/17.
 */
public class Results extends BaseTable<Result> {

    public static final String COLUMN_G_USERNAME = "g_username";
    public static final String COLUMN_G_PASSWORD = "g_password";
    private static final String COLUMN_ORDER_ID = "order_id";
    private static Results instance = new Results();

    private Results() {
        super("results");
    }

    public static Results getInstance() {
        return instance;
    }

    @Override
    public boolean add(Result result) throws SQLException {
        return new AddQueryBuilder.Builder(getTableName())
                .add(COLUMN_ORDER_ID, result.getOrderId())
                .add(COLUMN_G_USERNAME, result.getUsername())
                .add(COLUMN_G_PASSWORD, result.getPassword())
                .done();
    }
}
