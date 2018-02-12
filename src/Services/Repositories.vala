/*
 * Copyright (c) 2018 Chance Snow (https://chancesnow.me)
 *
 * See LICENSE file for full license terms.
 *
 * Chance Snow <hello@chancesnow.me>
*/

public class Repo.Services.Repositories : GLib.Object {
    public signal void connection_succeeded ();
    public signal void connection_failed (string reason);

    public SoftwareProperties software_properties { get; private set; }
    public bool connected {
        get { return software_properties != null; }
        private set {}
    }

    public Repositories() {
        software_properties = null;
        connected = false;
    }

    public new void connect () {
        try {
            software_properties = Bus.get_proxy_sync (BusType.SYSTEM, "com.ubuntu.SoftwareProperties", "/");
            connected = true;
            connection_succeeded ();
        } catch (IOError e) {
            connection_failed (e.message);
            error (e.message);
        }
    }
}

/**
 * Data source for software properties: https://launchpad.net/ubuntu/+source/software-properties
 * 
 * software-properties-common package
 * 
 * usr/lib/software-properties
 * 
 * software-properties-dbus
 * usr/share/dbus-1/system-services/com.ubuntu.SoftwareProperties.service
 */

[DBus (name = "com.ubuntu.SoftwareProperties")]
public interface Repo.Services.SoftwareProperties : GLib.Object {
    [DBus (name = "SourcesListModified")]
    public signal void sources_modified ();

    [DBus (name = "AddSourceFromLine")]
    public abstract void add_source_from_line(string sourceLine) throws IOError;

    [DBus (name = "RemoveSource")]
    public abstract void remove_source(string source) throws IOError;

    [DBus (name = "ToggleSourceUse")]
    public abstract void toggle_source_use(string source) throws IOError;
}
