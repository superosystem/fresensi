package com.gusrylmubarok.designpattern.singleton;

public class OrderDetailService {
    public void save(String orderId, String product) {
        Connection connection = new Connection("localhost", "root", "root");
        connection.sql("INSERT INTO order ...");
    }
}
