-----------------------------------
-- Area: Lower_Delkfutts_Tower
-----------------------------------
zones = zones or {}

zones[xi.zone.LOWER_DELKFUTTS_TOWER] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY = 159,   -- The door is firmly shut. You might be able to open it if you had the key.
        DOOR_FIRMLY_SHUT                 = 160,   -- The door is firmly shut.
        ITEM_CANNOT_BE_OBTAINED          = 6574,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6580,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6581,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6583,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY          = 6594,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET            = 6609,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS              = 7191,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7192,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7193,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7213,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET           = 7257,  -- You can't fish here.
        SOMETHING_HUGE_BEARING_DOWN      = 7505,  -- Something huge is bearing down upon you!
        PLAYER_OBTAINS_ITEM              = 8640,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM            = 8641,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM         = 8642,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP             = 8643,  -- You already possess that temporary item.
        NO_COMBINATION                   = 8648,  -- You were unable to enter a combination.
        REGIME_REGISTERED                = 10726, -- New training regime registered!
        LEARNS_SPELL                     = 11774, -- <name> learns <spell>!
        UNCANNY_SENSATION                = 11776, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL            = 11783, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HIPPOLYTOS    = GetFirstID('Hippolytos'),
        EPIALTES      = GetFirstID('Epialtes'),
        EURYMEDON     = GetFirstID('Eurymedon'),
        DISASTER_IDOL = GetFirstID('Disaster_Idol'),
    },
    npc =
    {
        TALES_BEGINNING = GetFirstID('Tales_Beginning'), -- CoP 1-1 mission script uses this
    },
}

return zones[xi.zone.LOWER_DELKFUTTS_TOWER]
