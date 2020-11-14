-----------------------------------
-- Area: Bostaunieux_Oubliette
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BOSTAUNIEUX_OUBLIETTE] =
{
    text =
    {
        CONQUEST_BASE            = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED  = 6541,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6547,  -- Obtained: <item>.
        GIL_OBTAINED             = 6548,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6550,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6561,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6576,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7158, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 7059, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 7060, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET   = 7208,  -- You can't fish here.
        CHUMIA_DIALOG            = 7308,  -- Welcome to Bostaunieux Oubliette...
        SEEMS_LOCKED             = 7310,  -- It seems to be locked.
        SPIRAL_HELL_LEARNED      = 7417,  -- You have learned the weapon skill Spiral Hell!
        SENSE_OMINOUS_PRESENCE   = 7418,  -- You sense an ominous presence...
        ITEMS_ITEMS_LA_LA        = 7421,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY      = 7427,  -- The Goblin slipped away when you were not looking...
        REGIME_REGISTERED        = 9532,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 10625, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        PLAYER_OBTAINS_ITEM      = 10584, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 10585, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 10586, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 10587, -- You already possess that temporary item.
        NO_COMBINATION           = 10592, -- You were unable to enter a combination.
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
    },
    npc =
    {
        CASKET_BASE = 17461487,
    },
}

return zones[tpz.zone.BOSTAUNIEUX_OUBLIETTE]
