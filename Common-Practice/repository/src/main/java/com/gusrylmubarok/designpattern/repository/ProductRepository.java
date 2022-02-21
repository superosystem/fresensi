package com.gusrylmubarok.designpattern.repository;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository {


    public void insert(Product product) {
        DatabasePool.getConnection().sql("INSERT INTO products(id, name, price) values (?, ?, ?)",
                product.getId(), product.getName(), product.getPrice());
    }

    public void update(Product product) {
        DatabasePool.getConnection().sql("UPDATE products set name = ?, price= ? WHERE id = ?",
                product.getName(), product.getPrice(), product.getId());
    }

    public void delete(String id) {
        DatabasePool.getConnection().sql("DELETE products WHERE id = ?", id);
    }

    public List<Product> selectAll() {
        List<Object []> select = DatabasePool.getConnection().select("SELECT * FROM products");
        List<Product> products = new ArrayList<Product>();
        for (Object[] objects : select) {
            Product product = new Product();
            product.setId((String) objects[0]);
            product.setName((String) objects[0]);
            product.setPrice((Integer) objects[0]);
            products.add(product);
        }
        return products;
    }

}
