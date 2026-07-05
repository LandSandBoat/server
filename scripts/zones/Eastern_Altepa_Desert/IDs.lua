-----------------------------------
-- Area: Eastern_Altepa_Desert
-----------------------------------
zones = zones or {}

zones[xi.zone.EASTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6398,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6409,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137,  -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA       = 7140,  -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE         = 7151,  -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED        = 7152,  -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER               = 7153,  -- There is a beastmen's banner.
        CONQUEST                      = 7240,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7573,  -- You can't fish here.
        DIG_THROW_AWAY                = 7586,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7588,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7654,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7663,  -- It appears your chocobo found this item with ease.
        ALREADY_OBTAINED_TELE         = 7683,  -- You already possess the gate crystal for this telepoint.
        REMNANTS_OF_A_PAST_AGE        = 7687,  -- These are remnants of a past age, made from a rare kind of stone.
        FEEL_A_HOSTILE_GAZE           = 7688,  -- You feel a hostile gaze upon you!
        GARRISON_BASE                 = 7710,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7783,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7784,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7785,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7786,  -- You already possess that temporary item.
        NO_COMBINATION                = 7791,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7853,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9969,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11105, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        CACTROT_RAPIDO         = GetFirstID('Cactrot_Rapido'),
        CENTURIO_XII_I         = GetFirstID('Centurio_XII-I'),
        CONTANTICAN_BLACK_MAGE = GetFirstID('Contantican_Black_Mage'),
        CONTANTICAN_PALADIN    = GetFirstID('Contantican_Paladin'),
        CONTANTICAN_RANGER     = GetFirstID('Contantican_Ranger'),
        CONTANTICAN_WARRIOR    = GetFirstID('Contantican_Warrior'),
        DECURIO_I_III          = GetFirstID('Decurio_I-III'),
        DONNERGUGI             = GetFirstID('Donnergugi'),
        DUNE_WIDOW             = GetFirstID('Dune_Widow'),
        HOBGOBLIN_BEASTMASTER  = GetFirstID('Hobgoblin_Beastmaster'),
        HOBGOBLIN_BLACK_MAGE   = GetFirstID('Hobgoblin_Black_Mage'),
        HOBGOBLIN_DARK_KNIGHT  = GetFirstID('Hobgoblin_Dark_Knight'),
        HOBGOBLIN_RANGER       = GetFirstID('Hobgoblin_Ranger'),
        HOBGOBLIN_RED_MAGE     = GetFirstID('Hobgoblin_Red_Mage'),
        HOBGOBLIN_THIEF        = GetFirstID('Hobgoblin_Thief'),
        HOBGOBLIN_WARRIOR      = GetFirstID('Hobgoblin_Warrior'),
        HOBGOBLIN_WHITE_MAGE   = GetFirstID('Hobgoblin_White_Mage'),
        NANDI                  = GetFirstID('Nandi'),
        TSUCHIGUMO_OFFSET      = GetFirstID('Tsuchigumo'),
    },
    npc =
    {
        BEASTMENS_BANNER = GetFirstID('Beastmens_Banner'),
        OVERSEER_BASE    = GetFirstID('Eaulevisat_RK'),
    },
}

return zones[xi.zone.EASTERN_ALTEPA_DESERT]
