package com.gusrylmubarok.designpattern.singleton;

public class OrderService {

    public void save(String orderId) {
        Connection connection = new Connection("localhost", "root", "root");
        connection.sql("INSERT INTO order ...");

    }
}
