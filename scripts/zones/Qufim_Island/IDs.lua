-----------------------------------
-- Area: Qufim_Island
-----------------------------------
zones = zones or {}

zones[xi.zone.QUFIM_ISLAND] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6399,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6409,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING            = 6410,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME            = 6411,  -- Now is not the time for that!
        WAIT_A_BIT_LONGER              = 6412,  -- It seems that you will have to wait a bit longer...
        FELLOW_MESSAGE_OFFSET          = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7073,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA         = 7138,  -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA        = 7141,  -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE          = 7152,  -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED         = 7153,  -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER                = 7154,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7232,  -- You can't fish here.
        THESE_WITHERED_FLOWERS         = 7353,  -- These withered flowers seem unable to bloom.
        NOW_THAT_NIGHT_HAS_FALLEN      = 7354,  -- Now that night has fallen, the flowers bloom with a strange glow.
        CONQUEST                       = 7402,  -- You've earned conquest points!
        AN_EMPTY_LIGHT_SWIRLS          = 7761,  -- An empty light swirls about the cave, eating away at the surroundings...
        GARRISON_BASE                  = 7766,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        GIGANTIC_FOOTPRINT             = 7845,  -- There is a gigantic footprint here.
        ASA_SNOW                       = 7858,  -- You see the following words scrawled into the snow: Shantotto Empire Provisional Headquarters.
        YOU_CANNOT_ENTER_DYNAMIS       = 7871,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7873,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7995,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8069,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8070,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8071,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8072,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8077,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT   = 8139,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10353, -- New training regime registered!
        LEARNS_SPELL                   = 12671, -- <name> learns <spell>!
        UNCANNY_SENSATION              = 12673, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL          = 12680, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                  = 12722, -- Home point set!
    },
    mob =
    {
        DOSETSU_TREE          = GetFirstID('Dosetsu_Tree'),
        GIANT_BEASTMASTER     = GetFirstID('Giant_Beastmaster'),
        GIANT_HIGH_RANGER     = GetFirstID('Giant_High_Ranger'),
        GIANT_MONK            = GetFirstID('Giant_Monk'),
        GIANT_WARRIOR         = GetFirstID('Giant_Warrior'),
        HOBGOBLIN_BEASTMASTER = GetFirstID('Hobgoblin_Beastmaster'),
        HOBGOBLIN_BLACK_MAGE  = GetFirstID('Hobgoblin_Black_Mage'),
        HOBGOBLIN_DARK_KNIGHT = GetFirstID('Hobgoblin_Dark_Knight'),
        HOBGOBLIN_RANGER      = GetFirstID('Hobgoblin_Ranger'),
        HOBGOBLIN_RED_MAGE    = GetFirstID('Hobgoblin_Red_Mage'),
        HOBGOBLIN_THIEF       = GetFirstID('Hobgoblin_Thief'),
        HOBGOBLIN_WARRIOR     = GetFirstID('Hobgoblin_Warrior'),
        HOBGOBLIN_WHITE_MAGE  = GetFirstID('Hobgoblin_White_Mage'),
        KRAKEN_NM             = GetTableOfIDs('Kraken')[3],
        OPHIOTAURUS           = GetFirstID('Ophiotaurus'),
        SLIPPERY_SUCKER       = GetFirstID('Slippery_Sucker'),
        TRICKSTER_KINETIX     = GetFirstID('Trickster_Kinetix'),
    },
    npc =
    {
        BEASTMENS_BANNER = GetFirstID('Beastmens_Banner'),
        OVERSEER_BASE    = GetFirstID('Pitoire_RK'),
    },
}

return zones[xi.zone.QUFIM_ISLAND]
