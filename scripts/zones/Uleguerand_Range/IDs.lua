-----------------------------------
-- Area: Uleguerand_Range
-----------------------------------
zones = zones or {}

zones[xi.zone.ULEGUERAND_RANGE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6398, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6404, -- Obtained: <item>.
        GIL_OBTAINED                  = 6405, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6407, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6418, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6433, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7015, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7016, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7017, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7037, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7081, -- Tallying conquest results...
        SOMETHING_GLITTERING          = 7352, -- You see something glittering beneath the surface of the ice.
        WHAT_LIES_BENEATH             = 7353, -- There are many cold <item> scattered around the area. Could someone be trying to melt the ice to retrieve what lies beneath?
        SOMETHING_GLITTERING_BUT      = 7354, -- You see something glittering below the surface here, but the ice encases it completely.
        HOMEPOINT_SET                 = 8346, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8404, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        SKVADER     = GetFirstID('Skvader'),
        MAGNOTAUR   = GetFirstID('Magnotaur'),
        BONNACON    = GetFirstID('Bonnacon'),
        JORMUNGAND  = GetFirstID('Jormungand'),
        GEUSH_URVAN = GetFirstID('Geush_Urvan'),
        WHITE_CONEY = GetFirstID('White_Coney'),
        BLACK_CONEY = GetFirstID('Black_Coney'),
    },
    npc =
    {
        WATERFALL        = GetFirstID('_058'),
        RABBIT_FOOTPRINT = GetFirstID('Rabbit_Footprint'),
    },
}

return zones[xi.zone.ULEGUERAND_RANGE]
