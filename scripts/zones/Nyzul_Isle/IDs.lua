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
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6393, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6397, -- You obtain <number> <item>!
        COMMENCE                      = 7293, -- Commencing. Complete on-site objectives
        TIME_TO_COMPLETE              = 7303, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7304, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7308, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7309, -- Time remaining: <number> [second/seconds] (Earth time).
        KI_FADES                      = 7310, -- The <ki> fades into nothingness...
        PARTY_FALLEN                  = 7311, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7320, -- <player> obtains the temporary item: <item>
        PLAYER_OBTAINS_ITEM           = 7322, -- <player> obtains <item>
        TEMP_ITEM_OBATINED            = 7344, -- Obtained temporary item: <item>
        ALREADY_HAVE_TEMP_ITEM        = 7345, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7348, -- Floor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7350, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7351, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7352, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7353, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7354, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7355, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7356, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7357, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7358, -- Confirming operstion procedure.
        ELIMINATE_ENEMY_LEADER        = 7361, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7362, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7363, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7364, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7365, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7366, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7367, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7368, -- Time limit has been reduced by <minute/minutes>.
        MALFUNCTION                   = 7369, -- Security field malfunction.
        TOKEN_LOSS                    = 7370, -- Potential token reward reduced.
        WARNING_RESET_DISC            = 7429, -- The data on the Runic Disc will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7461, -- New user confirmed.
        IN_OPERATION                  = 7479, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7480, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7482, -- You obtain <tokens>.
        FLOOR_RECORD                  = 7483, -- Data up to and including Floor <floor> has been recorded on your Runic Disk.
        WELCOME_TO_FLOOR              = 7484, -- Transfer complete. Welcome to Floor <floor>.
        FORMATION_GELINCIK            = 7503, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7504, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7505, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7506, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7507, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7508, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7509, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7510, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7511, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7512, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7513, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7514, -- <Phshooo>...
        NOT_POSSIBLE                  = 7515, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7516, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7517, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7518, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7519, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7520, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7521, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7522, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7523, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7524, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7525, -- Pray to whatever gods you serve.
        BEHOLD                        = 7526, -- Behold the power of my eldritch gaze!
        CARVE                         = 7527, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7528, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7529, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7530, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7531, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7532, -- Ugh... Has your god granted you the miracle you seek...?
        SHALL_BE_JUDGED               = 7534, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7535, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7536, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7537, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7538, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7539, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7540, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7541, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7542, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7543, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
    },

    mob =
    {
        [xi.assaultUtil.assaultArea.NYZUL_ISLE] =
        {
            ARCHAIC_RAMPART1    = 17092629,
            ARCHAIC_RAMPART2    = 17092630,
            DAHAK               = 17092823,
            BAT_EYE             = 17092824,
            TAISAIJIN           = 17092913,
            ADAMANTOISE         = 17092999,
            CERBERUS            = 17093004,
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
        RUNIC_LAMP_1        = 17093332,
        RUNIC_LAMP_2        = 17093333,
        RUNIC_LAMP_3        = 17093334,
        RUNIC_LAMP_4        = 17093335,
        RUNIC_LAMP_5        = 17093336,
        _257                = 17093359,
        _259                = 17093361,
        RUNE_TRANSFER_START = 17093429,
        VENDING_BOX         = 17093430,
    }
}

return zones[xi.zone.NYZUL_ISLE]
