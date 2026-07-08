-----------------------------------
-- Area: Mamook
-----------------------------------
zones = zones or {}

zones[xi.zone.MAMOOK] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7554, -- Logging is possible here if you have <item>.
        PARTY_MEMBERS_HAVE_FALLEN     = 7911, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7918, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        NOTHING_OUT_OF_ORDINARY       = 7044, -- Nothing out of the ordinary happens.
        IMPENDING_BATTLE              = 8079, -- You feel the rush of impending battle!
        PECULIAR_SENSATION            = 8137, -- <player> is overcome by a peculiar sensation.
        NUMEROUS_STRANDS              = 8684, -- Numerous strands of hair are scattered all over...
        SICKLY_SWEET                  = 8686, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR                    = 8708, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9579, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ZIZZY_ZILLAH           = GetFirstID('Zizzy_Zillah'),
        FIREDANCE_MAGMAAL_JA   = GetFirstID('Firedance_Magmaal_Ja'),
        GULOOL_JA_JA           = GetFirstID('Gulool_Ja_Ja'),
        CHAMROSH               = GetFirstID('Chamrosh'),
        IRIRI_SAMARIRI         = GetFirstID('Iriri_Samariri'),
        POROGGO_CASANOVA       = GetFirstID('Poroggo_Casanova'),
        MAMOOL_JA              = GetFirstID('Mamool_Ja'),
        MIKILULU               = GetFirstID('Mikilulu'),
        MIKIRURU               = GetFirstID('Mikiruru'),
        NIKILULU               = GetFirstID('Nikilulu'),
        MIKILURU               = GetFirstID('Mikiluru'),
        MIKIRULU               = GetFirstID('Mikirulu'),
        HUNDRED_FACE_HAPOOL_JA = GetFirstID('Hundredfaced_Hapool_Ja'),
    },
    npc =
    {
        LOGGING      = GetTableOfIDs('Logging_Point'),
        QUEST_LIQUID = GetTableOfIDs('Viscous_Liquid')[6], -- Used in quest Two Horn the Savage
    },
}

return zones[xi.zone.MAMOOK]
