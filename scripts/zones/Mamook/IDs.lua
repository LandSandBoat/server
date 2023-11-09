-----------------------------------
-- Area: Mamook
-----------------------------------
zones = zones or {}

zones[xi.zone.MAMOOK] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7058, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7543, -- Logging is possible here if you have <item>.
        PARTY_MEMBERS_HAVE_FALLEN     = 7900, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7907, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPENDING_BATTLE              = 8056, -- You feel the rush of impending battle!
        NUMEROUS_STRANDS              = 8653, -- Numerous strands of hair are scattered all over...
        SICKLY_SWEET                  = 8655, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR                    = 8677, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9548, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ZIZZY_ZILLAH_PH =
        {
            [17043560]           = 17043554,
            [17043561]           = 17043554,
            [17043562]           = 17043554,
            [17043563]           = 17043554,
            [17043564]           = 17043554,
        },
        FIREDANCE_MAGMAAL_JA_PH =
        {
            [17043773]           = 17043779, -- -201.522 17.209 -363.865
            [17043774]           = 17043779, -- -206.458 17.525 -373.798
        },
        GULOOL_JA_JA             = 17043875,
        CHAMROSH                 = 17043887,
        IRIRI_SAMARIRI           = 17043888,
        POROGGO_CASANOVA         = 17043881,
        MIKILULU                 = 17043882,
        MIKIRURU                 = 17043883,
        NIKILULU                 = 17043884,
        MIKILURU                 = 17043885,
        MIKIRULU                 = 17043886,
    },
    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.MAMOOK]
