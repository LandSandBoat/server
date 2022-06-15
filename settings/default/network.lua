-----------------------------------
-- NETWORK SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with networking between the database, client, and server executables.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.network =
{
    SQL_HOST     = "127.0.0.1",
    SQL_PORT     = 3306,
    SQL_LOGIN    = "root",
    SQL_PASSWORD = "root",
    SQL_DATABASE = "xidb",

    LOGIN_DATA_IP   = "127.0.0.1",
    LOGIN_DATA_PORT = 54230,
    LOGIN_VIEW_IP   = "127.0.0.1",
    LOGIN_VIEW_PORT = 54001,
    LOGIN_AUTH_IP   = "127.0.0.1",
    LOGIN_AUTH_PORT = 54231,

    MAP_PORT = 54230,

    SEARCH_PORT = 54002,

    -- Central message server settings (ensure these are the same on both all map servers and the central (lobby) server
    ZMQ_IP   = "127.0.0.1",
    ZMQ_PORT = 54003,
}
