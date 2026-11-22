/*
 * Copyright 2026 elementary, Inc. <https://elementary.io>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[DBus (name = "org.pantheon.gala.DesktopIntegration")]
public interface Keyboard.DesktopIntegration : GLib.Object {
    public signal void caps_lock_state_changed ();
    public signal void num_lock_state_changed ();

    public abstract async bool get_caps_lock_state () throws GLib.DBusError, GLib.IOError;
    public abstract async bool get_num_lock_state () throws GLib.DBusError, GLib.IOError;
}
