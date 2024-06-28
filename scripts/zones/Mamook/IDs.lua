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
        FISHING_MESSAGE_OFFSET        = 7061, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7546, -- Logging is possible here if you have <item>.
        PARTY_MEMBERS_HAVE_FALLEN     = 7903, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7910, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPENDING_BATTLE              = 8059, -- You feel the rush of impending battle!
        NUMEROUS_STRANDS              = 8656, -- Numerous strands of hair are scattered all over...
        SICKLY_SWEET                  = 8658, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR                    = 8680, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9551, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ZIZZY_ZILLAH         = GetFirstID('Zizzy_Zillah'),
        FIREDANCE_MAGMAAL_JA = GetFirstID('Firedance_Magmaal_Ja'),
        GULOOL_JA_JA         = GetFirstID('Gulool_Ja_Ja'),
        CHAMROSH             = GetFirstID('Chamrosh'),
        IRIRI_SAMARIRI       = GetFirstID('Iriri_Samariri'),
        POROGGO_CASANOVA     = GetFirstID('Poroggo_Casanova'),
        MIKILULU             = GetFirstID('Mikilulu'),
        MIKIRURU             = GetFirstID('Mikiruru'),
        NIKILULU             = GetFirstID('Nikilulu'),
        MIKILURU             = GetFirstID('Mikiluru'),
        MIKIRULU             = GetFirstID('Mikirulu'),
    },
    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.MAMOOK]
