-----------------------------------
-- Area: Phomiuna_Aqueducts
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PHOMIUNA_AQUEDUCTS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_HERE        = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7053, -- Tallying conquest results...
        CANNOT_REACH_LADDER     = 7214, -- You cannot reach the ladder from here.
        DOOR_SEALED_SHUT        = 7215, -- The door above you is sealed shut.
        DOOR_LOCKED             = 7217, -- The door is locked.  You might be able to open it with <item>.
        LAMP_OFFSET             = 7223, -- A symbol for fire is engraved on the base of the lamp...
        FISHING_MESSAGE_OFFSET  = 7236, -- You can't fish here.
        COMMON_SENSE_SURVIVAL   = 7412, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PHOMIUNA_AQUEDUCTS]
