-----------------------------------
-- Area: Mine_Shaft_2716
-----------------------------------
zones = zones or {}

zones[xi.zone.MINE_SHAFT_2716] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7074, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7089, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7093, -- The old wooden door is locked tight.
        MEMBERS_OF_YOUR_PARTY         = 7380, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7381, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7383, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7419, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7426, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        DO_NOT_MEET_REQUIREMENTS      = 7430, -- You do not meet the requirements to enter the battlefield with your party members. Access is denied.
        SNAPS_IN_TWO                  = 7434, -- The <keyitem> snaps in two!
        CONQUEST_BASE                 = 7443, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7606, -- Entering the battlefield for [A Century of Hardship/Return to the Depths/Bionic Bug/Pulling the Strings/Automaton Assault/The Mobline Comedy/To Movalpolos!]!
        MOVAMUQ_DIALOGUE              = 7824, -- Bug Bug! Come come!
        CHEKOCHUK_DIALOGUE            = 7832, -- Buuug! Oooveeer heeere nooow!
        TRIKOTRAK_DIALOGUE            = 7840, -- Bg! Pnch! Kck!
        SWIPOSTIK_DIALOGUE            = 7848, -- Bug's! Smash's up's this's one's!
        BUGBBY_DIALOGUE               = 7855, -- Ugh.
        HO_HO                         = 7866, -- Ho-Ho, ho-ho! Time for goodebyongo!
    },
    mob =
    {
        BUGBBY               = GetFirstID('Bugbby'),
        BUGBOY               = GetFirstID('Bugboy'),
        CHEKOCHUK            = GetFirstID('Chekochuk'),
        HUME_AUTOMATON       = GetFirstID('Hume_Automaton'),
        MOBLIN_FANTOCCINIMAN = GetFirstID('Moblin_Fantocciniman'),
        MOVAMUQ              = GetFirstID('Movamuq'),
        SWIPOSTIK            = GetFirstID('Swipostik'),
        TRIKOTRAK            = GetFirstID('Trikotrak'),
        TWILOTAK             = GetFirstID('Twilotak'),
    },
    npc =
    {
    },
}

return zones[xi.zone.MINE_SHAFT_2716]
