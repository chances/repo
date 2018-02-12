/*
* Copyright (c) 2018 Chance Snow (https://chancesnow.me)
*
* See LICENSE file for full license terms.
*
* Chance Snow <hello@chancesnow.me>
*/

public const string APP_NAME = Constants.RELEASE_NAME;

public static int main (string[] args) {
    Environment.set_application_name (APP_NAME);
    Environment.set_prgname (Constants.TERMINAL_NAME);

    var application = new Repo.Application ();

    return application.run (args);
}
