-----------------------------------
-- Area: Garlaige_Citadel_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.GARLAIGE_CITADEL_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        LYCOPODIUM_ENTRANCED          = 7079, -- The lycopodium is entranced by a sparkling light...
        CAMPAIGN_RESULTS_TALLIED      = 7541, -- Campaign results tallied.
        COMMON_SENSE_SURVIVAL         = 8902, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Lidaise_TK'), -- San, Bas, Win, Flag +4, CA
    },
}

return zones[xi.zone.GARLAIGE_CITADEL_S]
