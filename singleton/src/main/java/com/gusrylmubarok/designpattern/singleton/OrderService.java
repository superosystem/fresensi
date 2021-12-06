package com.gusrylmubarok.designpattern.singleton;

public class OrderService {

    public void save(String orderId) {
        DatabaseHelper.getConnection().sql("INSERT INTO order ...");

    }
}
