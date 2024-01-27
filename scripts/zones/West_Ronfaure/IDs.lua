-----------------------------------
-- Area: West_Ronfaure
-----------------------------------
zones = zones or {}

zones[xi.zone.WEST_RONFAURE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6416,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7083,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7242,  -- You can't fish here.
        DIG_THROW_AWAY                = 7255,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7257,  -- You dig and you dig, but find nothing.
        RAMAUFONT_DIALOG              = 7342,  -- Nothing to report.
        GACHEMAGE_DIALOG              = 7343,  -- Orcish scouts lurk in the shadows. Consider yourself warned!
        ADALEFONT_DIALOG              = 7344,  -- If you sense danger, just flee into the city. I'll not endanger myself on your account!
        LAILLERA_DIALOG               = 7345,  -- I mustn't chat while on duty. Sorry.
        PICKPOCKET_GACHEMAGE          = 7346,  -- A pickpocket? Now that you mention it, I did see a woman flee the city. She ran west.
        PICKPOCKET_ADALEFONT          = 7347,  -- What, someone picked your pocket? And you call yourself an adventurer!
        PICKPOCKET_COLMAIE            = 7348,  -- A pickpocket? Hmm... Can't say I've seen anyone like that around here.
        PICKPOCKET_LAILLERA           = 7349,  -- A pickpocket, you say? I don't think anybody came through here.
        AAVELEON_HEALED               = 7351,  -- My wounds are healed, thanks to you!
        PICKPOCKET_AAVELEON           = 7377,  -- A pickpocket, out here? Phew, my wallet is safe.
        PALCOMONDAU_REPORT            = 7389,  -- Scout reporting! All is quiet on the road to Ghelsba!
        PALCOMONDAU_DIALOG            = 7390,  -- Let me be! I must patrol the road to Ghelsba.
        ZOVRIACE_REPORT               = 7392,  -- Scout reporting! All is quiet on the roads to La Theine!
        ZOVRIACE_DIALOG               = 7394,  -- Let me be! I return to Southgate with word on La Theine.
        PICKPOCKET_PALCOMONDAU        = 7395,  -- A pickpocket? No, I haven't seen anyone matching that description. I've only seen Aaveleon, and a rather brusque woman.
        PICKPOCKET_ZOVRIACE           = 7396,  -- A pickpocket, out here? Can't say I've seen anyone like that. I'll keep my eyes peeled.
        DIADONOUR_DIALOG              = 7397,  -- Our people often fall prey to roving Orcs nearby. Take care out there!
        LAETTE_DIALOG                 = 7402,  -- This watchtower was built to strengthen Ranperre Gate. You can look around, but stay out of our way.
        CHATARRE_DIALOG               = 7403,  -- Ghelsba and its Orcish camps lie at the foot of mountains yonder. We must be vigilant! They could attack at any time.
        DISMAYED_CUSTOMER             = 7420,  -- You find some worthless scraps of paper.
        CONQUEST                      = 7542,  -- You've earned conquest points!
        SOMETHING_IS_AMISS            = 7894,  -- Something is amiss.
        GARRISON_BASE                 = 7924,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 8061,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8062,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8063,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8064,  -- You already possess that temporary item.
        NO_COMBINATION                = 8069,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10435, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12436, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FUNGUS_BEETLE_PH      =
        {
            [17187026] = 17187047, -- -332.722 -21.032 -112.044
        },
        JAGGEDY_EARED_JACK_PH =
        {
            [17187110] = 17187111, -- -262.780 -22.384 -253.873
        },
        MARAUDER_DVOGZOG      = 17187273,
    },
    npc =
    {
        SIGNPOST_OFFSET = 17187505,
        OVERSEER_BASE   = GetFirstID('Doladepaiton_RK'),
    },
}

return zones[xi.zone.WEST_RONFAURE]
