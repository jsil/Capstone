import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

MenuBar myMenu;
Menu topButton;
MenuItem item1, item2, item3, item4, item5;


void doMenu() {
  myMenu = new MenuBar();

  //create the top level button
  topButton = new Menu("Mode");

  //create all the Menu Items and add the menuListener to check their state.
  MenuShortcut ms1 = new MenuShortcut(KeyEvent.VK_2, false);
  
  item1 = new MenuItem("This/That");
  item1.setShortcut(ms1);
  item1.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      loadGameMode(1);
    }
  }
  );
  
  MenuShortcut ms2 = new MenuShortcut(KeyEvent.VK_3, false);

  item2 = new MenuItem("Debug");
  item2.setShortcut(ms2);
  item2.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      loadGameMode(2);
    }
  }
  );
  
  MenuShortcut ms3 = new MenuShortcut(KeyEvent.VK_1, false);
  
  item3 = new MenuItem("Menu");
  item3.setShortcut(ms3);
  item3.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      loadGameMode(0);
    }
  }
  );
  
  

  //add the items to the top level Button
  topButton.add(item3);
  topButton.add(item1);
  topButton.add(item2);


  //add the button to the menu
  myMenu.add(topButton);

  //add the menu to the frame!
  frame.setMenuBar(myMenu);
}

