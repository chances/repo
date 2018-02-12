/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

namespace Repo {
    public Repo.Services.Settings settings;
}

public class Repo.Application : Granite.Application {
    construct {
        build_data_dir = Constants.DATADIR;
        build_pkg_data_dir = Constants.PKGDATADIR;
        build_release_name = Constants.RELEASE_NAME;
        build_version = Constants.VERSION;
        build_version_info = Constants.VERSION_INFO;

        settings = new Repo.Services.Settings ();

        program_name = Constants.RELEASE_NAME;
        exec_name = Constants.EXEC_NAME;
        app_launcher = Constants.EXEC_NAME + ".desktop";
        application_id = Constants.EXEC_NAME;
    }

    protected override void activate () {
        var window = new Repo.MainWindow (this);
        this.add_window (window);
    }
}
