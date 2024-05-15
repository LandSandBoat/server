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
        CONQUEST_BASE                 = 7064,  -- Tallying conquest results...
        AIR_AROUND_YOU_CHANGED        = 7329,  -- The air around you has suddenly changed!
        SOMETHING_BETTER              = 7330,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7333,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7334,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7336,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7337,  -- It is an ancient Zilart monument.
        PLAYER_OBTAINS_ITEM           = 7358,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7359,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7360,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7361,  -- You already possess that temporary item.
        NO_COMBINATION                = 7366,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7428,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9544,  -- New training regime registered!
        LEARNS_SPELL                  = 11533, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11535, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11542, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BEHEMOTH                = GetFirstID('Behemoth'),
        KING_BEHEMOTH           = GetFirstID('King_Behemoth'),
        ANCIENT_WEAPON          = GetFirstID('Ancient_Weapon'),
        LEGENDARY_WEAPON        = GetFirstID('Legendary_Weapon'),
        TALEKEEPERS_GIFT_OFFSET = GetFirstID('Picklix_Longindex'),
    },
    npc =
    {
        BEHEMOTH_QM      = GetFirstID('qm2'),
        CERMET_HEADSTONE = GetFirstID('Cermet_Headstone'),
    },
}

return zones[xi.zone.BEHEMOTHS_DOMINION]
