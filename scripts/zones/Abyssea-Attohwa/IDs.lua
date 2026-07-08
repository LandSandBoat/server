-----------------------------------
-- Area: Abyssea-Attohwa
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_ATTOHWA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6398, -- Lost key item: <keyitem>.
        CRUOR_TOTAL                   = 6992, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_KEYITEM_OBTAINED       = 7232, -- <player> obtained the key item: <keyitem>!
        LIGHTS_MESSAGE_1              = 7237, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7238, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7239, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7240, -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7241, -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7242, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7243, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7244, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7245, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7246, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7255, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7256, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7258, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7315, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7358, -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7359, -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7360, -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7366, -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7373, -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7398, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7408, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7409, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7410, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7411, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7414, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7415, -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7416, -- That item had already disappeared.
        CHEST_DESPAWNED               = 7417, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7418, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7419, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7420, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7427, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7428, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7429, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7432, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7454, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7458, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7463, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7464, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7465, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7466, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7467, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7468, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7469, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7470, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7471, -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7472, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7495, -- You sense an aura of boundless rage...
        INFO_KI                       = 7496, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7499, -- Use the [key item/key items]? Yes. No.
    },
    mob =
    {
        GRANITE_BORER      = GetFirstID('Granite_Borer'),
        BLAZING_ERUCA      = GetFirstID('Blazing_Eruca'),
        PALLID_PERCY       = GetFirstID('Pallid_Percy'),
        GAIZKIN            = GetFirstID('Gaizkin'),
        KHARON             = GetFirstID('Kharon'),
        DREKAVAC           = GetFirstID('Drekavac'),
        SVARBHANU          = GetFirstID('Svarbhanu'),
        KAMPE              = GetFirstID('Kampe'),
        BERSTUK            = GetFirstID('Berstuk'),
        MAAHES             = GetFirstID('Maahes'),
        NIGHTSHADE         = GetFirstID('Nightshade'),
        WHERWETRICE        = GetFirstID('Wherwetrice'),
        MIELIKKI           = GetFirstID('Mielikki'),
        SMOK_OFFSET        = GetFirstID('Smok'),
        TITLACAUAN_OFFSET  = GetFirstID('Titlacauan'),
        ULHUADSHI_OFFSET   = GetFirstID('Ulhuadshi'),
        ITZPAPALOTL_OFFSET = GetFirstID('Itzpapalotl'),
    },
    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_ATTOHWA]
