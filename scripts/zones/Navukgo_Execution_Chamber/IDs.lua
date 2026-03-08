-----------------------------------
-- Area: Navukgo_Execution_Chamber
-----------------------------------
zones = zones or {}

zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7233, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7248, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7273, -- The door is locked.
        TESTIMONY_IS_TORN             = 7291, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7292, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7539, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7540, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7542, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7543, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7544, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7578, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7585, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPERIAL_ORDER_BREAKS         = 7593, -- The <item> breaks!
        ENTERING_THE_BATTLEFIELD_FOR  = 7606, -- Entering the battlefield for [Tough Nut to Crack/Happy Caster/Omens/Achieving True Power/Shield of Diplomacy/An Imperial Heist]!
        YOUR_LEVEL_LIMIT_IS_NOW_75    = 7646, -- Your level limit is now 75.
        KARABABA_ENOUGH               = 7651, -- That's quite enough...
        KARABABA_ROUGH                = 7652, -- Time for me to start playing rough!
        KARABARA_FIRE                 = 7653, -- Fuel for the fire! It doesn't pay to invoke my ire!
        KARABARA_ICE                  = 7654, -- Well, if you won't play nice, I'll put your sorry hide on ice!
        KARABARA_WIND                 = 7655, -- This battle is growing stale. How about we have a refreshing gale!
        KARABARA_EARTH                = 7656, -- Sometimes it comes as quite a shock, how much damage you can deal with simple rock!
        KARABARA_LIGHTNING            = 7657, -- How I love to rip things asunder! Witness the power of lightning and thunder!
        KARABARA_WATER                = 7658, -- Water is more dangerous than most expect. Never fear, I'll teach you respect!
        KARABABA_QUIT                 = 7666, -- What a completely useless shield. It's time for me to quit the field.
    },
    mob =
    {
        KHIMAIRA_13   = GetFirstID('Khimaira_13'),
        IMMORTAL_FLAN = GetFirstID('Immortal_Flan'),
        SHAMARHAAN    = GetFirstID('Shamarhaan'),
    },
    npc =
    {
    },
}

return zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
