-----------------------------------
-- Area: Abyssea-La_Theine
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_LA_THEINE] =
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
        PLAYER_KEYITEM_OBTAINED       = 7324, -- <player> obtained the key item: <keyitem>!
        LIGHTS_MESSAGE_1              = 7329, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7330, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7331, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7332, -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7333, -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7334, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7335, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7336, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7337, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7338, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7347, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7348, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7350, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7407, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7450, -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7451, -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7452, -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7458, -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7465, -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7490, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7500, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7501, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7502, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7503, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7506, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7507, -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7508, -- That item had already disappeared.
        CHEST_DESPAWNED               = 7509, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7510, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7511, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7512, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7519, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7520, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7521, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7524, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7546, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7550, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7555, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7556, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7557, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7558, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7559, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7560, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7561, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7562, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7563, -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7564, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7587, -- You sense an aura of boundless rage...
        INFO_KI                       = 7588, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7591, -- Use the [key item/key items]? Yes. No.
    },
    mob =
    {
        DOZING_DORIAN    = GetFirstID('Dozing_Dorian'),
        TRUDGING_THOMAS  = GetFirstID('Trudging_Thomas'),
        MEGANTEREON      = GetFirstID('Megantereon'),
        ADAMASTOR        = GetFirstID('Adamastor'),
        PANTAGRUEL       = GetFirstID('Pantagruel'),
        GRANDGOUSIER     = GetFirstID('Grandgousier'),
        LA_THEINE_LIEGE  = GetFirstID('La_Theine_Liege'),
        BABA_YAGA        = GetFirstID('Baba_Yaga'),
        NGURUVILU        = GetFirstID('Nguruvilu'),
        POROGGO_DOM_JUAN = GetFirstID('Poroggo_Dom_Juan'),
        TOPPLING_TUBER   = GetFirstID('Toppling_Tuber'),
        LUGARHOO         = GetFirstID('Lugarhoo'),
        BRIAREUS_OFFSET  = GetFirstID('Briareus'), -- 3 Copies: +0, +10, +13
        CARABOSSE_OFFSET = GetFirstID('Carabosse'), -- 3 Copies: +0, +10, +13
        HADHAYOSH_OFFSET = GetFirstID('Hadhayosh'), -- 3 Copies: +0, +10, +13
    },
    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_LA_THEINE]
