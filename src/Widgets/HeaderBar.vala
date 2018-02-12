/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Widgets.HeaderBar : Gtk.Box {
    private Gtk.HeaderBar headerbar;

    public HeaderBar () {
        Object (orientation: Gtk.Orientation.VERTICAL);
    }

    construct {
        headerbar = new Gtk.HeaderBar ();

        headerbar.set_title (APP_NAME);
        headerbar.set_show_close_button (true);

        pack_start (headerbar, true, true, 0);
    }
}
