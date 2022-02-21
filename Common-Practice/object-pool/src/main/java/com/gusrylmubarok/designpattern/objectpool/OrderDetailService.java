package com.gusrylmubarok.designpattern.objectpool;

public class OrderDetailService {
    public void save(String orderId, String product) {
        Connection connection = DatabasePool.getConnection();
        connection.sql("INSERT INTO order ...");
        DatabasePool.close(connection);
    }
}
