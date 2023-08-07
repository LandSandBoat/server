-----------------------------------
-- Area: Heavens_Tower
-----------------------------------
zones = zones or {}

zones[xi.zone.HEAVENS_TOWER] =
{
    text =
    {
        STAIRWAY_LOCKED               = 554,  -- The door to the Starway Stairway is locked tight.
        STAIRWAY_ONLY_CITIZENS        = 555,  -- The door to the Starway Stairway is locked tight, and only citizens of Windurst can open it.
        CONQUEST_BASE                 = 582,  -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 7125, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 7131, -- Obtained: <item>.
        GIL_OBTAINED                  = 7132, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 7134, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 7135, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 7136, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 7170, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7171, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7172, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7192, -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 7194, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 7195, -- You are now able to call multiple alter egos.
        FISHING_MESSAGE_OFFSET        = 7377, -- You can't fish here.
        CELEBRATORY_GOODS             = 9110, -- An assortment of celebratory goods is available for purchase.
        OBTAINED_NUM_KEYITEMS         = 9188, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                = 9190, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.HEAVENS_TOWER]
