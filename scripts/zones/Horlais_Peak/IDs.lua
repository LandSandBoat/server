-----------------------------------
-- Area: Horlais_Peak
-----------------------------------
zones = zones or {}

zones[xi.zone.HORLAIS_PEAK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        YOU_DECIDED_TO_SHOW_UP        = 7754, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7755, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7756, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7757, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7758, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7759, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7760, -- Ungh... That'll hurt in the morning...
        EVIL_OSCAR_BEGINS_FILLING     = 7947, -- Evil Oscar begins filling his lungs with the foul air around him...
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7963, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7964, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7965, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7966, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7967, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7968, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7969, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },
    mob =
    {
        ATORI_TUTORI_QM =
        {
            17346789,
            17346790,
            17346791,
        },
    },
    npc =
    {
    },
}

return zones[xi.zone.HORLAIS_PEAK]
