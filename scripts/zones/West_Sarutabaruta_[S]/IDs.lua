-----------------------------------
-- Area: West_Sarutabaruta_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WEST_SARUTABARUTA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login no. <number>...
        HARVESTING_IS_POSSIBLE_HERE = 7069, -- Harvesting is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET      = 7076, -- You can't fish here.
        DOOR_OFFSET                 = 7434, -- The door is sealed shut...
        COMMON_SENSE_SURVIVAL       = 9258, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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

return zones[tpz.zone.WEST_SARUTABARUTA_S]
