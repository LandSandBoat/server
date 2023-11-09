-----------------------------------
-- Area: Phomiuna_Aqueducts
-----------------------------------
zones = zones or {}

zones[xi.zone.PHOMIUNA_AQUEDUCTS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_HERE              = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061, -- Tallying conquest results...
        CANNOT_REACH_LADDER           = 7222, -- You cannot reach the ladder from here.
        DOOR_SEALED_SHUT              = 7223, -- The door above you is sealed shut.
        DOOR_FIRMLY_SHUT              = 7224, -- The door is firmly shut.
        DOOR_LOCKED                   = 7225, -- The door is locked.  You might be able to open it with <item>.
        ITEM_BREAKS                   = 7227, -- The <item> breaks!
        LAMP_OFFSET                   = 7231, -- A symbol for fire is engraved on the base of the lamp...
        FISHING_MESSAGE_OFFSET        = 7244, -- You can't fish here.
        COMMON_SENSE_SURVIVAL         = 7420, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        LADDER_KNOCKING = 16888096,
    },
}

return zones[xi.zone.PHOMIUNA_AQUEDUCTS]
