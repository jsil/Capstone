import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

MenuBar myMenu;
Menu topButton;
MenuItem item1, item2, item3, item4, item5;


void doMenu() {
  myMenu = new MenuBar();

  //create the top level button
  topButton = new Menu("File");

  //create all the Menu Items and add the menuListener to check their state.
  item1 = new MenuItem("Red");
  item1.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      println("test");
    }
  }
  );

  item2 = new MenuItem("Green");
  item2.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      println("test");
    }
  }
  );
  
  

  //add the items to the top level Button
  topButton.add(item1);
  topButton.add(item2);


  //add the button to the menu
  myMenu.add(topButton);

  //add the menu to the frame!
  frame.setMenuBar(myMenu);
}

