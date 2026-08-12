-----------------------------------
-- Area: West_Ronfaure
-----------------------------------
zones = zones or {}

zones[xi.zone.WEST_RONFAURE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6409,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6417,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6418,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6420,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6421,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6446,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7028,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7029,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7030,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7050,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7095,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7254,  -- You can't fish here.
        DIG_THROW_AWAY                = 7267,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7269,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7344,  -- It appears your chocobo found this item with ease.
        RAMAUFONT_DIALOG              = 7355,  -- Nothing to report.
        ORCISH_SCOUTS                 = 7356,  -- Orcish scouts lurk in the shadows. Consider yourself warned!
        ADALEFONT_DIALOG              = 7357,  -- If you sense danger, just flee into the city. I'll not endanger myself on your account!
        LAILLERA_DIALOG               = 7358,  -- I mustn't chat while on duty. Sorry.
        PICKPOCKET_GACHEMAGE          = 7359,  -- A pickpocket? Now that you mention it, I did see a woman flee the city. She ran west.
        PICKPOCKET_ADALEFONT          = 7360,  -- What, someone picked your pocket? And you call yourself an adventurer!
        PICKPOCKET_COLMAIE            = 7361,  -- A pickpocket? Hmm... Can't say I've seen anyone like that around here.
        PICKPOCKET_LAILLERA           = 7362,  -- A pickpocket, you say? I don't think anybody came through here.
        AAVELEON_HEALED               = 7364,  -- My wounds are healed, thanks to you!
        PICKPOCKET_AAVELEON           = 7390,  -- A pickpocket, out here? Phew, my wallet is safe.
        PALCOMONDAU_REPORT            = 7402,  -- Scout reporting! All is quiet on the road to Ghelsba!
        PALCOMONDAU_ENROUTE           = 7403,  -- Let me be! I must patrol the road to Ghelsba.
        PALCOMONDAU_RETURN            = 7404,  -- I bring word of Ghelsba to the Westgate. Out of my way!
        ZOVRIACE_REPORT               = 7405,  -- Scout reporting! All is quiet on the roads to La Theine!
        ZOVRIACE_ENROUTE              = 7406,  -- I must scour the roads to La Theine for signs of the enemy. Let me pass!
        ZOVRIACE_RETURN               = 7407,  -- Let me be! I return to Southgate with word on La Theine.
        PICKPOCKET_PALCOMONDAU        = 7408,  -- A pickpocket? No, I haven't seen anyone matching that description. I've only seen Aaveleon, and a rather brusque woman.
        PICKPOCKET_ZOVRIACE           = 7409,  -- A pickpocket, out here? Can't say I've seen anyone like that. I'll keep my eyes peeled.
        DIADONOUR_DIALOG              = 7410,  -- Our people often fall prey to roving Orcs nearby. Take care out there!
        LAETTE_DIALOG                 = 7415,  -- This watchtower was built to strengthen Ranperre Gate. You can look around, but stay out of our way.
        CHATARRE_DIALOG               = 7416,  -- Ghelsba and its Orcish camps lie at the foot of mountains yonder. We must be vigilant! They could attack at any time.
        DISMAYED_CUSTOMER             = 7433,  -- You find some worthless scraps of paper.
        CONQUEST                      = 7555,  -- You've earned conquest points!
        SOMETHING_IS_AMISS            = 7907,  -- Something is amiss.
        GARRISON_BASE                 = 7937,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        TIME_ELAPSED                  = 8068,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 8075,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8076,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8077,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8078,  -- You already possess that temporary item.
        NO_COMBINATION                = 8083,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10450, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12451, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FUNGUS_BEETLE      = GetFirstID('Fungus_Beetle'),
        JAGGEDY_EARED_JACK = GetFirstID('Jaggedy-Eared_Jack'),
        MARAUDER_DVOGZOG   = GetFirstID('Marauder_Dvogzog'),
    },
    npc =
    {
        SIGNPOST_OFFSET = GetFirstID('Signpost'),
        OVERSEER_BASE   = GetFirstID('Doladepaiton_RK'),
    },
}

return zones[xi.zone.WEST_RONFAURE]
