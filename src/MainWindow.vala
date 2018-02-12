/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.MainWindow : Gtk.ApplicationWindow {
    private Repo.Application app;

    public Repo.Services.Repositories repositories;
    public Repo.Widgets.HeaderBar headerbar;

    public bool edited { get; set; default = false; }
    public bool confirmed { get; set; default = false; }

    public MainWindow (Repo.Application app) {
        Object (application: app,
                resizable: false,
                width_request: 500,
                height_request: 200);

        this.app = app;
    }

    construct {
        repositories = new Repo.Services.Repositories ();
        headerbar = new Repo.Widgets.HeaderBar ();

        window_position = Gtk.WindowPosition.CENTER;

        move (settings.window_x, settings.window_y);

        build_ui ();

        show_app ();
    }

    private void build_ui () {
        //  Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = settings.dark_theme;

        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("/com/github/chances/repo/stylesheet.css");
        
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        set_titlebar (headerbar);

        set_border_width (0);



        state_changed.connect (() => {
            save_position ();
        });
    }

    public void show_app () {
        show_all ();
        show ();
        present ();
    }

    public void save_position () {
        int x, y;
        this.get_position (out x, out y);
        settings.window_x = x;
        settings.window_y = y;
        settings.save ();
    }
}
