-----------------------------------
-- Area: Abyssea-Grauberg
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_GRAUBERG] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6398,  -- Lost key item: <keyitem>.
        CRUOR_TOTAL                   = 6992,  -- Obtained <number> cruor. (Total: <number>)
        PLAYER_GAINED_EXPERIENCE      = 7003,  -- <name> gained <number> [points of experience/limit points].
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_KEYITEM_OBTAINED       = 7333,  -- <player> obtained the key item: <keyitem>!
        LIGHTS_MESSAGE_1              = 7338,  -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7339,  -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7340,  -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7341,  -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7342,  -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7343,  -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7344,  -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7345,  -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7346,  -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7347,  -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7356,  -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7357,  -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7359,  -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7416,  -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7459,  -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7460,  -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7461,  -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7467,  -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7474,  -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7499,  -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7509,  -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7510,  -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7511,  -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7512,  -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7515,  -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7516,  -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7517,  -- That item had already disappeared.
        CHEST_DESPAWNED               = 7518,  -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7519,  -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7520,  -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7521,  -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7528,  -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7529,  -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7530,  -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7533,  -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7555,  -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7559,  -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7564,  -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7565,  -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7566,  -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7567,  -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7568,  -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7569,  -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7570,  -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7571,  -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7572,  -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7573,  -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7596,  -- You sense an aura of boundless rage...
        INFO_KI                       = 7597,  -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7600,  -- Use the [key item/key items]? Yes. No.
        OBTAINS_DOMINION_NOTES        = 7889,  -- <name> obtains <number> Dominion note[/s] (Total: <number>).
        DOMINION_SIGNED_ON            = 10425, -- You have signed on for Dominion Ops!
        CANCELED_OBJECTIVE            = 10426, -- You have canceled your objective.
    },
    mob =
    {
        IRONCLAD_SUNDERER   = GetFirstID('Ironclad_Sunderer'),
        NINGISHZIDA         = GetFirstID('Ningishzida'),
        TEUGGHIA            = GetFirstID('Teugghia'),
        BOMBLIX_FLAMEFINGER = GetFirstID('Bomblix_Flamefinger'),
        TEEKESSELCHEN       = GetFirstID('Teekesselchen'),
        MINARUJA            = GetFirstID('Minaruja'),
        XIBALBA             = GetFirstID('Xibalba'),
        IKA_ROA             = GetFirstID('Ika-Roa'),
        LORELEI             = GetFirstID('Lorelei'),
        BURSTROX_POWDERPATE = GetFirstID('Burstrox_Powderpate'),
        RAJA_OFFSET         = GetFirstID('Raja'),
        ALFARD_OFFSET       = GetFirstID('Alfard'),
        AZDAJA_OFFSET       = GetFirstID('Azdaja'),
        AMPHITRITE_OFFSET   = GetFirstID('Amphitrite'),
    },
    npc =
    {
        HARVESTING = GetTableOfIDs('Harvesting_Point'),
    },
}

return zones[xi.zone.ABYSSEA_GRAUBERG]
