-----------------------------------
-- Area: Castle_Zvahl_Keep_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_ZVAHL_KEEP_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        NOTHING_OUT_OF_ORDINARY       = 7342, -- You find nothing out of the ordinary.
        A_SHIVER_RUNS_DOWN            = 7343, -- A shiver runs down your spine...
        HOMEPOINT_SET                 = 7886, -- Home point set!
    },
    mob =
    {
        GARGOUILLE_WARDEN             = GetFirstID('Gargouille_Warden'),
    },
    npc =
    {
    },
}

return zones[xi.zone.CASTLE_ZVAHL_KEEP_S]
