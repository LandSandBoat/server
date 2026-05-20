-----------------------------------
-- Area: Nyzul_Isle
-----------------------------------
zones = zones or {}

zones[xi.zone.NYZUL_ISLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6396, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6400, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        COMMENCE                      = 7309, -- Commencing %! Objective: Complete on-site objectives
        TIME_TO_COMPLETE              = 7319, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7320, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7324, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7325, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7326, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7327, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7336, -- <player> obtains the temporary item: <item>!
        TEMP_ITEM_OBTAINED            = 7337, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7338, -- <player> obtains <item>!
        ALREADY_HAVE_TEMP_ITEM        = 7361, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7364, -- loor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7366, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7367, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7368, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7369, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7370, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7371, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7372, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7373, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7374, -- Confirming operation procedure...
        OBJECTIVE_TEXT_OFFSET         = 7376, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7378, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7379, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7380, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7381, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7382, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7383, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7384, -- Time limit has been reduced by <number> [minute/minutes].
        MALFUNCTION                   = 7385, -- Security field malfunction.
        TOKEN_LOSS                    = 7386, -- Potential token reward reduced.
        RESTRICTION_JOB_ABILITIES     = 7388, -- Job abilities are restricted.
        RESTRICTION_WEAPON_SKILLS     = 7390, -- Weapon skills are restricted.
        RESTRICTION_WHITE_MAGIC       = 7392, -- White magic is restricted.
        RESTRICTION_BLACK_MAGIC       = 7394, -- Black magic is restricted.
        RESTRICTION_SONGS             = 7396, -- Songs are restricted.
        RESTRICTION_NINJITSU          = 7398, -- Ninjutsu is restricted.
        RESTRICTION_SUMMON_MAGIC      = 7400, -- Summon magic is restricted.
        RESTRICTION_BLUE_MAGIC        = 7402, -- Blue magic is restricted.
        AFFLICTION_ATTACK_SPEED_DOWN  = 7404, -- Afflicted by Attack Speed Down.
        AFFLICTION_CASTING_SPEED_DOWN = 7406, -- Afflicted by Casting Speed Down.
        AFFLICTION_STR_DOWN           = 7408, -- Afflicted by STR Down.
        AFFLICTION_DEX_DOWN           = 7410, -- Afflicted by DEX Down.
        AFFLICTION_VIT_DOWN           = 7412, -- Afflicted by VIT Down.
        AFFLICTION_AGI_DOWN           = 7414, -- Afflicted by AGI Down.
        AFFLICTION_INT_DOWN           = 7416, -- Afflicted by INT Down.
        AFFLICTION_MND_DOWN           = 7418, -- Afflicted by MND Down.
        AFFLICTION_CHR_DOWN           = 7420, -- Afflicted by CHR Down.
        RECEIVED_REGAIN_EFFECT        = 7422, -- Received Regain effect.
        RECEIVED_REGEN_EFFECT         = 7424, -- Received Regen effect.
        RECEIVED_REFRESH_EFFECT       = 7426, -- Received Refresh effect.
        RECEIVED_FLURRY_EFFECT        = 7428, -- Received Flurry effect.
        RECEIVED_CONCENTRATION_EFFECT = 7430, -- Received Concentration effect.
        RECEIVED_STR_BOOST            = 7432, -- Received STR Boost.
        RECEIVED_DEX_BOOST            = 7434, -- Received DEX Boost.
        RECEIVED_VIT_BOOST            = 7436, -- Received VIT Boost.
        RECEIVED_AGI_BOOST            = 7438, -- Received AGI Boost.
        RECEIVED_INT_BOOST            = 7440, -- Received INT Boost.
        RECEIVED_MND_BOOST            = 7442, -- Received MND Boost.
        RECEIVED_CHR_BOOST            = 7444, -- Received CHR Boost.
        WARNING_RESET_DISC            = 7445, -- The data on the <item> will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7477, -- New user confirmed. Issuing <item>.
        IN_OPERATION                  = 7495, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7496, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7498, -- You obtain <number> [token/tokens]!
        FLOOR_RECORD                  = 7499, -- Data up to and including Floor <number> has been recorded on your <item>.
        WELCOME_TO_FLOOR              = 7500, -- Transfer complete. Welcome to Floor <number>.
        FORMATION_GELINCIK            = 7519, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7520, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7521, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7522, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7523, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7524, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7525, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7526, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7527, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7528, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7529, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7530, -- <Phshooo>...
        NOT_POSSIBLE                  = 7531, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7532, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7533, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7534, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7535, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7536, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7537, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7538, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7539, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7540, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7541, -- Pray to whatever gods you serve.
        BEHOLD                        = 7542, -- Behold the power of my eldritch gaze!
        CARVE                         = 7543, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7544, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7545, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7546, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7547, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7548, -- Ugh... Has your god granted you the miracle you seek...?
        DIVINE_MIGHT                  = 7549, -- Incredible. Feel the infinite power of divine might! Alexander will lead Aht Urhgan to certain victory!
        SHALL_BE_JUDGED               = 7550, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7551, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7552, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7553, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7554, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7555, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7556, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7557, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7558, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7559, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
        LIGHTNING_CELL_SPARKS         = 7567, -- The % begins to crackle and emit sparks!
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
        ALEXANDER = GetFirstID('Alexander_NP'),
        RAUBAHN   = GetFirstID('Raubahn'),
        RAZFAHD   = GetFirstID('Razfahd'),

        -- Instance ID: 60 - Waking the Colossus/Divine Interference
        ALEXANDER_WTC   = GetFirstID('Alexander_WTC'),
        ALEXANDER_IMAGE = GetTableOfIDs('Alexander_Image'),
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
