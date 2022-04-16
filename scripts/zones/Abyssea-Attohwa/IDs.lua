-----------------------------------
-- Area: Abyssea-Attohwa
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_ATTOHWA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6390, -- Obtained: <item>.
        GIL_OBTAINED                = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6393, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                 = 6988, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS         = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LIGHTS_MESSAGE_1            = 7222, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2            = 7223, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                   = 7224, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER              = 7225, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7226, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7227, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7228, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS               = 7229, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                = 7230, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET         = 7231, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN     = 7240, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD            = 7241, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD           = 7243, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS          = 7300, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        MONSTER_CONCEALED_CHEST     = 7383, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM           = 7393, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                = 7394, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM             = 7395, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE      = 7396, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED       = 7399, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED         = 7400, -- That key item had already disappeared.
        ITEM_DISAPPEARED            = 7401, -- That item had already disappeared.
        CHEST_DESPAWNED             = 7402, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED              = 7403, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS       = 7404, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET           = 7405, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST           = 7412, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST   = 7413, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST         = 7414, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED           = 7417, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS   = 7439, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE         = 7443, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS    = 7448, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN        = 7449, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD = 7450, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS       = 7451, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR    = 7452, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS          = 7453, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS            = 7454, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK          = 7455, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK          = 7456, -- <name> failed to open the lock.
        TRADE_KEY_OPEN              = 7457, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE              = 7480, -- You sense an aura of boundless rage...
        INFO_KI                     = 7481, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                      = 7484, -- Use the [key item/key items]? Yes. No.
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
            --  [17658351] = { 'qm1', {3072},                                                                                                                       {}, 17658261}, -- Granite Borer
            --  [17658352] = { 'qm2', {3073},                                                                                                                       {}, 17658262}, -- Blazing Eruca
            --  [17658353] = { 'qm3', {3074},                                                                                                                       {}, 17658263}, -- Pallid Percy
            --  [17658354] = { 'qm4', {3075},                                                                                                                       {}, 17658264}, -- Gaizkin
            --  [17658355] = { 'qm5', {3076},                                                                                                                       {}, 17658265}, -- Kharon
            --  [17658356] = { 'qm6', {3077},                                                                                                                       {}, 17658266}, -- Drekavac
            --  [17658357] = { 'qm7', {3078},                                                                                                                       {}, 17658267}, -- Svarbhanu
            --  [17658358] = { 'qm8', {3079},                                                                                                                       {}, 17658268}, -- Kampe
            --  [17658359] = { 'qm9', {3080},                                                                                                                       {}, 17658269}, -- Berstuk
            --  [17658360] = {'qm10', {3081},                                                                                                                       {}, 17658270}, -- Maahes
            --  [17658361] = {'qm11', {3082},                                                                                                                       {}, 17658271}, -- Nightshade
            --  [17658362] = {'qm12', {3083},                                                                                                                       {}, 17658272}, -- Wherwetrice
            --  [17658363] = {'qm13', {3084},                                                                                                                       {}, 17658273}, -- Mielikki
            --  [17658364] = {'qm14',     {},                                                                                               { xi.ki.HOLLOW_DRAGON_EYE}, 17658274}, -- Smok
            --  [17658365] = {'qm15',     {}, { xi.ki.BLOTCHED_DOOMED_TONGUE, xi.ki.CRACKED_SKELETON_CLAVICLE, xi.ki.WRITHING_GHOST_FINGER, xi.ki.RUSTED_HOUND_COLLAR}, 17658275}, -- Titlacauan
            --  [17658366] = {'qm16',     {},                                                              { xi.ki.MUCID_WORM_SEGMENT, xi.ki.SHRIVELED_HECTEYES_STALK}, 17658276}, -- Ulhuadshi
            --  [17658367] = {'qm17',     {},                           { xi.ki.VENOMOUS_WAMOURA_FEELER, xi.ki.BULBOUS_CRAWLER_COCOON, xi.ki.DISTENDED_CHIGOE_ABDOMEN}, 17658277}, -- Itzpapalotl
            --  [17658368] = {'qm18',     {},                                                                                               { xi.ki.HOLLOW_DRAGON_EYE}, 17658278}, -- Smok
            --  [17658369] = {'qm19',     {}, { xi.ki.BLOTCHED_DOOMED_TONGUE, xi.ki.CRACKED_SKELETON_CLAVICLE, xi.ki.WRITHING_GHOST_FINGER, xi.ki.RUSTED_HOUND_COLLAR}, 17658279}, -- Titlacauan
            --  [17658370] = {'qm20',     {},                                                              { xi.ki.MUCID_WORM_SEGMENT, xi.ki.SHRIVELED_HECTEYES_STALK}, 17658280}, -- Ulhuadshi
            --  [17658371] = {'qm21',     {},                           { xi.ki.VENOMOUS_WAMOURA_FEELER, xi.ki.BULBOUS_CRAWLER_COCOON, xi.ki.DISTENDED_CHIGOE_ABDOMEN}, 17658281}, -- Itzpapalotl
            --  [17658372] = {'qm22',     {},                                                                                               { xi.ki.HOLLOW_DRAGON_EYE}, 17658282}, -- Smok
            --  [17658373] = {'qm23',     {}, { xi.ki.BLOTCHED_DOOMED_TONGUE, xi.ki.CRACKED_SKELETON_CLAVICLE, xi.ki.WRITHING_GHOST_FINGER, xi.ki.RUSTED_HOUND_COLLAR}, 17658283}, -- Titlacauan
            --  [17658374] = {'qm24',     {},                                                              { xi.ki.MUCID_WORM_SEGMENT, xi.ki.SHRIVELED_HECTEYES_STALK}, 17658284}, -- Ulhuadshi
            --  [17658375] = {'qm25',     {},                           { xi.ki.VENOMOUS_WAMOURA_FEELER, xi.ki.BULBOUS_CRAWLER_COCOON, xi.ki.DISTENDED_CHIGOE_ABDOMEN}, 17658285}, -- Itzpapalotl
        },
        STURDY_PYXIS_BASE = 17658390,
    },
}

return zones[xi.zone.ABYSSEA_ATTOHWA]
