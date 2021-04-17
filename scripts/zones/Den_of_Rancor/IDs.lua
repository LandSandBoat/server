-----------------------------------
-- Area: Den_of_Rancor
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DEN_OF_RANCOR] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389,  -- Obtained: <item>.
        GIL_OBTAINED             = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7050,  -- Tallying conquest results...
        LANTERN_OFFSET           = 7209,  -- The grating will not budge.
        FISHING_MESSAGE_OFFSET   = 7237,  -- You can't fish here.
        CHEST_UNLOCKED           = 7345,  -- You unlock the chest!
        SENSE_OMINOUS_PRESENCE   = 7355,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM      = 7402,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7403,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7404,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7405,  -- You already possess that temporary item.
        NO_COMBINATION           = 7410,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9488,  -- New training regime registered!
        HOMEPOINT_SET            = 10538, -- Home point set!
    },
    mob =
    {
        CELESTE_EYED_TOZBERRY_PH =
        {
            [17432622] = 17432624,
        },
        FRIAR_RUSH_PH =
        {
            [17432638] = 17432640,
        },
        CARMINE_TAILED_JANBERRY_PH =
        {
            [17432661] = 17432659,
            [17432662] = 17432659,
        },
        TAWNY_FINGERED_MUGBERRY_PH =
        {
            [17432784] = 17432798,
            [17432785] = 17432798,
            [17432787] = 17432798,
            [17432788] = 17432798,
            [17432793] = 17432798,
            [17432794] = 17432798,
        },
        BISTRE_HEARTED_MALBERRY_PH =
        {
            [17432822] = 17432845,
        },
        OGAMA_PH =
        {
            [17432972] = 17432974,
            [17432978] = 17432974,
            [17432979] = 17432974,
        },
        MIMIC       = 17432583,
        HAKUTAKU    = 17433005,
        MOKUMOKUREN = 17433006,
    },
    npc =
    {
        CASKET_BASE     = 17433024,
        LANTERN_OFFSET  = 17433047,
        DROP_GATE       = 17433051,
        TREASURE_COFFER = 17433077,
    },
}

return zones[xi.zone.DEN_OF_RANCOR]
