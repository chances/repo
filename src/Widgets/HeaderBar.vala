/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Widgets.HeaderBar : Gtk.HeaderBar {
    public signal void add_repo_clicked ();

    public HeaderBar () {
        Object (title: APP_NAME,
                show_close_button: true,
                has_subtitle: true);
    }

    construct {
        var add_repo = new Gtk.Button.from_icon_name ("list-add", Gtk.IconSize.LARGE_TOOLBAR);
        add_repo.tooltip_text = _("Add Software Repository");
		add_repo.clicked.connect (() => {
            add_repo_clicked ();
        });

		pack_start (add_repo);
    }
}
