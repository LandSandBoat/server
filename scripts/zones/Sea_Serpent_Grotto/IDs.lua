-----------------------------------
-- Area: Sea_Serpent_Grotto
-----------------------------------
zones = zones or {}

zones[xi.zone.SEA_SERPENT_GROTTO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7223,  -- You can't fish here.
        CHEST_UNLOCKED                = 7331,  -- You unlock the chest!
        SAHAGIN_DOOR_INSIDE           = 7349,  -- The door is tightly shut.
        SAHAGIN_DOOR_OUTSIDE          = 7350,  -- This door has an oddly shaped keyhole. It looks as if once you enter, you may not be able to get out the way you came in.
        SAHAGIN_DOOR_TRADED           = 7351,  -- The <item> breaks!
        FIRST_CHECK                   = 7355,  -- You do not see anything out of the ordinary.
        SECOND_CHECK                  = 7356,  -- You do not see anything out of the ordinary...
        THIRD_CHECK                   = 7357,  -- It looks like a rock wall.
        FOURTH_CHECK                  = 7358,  -- It looks like a rock wall...
        FIFTH_CHECK                   = 7359,  -- You see a small indentation in the wall.
        SILVER_CHECK                  = 7360,  -- You see something silver glittering around the indentation.
        MYTHRIL_CHECK                 = 7361,  -- You find something that looks like mythril dust scattered about the indentation.
        GOLD_CHECK                    = 7362,  -- You see something gold glittering around the indentation.
        COMPLETED_CHECK               = 7363,  -- It is a door you can open using <item>!
        SENSE_OMINOUS_PRESENCE        = 7377,  -- You sense an ominous presence...
        BODY_NUMB_DREAD               = 7565,  -- Your body goes numb with dread!
        PLAYER_OBTAINS_ITEM           = 7611,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7612,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7613,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7614,  -- You already possess that temporary item.
        NO_COMBINATION                = 7619,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9697,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10757, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 10837, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        MASAN                   = GetFirstID('Masan'),
        NAMTAR                  = GetFirstID('Namtar'),
        WUUR_THE_SANDCOMBER     = GetFirstID('Wuur_the_Sandcomber'),
        FYUU_THE_SEABELLOW      = GetFirstID('Fyuu_the_Seabellow'),
        QULL_THE_SHELLBUSTER    = GetFirstID('Qull_the_Shellbuster'),
        SEWW_THE_SQUIDLIMBED    = GetFirstID('Seww_the_Squidlimbed'),
        PAHH_THE_GULLCALLER     = GetFirstID('Pahh_the_Gullcaller'),
        MOUU_THE_WAVERIDER      = GetFirstID('Mouu_the_Waverider'),
        WORR_THE_CLAWFISTED     = GetFirstID('Worr_the_Clawfisted'),
        VOLL_THE_SHARKFINNED    = GetFirstID('Voll_the_Sharkfinned'),
        YARR_THE_PEARLEYED      = GetFirstID('Yarr_the_Pearleyed'),
        NOVV_THE_WHITEHEARTED   = GetFirstID('Novv_the_Whitehearted'),
        DENN_THE_ORCAVOICED     = GetFirstID('Denn_the_Orcavoiced'),
        ZUUG_THE_SHORELEAPER    = GetFirstID('Zuug_the_Shoreleaper'),
        SEA_HOG                 = GetFirstID('Sea_Hog'),
        CHARYBDIS               = GetFirstID('Charybdis'),
        MIMIC                   = GetFirstID('Mimic'),
        WATER_LEAPER            = GetFirstID('Water_Leaper'),
        GLYRYVILU               = GetFirstID('Glyryvilu'),
    },
    npc =
    {
        TREASURE_CHEST  = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.SEA_SERPENT_GROTTO]
