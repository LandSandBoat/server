-----------------------------------
-- Area: Uleguerand_Range
-----------------------------------
zones = zones or {}

zones[xi.zone.ULEGUERAND_RANGE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6397, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6403, -- Obtained: <item>.
        GIL_OBTAINED                  = 6404, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6406, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6417, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6432, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7014, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7015, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7016, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7036, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        SOMETHING_GLITTERING          = 7344, -- You see something glittering beneath the surface of the ice.
        WHAT_LIES_BENEATH             = 7345, -- There are many cold <item> scattered around the area. Could someone be trying to melt the ice to retrieve what lies beneath?
        SOMETHING_GLITTERING_BUT      = 7346, -- You see something glittering below the surface here, but the ice encases it completely.
        HOMEPOINT_SET                 = 8338, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8396, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        SKVADER_PH =
        {
            [16797769] = 16797770,
        },
        MAGNOTAUR_PH =
        {
            [16797966] = 16797968,
            [16797967] = 16797968,
        },
        BONNACON_PH =
        {
            [16798050] = 16798056, -- -623.154 -40.604 -51.621
            [16798051] = 16798056, -- -587.026 -40.994 -22.551
            [16798052] = 16798056, -- -513.416 -40.490 -43.706
            [16798053] = 16798056, -- -553.844 -38.958 -53.864
            [16798054] = 16798056, -- -631.268 -40.257 0.709
            [16798055] = 16798056, -- -513.999 -40.541 -34.928
        },
        JORMUNGAND  = 16797969,
        GEUSH_URVAN = 16798078,
        WHITE_CONEY = 16798079,
        BLACK_CONEY = 16798080,
    },
    npc =
    {
        WATERFALL = 16798112,
        RABBIT_FOOTPRINT = 16798100,
    },
}

return zones[xi.zone.ULEGUERAND_RANGE]
