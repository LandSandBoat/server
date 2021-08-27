-----------------------------------
-- Area: QuBia_Arena
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.QUBIA_ARENA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6389, -- Obtained: <item>.
        GIL_OBTAINED                 = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS          = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                = 7053, -- Tallying conquest results...
        FLAT_PREPARE                 = 7626, -- I am Trion, of San d'Oria!
        FLAT_LAND                    = 7627, -- Feel the fire of my forefathers!
        RLB_PREPARE                  = 7628, -- The darkness before me that shrouds the light of good...
        RLB_LAND                     = 7629, -- ...Return to the hell you crawled out from!
        SAVAGE_PREPARE               = 7630, -- The anger, the pain, and the will to survive... Let the spirit of San d'Oria converge within this blade.
        SAVAGE_LAND                  = 7631, -- And with this blade I will return the glory to my kingdom's people!
        YOU_DECIDED_TO_SHOW_UP       = 7632, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY  = 7633, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY        = 7634, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS  = 7635, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER = 7636, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP        = 7637, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING  = 7638, -- Ungh... That'll hurt in the morning...
        PROMISE_ME_YOU_WONT_GO_DOWN  = 8008, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP    = 8009, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH   = 8010, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING   = 8011, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL              = 8012, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                 = 8013, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU            = 8014, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },
    mob =
    {
        HEIR_TO_THE_LIGHT_OFFSET   = 17621014,
        ATORI_TUTORI_QM            =
        {
            17621302,
            17621303,
            17621304,
        },
    },
    npc =
    {
    },
}

return zones[xi.zone.QUBIA_ARENA]
