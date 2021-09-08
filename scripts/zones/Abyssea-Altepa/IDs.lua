-----------------------------------
-- Area: Abyssea-Altepa
-----------------------------------
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
        STURDY_PYXIS_BASE = 17670627,
    },
}

return zones[xi.zone.ABYSSEA_ALTEPA]
