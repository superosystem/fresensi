package com.gusrylmubarok.designpattern.objectpool;

public class OrderService {

    public void save(String orderId) {
        Connection connection = DatabasePool.getConnection();
        connection.sql("INSERT INTO order ...");
        DatabasePool.close(connection);

    }
}
