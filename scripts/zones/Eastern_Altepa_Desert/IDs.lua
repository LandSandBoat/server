-----------------------------------
-- Area: Eastern_Altepa_Desert
-----------------------------------
zones = zones or {}

zones[xi.zone.EASTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7141,  -- There is a beastmen's banner.
        CONQUEST                      = 7228,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7561,  -- You can't fish here.
        DIG_THROW_AWAY                = 7574,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7576,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7642,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        ALREADY_OBTAINED_TELE         = 7670,  -- You already possess the gate crystal for this telepoint.
        GARRISON_BASE                 = 7696,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7769,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7770,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7771,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7772,  -- You already possess that temporary item.
        NO_COMBINATION                = 7777,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7839,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9955,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11091, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DUNE_WIDOW_PH     =
        {
            [17244395] = 17244396,
        },
        DONNERGUGI_PH     =
        {
            [17244258] = 17244268,
            [17244263] = 17244268,
        },
        CENTURIO_XII_I    = 17244372,
        NANDI             = 17244471,
        DECURIO_I_III     = 17244523,
        TSUCHIGUMO_OFFSET = 17244524,
        CACTROT_RAPIDO    = 17244539,
    },
    npc =
    {
        OVERSEER_BASE = GetFirstID('Eaulevisat_RK'),
    },
}

return zones[xi.zone.EASTERN_ALTEPA_DESERT]
