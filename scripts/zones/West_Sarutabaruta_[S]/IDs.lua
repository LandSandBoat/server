-----------------------------------
-- Area: West_Sarutabaruta_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.WEST_SARUTABARUTA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389, -- Obtained: <item>.
        GIL_OBTAINED                = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HARVESTING_IS_POSSIBLE_HERE = 7070, -- Harvesting is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET      = 7077, -- You can't fish here.
        DOOR_OFFSET                 = 7435, -- The door is sealed shut...
        COMMON_SENSE_SURVIVAL       = 9259, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        JEDUAH_PH =
        {
            [17166542] = 17166543, -- 113.797 -0.8 -310.342
        },
        RAMPONNEAU_PH =
        {
            [17166701] = 17166705, -- 78.836 -0.109 -199.204
        },
    },
    npc =
    {
        HARVESTING =
        {
            17167162,
            17167163,
            17167164,
            17167165,
            17167166,
            17167167,
        },
    },
}

return zones[ xi.zone.WEST_SARUTABARUTA_S]
