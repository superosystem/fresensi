/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package factory;

import buttons.Button;
import buttons.HtmlButton;

/**
 *
 * @author Gusryl Mubarok <gusrylmubarok@gmail.com>
 */
public class HtmlDialog extends  Dialog {
    @Override
    public Button createButton() {
        return new HtmlButton();
    }
}
