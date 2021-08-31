-----------------------------------
-- Area: Horlais_Peak
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.HORLAIS_PEAK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE   = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                = 6389, -- Obtained: <item>.
        GIL_OBTAINED                 = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6392, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED               = 6398, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY      = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS          = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                = 7053, -- Tallying conquest results...
        YOU_DECIDED_TO_SHOW_UP       = 7746, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY  = 7747, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY        = 7748, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS  = 7749, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER = 7750, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP        = 7751, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING  = 7752, -- Ungh... That'll hurt in the morning...
        EVIL_OSCAR_BEGINS_FILLING    = 7939, -- Evil Oscar begins filling his lungs with the foul air around him...
        PROMISE_ME_YOU_WONT_GO_DOWN  = 7955, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP    = 7956, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH   = 7957, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING   = 7958, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL              = 7959, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                 = 7960, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU            = 7961, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
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
