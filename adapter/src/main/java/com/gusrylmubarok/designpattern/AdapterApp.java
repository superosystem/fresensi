package com.gusrylmubarok.designpattern;

import java.util.ArrayList;
import java.util.List;

public class AdapterApp {

    public static void main(String[] args) {
        List<CatalogAdapter> list = new ArrayList<>();

        list.add(new BookCatalogAdapter(new Book("Java", "Budi")));
        list.add(new BookCatalogAdapter(new Book("PHP", "Cecep")));
        list.add(new BookCatalogAdapter(new Book("Go", "Andi")));

        list.add(new ScreencastCatalogAdapter(new Screencast("Java", "Budi", 100L)));
        list.add(new ScreencastCatalogAdapter(new Screencast("PHP", "Cecep", 200L)));
        list.add(new ScreencastCatalogAdapter(new Screencast("Go", "Andi", 90L)));

        list.forEach(item -> System.out.println(item.getCatalogTitle()));
    }
}
