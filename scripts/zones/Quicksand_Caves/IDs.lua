-----------------------------------
-- Area: Quicksand_Caves
-----------------------------------
zones = zones or {}

zones[xi.zone.QUICKSAND_CAVES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6406,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7220,  -- You can't fish here.
        CHEST_UNLOCKED                = 7328,  -- You unlock the chest!
        DOOR_FIRMLY_SHUT              = 7336,  -- The door is firmly shut.
        ANCIENT_LETTERS_UNREAD        = 7345,  -- Ancient letters are carved here, but you are unable to read them.
        POOL_OF_WATER                 = 7368,  -- It is a pool of water.
        SENSE_SOMETHING_EVIL          = 7369,  -- You sense something evil.
        YOU_FIND_NOTHING_OUT          = 7370,  -- You find nothing out of the ordinary.
        YOU_FIND_NOTHING              = 7371,  -- You find nothing.
        SOMETHING_ATTACKING_YOU       = 7375,  -- Something is attacking from behind you!
        SOMETHING_IS_BURIED           = 7376,  -- Something is buried in this fallen pillar.
        SENSE_OMINOUS_PRESENCE        = 7380,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM           = 8288,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8289,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8290,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8291,  -- You already possess that temporary item.
        NO_COMBINATION                = 8296,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10374, -- New training regime registered!
        HOMEPOINT_SET                 = 11436, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11494, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
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
