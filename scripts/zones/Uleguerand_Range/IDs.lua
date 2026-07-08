-----------------------------------
-- Area: Uleguerand_Range
-----------------------------------
zones = zones or {}

zones[xi.zone.ULEGUERAND_RANGE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6399, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6407, -- Obtained: <item>.
        GIL_OBTAINED                  = 6408, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6410, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6421, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6436, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7018, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7019, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7020, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7040, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7085, -- Tallying conquest results...
        SOMETHING_GLITTERING          = 7357, -- You see something glittering beneath the surface of the ice.
        WHAT_LIES_BENEATH             = 7358, -- There are many cold <item> scattered around the area. Could someone be trying to melt the ice to retrieve what lies beneath?
        SOMETHING_GLITTERING_BUT      = 7359, -- You see something glittering below the surface here, but the ice encases it completely.
        GEUSH_COUNTER                 = 7414, -- Geush Urvan uses Counterstance!
        FRESH_RABBIT_TRACKS           = 7416, -- There are fresh rabbit tracks here. The creature must still be in the vicinity.
        HOMEPOINT_SET                 = 8351, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8409, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        BLACK_CONEY  = GetFirstID('Black_Coney'),
        BONNACON     = GetFirstID('Bonnacon'),
        FATHER_FROST = GetFirstID('Father_Frost'),
        GEUSH_URVAN  = GetFirstID('Geush_Urvan'),
        JORMUNGAND   = GetFirstID('Jormungand'),
        MAGNOTAUR    = GetFirstID('Magnotaur'),
        SKVADER      = GetFirstID('Skvader'),
        SNOW_MAIDEN  = GetFirstID('Snow_Maiden'),
        WHITE_CONEY  = GetFirstID('White_Coney'),
    },
    npc =
    {
        RABBIT_FOOTPRINT = GetFirstID('Rabbit_Footprint'),
        WATERFALL        = GetFirstID('_058'),
    },
}

return zones[xi.zone.ULEGUERAND_RANGE]
