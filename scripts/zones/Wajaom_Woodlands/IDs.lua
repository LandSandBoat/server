-----------------------------------
-- Area: Wajaom_Woodlands
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WAJAOM_WOODLANDS] =
{
    text =
    {
        NOTHING_HAPPENS             = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET       = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET      = 7049, -- You can't fish here.
        DIG_THROW_AWAY              = 7062, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                = 7064, -- You dig and you dig, but find nothing.
        PLACE_HYDROGAUGE            = 7342, -- You set the <item> in the glowing trench.
        ENIGMATIC_LIGHT             = 7343, -- The <item> is giving off an enigmatic light.
        LEYPOINT                    = 7398, -- An eerie red glow emanates from this stone platform. The surrounding air feels alive with energy...
        HARVESTING_IS_POSSIBLE_HERE = 7406, -- Harvesting is possible here if you have <item>.
        HEAVY_FRAGRANCE             = 8485, -- The heady fragrance of wine pervades the air...
        INSECT_WINGS                = 8487, -- Broken shards of insect wing are scattered all over...
        PAMAMA_PEELS                = 8489, -- Piles of pamama peels litter the ground...
        BROKEN_SHARDS               = 8492, -- Broken shards of insect wing are scattered all over...
        DRAWS_NEAR                  = 8515, -- Something draws near!
        COMMON_SENSE_SURVIVAL       = 9633, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        JADED_JODY_PH          =
        {
            [16986376] = 16986378, -- -560 -8 -360
            [16986390] = 16986378, -- -565 -7 -324
        },
        ZORAAL_JA_S_PKUUCHA_PH =
        {
            [16986191] = 16986197, -- 181.000 -18.000 -63.000
            [16986192] = 16986197, -- 181.000 -19.000 -77.000
            [16986193] = 16986197, -- 195.000 -18.000 -95.000
            [16986194] = 16986197, -- 220.000 -19.000 -80.000
            [16986195] = 16986197, -- 219.000 -18.000 -59.000
            [16986196] = 16986197, -- 203.000 -16.000 -74.000
        },
        ZORAAL_JA_S_PKUUCHA    = 16986197,
        PERCIPIENT_ZORAAL_JA   = 16986198,
        VULPANGUE              = 16986428,
        IRIZ_IMA               = 16986429,
        GOTOH_ZHA_THE_REDOLENT = 16986430,
        TINNIN                 = 16986431,
    },
    npc =
    {
        HARVESTING =
        {
            16986725,
            16986726,
            16986727,
            16986728,
            16986729,
            16986730,
        },
    },
}

return zones[tpz.zone.WAJAOM_WOODLANDS]
