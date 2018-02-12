/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Widgets.HeaderBar : Gtk.Box {
    private Gtk.HeaderBar headerbar;
    private Gtk.Box toolbar;
    public bool toggled {
        get {
            return visible;
        } set {
            visible = value;
            no_show_all = !value;
        }
    }

    public HeaderBar () {
        Object (orientation: Gtk.Orientation.VERTICAL, toggled: true);
    }

    construct {
        headerbar = new Gtk.HeaderBar ();

        headerbar.set_title (APP_NAME);
        headerbar.set_show_close_button (true);

        pack_start (headerbar, true, true, 0);

        toolbar = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        toolbar.margin_start = 20;
        toolbar.margin_end = 20;
        toolbar.margin_top = 10;
        toolbar.margin_bottom = 20;

        var icon_mode = new Granite.Widgets.ModeButton ();
        icon_mode.append_icon ("view-grid-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.append_icon ("view-list-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.append_icon ("view-column-symbolic", Gtk.IconSize.BUTTON);

        toolbar.add (icon_mode);

        pack_start (toolbar, true, true, 0);
    }

    public void toggle () {
        toggled = !toggled;
    }
}
