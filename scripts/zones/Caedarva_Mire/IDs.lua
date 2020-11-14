-----------------------------------
-- Area: Caedarva_Mire
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CAEDARVA_MIRE] =
{
    text =
    {
        NOTHING_HAPPENS          = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET   = 7049, -- You can't fish here.
        MOVE_CLOSER              = 7309, -- You must move closer.
        IMPERIAL_CONTROL         = 7310, -- This gate guards an area under Imperial control.
        STAGING_POINT_AZOUPH     = 7311, -- Azouph Isle Staging Point.
        STAGING_POINT_DVUCCA     = 7314, -- Dvucca Isle Staging Point.
        CANNOT_LEAVE             = 7320, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                 = 7329, -- There is no response...
        LOGGING_IS_POSSIBLE_HERE = 7343, -- Logging is possible here if you have <item>.
        CANNOT_ENTER             = 7463, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                = 7464, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS           = 7468, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR           = 7472, -- One or more party members are too far away from the entrance. Unable to enter area.
        JAZARAATS_HEADSTONE      = 7524, -- The name Sir Jazaraat is engraved on the headstone...
        SEAPRINCES_TOMBSTONE     = 8048, -- It appears to be the grave of a great soul to an age long past.
        HOMEPOINT_SET            = 8974, -- Home point set!
        COMMON_SENSE_SURVIVAL    = 9054, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        PEALLAIDH_PH          =
        {
            [17100870] = 17101143, -- 333.885 -9.646 -447.557
            [17100871] = 17101143, -- 309.638 -8.548 -447.557
            [17100872] = 17101143, -- 307.320 -10.088 -451.786
            [17100873] = 17101143, -- 295.122 -12.271 -414.418
            [17100874] = 17101143, -- 287.607 -16.220 -387.671
            [17100875] = 17101143, -- 315.793 -16.336 -402.407
            [17100876] = 17101143, -- 321.809 -16.843 -373.780
        },
        AYNU_KAYSEY           = 17101099,
        CAEDARVA_TOAD         = 17101145,
        JAZARAAT              = 17101146,
        LAMIA_NO27            = 17101148,
        MOSHDAHN              = 17101149,
        KHIMAIRA              = 17101201,
        VERDELET              = 17101202,
        TYGER                 = 17101203,
        MAHJLAEF_THE_PAINTORN = 17101204,
        EXPERIMENTAL_LAMIA    = 17101205,
    },
    npc =
    {
        LOGGING =
        {
            17101318,
            17101319,
            17101320,
            17101321,
            17101322,
            17101323,
        },
        RUNIC_PORTAL_AZOUPH = 17101271,
        RUNIC_PORTAL_DVUCCA = 17101274,
    },
}

return zones[tpz.zone.CAEDARVA_MIRE]
