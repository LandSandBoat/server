-----------------------------------
-- Area: Nyzul_Isle
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
        COMMENCE                      = 7302, -- Commencing %! Objective: Complete on-site objectives
        TIME_TO_COMPLETE              = 7312, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7313, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7317, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7318, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7319, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7320, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7329, -- <player> obtains the temporary item: <item>!
        TEMP_ITEM_OBTAINED            = 7330, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7331, -- <player> obtains <item>!
        ALREADY_HAVE_TEMP_ITEM        = 7354, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7357, -- loor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7359, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7360, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7361, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7362, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7363, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7364, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7365, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7366, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7367, -- Confirming operation procedure...
        OBJECTIVE_TEXT_OFFSET         = 7369, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7371, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7372, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7373, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7374, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7375, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7376, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7377, -- Time limit has been reduced by <number> [minute/minutes].
        MALFUNCTION                   = 7378, -- Security field malfunction.
        TOKEN_LOSS                    = 7379, -- Potential token reward reduced.
        RESTRICTION_JOB_ABILITIES     = 7381, -- Job abilities are restricted.
        RESTRICTION_WEAPON_SKILLS     = 7383, -- Weapon skills are restricted.
        RESTRICTION_WHITE_MAGIC       = 7385, -- White magic is restricted.
        RESTRICTION_BLACK_MAGIC       = 7387, -- Black magic is restricted.
        RESTRICTION_SONGS             = 7389, -- Songs are restricted.
        RESTRICTION_NINJITSU          = 7391, -- Ninjutsu is restricted.
        RESTRICTION_SUMMON_MAGIC      = 7393, -- Summon magic is restricted.
        RESTRICTION_BLUE_MAGIC        = 7395, -- Blue magic is restricted.
        AFFLICTION_ATTACK_SPEED_DOWN  = 7397, -- Afflicted by Attack Speed Down.
        AFFLICTION_CASTING_SPEED_DOWN = 7399, -- Afflicted by Casting Speed Down.
        AFFLICTION_STR_DOWN           = 7401, -- Afflicted by STR Down.
        AFFLICTION_DEX_DOWN           = 7403, -- Afflicted by DEX Down.
        AFFLICTION_VIT_DOWN           = 7405, -- Afflicted by VIT Down.
        AFFLICTION_AGI_DOWN           = 7407, -- Afflicted by AGI Down.
        AFFLICTION_INT_DOWN           = 7409, -- Afflicted by INT Down.
        AFFLICTION_MND_DOWN           = 7411, -- Afflicted by MND Down.
        AFFLICTION_CHR_DOWN           = 7413, -- Afflicted by CHR Down.
        RECEIVED_REGAIN_EFFECT        = 7415, -- Received Regain effect.
        RECEIVED_REGEN_EFFECT         = 7417, -- Received Regen effect.
        RECEIVED_REFRESH_EFFECT       = 7419, -- Received Refresh effect.
        RECEIVED_FLURRY_EFFECT        = 7421, -- Received Flurry effect.
        RECEIVED_CONCENTRATION_EFFECT = 7423, -- Received Concentration effect.
        RECEIVED_STR_BOOST            = 7425, -- Received STR Boost.
        RECEIVED_DEX_BOOST            = 7427, -- Received DEX Boost.
        RECEIVED_VIT_BOOST            = 7429, -- Received VIT Boost.
        RECEIVED_AGI_BOOST            = 7431, -- Received AGI Boost.
        RECEIVED_INT_BOOST            = 7433, -- Received INT Boost.
        RECEIVED_MND_BOOST            = 7435, -- Received MND Boost.
        RECEIVED_CHR_BOOST            = 7437, -- Received CHR Boost.
        WARNING_RESET_DISC            = 7438, -- The data on the <item> will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7470, -- New user confirmed. Issuing <item>.
        IN_OPERATION                  = 7488, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7489, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7491, -- You obtain <number> [token/tokens]!
        FLOOR_RECORD                  = 7492, -- Data up to and including Floor <number> has been recorded on your <item>.
        WELCOME_TO_FLOOR              = 7493, -- Transfer complete. Welcome to Floor <number>.
        FORMATION_GELINCIK            = 7512, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7513, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7514, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7515, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7516, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7517, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7518, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7519, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7520, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7521, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7522, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7523, -- <Phshooo>...
        NOT_POSSIBLE                  = 7524, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7525, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7526, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7527, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7528, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7529, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7530, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7531, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7532, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7533, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7534, -- Pray to whatever gods you serve.
        BEHOLD                        = 7535, -- Behold the power of my eldritch gaze!
        CARVE                         = 7536, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7537, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7538, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7539, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7540, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7541, -- Ugh... Has your god granted you the miracle you seek...?
        DIVINE_MIGHT                  = 7542, -- Incredible. Feel the infinite power of divine might! Alexander will lead Aht Urhgan to certain victory!
        SHALL_BE_JUDGED               = 7543, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7544, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7545, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7546, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7547, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7548, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7549, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7550, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7551, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7552, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
    },

    mob =
    {
        [51] = -- Nyzul Isle Investigation
        {
            ARCHAIC_RAMPART1    = 17092629,
            ARCHAIC_RAMPART2    = 17092630,
            OFFSET_REGULAR      = 17092631, -- Greatclaw
            DAHAK               = 17092823,
            OFFSET_NM           = 17092824, -- Bat Eye
            TAISAIJIN           = 17092913,
            OFFSET_GEARS        = 17092916, -- Gear
            MOKKE               = 17092944,
            LONG_HORNED_CHARIOT = 17092968,
            OFFSET_SPECIFIED    = 17092969, -- Heraldic Imp
            ADAMANTOISE         = 17092999,
        },

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
        },
    },

    npc =
    {
        TREASURE_COFFER =
        {
            17092611, 17092612, 17092614
        },

        TREASURE_CASKET =
        {
            17092609, 17092610, 17092613, 17092620
        },

        RUNE_OF_TRANSFER =
        {
            17093330, 17093331
        },

        -- Nyzul Isle Investigation
        RUNIC_LAMP_OFFSET   = GetFirstID('Runic_Lamp'),
        _257                = GetFirstID('_257'),
        _259                = GetFirstID('_259'),
        RUNE_TRANSFER_START = GetFirstID('Rune_of_Transfer_Start'),
        VENDING_BOX         = GetFirstID('Vending_Box'),

        -- Other instances
        WEATHER             = 17093423,
        QM1                 = 17093472,
        BLANK1              = 17093473,
        BLANK2              = 17093474,
        BLANK3              = 17093475,
        NASHMEIRA1          = 17093476,
        NASHMEIRA2          = 17093477,
        RAZFAHD             = 17093478,
        CSNPC1              = 17093479,
        GHATSAD             = 17093480,
        ALEXANDER           = 17093481,
        CSNPC2              = 17093482,
    }
}

return zones[xi.zone.NYZUL_ISLE]
