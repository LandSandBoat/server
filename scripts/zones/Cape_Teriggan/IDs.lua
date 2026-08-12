-----------------------------------
-- Area: Cape_Teriggan
-----------------------------------
zones = zones or {}

zones[xi.zone.CAPE_TERIGGAN] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6404,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7138,  -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA       = 7141,  -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE         = 7152,  -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED        = 7153,  -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER               = 7154,  -- There is a beastmen's banner.
        CONQUEST                      = 7241,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7574,  -- You can't fish here.
        SOMETHING_BETTER              = 7687,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7690,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7691,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7692,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        ZILART_MONUMENT               = 7694,  -- It is an ancient Zilart monument.
        MUST_BE_A_WAY_TO_SOOTHE       = 7702,  -- There must be a way to soothe the weary soul who once guarded this monument...
        COLD_WIND_CHILLS_YOU          = 7709,  -- A cold wind chills you to the bone.
        SENSE_OMINOUS_PRESENCE        = 7711,  -- You sense an ominous presence...
        GARRISON_BASE                 = 7898,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7945,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7946,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7947,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7948,  -- You already possess that temporary item.
        NO_COMBINATION                = 7953,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 8015,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10131, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11250, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                 = 11278, -- Home point set!
    },
    mob =
    {
        AXESARION_THE_WANDERER = GetFirstID('Axesarion_the_Wanderer'),
        FROSTMANE              = GetFirstID('Frostmane'),
        HOBGOBLIN_BEASTMASTER  = GetFirstID('Hobgoblin_Beastmaster'),
        HOBGOBLIN_BLACK_MAGE   = GetFirstID('Hobgoblin_Black_Mage'),
        HOBGOBLIN_DARK_KNIGHT  = GetFirstID('Hobgoblin_Dark_Knight'),
        HOBGOBLIN_RANGER       = GetFirstID('Hobgoblin_Ranger'),
        HOBGOBLIN_RED_MAGE     = GetFirstID('Hobgoblin_Red_Mage'),
        HOBGOBLIN_THIEF        = GetFirstID('Hobgoblin_Thief'),
        HOBGOBLIN_WARRIOR      = GetFirstID('Hobgoblin_Warrior'),
        HOBGOBLIN_WHITE_MAGE   = GetFirstID('Hobgoblin_White_Mage'),
        KILLER_JONNY           = GetFirstID('Killer_Jonny'),
        KREUTZET               = GetFirstID('Kreutzet'),
        STOLAS                 = GetFirstID('Stolas'),
        ZMEY_GORYNYCH          = GetFirstID('Zmey_Gorynych'),
    },
    npc =
    {
        BEASTMENS_BANNER = GetFirstID('Beastmens_Banner'),
        CERMET_HEADSTONE = GetFirstID('Cermet_Headstone'),
        OVERSEER_BASE    = GetFirstID('Salimardi_RK'),
    },
}

return zones[xi.zone.CAPE_TERIGGAN]
