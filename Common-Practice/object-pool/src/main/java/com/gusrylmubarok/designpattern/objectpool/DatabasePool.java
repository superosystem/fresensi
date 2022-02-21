package com.gusrylmubarok.designpattern.objectpool;

import java.util.List;

import java.util.ArrayList;

public class DatabasePool {

    private static List<Connection> pool = new ArrayList<Connection>();

    static 
    {
        for (int i = 0; i < 100; i++) {
            Connection connection = new Connection("localhost", "root", "root");
            pool.add(connection);
        }
    }

    public static Connection getConnection() 
    {
        if (pool.isEmpty()) {
            throw new RuntimeException("Koneksinya abis");
        }else{
            Connection connection = pool.remove(0);
            return connection;
        }
    }
    
    public static void close(Connection connection)
    {
        pool.add(connection);
    }
}
