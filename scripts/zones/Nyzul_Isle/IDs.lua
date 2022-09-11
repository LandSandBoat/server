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
        COMMENCE                      = 7298, -- Commencing %! Objective: Complete on-site objectives
        TIME_TO_COMPLETE              = 7308, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7309, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7313, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7314, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7315, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7316, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7325, -- <player> obtains the temporary item: <item>
        PLAYER_OBTAINS_ITEM           = 7327, -- <player> obtains <item>
        TEMP_ITEM_OBTAINED            = 7349, -- Obtained temporary item: <item>
        ALREADY_HAVE_TEMP_ITEM        = 7350, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7353, -- Floor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7355, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7356, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7357, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7358, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7359, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7360, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7361, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7362, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7363, -- Confirming operation procedure...
        OBJECTIVE_TEXT_OFFSET         = 7365, -- Objective: Eliminate enemy leader.
        ELIMINATE_ENEMY_LEADER        = 7366, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7367, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7368, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7369, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7370, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7371, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7372, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7373, -- Time limit has been reduced by <minute/minutes>.
        MALFUNCTION                   = 7374, -- Security field malfunction.
        TOKEN_LOSS                    = 7375, -- Potential token reward reduced.
        RESTRICTION_JOB_ABILITIES     = 7377, -- Job abilities are restricted.
        RESTRICTION_WEAPON_SKILLS     = 7379, -- Weapon skills are restricted.
        RESTRICTION_WHITE_MAGIC       = 7381, -- White magic is restricted.
        RESTRICTION_BLACK_MAGIC       = 7383, -- Black Magic is restricted.
        RESTRICTION_SONGS             = 7385, -- Songs are restricted.
        RESTRICTION_NINJITSU          = 7387, -- Ninjutsu is restricted.
        RESTRICTION_SUMMON_MAGIC      = 7389, -- Summon Magic is restricted.
        RESTRICTION_BLUE_MAGIC        = 7391, -- Blue Magic is restricted.
        AFFLICTION_ATTACK_SPEED_DOWN  = 7393, -- Afflicted by Attack Speed Down.
        AFFLICTION_CASTING_SPEED_DOWN = 7395, -- Afflicted by Casting Speed Down.
        AFFLICTION_STR_DOWN           = 7397, -- Afflicted by STR Down.
        AFFLICTION_DEX_DOWN           = 7399, -- Afflicted by DEX Down.
        AFFLICTION_VIT_DOWN           = 7401, -- Afflicted by VIT Down.
        AFFLICTION_AGI_DOWN           = 7403, -- Afflicted by AGI Down.
        AFFLICTION_INT_DOWN           = 7405, -- Afflicted by INT Down.
        AFFLICTION_MND_DOWN           = 7407, -- Afflicted by MND Down.
        AFFLICTION_CHR_DOWN           = 7409, -- Afflicted by CHR Down.
        RECEIVED_REGAIN_EFFECT        = 7411, -- Received Regain effect.
        RECEIVED_REGEN_EFFECT         = 7413, -- Received Regen effect.
        RECEIVED_REFRESH_EFFECT       = 7415, -- Received Refresh effect.
        RECEIVED_FLURRY_EFFECT        = 7417, -- Received Flurry effect.
        RECEIVED_CONCENTRATION_EFFECT = 7419, -- Received Concentration effect.
        RECEIVED_STR_BOOST            = 7421, -- Received STR Boost.
        RECEIVED_DEX_BOOST            = 7423, -- Received DEX Boost.
        RECEIVED_VIT_BOOST            = 7425, -- Received VIT Boost.
        RECEIVED_AGI_BOOST            = 7427, -- Received AGI Boost.
        RECEIVED_INT_BOOST            = 7429, -- Received INT Boost.
        RECEIVED_MND_BOOST            = 7431, -- Received MND Boost.
        RECEIVED_CHR_BOOST            = 7433, -- Received CHR Boost.
        WARNING_RESET_DISC            = 7434, -- The data on the Runic Disc will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7466, -- New user confirmed.
        IN_OPERATION                  = 7484, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7485, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7487, -- You obtain <tokens>.
        FLOOR_RECORD                  = 7488, -- Data up to and including Floor <floor> has been recorded on your Runic Disk.
        WELCOME_TO_FLOOR              = 7489, -- Transfer complete. Welcome to Floor <floor>.
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
        DIVINE_MIGHT                  = 7538, -- Incredible. Feel the infinite power of divine might! Alexander will lead Aht Urhgan to certain victory!
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
        [51] =
        {
            ARCHAIC_RAMPART1 = 17092629,
            ARCHAIC_RAMPART2 = 17092630,
            DAHAK            = 17092823,
            BAT_EYE          = 17092824,
            TAISAIJIN        = 17092913,
            ADAMANTOISE      = 17092999,
            CERBERUS         = 17093004,
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
        RUNIC_LAMP_1        = 17093332,
        RUNIC_LAMP_2        = 17093333,
        RUNIC_LAMP_3        = 17093334,
        RUNIC_LAMP_4        = 17093335,
        RUNIC_LAMP_5        = 17093336,
        _257                = 17093359,
        _259                = 17093361,
        RUNE_TRANSFER_START = 17093429,
        VENDING_BOX         = 17093430,

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
