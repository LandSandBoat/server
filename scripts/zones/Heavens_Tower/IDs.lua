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
        ITEM_CANNOT_BE_OBTAINED       = 7127, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 7135, -- Obtained: <item>.
        GIL_OBTAINED                  = 7136, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 7138, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 7139, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 7140, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 7174, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7175, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7176, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7196, -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 7198, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 7199, -- You are now able to call multiple alter egos.
        YOU_ACCEPT_THE_MISSION        = 7336, -- You have accepted the mission.
        FISHING_MESSAGE_OFFSET        = 7389, -- You can't fish here.
        INVALID_ENSIGNIAS             = 7621, -- Your invalid ensignias have been disposed of.
        CELEBRATORY_GOODS             = 9123, -- An assortment of celebratory goods is available for purchase.
        OBTAINED_NUM_KEYITEMS         = 9201, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                = 9203, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.HEAVENS_TOWER]
