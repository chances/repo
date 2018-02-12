/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.MainWindow : Gtk.ApplicationWindow {
    private Repo.Application app;

    public Repo.Services.Repositories repos;
    public Repo.Widgets.HeaderBar headerbar;
    public Repo.Widgets.RepositoryList repo_list;
    public Gtk.Stack stack;

    public bool edited { get; set; default = false; }
    public bool confirmed { get; set; default = false; }

    public MainWindow (Repo.Application app) {
        Object (application: app,
                resizable: false,
                width_request: 700,
                height_request: 600);

        this.app = app;
    }

    construct {
        repos = new Repo.Services.Repositories ();
        headerbar = new Repo.Widgets.HeaderBar ();
        repo_list = new Repo.Widgets.RepositoryList ();

        window_position = Gtk.WindowPosition.CENTER;

        move (settings.window_x, settings.window_y);

        build_ui ();

        show_app ();
    }

    private void build_ui () {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("/com/github/chances/repo/stylesheet.css");
        
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        set_titlebar (headerbar);

        headerbar.add_repo_clicked.connect (() => {
            message ("Clicked Add Repo button");

            repo_list.add_source ("Foo");
        });

        set_border_width (0);

        var spinner = new Gtk.Spinner ();
        spinner.active = true;
        spinner.width_request = 32;
        spinner.height_request = 32;

        var loading_label = new Gtk.Label (_("Fetching your system's software repositories…"));

        var loading = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
        loading.halign = Gtk.Align.CENTER;
        loading.valign = Gtk.Align.CENTER;
        loading.add (spinner);
        loading.add (loading_label);

        var alert_label = new Gtk.Label (_("Unable to Fetch Software Repositories"));
        alert_label.halign = Gtk.Align.CENTER;
        alert_label.valign = Gtk.Align.CENTER;

        stack = new Gtk.Stack ();
        stack.vexpand = true;
        stack.add (loading);
        stack.add_named (repo_list, "repos");
        stack.add_named (alert_label, "alert");

        add (stack);

        repos.connection_succeeded.connect (show_repos);
        repos.connection_failed.connect (show_alert);

        state_changed.connect (save_position);
    }

    public void show_app () {
        show_all ();
        show ();
        present ();

        repos.connect ();
    }

    public void show_alert () {
        stack.visible_child_name = "alert";
    }

    public void show_repos () {
        message ("Connected to Repositories DBus");
        repo_list.software_properties = repos.software_properties;
        stack.visible_child_name = "repos";
    }

    public void save_position () {
        int x, y;
        this.get_position (out x, out y);
        settings.window_x = x;
        settings.window_y = y;
        settings.save ();
    }
}
