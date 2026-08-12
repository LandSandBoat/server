-----------------------------------
-- Area: Abyssea-Uleguerand
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_ULEGUERAND] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6399,  -- Lost key item: <keyitem>.
        CRUOR_TOTAL                   = 6993,  -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_KEYITEM_OBTAINED       = 7233,  -- <player> obtained the key item: <keyitem>!
        LIGHTS_MESSAGE_1              = 7238,  -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7239,  -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7240,  -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7241,  -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7242,  -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7243,  -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7244,  -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7245,  -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7246,  -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7247,  -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7256,  -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7257,  -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7259,  -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7316,  -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7359,  -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7360,  -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7361,  -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7367,  -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7374,  -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7399,  -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7409,  -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7410,  -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7411,  -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7412,  -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7415,  -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7416,  -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7417,  -- That item had already disappeared.
        CHEST_DESPAWNED               = 7418,  -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7419,  -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7420,  -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7421,  -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7428,  -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7429,  -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7430,  -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7433,  -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7455,  -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7459,  -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7464,  -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7465,  -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7466,  -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7467,  -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7468,  -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7469,  -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7470,  -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7471,  -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7472,  -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7473,  -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7496,  -- You sense an aura of boundless rage...
        INFO_KI                       = 7497,  -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7500,  -- Use the [key item/key items]? Yes. No.
        OBTAINS_DOMINION_NOTES        = 7789,  -- <name> obtains <number> Dominion note[/s] (Total: <number>).
        DOMINION_SIGNED_ON            = 10309, -- You have signed on for Dominion Ops!
        CANCELED_OBJECTIVE            = 10310, -- You have canceled your objective.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_ULEGUERAND]
