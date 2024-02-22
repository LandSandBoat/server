-----------------------------------
-- SEARCH SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with /sea, searching, and the auction house.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.search =
{
    -- Omit items with no listing history from auction house results
    OMIT_NO_HISTORY = false,

    -- After EXPIRE_DAYS, will listed auctions expire?
    EXPIRE_AUCTIONS = true,

    -- Expire items older than this number of days
    EXPIRE_DAYS = 3,

    -- Interval is in seconds, default is one hour
    EXPIRE_INTERVAL = 3600,

    -- IP address strings in this list won't be subject to 'IPAddressesInUse' rate limiting
    ACCESS_WHITELIST =
    {
        "127.0.0.1",   -- Example, not actually needed
        "192.168.0.1", -- Example, not actually needed
    },
}
