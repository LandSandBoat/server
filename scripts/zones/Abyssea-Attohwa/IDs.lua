-----------------------------------
-- Area: Abyssea-Attohwa
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ABYSSEA_ATTOHWA] =
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
        LIGHTS_MESSAGE_1              = 7225, -- Visitant Light Intensity Pearlescent: <number> / Ebon: <number> Golden: <number> / Silvery: <number>
        LIGHTS_MESSAGE_2              = 7226, -- Azure: <number> / Ruby: <number> / Amber: <number>
        STAGGERED                     = 7227, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7228, -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7229, -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7230, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7231, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7232, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7233, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7234, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7243, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7244, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7246, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7303, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7346, -- <name> expends <number> cruor and is now infused with <atma>!
        ATMA_PURGED                   = 7347, -- <name> has been purged of the <atma>.
        ALL_ATMA_PURGED               = 7348, -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7354, -- <name> expends <number> cruor and his/her previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7361, -- <name> expends <number> cruor and is now infused with his/her chosen atma set!
        MONSTER_CONCEALED_CHEST       = 7386, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM             = 7396, -- <name> obtains the temporary item: <item>!
        OBTAINS_ITEM                  = 7397, -- <name> obtains the item: <item>!
        OBTAINS_KEYITEM               = 7398, -- <name> obtains the key item: <item>!
        ADD_SPOILS_TO_TREASURE        = 7399, -- <name> transferred the contents of the pyxis to the cache of lottable spoils.
        TEMP_ITEM_DISAPPEARED         = 7402, -- That temporary item had already disappeared.
        KEYITEM_DISAPPEARED           = 7403, -- That key item had already disappeared.
        ITEM_DISAPPEARED              = 7404, -- That item had already disappeared.
        CHEST_DESPAWNED               = 7405, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED                = 7406, -- <name> obtained <number> cruor.
        OBTAINS_SEVERAL_TEMPS         = 7407, -- <name> obtains several temporary items!
        BODY_EMITS_OFFSET             = 7408, -- <name>'s body emits [a faint/a mild/a strong] pearlescent light!
        CANNOT_OPEN_CHEST             = 7415, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST     = 7416, -- <name> has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST           = 7417, -- Your party does not have claim over that treasure chest.
        CHEST_DISAPPEARED             = 7420, -- The treasure chest has disappeared.
        RANDOM_SUCCESS_FAIL_GUESS     = 7442, -- The randomly generated number was <number>! <name> guessed [successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE           = 7446, -- <name> [reduced/increased] the air pressure by <number> units. Current air pressure: <number>[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS      = 7451, -- <name> inputs the number <number>[, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN          = 7452, -- You have a hunch that the lock's combination is [greater/less] than <number>.
        HUNCH_SECOND_FIRST_EVEN_ODD   = 7453, -- You have a hunch that the [second/first] digit is [even/odd].
        HUNCH_SECOND_FIRST_IS         = 7454, -- You have a hunch that the [second/first] digit is <number>.
        HUNCH_SECOND_FIRST_IS_OR      = 7455, -- You have a hunch that the [second/first] digit is <number>, <number>, or <number>.
        HUNCH_ONE_DIGIT_IS            = 7456, -- You have a hunch that one of the digits is <number>.
        HUNCH_SUM_EQUALS              = 7457, -- You have a hunch that the sum of the two digits is <number>.
        PLAYER_OPENED_LOCK            = 7458, -- <name> succeeded in opening the lock!
        PLAYER_FAILED_LOCK            = 7459, -- <name> failed to open the lock.
        TRADE_KEY_OPEN                = 7460, -- <name> uses <item> and opens the lock!
        BOUNDLESS_RAGE                = 7483, -- You sense an aura of boundless rage...
        INFO_KI                       = 7484, -- Your keen senses tell you that something may happen if only you had [this item/these items].
        USE_KI                        = 7487, -- Use the [key item/key items]? Yes. No.
    },
    mob =
    {
        GRANITE_BORER               = 17658261,
        BLAZING_ERUCA               = 17658262,
        PALLID_PERCY                = 17658263,
        GAIZKIN                     = 17658264,
        KHARON                      = 17658265,
        DREKAVAC                    = 17658266,
        SVARBHANU                   = 17658267,
        KAMPE                       = 17658268,
        BERSTUK                     = 17658269,
        MAAHES                      = 17658270,
        NIGHTSHADE                  = 17658271,
        WHERWETRICE                 = 17658272,
        MIELIKKI                    = 17658273,
        SMOK_1                      = 17658274,
        TITLACAUAN_1                = 17658275,
        ULHUADSHI_1                 = 17658276,
        ITZPAPALOTL_1               = 17658277,
        SMOK_2                      = 17658278,
        TITLACAUAN_2                = 17658279,
        ULHUADSHI_2                 = 17658280,
        ITZPAPALOTL_2               = 17658281,
        SMOK_3                      = 17658282,
        TITLACAUAN_3                = 17658283,
        ULHUADSHI_3                 = 17658284,
        ITZPAPALOTL_3               = 17658285,
    },
    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_ATTOHWA]
