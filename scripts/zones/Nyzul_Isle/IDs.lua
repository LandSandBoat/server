-----------------------------------
-- Area: Nyzul_Isle
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/missions")
-----------------------------------

zones = zones or {}

zones[xi.zone.NYZUL_ISLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6389, -- Obtained: <item>.
        GIL_OBTAINED                  = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6393, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6394, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6398, -- You obtain <number> <item>!
        COMMENCE                      = 7297, -- Commencing. Complete on-site objectives
        TIME_TO_COMPLETE              = 7307, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7308, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7312, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7313, -- Time remaining: <number> [second/seconds] (Earth time).
        KI_FADES                      = 7314, -- The <ki> fades into nothingness...
        PARTY_FALLEN                  = 7315, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7324, -- <player> obtains the temporary item: <item>
        PLAYER_OBTAINS_ITEM           = 7326, -- <player> obtains <item>
        TEMP_ITEM_OBATINED            = 7348, -- Obtained temporary item: <item>
        ALREADY_HAVE_TEMP_ITEM        = 7349, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7352, -- Floor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7354, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7355, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7356, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7357, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7358, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7359, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7360, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7361, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7362, -- Confirming operstion procedure.
        ELIMINATE_ENEMY_LEADER        = 7365, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7366, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7367, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7368, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7369, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7370, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7371, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7372, -- Time limit has been reduced by <minute/minutes>.
        MALFUNCTION                   = 7373, -- Security field malfunction.
        TOKEN_LOSS                    = 7374, -- Potential token reward reduced.
        WARNING_RESET_DISC            = 7433, -- The data on the Runic Disc will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7465, -- New user confirmed.
        IN_OPERATION                  = 7483, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7484, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7486, -- You obtain <tokens>.
        FLOOR_RECORD                  = 7487, -- Data up to and including Floor <floor> has been recorded on your Runic Disk.
        WELCOME_TO_FLOOR              = 7488, -- Transfer complete. Welcome to Floor <floor>.
        FORMATION_GELINCIK            = 7507, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7508, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7509, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7510, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7511, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7512, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7513, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7514, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7515, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7516, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7517, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7518, -- <Phshooo>...
        NOT_POSSIBLE                  = 7519, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7520, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7521, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7522, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7523, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7524, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7525, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7526, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7527, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7528, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7529, -- Pray to whatever gods you serve.
        BEHOLD                        = 7530, -- Behold the power of my eldritch gaze!
        CARVE                         = 7531, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7532, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7533, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7534, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7535, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7536, -- Ugh... Has your god granted you the miracle you seek...?
        SHALL_BE_JUDGED               = 7538, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7539, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7540, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7541, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7542, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7543, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7544, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7545, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7546, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7547, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
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
