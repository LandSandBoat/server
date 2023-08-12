-----------------------------------
-- Area: Behemoths_Dominion
-----------------------------------
zones = zones or {}

zones[xi.zone.BEHEMOTHS_DOMINION] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        IRREPRESSIBLE_MIGHT           = 6408,  -- An aura of irrepressible might threatens to overwhelm you...
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        AIR_AROUND_YOU_CHANGED        = 7325,  -- The air around you has suddenly changed!
        SOMETHING_BETTER              = 7326,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7329,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7330,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7332,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7333,  -- It is an ancient Zilart monument.
        PLAYER_OBTAINS_ITEM           = 7354,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7355,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7356,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7357,  -- You already possess that temporary item.
        NO_COMBINATION                = 7362,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7424,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9540,  -- New training regime registered!
        LEARNS_SPELL                  = 11529, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11531, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11538, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BEHEMOTH                = 17297440,
        KING_BEHEMOTH           = 17297441,
        TALEKEEPERS_GIFT_OFFSET = 17297446,
        ANCIENT_WEAPON          = 17297449,
        LEGENDARY_WEAPON        = 17297450,
    },
    npc =
    {
        BEHEMOTH_QM      = 17297459,
        CERMET_HEADSTONE = 17297493,
    },
}

return zones[xi.zone.BEHEMOTHS_DOMINION]
