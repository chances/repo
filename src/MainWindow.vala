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
        repositories = new Repo.Services.Repositories ();
        headerbar = new Repo.Widgets.HeaderBar ();
        repo_list = new Repo.Widgets.RepositoryList ();

        window_position = Gtk.WindowPosition.CENTER;

        move (settings.window_x, settings.window_y);

        build_ui ();

        show_app ();
    }

    private void build_ui () {
        try {
            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource ("/com/github/chances/repo/stylesheet.css");
            
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        } catch (GLib.Error e) {
            critical (e.message);
        }

        set_titlebar (headerbar);

        set_border_width (0);

        var spinner = new Gtk.Spinner ();
        spinner.active = true;
        spinner.width_request = 32;
        spinner.height_request = 32;

        var loading_label = new Gtk.Label (_("Fetching your system's PPA repositories…"));

        var loading = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        loading.halign = Gtk.Align.CENTER;
        loading.valign = Gtk.Align.CENTER;
        loading.add (spinner);
        loading.add (loading_label);

        var alert_label = new Gtk.Label (_("Unable to Get PPA Repositories"));

        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
        stack.vhomogeneous = true;
        stack.vexpand = true;
        stack.add (loading);
        stack.add_named (repo_list, "repos");
        stack.add_named (alert_label, "alert");

        add (stack);

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
