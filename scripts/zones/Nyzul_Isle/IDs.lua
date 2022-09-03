-----------------------------------
-- Area: Nyzul_Isle
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NYZUL_ISLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_TO_COMPLETE              = 7308, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7309, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7313, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7314, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7315, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7316, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        FORMATION_GELINCIK            = 7508, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7509, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7510, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7511, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7512, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7513, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7514, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7515, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7516, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7517, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7518, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7519, -- <Phshooo>...
        NOT_POSSIBLE                  = 7520, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7521, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7522, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7523, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7524, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7525, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7526, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7527, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7528, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7529, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7530, -- Pray to whatever gods you serve.
        BEHOLD                        = 7531, -- Behold the power of my eldritch gaze!
        CARVE                         = 7532, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7533, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7534, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7535, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7536, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7537, -- Ugh... Has your god granted you the miracle you seek...?
        SHALL_BE_JUDGED               = 7539, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7540, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7541, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7542, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7543, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7544, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7545, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7546, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7547, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7548, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
    },

    mob =
    {
        -- Path of Darkness
        [58] =
        {
            AMNAF_BLU          = 17093132,
            AMNAF_PSYCHEFLAYER = 17093133,
            IMPERIAL_GEAR1     = 17093134,
            IMPERIAL_GEAR2     = 17093135,
            IMPERIAL_GEAR3     = 17093136,
            IMPERIAL_GEAR4     = 17093137,
            NAJA               = 17093142,
        },

        [59] =
        {
            RAZFAHD   = 17093143,
            ALEXANDER = 17093144,
            RAUBAHN   = 17093145,
        }
    },

    npc =
    {
        _257       = 17093359,
        _259       = 17093361,
        QM1        = 17093472,
        BLANK1     = 17093473,
        BLANK2     = 17093474,
        BLANK3     = 17093475,
        NASHMEIRA1 = 17093476,
        NASHMEIRA2 = 17093477,
        RAZFAHD    = 17093478,
        CSNPC1     = 17093479,
        GHATSAD    = 17093480,
        ALEXANDER  = 17093481,
        CSNPC2     = 17093482,
        WEATHER    = 17093423,
    }
}

return zones[xi.zone.NYZUL_ISLE]
