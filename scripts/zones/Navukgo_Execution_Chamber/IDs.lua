-----------------------------------
-- Area: Navukgo_Execution_Chamber
-----------------------------------
zones = zones or {}

zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7225, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7240, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7265, -- The door is locked.
        TESTIMONY_IS_TORN             = 7283, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7284, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7531, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7532, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7534, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7535, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7536, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7570, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7577, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7598, -- Entering the battlefield for [Tough Nut to Crack/Happy Caster/Omens/Achieving True Power/Shield of Diplomacy]!
        KARABABA_ENOUGH               = 7643, -- That's quite enough...
        KARABABA_ROUGH                = 7644, -- Time for me to start playing rough!
        KARABARA_FIRE                 = 7645, -- Fuel for the fire! It doesn't pay to invoke my ire!
        KARABARA_ICE                  = 7646, -- Well, if you won't play nice, I'll put your sorry hide on ice!
        KARABARA_WIND                 = 7647, -- This battle is growing stale. How about we have a refreshing gale!
        KARABARA_EARTH                = 7648, -- Sometimes it comes as quite a shock, how much damage you can deal with simple rock!
        KARABARA_LIGHTNING            = 7649, -- How I love to rip things asunder! Witness the power of lightning and thunder!
        KARABARA_WATER                = 7650, -- Water is more dangerous than most expect. Never fear, I'll teach you respect!
        KARABABA_QUIT                 = 7658, -- What a completely useless shield. It's time for me to quit the field.
    },
    mob =
    {
        KARABABA_OFFSET = 17039401,
        IMMORTAL_FLAN2  = 17039375, -- IMMORTAL_FLAN1 always pops in battlefield, other flans pop depending on party size
        IMMORTAL_FLAN3  = 17039376,
        IMMORTAL_FLAN4  = 17039377,
        IMMORTAL_FLAN5  = 17039378,
        IMMORTAL_FLAN6  = 17039379,
    },
    npc =
    {
    },
}

return zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
