-----------------------------------
-- Area: Dragons_Aery
-----------------------------------
zones = zones or {}

zones[xi.zone.DRAGONS_AERY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6400, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068, -- You can't fish here.
        CONQUEST_BASE                 = 7170, -- Tallying conquest results...
        COMMON_SENSE_SURVIVAL         = 7514, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FAFNIR  = GetFirstID('Fafnir'),
        NIDHOGG = GetFirstID('Nidhogg'),
    },
    npc =
    {
        FAFNIR_QM = GetFirstID('qm0'),
    },
}

return zones[xi.zone.DRAGONS_AERY]
