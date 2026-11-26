-----------------------------------
-- Area: Sacrificial_Chamber
-----------------------------------
zones = zones or {}

zones[xi.zone.SACRIFICIAL_CHAMBER] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7237, -- Your time in the battlefield is up! Now exiting...
        CLEARED_BUT_MEMBERS_ENGAGED   = 7239, -- You are cleared to enter the battlefield, but you cannot while party members are engaged in combat.
        PARTY_MEMBERS_ARE_ENGAGED     = 7252, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7256, -- The old wooden door is locked tight.
        MEMBERS_OF_YOUR_PARTY         = 7543, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7544, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7546, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7547, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7548, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7582, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7589, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        D_SHANTOTTO_WELCOME           = 7649, -- We warmly welcome you to the place of your unmaking.
        SHANTOTTO_BREAD               = 7650, -- From your ground bones, a loaf of bread we shall be baking.
        D_SHANTOTTO_CURSE             = 7651, -- We shall curse you unto death! Prepare to breathe your final breath!
        SHANTOTTO_BEG_TO_DIE          = 7652, -- We will make you beg to die! Six fulms under you will lie!
        D_SHANTOTTO_NO_QUARTER        = 7653, -- Naughty children shall receive no quarter! Curl up and die, this is your empress's order!
        SHANTOTTO_OVERSTAYED          = 7654, -- You've long overstayed your welcome! The punishment will be brutal and gruesome!
        D_SHANTOTTO_SLOW_OR_FAST      = 7655, -- Which way do you like it--slow or fast? Should you lose a limb, be not aghast!
        SHANTOTTO_NEVER_BORN          = 7656, -- You'll wish you were never born! From your torso limbs will be torn!
        SHANTOTTO_WICKED_FRIGHT       = 7657, -- Steel yourself for a wicked fright!
        SHANTOTTO_PANTS_ALIGHT        = 7658, -- We shall set your pants alight!
        D_SHANTOTTO_BOW_BEFORE_MIGHT  = 7659, -- The world shall bow before our might!
        D_SHANTOTTO_DEFEATED          = 7660, -- H-how could this be? This outcome, we did not foresee...
        SHANTOTTO_DEFEATED            = 7661, -- Be this a dream? Or is it real? This ending falls sorely short of ideal...
        D_SHANTOTTO_VICTORY           = 7662, -- 'Twas high time you were made to know that your abilities are purely for show. Ohohohohoho!
        SHANTOTTO_VICTORY             = 7663, -- A fitting end for a talentless crew that tried to bite off more than it could chew. Ohohohohoho!
        ABSORB_ANCIENT_RUNES          = 7664, -- Your body absorbs the power held within the ancient runes!
        CANNOT_ENTER_WITH_KEY         = 7668, -- You cannot enter the battlefield for Project: Shantottofication with a <keyitem> in your possession.
        ENTERING_THE_BATTLEFIELD_FOR  = 7680, -- Entering the battlefield for [The Temple of Uggalepih/Jungle Boogymen/Amphibian Assault/Project: Shantottofication/Whom Wilt Thou Call/★Jungle Boogymen/★Amphibian Assault]!
    },
    mob =
    {
        GRAVITON             =   GetFirstID('Graviton'),
        QULL_THE_FALLSTOPPER   = GetFirstID('Qull_the_Fallstopper'),
        SABLE_TONGUED_GONBERRY = GetFirstID('Sable-tongued_Gonberry'),
        SHANTOTTO              = GetFirstID('Shantotto'), -- ASA-13, D. Shantotto at +1, one pair per area
    },
    npc =
    {
        MAHOGANY_DOOR = GetFirstID('_4j0'), -- Battlefield entrance, ASA-12 and ASA-13
    },
}

return zones[xi.zone.SACRIFICIAL_CHAMBER]
