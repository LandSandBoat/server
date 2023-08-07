-----------------------------------
-- Area: Bostaunieux_Oubliette
-----------------------------------
zones = zones or {}

zones[xi.zone.BOSTAUNIEUX_OUBLIETTE] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7219,  -- You can't fish here.
        CHUMIA_DIALOG                 = 7319,  -- Welcome to Bostaunieux Oubliette...
        SEEMS_LOCKED                  = 7321,  -- It seems to be locked.
        SPIRAL_HELL_LEARNED           = 7428,  -- You have learned the weapon skill Spiral Hell!
        SENSE_OMINOUS_PRESENCE        = 7429,  -- You sense an ominous presence...
        ITEMS_ITEMS_LA_LA             = 7432,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7438,  -- The Goblin slipped away when you were not looking...
        REGIME_REGISTERED             = 9543,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10595, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10596, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10597, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10598, -- You already possess that temporary item.
        NO_COMBINATION                = 10603, -- You were unable to enter a combination.
        LEARNS_SPELL                  = 10627, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 10629, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 10636, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 10700, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        SEWER_SYRUP_PH          =
        {
            [17461305] = 17461307, -- -19.000 1.000 -173.000
            [17461306] = 17461307, -- -20.000 1.000 -148.000
        },
        SHII_PH                 =
        {
            [17461311] = 17461315, -- -59.000 0.941 -149.000
            [17461334] = 17461315, -- -64.000 -0.500 -144.000
            [17461277] = 17461315, -- -65.000 -1.000 -137.000
            [17461309] = 17461315, -- -64.000 0.950 -132.000
            [17461312] = 17461315, -- -53.000 -0.500 -137.000
            [17461308] = 17461315, -- -57.000 0.998 -135.000
        },
        ARIOCH_PH               =
        {
            [17461322] = 17461433, -- -259 0.489 -188
        },
        MANES_PH                =
        {
            [17461469] = 17461471,
            [17461470] = 17461471,
            [17461476] = 17461471,
            [17461477] = 17461471,
        },
        DREXERION_THE_CONDEMNED = 17461338,
        PHANDURON_THE_CONDEMNED = 17461343,
        BLOODSUCKER             = 17461478,
        BODACH                  = 17461479,
        MANES                   = 17461471,
        SHII                    = 17461315,
    },
    npc =
    {
    },
}

return zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
