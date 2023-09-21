-----------------------------------
-- Area: Boneyard_Gully
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BONEYARD_GULLY] =
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
        PARTY_MEMBERS_HAVE_FALLEN     = 7410, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7417, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7433, -- Tallying conquest results...
        HOW_IS_THIS_POSSIBLE          = 7717, -- H-how...is this possible...?
        TIME_WASTED                   = 7718, -- Enough time has been wasted!
        FOLLOW_LEAD                   = 7719, -- Follow my lead!
        TIME_TO_DIE                   = 7720, -- Time to die!
        SINS_JUDGED                   = 7721, -- Your sins will be judged!
        I_LOST                        = 7728, -- I...I can't have lost...
        READY_TO_REAP                 = 7729, -- Ready to rrrreap!
        MASSACRE_BEGIN                = 7730, -- Let the massacrrre begin!
        SUGARPLUM                     = 7731, -- Just for you, sugarplum!
        HONEYCAKES                    = 7732, -- In your eye, honeycakes!
        READY_TO_RUMBLE               = 7740, -- Ready to rrrumble!
        MITHRAN_TRACKERS              = 7741, -- Mithran Trackers! Time to hunt!
        MY_TURN                       = 7742, -- My turn! My Turn!
        YOURE_MINE                    = 7743, -- You're mine!
        TUCHULCHA_SANDPIT             = 7752, -- Tuchulcha retreats beneath the soil!
        GIANT_ANTLION                 = 7753, -- A giant antlion appears! This one may be carrying an armoury crate!
        ANTLION_ESCAPED               = 7754, -- It's the antlion that escaped earlier!
        SMALL_ANTLION                 = 7755, -- A small antlion appears! It doesn't seem large enough to carry an armoury crate.
        TUCHCULA_CRATE                = 7756, -- Tuchulcha drops an armoury crate!
        BLOOD_RACING                  = 7807, -- I'll get your blood rrracing!
        SCENT_OF_BLOOD                = 7808, -- Ah, the scent of frrrresh blood!
        AT_MY_BEST                    = 7811, -- Even at my best...
        END_THE_HUNT                  = 7812, -- Time to end the hunt! Go for the jugular!
        ADVENTURER_STEAK              = 7813, -- Dinner time! Tonight we're having "Adventurer Steak"!
    },
    mob =
    {
        SHIKAREE_HEADWIND_START = 16809985,
        SHIKAREE_HEADWIND_END   = 16809997,
    },
    npc =
    {
    },
    sheepInAntlionsClothing =
    {
        [1] =
        {
            TUCHULCHA_ID      = 16810001,
            SWIFT_HUNTER_ID   = 16810002,
            SHREWD_HUNTER_ID  = 16810003,
            ARMORED_HUNTER_ID = 16810004,
            -- List of positions used to set
            -- (1) Tuchulcha's location after using sand pit
            -- (2) The starting position of the hunters
            ant_positions =
            {
                { -588.45, -4.34, -461.28, 171 },
                { -572.16, -3.29, -466.94, 171 },
                { -565.25,  0.06, -480.63, 171 },
                { -550.94,  0.25, -483.01, 171 },
                { -535.86, -0.55, -491.57, 171 },
                { -522.41,  0.00, -517.34, 171 },
                { -515.09,  0.61, -501.09, 171 },
                { -518.50,  0.17, -487.47, 171 },
                { -527.98,  0.37, -474.86, 171 },
                { -535.84,  0.17, -457.00, 171 },
                { -543.24,  0.32, -446.15, 171 },
                { -553.83,  0.86, -450.61, 171 },
                { -574.58, -0.17, -452.69, 171 },
                { -568.41,  2.98, -441.37, 171 },
                { -582.08,  0.77, -435.93, 171 },
                { -575.61,  1.49, -422.20, 171 },
                { -550.10,  1.32, -415.49, 171 },
            },
        },
        [2] =
        {
            TUCHULCHA_ID      = 16810007,
            SWIFT_HUNTER_ID   = 16810008,
            SHREWD_HUNTER_ID  = 16810009,
            ARMORED_HUNTER_ID = 16810010,
            ant_positions =
            {
                { -588.45 + 560, -4.34, -461.28 + 560, 171 },
                { -572.16 + 560, -3.29, -466.94 + 560, 171 },
                { -565.25 + 560,  0.06, -480.63 + 560, 171 },
                { -550.94 + 560,  0.25, -483.01 + 560, 171 },
                { -535.86 + 560, -0.55, -491.57 + 560, 171 },
                { -522.41 + 560,  0.00, -517.34 + 560, 171 },
                { -515.09 + 560,  0.61, -501.09 + 560, 171 },
                { -518.50 + 560,  0.17, -487.47 + 560, 171 },
                { -527.98 + 560,  0.37, -474.86 + 560, 171 },
                { -535.84 + 560,  0.17, -457.00 + 560, 171 },
                { -543.24 + 560,  0.32, -446.15 + 560, 171 },
                { -553.83 + 560,  0.86, -450.61 + 560, 171 },
                { -574.58 + 560, -0.17, -452.69 + 560, 171 },
                { -568.41 + 560,  2.98, -441.37 + 560, 171 },
                { -582.08 + 560,  0.77, -435.93 + 560, 171 },
                { -575.61 + 560,  1.49, -422.20 + 560, 171 },
                { -550.10 + 560,  1.32, -415.49 + 560, 171 },
            },
        },
        [3] =
        {
            TUCHULCHA_ID      = 16810013,
            SWIFT_HUNTER_ID   = 16810014,
            SHREWD_HUNTER_ID  = 16810015,
            ARMORED_HUNTER_ID = 16810016,
            ant_positions =
            {
                { -588.45 + 1040, -4.34, -461.28 + 1040, 171 },
                { -572.16 + 1040, -3.29, -466.94 + 1040, 171 },
                { -565.25 + 1040,  0.06, -480.63 + 1040, 171 },
                { -550.94 + 1040,  0.25, -483.01 + 1040, 171 },
                { -535.86 + 1040, -0.55, -491.57 + 1040, 171 },
                { -522.41 + 1040,  0.00, -517.34 + 1040, 171 },
                { -515.09 + 1040,  0.61, -501.09 + 1040, 171 },
                { -518.50 + 1040,  0.17, -487.47 + 1040, 171 },
                { -527.98 + 1040,  0.37, -474.86 + 1040, 171 },
                { -535.84 + 1040,  0.17, -457.00 + 1040, 171 },
                { -543.24 + 1040,  0.32, -446.15 + 1040, 171 },
                { -553.83 + 1040,  0.86, -450.61 + 1040, 171 },
                { -574.58 + 1040, -0.17, -452.69 + 1040, 171 },
                { -568.41 + 1040,  2.98, -441.37 + 1040, 171 },
                { -582.08 + 1040,  0.77, -435.93 + 1040, 171 },
                { -575.61 + 1040,  1.49, -422.20 + 1040, 171 },
                { -550.10 + 1040,  1.32, -415.49 + 1040, 171 },
            },
        },
    },
    shellWeDance =
    {
        [1] =
        {
            PARATA_ID        = 16810024,
            BLADMALL_ID      = 16810025,
            PARATA_PET_IDS   = { 16810026, 16810027, 16810028 },
            BLADMALL_PET_IDS = { 16810029, 16810030, 16810031 },
        },
        [2] =
        {
            PARATA_ID        = 16810033,
            BLADMALL_ID      = 16810034,
            PARATA_PET_IDS   = { 16810035, 16810036, 16810037 },
            BLADMALL_PET_IDS = { 16810038, 16810039, 16810040 },
        },
        [3] =
        {
            PARATA_ID        = 16810042,
            BLADMALL_ID      = 16810043,
            PARATA_PET_IDS   = { 16810044, 16810045, 16810046 },
            BLADMALL_PET_IDS = { 16810047, 16810048, 16810049 },
        },
    },
}

return zones[xi.zone.BONEYARD_GULLY]
