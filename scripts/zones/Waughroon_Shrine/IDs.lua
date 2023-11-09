-----------------------------------
-- Area: Waughroon_Shrine
-----------------------------------
zones = zones or {}

zones[xi.zone.WAUGHROON_SHRINE] =
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
        CONQUEST_BASE                 = 7061, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7570, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7577, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        YOU_DECIDED_TO_SHOW_UP        = 7691, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7692, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7693, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7694, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7695, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7696, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7697, -- Ungh... That'll hurt in the morning...
        ONE_TENTACLE_WOUNDED          = 7715, -- One of the sea creature's tentacles have been wounded.
        ALL_TENTACLES_WOUNDED         = 7716, -- All of the sea creature's tentacles have been wounded.
        SCORPION_IS_STUNNED           = 7717, -- The platoon scorpion does not have enough energy to attack!
        SCORPION_IS_BOUND             = 7718, -- The platoon scorpion's legs are lodged in the rocks!
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7734, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7735, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7736, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7737, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7738, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7739, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7740, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },

    mob =
    {
        ATORI_TUTORI_QM =
        {
            17367332,
            17367333,
            17367334,
        },
    },

    npc =
    {
    },

    operationDesertSwarm =
    {
        [1] =
        {
            17367266,
            17367267,
            17367268,
            17367269,
            17367270,
            17367271,
        },

        [2] =
        {
            17367273,
            17367274,
            17367275,
            17367276,
            17367277,
            17367278,
        },

        [3] =
        {
            17367280,
            17367281,
            17367282,
            17367283,
            17367284,
            17367285,
        },
    },
}

return zones[xi.zone.WAUGHROON_SHRINE]
