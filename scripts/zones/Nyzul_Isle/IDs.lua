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
        COMMENCE                      = 7307, -- Commencing %! Objective: Complete on-site objectives
        TIME_TO_COMPLETE              = 7317, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7318, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7322, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7323, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7324, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7325, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7334, -- <player> obtains the temporary item: <item>!
        TEMP_ITEM_OBTAINED            = 7335, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7336, -- <player> obtains <item>!
        ALREADY_HAVE_TEMP_ITEM        = 7359, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7362, -- loor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7364, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7365, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7366, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7367, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7368, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7369, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7370, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7371, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7372, -- Confirming operation procedure...
        OBJECTIVE_TEXT_OFFSET         = 7374, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7376, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7377, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7378, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7379, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7380, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7381, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7382, -- Time limit has been reduced by <number> [minute/minutes].
        MALFUNCTION                   = 7383, -- Security field malfunction.
        TOKEN_LOSS                    = 7384, -- Potential token reward reduced.
        RESTRICTION_JOB_ABILITIES     = 7386, -- Job abilities are restricted.
        RESTRICTION_WEAPON_SKILLS     = 7388, -- Weapon skills are restricted.
        RESTRICTION_WHITE_MAGIC       = 7390, -- White magic is restricted.
        RESTRICTION_BLACK_MAGIC       = 7392, -- Black magic is restricted.
        RESTRICTION_SONGS             = 7394, -- Songs are restricted.
        RESTRICTION_NINJITSU          = 7396, -- Ninjutsu is restricted.
        RESTRICTION_SUMMON_MAGIC      = 7398, -- Summon magic is restricted.
        RESTRICTION_BLUE_MAGIC        = 7400, -- Blue magic is restricted.
        AFFLICTION_ATTACK_SPEED_DOWN  = 7402, -- Afflicted by Attack Speed Down.
        AFFLICTION_CASTING_SPEED_DOWN = 7404, -- Afflicted by Casting Speed Down.
        AFFLICTION_STR_DOWN           = 7406, -- Afflicted by STR Down.
        AFFLICTION_DEX_DOWN           = 7408, -- Afflicted by DEX Down.
        AFFLICTION_VIT_DOWN           = 7410, -- Afflicted by VIT Down.
        AFFLICTION_AGI_DOWN           = 7412, -- Afflicted by AGI Down.
        AFFLICTION_INT_DOWN           = 7414, -- Afflicted by INT Down.
        AFFLICTION_MND_DOWN           = 7416, -- Afflicted by MND Down.
        AFFLICTION_CHR_DOWN           = 7418, -- Afflicted by CHR Down.
        RECEIVED_REGAIN_EFFECT        = 7420, -- Received Regain effect.
        RECEIVED_REGEN_EFFECT         = 7422, -- Received Regen effect.
        RECEIVED_REFRESH_EFFECT       = 7424, -- Received Refresh effect.
        RECEIVED_FLURRY_EFFECT        = 7426, -- Received Flurry effect.
        RECEIVED_CONCENTRATION_EFFECT = 7428, -- Received Concentration effect.
        RECEIVED_STR_BOOST            = 7430, -- Received STR Boost.
        RECEIVED_DEX_BOOST            = 7432, -- Received DEX Boost.
        RECEIVED_VIT_BOOST            = 7434, -- Received VIT Boost.
        RECEIVED_AGI_BOOST            = 7436, -- Received AGI Boost.
        RECEIVED_INT_BOOST            = 7438, -- Received INT Boost.
        RECEIVED_MND_BOOST            = 7440, -- Received MND Boost.
        RECEIVED_CHR_BOOST            = 7442, -- Received CHR Boost.
        WARNING_RESET_DISC            = 7443, -- The data on the <item> will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7475, -- New user confirmed. Issuing <item>.
        IN_OPERATION                  = 7493, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7494, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7496, -- You obtain <number> [token/tokens]!
        FLOOR_RECORD                  = 7497, -- Data up to and including Floor <number> has been recorded on your <item>.
        WELCOME_TO_FLOOR              = 7498, -- Transfer complete. Welcome to Floor <number>.
        FORMATION_GELINCIK            = 7517, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7518, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7519, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7520, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7521, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7522, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7523, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7524, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7525, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7526, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7527, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7528, -- <Phshooo>...
        NOT_POSSIBLE                  = 7529, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7530, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7531, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7532, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7533, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7534, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7535, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7536, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7537, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7538, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7539, -- Pray to whatever gods you serve.
        BEHOLD                        = 7540, -- Behold the power of my eldritch gaze!
        CARVE                         = 7541, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7542, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7543, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7544, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7545, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7546, -- Ugh... Has your god granted you the miracle you seek...?
        DIVINE_MIGHT                  = 7547, -- Incredible. Feel the infinite power of divine might! Alexander will lead Aht Urhgan to certain victory!
        SHALL_BE_JUDGED               = 7548, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7549, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7550, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7551, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7552, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7553, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7554, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7555, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7556, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7557, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
    },

    mob =
    {
        -- Instance ID: 51 - Nyzul Isle Investigation
        ARCHAIC_RAMPART_OFFSET = GetFirstID('Archaic_Rampart'),
        BOSS_OFFSET            = GetFirstID('Adamantoise'),
        DAHAK                  = GetFirstID('Dahak'),
        GEAR_OFFSET            = GetFirstID('Archaic_Gear'),
        LEADER_OFFSET          = GetFirstID('Mokke'),
        MOB_OFFSET             = GetFirstID('Greatclaw'),
        NM_OFFSET              = GetFirstID('Bat_Eye'),
        SPECIFIED_OFFSET       = GetFirstID('Heraldic_Imp'),
        TAISAIJIN              = GetFirstID('Taisaijin'),

        -- Instance ID: 58 - Path of Darkness
        AMNAF_BLU            = GetFirstID('Amnaf_BLU'),
        AMNAF_PSYCHEFLAYER   = GetFirstID('Amnaf_Psycheflayer'),
        IMPERIAL_GEAR_OFFSET = GetFirstID('Imperial_Gear'),
        NAJA_SALAHEEM        = GetFirstID('Naja_Salaheem'),

        -- Instance ID: 59 - Nashmeiras Plea
        ALEXANDER = GetFirstID('Alexander'),
        RAUBAHN   = GetFirstID('Raubahn'),
        RAZFAHD   = GetFirstID('Razfahd'),
    },

    npc =
    {
        -- Nyzul Isle Investigation
        DOOR_OFFSET               = GetFirstID('_253'),
        RUNE_OF_TRANSFER_OFFSET   = GetFirstID('Rune_of_Transfer'),
        RUNE_OF_TRANSFER_ENTRANCE = GetFirstID('Rune_of_Transfer_Start'),
        RUNIC_LAMP_OFFSET         = GetFirstID('Runic_Lamp'),
        TREASURE_CASKET_OFFSET    = GetFirstID('Armoury_Crate_Casket'),
        TREASURE_COFFER_OFFSET    = GetFirstID('Armoury_Crate_Coffer'),
        VENDING_BOX               = GetFirstID('Vending_Box'),

        -- Other instances
        WEATHER    = GetFirstID('_k5y'), -- Unused?

        -- This NPCs aren't even enabled in the sql (pos 0, 0, 0). Leaving them here for now.
        -- QM1        = GetFirstID('17093473'),
        -- BLANK1     = GetFirstID('17093474'),
        -- BLANK2     = GetFirstID('17093475'),
        -- BLANK3     = GetFirstID('17093476'),
        -- NASHMEIRA1 = GetFirstID('17093477'),
        -- NASHMEIRA2 = GetFirstID('17093478'),
        -- RAZFAHD    = GetFirstID('17093479'),
        -- CSNPC1     = GetFirstID('17093480'),
        -- GHATSAD    = GetFirstID('17093481'),
        -- ALEXANDER  = GetFirstID('17093482'),
        -- CSNPC2     = GetFirstID('17093483'),
    }
}

return zones[xi.zone.NYZUL_ISLE]
