-----------------------------------
-- Area: Abyssea-Vunkerl
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_VUNKERL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389, -- Obtained: <item>.
        GIL_OBTAINED                = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                 = 6987, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LIGHTS_MESSAGE_1            = 7318, -- Visitant Light Intensity Pearlescent: <number> Ebon: <number> Golden: <number> Silvery: <number>
        LIGHTS_MESSAGE_2            = 7319, -- Azure: <number> Ruby: <number> Amber: <number>
        STAGGERED                   = 7320, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER              = 7321, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7322, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7323, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7324, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS               = 7325, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                = 7326, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET         = 7327, -- Your visitant status will wear off in <number> [second/minute].
        NO_VISITANT_WARD            = 7337, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_SEARING_IN     = 7338, -- Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD           = 7339, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS          = 7396, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        MONSTER_CONCEALED_CHEST     = 7479, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM           = 7489, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                = 7490, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM             = 7491, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE      = 7492, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED       = 7495, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED         = 7496, -- That key item had already disappeared.
        ITEM_DISAPPEARED            = 7497, -- That item had already disappeared.
        CHEST_DESPAWNED             = 7498, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED              = 7499, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS       = 7500, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET           = 7501, -- <name>'s body emits [/a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST           = 7508, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST   = 7509, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST         = 7510, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED           = 7513, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS   = 7535, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE         = 7539, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number> [/(minimum)/(maximum)]
        INPUT_SUCCESS_FAIL_GUESS    = 7544, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN        = 7545, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD = 7546, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS       = 7547, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR    = 7548, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS          = 7549, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS            = 7550, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK          = 7551, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK          = 7552, -- <name> failed to open the lock.
        TRADE_KEY_OPEN              = 7553, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE              = 7576, -- You sense an aura of boundless rage...
        INFO_KI                     = 7577, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                      = 7580, -- Use the [key item/key items]? Yes. No.
    },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
            -- TODO: the first item, e.g. 'qm1', is unused and will be meaningless once I (Wren) finish entity-QC on all Abyssea zones.
            -- When that is done, I will rewrite Abyssea global and adjust and neaten this table
            --  [17666576] = { 'qm1', {3098},                                                                                          {}, 17666487}, -- Khalkotaur
            --  [17666577] = { 'qm2', {3099},                                                                                          {}, 17666488}, -- Quasimodo
            --  [17666578] = { 'qm3', {3100},                                                                                          {}, 17666489}, -- Iku-Turso
            --  [17666579] = { 'qm4', {3101},                                                                                          {}, 17666490}, -- Dvalinn
            --  [17666580] = { 'qm5', {3102},                                                                                          {}, 17666491}, -- Kadraeth the Hatespawn
            --  [17666581] = { 'qm6', {3103},                                                                                          {}, 17666492}, -- Rakshas
            --  [17666582] = { 'qm7', {3104},                                                                                          {}, 17666493}, -- Seps
            --  [17666583] = { 'qm8', {3105},                                                                                          {}, 17666494}, -- Xan
            --  [17666584] = { 'qm9', {3106},                                                                                          {}, 17666495}, -- Chhir Batti
            --  [17666585] = {'qm10', {3107},                                                                                          {}, 17666496}, -- Armillaria
            --  [17666586] = {'qm11', {3108},                                                                                          {}, 17666497}, -- Pascerpot
            --  [17666587] = {'qm12', {3109},                                                                                          {}, 17666498}, -- Gnawtooth Gary
            --  [17666588] = {'qm13',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666499}, -- Bukhis
            --  [17666589] = {'qm14',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666500}, -- Sedna
            --  [17666590] = {'qm15',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666501}, -- Durinn
            --  [17666591] = {'qm16',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666502}, -- Karkadann
            --  [17666592] = {'qm17',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666503}, -- Bukhis
            --  [17666593] = {'qm18',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666504}, -- Sedna
            --  [17666594] = {'qm19',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666505}, -- Durinn
            --  [17666595] = {'qm20',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666506}, -- Karkadann
            --  [17666596] = {'qm21',     {},     {xi.ki.INGROWN_TAURUS_NAIL, xi.ki.OSSIFIED_GARGOUILLE_HAND, xi.ki.IMBRUED_VAMPYR_FANG}, 17666507}, -- Bukhis
            --  [17666597] = {'qm22',     {},                               {xi.ki.GLOSSY_SEA_MONK_SUCKER, xi.ki.SHIMMERING_PUGIL_SCALE}, 17666508}, -- Sedna
            --  [17666598] = {'qm23',     {}, {xi.ki.DECAYED_DVERGR_TOOTH, xi.ki.PULSATING_SOULFLAYER_BEARD, xi.ki.CHIPPED_IMPS_OLIFANT}, 17666509}, -- Durinn
            --  [17666599] = {'qm24',     {},                                 {xi.ki.MALODOROUS_MARID_FUR, xi.ki.WARPED_SMILODON_CHOKER}, 17666510}, -- Karkadann
        },
    },
}

return zones[xi.zone.ABYSSEA_VUNKERL]
