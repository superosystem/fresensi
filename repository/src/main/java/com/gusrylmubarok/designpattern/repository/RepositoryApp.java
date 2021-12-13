package com.gusrylmubarok.designpattern.repository;

public class RepositoryApp {

    public static void main(String[] args) {
        Product product = new Product();
        product.setId("1");
        product.setName("Contoh 1");
        product.setPrice(1000);

        DatabasePool.getConnection().sql("INSERT INTO products(id, name, price) values (?, ?, ?)",
            product.getId(), product.getName(), product.getPrice());

        DatabasePool.getConnection().sql("UPDATE products set name = ?, price= ? WHERE id = ?",
                product.getName(), product.getPrice(), product.getId());
    }

}
