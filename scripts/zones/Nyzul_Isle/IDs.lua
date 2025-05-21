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
        COMMENCE                      = 7308, -- Commencing %! Objective: Complete on-site objectives
        TIME_TO_COMPLETE              = 7318, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7319, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7323, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7324, -- ime remaining: <number> [second/seconds] (Earth time).
        FADES_INTO_NOTHINGNESS        = 7325, -- The <keyitem> fades into nothingness...
        PARTY_FALLEN                  = 7326, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        PLAYER_OBTAINS_TEMP_ITEM      = 7335, -- <player> obtains the temporary item: <item>!
        TEMP_ITEM_OBTAINED            = 7336, -- Obtained temporary item: <item>!
        PLAYER_OBTAINS_ITEM           = 7337, -- <player> obtains <item>!
        ALREADY_HAVE_TEMP_ITEM        = 7360, -- You already have that temporary item.
        OBJECTIVE_COMPLETE            = 7363, -- loor <number> objective complete. Rune of Transfer activated.
        LAMP_CERTIFICATION_CODE       = 7365, -- The certification code for all party members is required to activate this lamp. Your certification code has been registered.
        LAMP_CERTIFICATION_REGISTERED = 7366, -- Your certification code has been registered.
        LAMP_ACTIVE                   = 7367, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7368, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_ALL_ACTIVE               = 7369, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_CANNOT_ACTIVATE          = 7370, -- It appears you cannot activate this lamp for some time...
        LAMP_ORDER                    = 7371, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVE           = 7372, -- Not all lights have been activated...
        CONFIRMING_PROCEDURE          = 7373, -- Confirming operation procedure...
        OBJECTIVE_TEXT_OFFSET         = 7375, -- Objective: Eliminate enemy leader.
        ELIMINATE_SPECIFIED_ENEMIES   = 7377, -- Objective: Eliminate specified enemies.
        ACTIVATE_ALL_LAMPS            = 7378, -- Objective: Activate all lamps.
        ELIMINATE_SPECIFIED_ENEMY     = 7379, -- Objective: Eliminate specified enemy.
        ELIMINATE_ALL_ENEMIES         = 7380, -- Objective: Eliminate all enemies.
        AVOID_DISCOVERY               = 7381, -- Avoid discovery by archaic gears!
        DO_NOT_DESTROY                = 7382, -- Do not destroy archaic gears!
        TIME_LOSS                     = 7383, -- Time limit has been reduced by <number> [minute/minutes].
        MALFUNCTION                   = 7384, -- Security field malfunction.
        TOKEN_LOSS                    = 7385, -- Potential token reward reduced.
        RESTRICTION_JOB_ABILITIES     = 7387, -- Job abilities are restricted.
        RESTRICTION_WEAPON_SKILLS     = 7389, -- Weapon skills are restricted.
        RESTRICTION_WHITE_MAGIC       = 7391, -- White magic is restricted.
        RESTRICTION_BLACK_MAGIC       = 7393, -- Black magic is restricted.
        RESTRICTION_SONGS             = 7395, -- Songs are restricted.
        RESTRICTION_NINJITSU          = 7397, -- Ninjutsu is restricted.
        RESTRICTION_SUMMON_MAGIC      = 7399, -- Summon magic is restricted.
        RESTRICTION_BLUE_MAGIC        = 7401, -- Blue magic is restricted.
        AFFLICTION_ATTACK_SPEED_DOWN  = 7403, -- Afflicted by Attack Speed Down.
        AFFLICTION_CASTING_SPEED_DOWN = 7405, -- Afflicted by Casting Speed Down.
        AFFLICTION_STR_DOWN           = 7407, -- Afflicted by STR Down.
        AFFLICTION_DEX_DOWN           = 7409, -- Afflicted by DEX Down.
        AFFLICTION_VIT_DOWN           = 7411, -- Afflicted by VIT Down.
        AFFLICTION_AGI_DOWN           = 7413, -- Afflicted by AGI Down.
        AFFLICTION_INT_DOWN           = 7415, -- Afflicted by INT Down.
        AFFLICTION_MND_DOWN           = 7417, -- Afflicted by MND Down.
        AFFLICTION_CHR_DOWN           = 7419, -- Afflicted by CHR Down.
        RECEIVED_REGAIN_EFFECT        = 7421, -- Received Regain effect.
        RECEIVED_REGEN_EFFECT         = 7423, -- Received Regen effect.
        RECEIVED_REFRESH_EFFECT       = 7425, -- Received Refresh effect.
        RECEIVED_FLURRY_EFFECT        = 7427, -- Received Flurry effect.
        RECEIVED_CONCENTRATION_EFFECT = 7429, -- Received Concentration effect.
        RECEIVED_STR_BOOST            = 7431, -- Received STR Boost.
        RECEIVED_DEX_BOOST            = 7433, -- Received DEX Boost.
        RECEIVED_VIT_BOOST            = 7435, -- Received VIT Boost.
        RECEIVED_AGI_BOOST            = 7437, -- Received AGI Boost.
        RECEIVED_INT_BOOST            = 7439, -- Received INT Boost.
        RECEIVED_MND_BOOST            = 7441, -- Received MND Boost.
        RECEIVED_CHR_BOOST            = 7443, -- Received CHR Boost.
        WARNING_RESET_DISC            = 7444, -- The data on the <item> will be reset when you complete the objective of the next floor.
        NEW_USER                      = 7476, -- New user confirmed. Issuing <item>.
        IN_OPERATION                  = 7494, -- Transfer controls in operation by another user.
        INSUFFICIENT_TOKENS           = 7495, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7497, -- You obtain <number> [token/tokens]!
        FLOOR_RECORD                  = 7498, -- Data up to and including Floor <number> has been recorded on your <item>.
        WELCOME_TO_FLOOR              = 7499, -- Transfer complete. Welcome to Floor <number>.
        FORMATION_GELINCIK            = 7518, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7519, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7520, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7521, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7522, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7523, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7524, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7525, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7526, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7527, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7528, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7529, -- <Phshooo>...
        NOT_POSSIBLE                  = 7530, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7531, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7532, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7533, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7534, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7535, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7536, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7537, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7538, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7539, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7540, -- Pray to whatever gods you serve.
        BEHOLD                        = 7541, -- Behold the power of my eldritch gaze!
        CARVE                         = 7542, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7543, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7544, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7545, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7546, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7547, -- Ugh... Has your god granted you the miracle you seek...?
        DIVINE_MIGHT                  = 7548, -- Incredible. Feel the infinite power of divine might! Alexander will lead Aht Urhgan to certain victory!
        SHALL_BE_JUDGED               = 7549, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7550, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7551, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7552, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7553, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7554, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7555, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7556, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7557, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7558, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
        LIGHTNING_CELL_SPARKS         = 7566, -- The % begins to crackle and emit sparks!
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
