/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import factory.Dialog;
import factory.HtmlDialog;
import factory.WindowDialog;

/**
 *
 * @author Gusryl Mubarok <gusrylmubarok@gmail.com>
 */
public class Demo {
    public static Dialog dialog;
    
    public static void main(String[] args) {
        configure();
        runBusinessLogic();
    }
    
    static void configure() {
        if (System.getProperty("os.name").equals("Windows 10")) {
            dialog = new WindowDialog();
        } else {
            dialog = new HtmlDialog();
        }
    }
    
     static void runBusinessLogic() {
        dialog.renderWindow();
    }
}
