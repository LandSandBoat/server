-----------------------------------
-- Area: Mount_Zhayolm
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MOUNT_ZHAYOLM] =
{
    text =
    {
        NOTHING_HAPPENS         =  119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        RESPONSE                = 7329, -- There is no response...
        MINING_IS_POSSIBLE_HERE = 7418, -- Mining is possible here if you have <item>.
        CANNOT_ENTER            = 7477, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL               = 7478, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS          = 7482, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR          = 7486, -- One or more party members are too far away from the entrance. Unable to enter area.
        SHED_LEAVES             = 7548, -- The ground is strewn with shed leaves...
        SICKLY_SWEET            = 7563, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR              = 7575, -- Something draws near!
        HOMEPOINT_SET           = 8724, -- Home point set!
    },
    mob =
    {
        ENERGETIC_ERUCA_PH    =
        {
            [17027146] = 17027466, -- 175.315 -14.444 -173.589
            [17027145] = 17027466, -- 181.601 -14.120 -166.218
        },
        IGNAMOTH_PH =
        {
            [17027421] = 17027423, -- -567.6 -15.35 252.201
            [17027422] = 17027423, -- -544.3 -14.8 262.992
        },
        CERBERUS              = 17027458,
        BRASS_BORER           = 17027471,
        CLARET                = 17027472,
        ANANTABOGA            = 17027473,
        KHROMASOUL_BHURBORLOR = 17027474,
        SARAMEYA              = 17027485,
    },
    npc =
    {
        MINING =
        {
            17027559,
            17027560,
            17027561,
            17027562,
            17027563,
            17027564,
        },
    },
}

return zones[tpz.zone.MOUNT_ZHAYOLM]
