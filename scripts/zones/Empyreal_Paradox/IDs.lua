-----------------------------------
-- Area: Empyreal_Paradox
-----------------------------------
zones = zones or {}

zones[xi.zone.EMPYREAL_PARADOX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7077, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7092, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7383, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7384, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7386, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7422, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7429, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7445, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7608, -- Entering the battlefield for [Dawn/Apocalypse Nigh/Both Paths Taken/★Dawn/The Winds of Time/Sealed Fate]!
        PRISHE_TEXT                   = 7710, -- You're about to learn how strong the will to live makes us!
        SELHTEUS_TEXT                 = 7723, -- The...Emptiness... Is this...how it was meant...to be...?
        PROMATHIA_TEXT                = 7726, -- Give thyself to the apathy within...
        AIR_WARPED_AND_DISTORTED      = 7824, -- The air before you appears warped and distorted...
    },
    mob =
    {
        KAMLANAUT = GetFirstID('Kamlanaut'),
        PROMATHIA = GetFirstID('Promathia'),
    },
    npc =
    {
    },
}

return zones[xi.zone.EMPYREAL_PARADOX]
