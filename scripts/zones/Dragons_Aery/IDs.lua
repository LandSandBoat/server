-----------------------------------
-- Area: Dragons_Aery
-----------------------------------
zones = zones or {}

zones[xi.zone.DRAGONS_AERY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6404, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7073, -- You can't fish here.
        CONQUEST_BASE                 = 7176, -- Tallying conquest results...
        COMMON_SENSE_SURVIVAL         = 7520, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FAFNIR  = GetFirstID('Fafnir'),
        NIDHOGG = GetFirstID('Nidhogg'),
    },
    npc =
    {
        FAFNIR_QM = GetFirstID('qm_fafnir'),
    },
}

return zones[xi.zone.DRAGONS_AERY]
