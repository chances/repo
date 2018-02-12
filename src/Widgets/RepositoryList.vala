/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Widgets.RepositoryList : Gtk.Box {
    private Gtk.ListBox list;

    public RepositoryList () {
        Object (orientation: Gtk.Orientation.VERTICAL,
                vexpand: true);
    }

    construct {
        list = new Gtk.ListBox ();
        list.vexpand = true;
        list.selection_mode = Gtk.SelectionMode.NONE;

        add (list);
    }
}
