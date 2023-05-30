-----------------------------------
-- Area: Cape_Teriggan
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CAPE_TERIGGAN] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7141,  -- There is a beastmen's banner.
        CONQUEST                      = 7228,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7561,  -- You can't fish here.
        SOMETHING_BETTER              = 7673,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7676,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7677,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7678,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        ZILART_MONUMENT               = 7680,  -- It is an ancient Zilart monument.
        MUST_BE_A_WAY_TO_SOOTHE       = 7688,  -- There must be a way to soothe the weary soul who once guarded this monument...
        COLD_WIND_CHILLS_YOU          = 7695,  -- A cold wind chills you to the bone.
        SENSE_OMINOUS_PRESENCE        = 7697,  -- You sense an ominous presence...
        GARRISON_BASE                 = 7884,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7931,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7932,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7933,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7934,  -- You already possess that temporary item.
        NO_COMBINATION                = 7939,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 8001,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10117, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11236, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                 = 11264, -- Home point set!
    },
    mob =
    {
        FROSTMANE_PH           =
        {
            [17240374] = 17240376, -- -283.874 -0.660 485.504
            [17240372] = 17240376, -- -272.224 -0.942 461.321
            [17240373] = 17240376, -- -268.000 -0.558 440.000
            [17240371] = 17240376, -- -262.000 -0.700 442.000
        },
        KREUTZET               = 17240413,
        AXESARION_THE_WANDERER = 17240414,
        STOLAS                 = 17240424,
    },
    npc =
    {
        OVERSEER_BASE    = GetFirstID('Salimardi_RK'),
        CERMET_HEADSTONE = 17240497,
    },
}

return zones[xi.zone.CAPE_TERIGGAN]
