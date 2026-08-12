-----------------------------------
-- Area: Rala_Waterways (258)
-----------------------------------
zones = zones or {}

zones[xi.zone.RALA_WATERWAYS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7012, -- You have obtained <number> bayld!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        NOTHING_HAPPENS               = 8089, -- Nothing happens.
        PERHAPS_THE_WISEST            = 8090, -- Perhaps the wisest approach would be to search for <keyitem> with which to open the decrepit sluice gate.
        A_QUICK_GLANCE_REVEALS        = 8712, -- A quick glance reveals spoiled water trickling from upstream, likely caused by effluvium from the recent destruction.
        THREE_BLOOD_SIGILS_PULSE      = 8936, -- The three blood sigils begin to pulse a violent crimson!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RALA_WATERWAYS]
