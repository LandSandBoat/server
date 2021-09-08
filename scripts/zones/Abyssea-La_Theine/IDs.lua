-----------------------------------
-- Area: Abyssea-La_Theine
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_LA_THEINE] =
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
            --  [17318473] = { 'qm1', {2891},                                                                                                                      {}, 17318434}, -- Dozing Dorian
            --  [17318474] = { 'qm2', {2892},                                                                                                                      {}, 17318435}, -- Trudging Thomas
            --  [17318475] = { 'qm3', {2893},                                                                                                                      {}, 17318436}, -- Megantereon
            --  [17318476] = { 'qm4', {2894},                                                                                                                      {}, 17318437}, -- Adamastor
            --  [17318477] = { 'qm5', {2895},                                                                                                                      {}, 17318438}, -- Pantagruel
            --  [17318478] = { 'qm6', {2896},                                                                                                                      {}, 17318439}, -- Grandgousier
            --  [17318479] = { 'qm7', {2897},                                                                                                                      {}, 17318440}, -- La Theine Liege
            --  [17318480] = { 'qm8', {2898},                                                                                                                      {}, 17318441}, -- Baba Yaga
            --  [17318481] = { 'qm9', {2899},                                                                                                                      {}, 17318442}, -- Nguruvilu
            --  [17318482] = {'qm10', {2900},                                                                                                                      {}, 17318443}, -- Poroggo Dom Juan
            --  [17318483] = {'qm11', {2901},                                                                                                                      {}, 17318444}, -- Toppling Tuber
            --  [17318484] = {'qm12', {2902},                                                                                                                      {}, 17318445}, -- Lugarhoo
            --  [17318485] = {'qm13',     {},                                    {xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318446}, -- Briareus
            --  [17318486] = {'qm14',     {},                                                                {xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318447}, -- Carabosse
            --  [17318487] = {'qm15',     {}, {xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318448}, -- Hadhayosh
            --  [17318488] = {'qm16',     {},                                    {xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318456}, -- Briareus
            --  [17318489] = {'qm17',     {},                                                                {xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318457}, -- Carabosse
            --  [17318490] = {'qm18',     {}, {xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318458}, -- Hadhayosh
            --  [17318491] = {'qm19',     {},                                    {xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR}, 17318459}, -- Briareus
            --  [17318492] = {'qm20',     {},                                                                {xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION}, 17318460}, -- Carabosse
            --  [17318493] = {'qm21',     {}, {xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318461}, -- Hadhayosh
        },
        STURDY_PYXIS_BASE = 17318509,
    },
}

return zones[xi.zone.ABYSSEA_LA_THEINE]
