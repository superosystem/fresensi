package com.gusrylmubarok.designpattern.singleton;

public class OrderDetailService {
    public void save(String orderId, String product) {
        DatabaseHelper.getConnection().sql("INSERT INTO order ...");
    }
}