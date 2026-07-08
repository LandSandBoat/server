-----------------------------------
-- Area: Quicksand_Caves
-----------------------------------
zones = zones or {}

zones[xi.zone.QUICKSAND_CAVES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6409,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6410,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137,  -- San d'Oria's region points have increased!
        FISHING_MESSAGE_OFFSET        = 7231,  -- You can't fish here.
        CHEST_UNLOCKED                = 7340,  -- You unlock the chest!
        DOOR_FIRMLY_SHUT              = 7348,  -- The door is firmly shut.
        ANCIENT_LETTERS_UNREAD        = 7357,  -- Ancient letters are carved here, but you are unable to read them.
        POOL_OF_WATER                 = 7380,  -- It is a pool of water.
        SENSE_SOMETHING_EVIL          = 7381,  -- You sense something evil.
        YOU_FIND_NOTHING_OUT          = 7382,  -- You find nothing out of the ordinary.
        YOU_FIND_NOTHING              = 7383,  -- You find nothing.
        SOMETHING_ATTACKING_YOU       = 7387,  -- Something is attacking from behind you!
        SOMETHING_IS_BURIED           = 7388,  -- Something is buried in this fallen pillar.
        SENSE_OMINOUS_PRESENCE        = 7392,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM           = 8300,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8301,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8302,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8303,  -- You already possess that temporary item.
        NO_COMBINATION                = 8308,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10386, -- New training regime registered!
        HOMEPOINT_SET                 = 11448, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11506, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        SAGITTARIUS_X_XIII    = GetFirstID('Sagittarius_X-XIII'),
        NUSSKNACKER           = GetFirstID('Nussknacker'),
        CENTURIO_X_I          = GetFirstID('Centurio_X-I'),
        ANTICAN_MAGISTER      = GetFirstID('Antican_Magister'),
        ANTICAN_PRAEFECTUS    = GetFirstID('Antican_Praefectus'),
        ANTICAN_PROCONSUL     = GetFirstID('Antican_Proconsul'),
        DIAMOND_DAIG          = GetFirstID('Diamond_Daig'),
        ANTICAN_TRIBUNUS      = GetFirstID('Antican_Tribunus'),
        TRIARIUS_X_XV         = GetFirstID('Triarius_X-XV'),
        HASTATUS_XI_XII       = GetFirstID('Hastatus_XI-XII'),
        SABOTENDER_BAILARIN   = GetFirstID('Sabotender_Bailarin'),
        SABOTENDER_BAILARINA  = GetFirstID('Sabotender_Bailarina'),
        VALOR                 = GetFirstID('Valor'),
        HONOR                 = GetFirstID('Honor'),
        CENTURIO_IV_VII       = GetFirstID('Centurio_IV-VII'),
        TRIARIUS_IV_XIV       = GetFirstID('Triarius_IV-XIV'),
        PRINCEPS_IV_XLV       = GetFirstID('Princeps_IV-XLV'),
        MIMIC                 = GetFirstID('Mimic'),
        ANCIENT_VESSEL        = GetFirstID('Ancient_Vessel'),
        TRIBUNUS_VII_I        = GetFirstID('Tribunus_VII-I'),
        GIRTABLULU            = GetFirstID('Girtablulu'),
    },
    npc =
    {
        ANTICAN_TAG_POSITIONS =
        {
            [1] = { 590.000,  -6.600, -663.000 },
            [2] = { 748.000,   2.000, -570.000 },
            [3] = { 479.000, -14.000, -815.000 },
            [4] = { 814.000, -14.000, -761.000 },
        },

        ORNATE_DOOR_OFFSET     = GetFirstID('_5s0'),
        CHAINS_THAT_BIND_US_QM = GetFirstID('qm6'),
        TREASURE_COFFER        = GetFirstID('Treasure_Coffer'),
        ANTICAN_TAG_QM         = GetFirstID('qm25'),
    },
}

return zones[xi.zone.QUICKSAND_CAVES]
