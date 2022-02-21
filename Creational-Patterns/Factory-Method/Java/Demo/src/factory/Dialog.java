/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package factory;

import buttons.Button;

/**
 *
 * @author Gusryl Mubarok <gusrylmubarok@gmail.com>
 */
public abstract class Dialog {
    public void renderWindow() {
        Button okButton = createButton();
        okButton.render();
    }
    
    public abstract Button createButton();
}
