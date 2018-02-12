/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Services.Settings : Granite.Services.Settings {
    public int window_x { get; set; }
    public int window_y { get; set; }

    public Settings () {
        base (Constants.PACKAGE_NAME);
    }
}
