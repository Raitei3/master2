using System;
using Gtk;

public class GtkPingPong {





  public static void Main() {
    Application.Init();

    //Create the Window
    Window myWin = new Window("Brave new world");
    myWin.Resize(200,200);
    HBox myBox = new HBox (false, 10);
    myWin.Add(myBox);

    // Set up a button object.
    Button ping = new Button ("Ping");
    Button pong = new Button("Pong");

    ping.Clicked += new EventHandler((obj, args) => {
        Console.WriteLine("Ping !");
        ping.Sensitive = false;
        pong.Sensitive = true;
    });

    pong.Clicked += new EventHandler((obj, args) => {
        Console.WriteLine("Pong !");
        pong.Sensitive = false;
        ping.Sensitive = true;
    });

    pong.Sensitive = false;
    myBox.Add(ping);
    myBox.Add(pong);

    //Show Everything
    myWin.ShowAll();
    Application.Run(); }
}
