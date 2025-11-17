-----------------------------------
-- Area: Throne_Room
-----------------------------------
zones = zones or {}

zones[xi.zone.THRONE_ROOM] =
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
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7232, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7247, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7249, -- The door is sealed shut with an evil curse.
        UNABLE_TO_PROTECT             = 7288, -- You were unable to protect Captain Volker. Now leaving the battlefield.
        TESTIMONY_IS_TORN             = 7290, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7291, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7538, -- Currently, <number> members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7539, -- Currently, <number> members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7541, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7542, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7543, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7577, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7584, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7604, -- Entering the battlefield for [The Shadow Lord Battle/Where Two Paths Converge/Kindred Spirits/Survival of the Wisest/Smash! A Malevolent Menace/Kindred Spirits/The Shadow Lord Battle/True Love/A Fond Farewell/Kipdrix the Faithful]!
        NO_HIDE_AWAY                  = 7719, -- I have not been hiding away from my troubles!
        FEEL_MY_PAIN                  = 7720, -- Feel my twenty years of pain!
        YOUR_ANSWER                   = 7721, -- Is that your answer!?
        RETURN_TO_THE_DARKNESS        = 7722, -- Return with your soul to the darkness you came from!
        CANT_UNDERSTAND               = 7723, -- You--a man who has never lived bound by the chains of his country--how can you understand my pain!?
        BLADE_ANSWER                  = 7724, -- Let my blade be the answer!
    },
    mob =
    {
        GRAND_MARQUIS_CHOMIEL      = GetFirstID('Grand_Marquis_Chomiel'),
        RIKO_KUPENREICH            = GetFirstID('Riko_Kupenreich'),
        SHADOW_LORD_PHASE_1_OFFSET = GetTableOfIDs('Shadow_Lord')[1],
        SHADOW_LORD_PHASE_2_OFFSET = GetTableOfIDs('Shadow_Lord')[4],
        ZEID_BCNM_OFFSET           = GetFirstID('Zeid'),
    },
    npc =
    {
    },
}

return zones[xi.zone.THRONE_ROOM]
