-----------------------------------
-- Area: Caedarva_Mire
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CAEDARVA_MIRE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7054, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7314, -- You must move closer.
        STAGING_GATE_INTERACT         = 7315, -- This gate guards an area under Imperial control.
        STAGING_GATE_AZOUPH           = 7316, -- Azouph Isle Staging Point.
        STAGING_GATE_DVUCCA           = 7319, -- Dvucca Isle Staging Point.
        CANNOT_LEAVE                  = 7325, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7334, -- There is no response...
        LOGGING_IS_POSSIBLE_HERE      = 7348, -- Logging is possible here if you have <item>.
        HAND_OVER_TO_IMMORTAL         = 7429, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7430, -- Your Imperial Standing has increased!
        CANNOT_ENTER                  = 7468, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7469, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7473, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7477, -- One or more party members are too far away from the entrance. Unable to enter area.
        JAZARAATS_HEADSTONE           = 7529, -- The name Sir Jazaraat is engraved on the headstone...
        SEAPRINCES_TOMBSTONE          = 8053, -- It appears to be the grave of a great soul to an age long past.
        SHED_LEAVES                   = 8059, -- The ground is strewn with shed leaves...
        SICKLY_SWEET                  = 8064, -- A sickly sweet fragrance pervades the air...
        STIFLING_STENCH               = 8070, -- A stifling stench pervades the air...
        SHREDDED_SCRAPS               = 8077, -- Shredded scraps of paper are scattered all over...
        DRAWS_NEAR                    = 8086, -- Something draws near!
        HOMEPOINT_SET                 = 8979, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 9037, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 9059, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
            17101329,
            17101330,
            17101331,
            17101332,
            17101333,
            17101334,
        },
        RUNIC_PORTAL_AZOUPH = 17101271,
        RUNIC_PORTAL_DVUCCA = 17101274,
    },
}

return zones[xi.zone.CAEDARVA_MIRE]
