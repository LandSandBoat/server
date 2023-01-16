-----------------------------------
-- Area: Throne_Room
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.THRONE_ROOM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7224, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7239, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7530, -- Currently, <number> members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7531, -- Currently, <number> members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7533, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7594, -- Entering the battlefield for [The Shadow Lord Battle/Where Two Paths Converge/Kindred Spirits/Survival of the Wisest/Smash! A Malevolent Menace/Kindred Spirits/The Shadow Lord Battle/True Love/A Fond Farewell/Kipdrix the Faithful]!
        NO_HIDE_AWAY                  = 7709, -- I have not been hiding away from my troubles!
        FEEL_MY_PAIN                  = 7710, -- Feel my twenty years of pain!
        YOUR_ANSWER                   = 7711, -- Is that your answer!?
        RETURN_TO_THE_DARKNESS        = 7712, -- Return with your soul to the darkness you came from!
        CANT_UNDERSTAND               = 7713, -- You--a man who has never lived bound by the chains of his country--how can you understand my pain!?
        BLADE_ANSWER                  = 7714, -- Let my blade be the answer!
    },
    mob =
    {
        SHADOW_LORD_PHASE_1_OFFSET = 17453057,
        SHADOW_LORD_PHASE_2_OFFSET = 17453060,
        ZEID_BCNM_OFFSET           = 17453063,
    },
    npc =
    {
    },
}

return zones[xi.zone.THRONE_ROOM]
