-----------------------------------
-- Area: Abyssea-Uleguerand
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_ULEGUERAND] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6394, -- Lost key item: <keyitem>.
        CRUOR_TOTAL                   = 6988, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_KEYITEM_OBTAINED       = 7221, -- <player> obtained the key item: <keyitem>!
        LIGHTS_MESSAGE_1              = 7226, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7227, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7228, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7229, -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7230, -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7231, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7232, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7233, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7234, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7235, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7244, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7245, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7247, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7304, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7347, -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7348, -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7349, -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7355, -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7362, -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7387, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7397, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7398, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7399, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7400, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7403, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7404, -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7405, -- That item had already disappeared.
        CHEST_DESPAWNED               = 7406, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7407, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7408, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7409, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7416, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7417, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7418, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7421, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7443, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7447, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7452, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7453, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7454, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7455, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7456, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7457, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7458, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7459, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7460, -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7461, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7484, -- You sense an aura of boundless rage...
        INFO_KI                       = 7485, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7488, -- Use the [key item/key items]? Yes. No.
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
            --  [17813949] = {  'qm1',       { 3245, 3251 },                                                           { }, 17813925 }, -- Ironclad Triturator
            --  [17813950] = {  'qm2', { 3246, 3247, 3253 },                                                           { }, 17813927 }, -- Dhorme Khimaira
            --  [17813951] = {  'qm3',       { 3248, 3257 },                                                           { }, 17813930 }, -- Blanga
            --  [17813952] = {  'qm4',       { 3249, 3259 },                                                           { }, 17813931 }, -- Yaguarogui
            --  [17813953] = {  'qm5',             { 3250 },                                                           { }, 17813933 }, -- Koghatu
            --  [17813954] = {  'qm6',             { 3252 },                                                           { }, 17813935 }, -- Upas-Kamuy
            --  [17813955] = {  'qm7',             { 3254 },                                                           { }, 17813937 }, -- Veri Selen
            --  [17813956] = {  'qm8',             { 3255 },                                                           { }, 17813938 }, -- Anemic Aloysius
            --  [17813957] = {  'qm9',             { 3256 },                                                           { }, 17813939 }, -- Chillwing Hwitti
            --  [17813958] = { 'qm10',             { 3258 },                                                           { }, 17813940 }, -- Audumbla
            --  [17813959] = { 'qm11',                  { }, { xi.ki.WARPED_IRON_GIANT_NAIL, xi.ki.DENTED_CHARIOT_SHIELD }, 17813910 }, -- Pantokrator
            --  [17813960] = { 'qm12',                  { },                                  { xi.ki.TORN_KHIMAIRA_WING }, 17813911 }, -- Apademak
            --  [17813961] = { 'qm13',                  { },                                { xi.ki.BEGRIMED_DRAGON_HIDE }, 17813912 }, -- Isgebind
            --  [17813962] = { 'qm14',                  { },                              { xi.ki.DECAYING_DIREMITE_FANG }, 17813913 }, -- Resheph
            --  [17813963] = { 'qm15',                  { }, { xi.ki.WARPED_IRON_GIANT_NAIL, xi.ki.DENTED_CHARIOT_SHIELD }, 17813914 }, -- Pantokrator
            --  [17813964] = { 'qm16',                  { },                                  { xi.ki.TORN_KHIMAIRA_WING }, 17813915 }, -- Apademak
            --  [17813965] = { 'qm17',                  { },                                { xi.ki.BEGRIMED_DRAGON_HIDE }, 17813916 }, -- Isgebind
            --  [17813966] = { 'qm18',                  { },                              { xi.ki.DECAYING_DIREMITE_FANG }, 17813917 }, -- Resheph
            --  [17813967] = { 'qm19',                  { }, { xi.ki.WARPED_IRON_GIANT_NAIL, xi.ki.DENTED_CHARIOT_SHIELD }, 17813918 }, -- Pantokrator
            --  [17813968] = { 'qm20',                  { },                                  { xi.ki.TORN_KHIMAIRA_WING }, 17813919 }, -- Apademak
            --  [17813969] = { 'qm21',                  { },                                { xi.ki.BEGRIMED_DRAGON_HIDE }, 17813920 }, -- Isgebind
            --  [17813970] = { 'qm22',                  { },                              { xi.ki.DECAYING_DIREMITE_FANG }, 17813921 }, -- Resheph
        },
    },
}

return zones[xi.zone.ABYSSEA_ULEGUERAND]
