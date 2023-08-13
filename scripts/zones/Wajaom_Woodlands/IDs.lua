-----------------------------------
-- Area: Wajaom_Woodlands
-----------------------------------
zones = zones or {}

zones[xi.zone.WAJAOM_WOODLANDS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        DIG_THROW_AWAY                = 7070, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7072, -- You dig and you dig, but find nothing.
        PLACE_HYDROGAUGE              = 7350, -- You set the <item> in the glowing trench.
        ENIGMATIC_LIGHT               = 7351, -- The <item> is giving off an enigmatic light.
        LEYPOINT                      = 7406, -- An eerie red glow emanates from this stone platform. The surrounding air feels alive with energy...
        HARVESTING_IS_POSSIBLE_HERE   = 7414, -- Harvesting is possible here if you have <item>.
        GIWAHB_WATCHTOWER_LOCKED      = 7988, -- The door is locked...
        INCREASED_STANDING            = 7989, -- Your Imperial Standing has increased!
        HEADY_FRAGRANCE               = 8493, -- The heady fragrance of wine pervades the air...
        BROKEN_SHARDS                 = 8495, -- Broken shards of insect wing are scattered all over...
        PAMAMA_PEELS                  = 8497, -- Piles of pamama peels litter the ground...
        DRAWS_NEAR                    = 8523, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9641, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 9705, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
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
        HARVESTING = GetTableOfIDs('Harvesting_Point'),
    },
}

return zones[xi.zone.WAJAOM_WOODLANDS]
