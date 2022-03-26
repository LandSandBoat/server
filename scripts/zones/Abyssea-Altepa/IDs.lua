-----------------------------------
-- Area: Abyssea-Altepa
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_ALTEPA] =
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
        LIGHTS_MESSAGE_1            = 7321, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2            = 7322, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                   = 7323, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER              = 7324, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7325, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7326, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7327, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS               = 7328, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                = 7329, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET         = 7330, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN     = 7339, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD            = 7340, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD           = 7342, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS          = 7399, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        MONSTER_CONCEALED_CHEST     = 7482, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM           = 7492, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                = 7493, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM             = 7494, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE      = 7495, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED       = 7498, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED         = 7499, -- That key item had already disappeared.
        ITEM_DISAPPEARED            = 7500, -- That item had already disappeared.
        CHEST_DESPAWNED             = 7501, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED              = 7502, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS       = 7503, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET           = 7504, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST           = 7511, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST   = 7512, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST         = 7513, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED           = 7516, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS   = 7538, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE         = 7542, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS    = 7547, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN        = 7548, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD = 7549, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS       = 7550, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR    = 7551, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS          = 7552, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS            = 7553, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK          = 7554, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK          = 7555, -- <name> failed to open the lock.
        TRADE_KEY_OPEN              = 7556, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE              = 7579, -- You sense an aura of boundless rage...
        INFO_KI                     = 7580, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                      = 7583, -- Use the [key item/key items]? Yes. No.
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
            --  [17670591] = { 'qm1',      {3230, 3236},                                                          {}, 17670565}, -- Ironclad Smiter
            --  [17670592] = { 'qm2', {3231, 3232, 3238},                                                          {}, 17670567}, -- Amarok
            --  [17670593] = { 'qm3',      {3233, 3242},                                                          {}, 17670570}, -- Shaula
            --  [17670594] = { 'qm4',      {3234, 3244},                                                          {}, 17670571}, -- Emperador de Altepa
            --  [17670595] = { 'qm5',           {3235},                                                          {}, 17670572}, -- Tablilla
            --  [17670596] = { 'qm6',           {3237},                                                          {}, 17670574}, -- Sharabha
            --  [17670597] = { 'qm7',           {3239},                                                          {}, 17670576}, -- Waugyl
            --  [17670598] = { 'qm8',           {3240},                                                          {}, 17670577}, -- Chickcharney
            --  [17670599] = { 'qm9',           {3241},                                                          {}, 17670578}, -- Vadleany
            --  [17670600] = {'qm10',           {3243},                                                          {}, 17670579}, -- Bugul Noz
            --  [17670601] = {'qm11',               {}, {xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR}, 17670551}, -- Rani
            --  [17670602] = {'qm12',               {},                           {xi.ki.STEAMING_CERBERUS_TONGUE}, 17670552}, -- Orthus
            --  [17670603] = {'qm13',               {},                                {xi.ki.BLOODIED_DRAGON_EAR}, 17670553}, -- Dragua
            --  [17670604] = {'qm14',               {},                              {xi.ki.RESPLENDENT_ROC_QUILL}, 17670554}, -- Bennu
            --  [17670605] = {'qm15',               {}, {xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR}, 17670555}, -- Rani
            --  [17670606] = {'qm16',               {},                           {xi.ki.STEAMING_CERBERUS_TONGUE}, 17670556}, -- Orthus
            --  [17670607] = {'qm17',               {},                                {xi.ki.BLOODIED_DRAGON_EAR}, 17670557}, -- Dragua
            --  [17670608] = {'qm18',               {},                              {xi.ki.RESPLENDENT_ROC_QUILL}, 17670558}, -- Bennu
            --  [17670609] = {'qm19',               {}, {xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR}, 17670559}, -- Rani
            --  [17670610] = {'qm20',               {},                           {xi.ki.STEAMING_CERBERUS_TONGUE}, 17670560}, -- Orthus
            --  [17670611] = {'qm21',               {},                                {xi.ki.BLOODIED_DRAGON_EAR}, 17670561}, -- Dragua
            --  [17670612] = {'qm22',               {},                              {xi.ki.RESPLENDENT_ROC_QUILL}, 17670562}, -- Bennu
        },
    },
}

return zones[xi.zone.ABYSSEA_ALTEPA]
