-----------------------------------
-- Area: Qu'Bia Arena
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Demolition Squad
    [520] =
    {
        {
            { itemid = xi.item.MARINE_M_GLOVES, droprate = 125 }, -- marine_m_gloves
            { itemid = xi.item.MARINE_F_GLOVES, droprate = 125 }, -- marine_f_gloves
            { itemid = xi.item.WOOD_GAUNTLETS,  droprate = 125 }, -- wood_gauntlets
            { itemid = xi.item.WOOD_GLOVES,     droprate = 125 }, -- wood_gloves
            { itemid = xi.item.CREEK_M_MITTS,   droprate = 125 }, -- creek_m_mitts
            { itemid = xi.item.CREEK_F_MITTS,   droprate = 125 }, -- creek_f_mitts
            { itemid = xi.item.RIVER_GAUNTLETS, droprate = 125 }, -- river_gauntlets
            { itemid = xi.item.DUNE_BRACERS,    droprate = 125 }, -- dune_bracers
        },

        {
            { itemid = xi.item.RED_CHIP,    droprate = 125 }, -- red_chip
            { itemid = xi.item.BLUE_CHIP,   droprate = 125 }, -- blue_chip
            { itemid = xi.item.YELLOW_CHIP, droprate = 125 }, -- yellow_chip
            { itemid = xi.item.GREEN_CHIP,  droprate = 125 }, -- green_chip
            { itemid = xi.item.CLEAR_CHIP,  droprate = 125 }, -- clear_chip
            { itemid = xi.item.PURPLE_CHIP, droprate = 125 }, -- purple_chip
            { itemid = xi.item.WHITE_CHIP,  droprate = 125 }, -- white_chip
            { itemid = xi.item.BLACK_CHIP,  droprate = 125 }, -- black_chip
        },

        {
            { itemid = xi.item.NONE,          droprate = 125 }, -- nothing
            { itemid = xi.item.MYTHRIL_INGOT, droprate = 125 }, -- mythril_ingot
            { itemid = xi.item.EBONY_LOG,     droprate = 125 }, -- ebony_log
            { itemid = xi.item.PETRIFIED_LOG, droprate = 125 }, -- petrified_log
            { itemid = xi.item.AQUAMARINE,    droprate = 125 }, -- aquamarine
            { itemid = xi.item.PAINITE,       droprate = 125 }, -- painite
            { itemid = xi.item.CHRYSOBERYL,   droprate = 125 }, -- chrysoberyl
            { itemid = xi.item.MOONSTONE,     droprate = 125 }, -- moonstone
        },

        {
            { itemid = xi.item.NONE,                      droprate = 625 }, -- nothing
            { itemid = xi.item.SCROLL_OF_RERAISE_II,      droprate = 125 }, -- scroll_of_reraise_ii
            { itemid = xi.item.SCROLL_OF_FLARE,           droprate = 125 }, -- scroll_of_flare
            { itemid = xi.item.SCROLL_OF_VALOR_MINUET_IV, droprate = 125 }, -- scroll_of_valor_minuet_iv
        },

        {
            { itemid = xi.item.NONE,           droprate = 700 }, -- nothing
            { itemid = xi.item.HI_POTION_P3,   droprate =  75 }, -- hi-potion_+3
            { itemid = xi.item.HI_RERAISER,    droprate = 150 }, -- hi-reraiser
            { itemid = xi.item.VILE_ELIXIR,    droprate =  50 }, -- vile_elixir
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  25 }, -- vile_elixir_+1
        },
    },

    -- BCNM Die by the Sword
    [521] =
    {
        {
            { itemid = xi.item.RUSTY_PICK, droprate = 1000 }, -- rusty_pick
        },

        {
            { itemid = xi.item.ASHIGARU_EARRING,   droprate = 71 }, -- ashigaru_earring
            { itemid = xi.item.ESQUIRES_EARRING,   droprate = 71 }, -- esquires_earring
            { itemid = xi.item.MAGICIANS_EARRING,  droprate = 72 }, -- magicians_earring
            { itemid = xi.item.MERCENARYS_EARRING, droprate = 72 }, -- mercenarys_earring
            { itemid = xi.item.PILFERERS_EARRING,  droprate = 72 }, -- pilferers_earring
            { itemid = xi.item.SINGERS_EARRING,    droprate = 71 }, -- singers_earring
            { itemid = xi.item.TRIMMERS_EARRING,   droprate = 71 }, -- trimmers_earring
            { itemid = xi.item.WARLOCKS_EARRING,   droprate = 72 }, -- warlocks_earring
            { itemid = xi.item.WIZARDS_EARRING,    droprate = 72 }, -- wizards_earring
            { itemid = xi.item.WRESTLERS_EARRING,  droprate = 72 }, -- wrestlers_earring
            { itemid = xi.item.WYVERN_EARRING,     droprate = 71 }, -- wyvern_earring
            { itemid = xi.item.BEATERS_EARRING,    droprate = 71 }, -- beaters_earring
            { itemid = xi.item.GENIN_EARRING,      droprate = 71 }, -- genin_earring
            { itemid = xi.item.KILLER_EARRING,     droprate = 71 }, -- killer_earring
        },

        {
            { itemid = xi.item.AVATAR_BELT, droprate = 71 }, -- avatar_belt
            { itemid = xi.item.AXE_BELT,    droprate = 71 }, -- axe_belt
            { itemid = xi.item.CESTUS_BELT, droprate = 72 }, -- cestus_belt
            { itemid = xi.item.DAGGER_BELT, droprate = 72 }, -- dagger_belt
            { itemid = xi.item.GUN_BELT,    droprate = 72 }, -- gun_belt
            { itemid = xi.item.KATANA_OBI,  droprate = 71 }, -- katana_obi
            { itemid = xi.item.LANCE_BELT,  droprate = 71 }, -- lance_belt
            { itemid = xi.item.SARASHI,     droprate = 72 }, -- sarashi
            { itemid = xi.item.SCYTHE_BELT, droprate = 72 }, -- scythe_belt
            { itemid = xi.item.SHIELD_BELT, droprate = 72 }, -- shield_belt
            { itemid = xi.item.SONG_BELT,   droprate = 71 }, -- song_belt
            { itemid = xi.item.STAFF_BELT,  droprate = 71 }, -- staff_belt
            { itemid = xi.item.PICK_BELT,   droprate = 71 }, -- pick_belt
            { itemid = xi.item.RAPIER_BELT, droprate = 71 }, -- rapier_belt
        },

        {
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 200 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_REPRISAL,     droprate = 200 }, -- scroll_of_reprisal
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 200 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 200 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 200 }, -- gscroll_of_utsusemi_nin_belt
        },

        {
            { itemid = xi.item.NONE,             droprate = 775 }, -- nothing
            { itemid = xi.item.GOLD_INGOT,       droprate =  50 }, -- gold_ingot
            { itemid = xi.item.PLATINUM_INGOT,   droprate =  50 }, -- platinum_ingot
            { itemid = xi.item.PETRIFIED_LOG,    droprate =  50 }, -- petrified_log
            { itemid = xi.item.RUSTY_GREATSWORD, droprate =  75 }, -- rusty_greatsword
        },

        {
            { itemid = xi.item.NONE,            droprate = 250 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 250 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_BODY,  droprate = 250 }, -- mannequin_body
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 250 }, -- mannequin_hands
        },

        {
            { itemid = xi.item.NONE,     droprate = 667 }, -- nothing
            { itemid = xi.item.HI_ETHER, droprate = 333 }, -- hi-ether
        },
    },

    -- BCNM Let Sleeping Dogs Die
    [522] =
    {
        {
            { itemid = xi.item.WOLF_HIDE, droprate = 1000 }, -- wolf_hide
        },

        {
            { itemid = xi.item.REVIVAL_TREE_ROOT, droprate = 1000 }, -- revival_tree_root
        },

        {
            { itemid = xi.item.NONE,            droprate = 100 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 300 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_BODY,  droprate = 300 }, -- mannequin_body
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 300 }, -- mannequin_hands
        },

        {
            { itemid = xi.item.NONE,                  droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_ABSORB_AGI,  droprate = 125 }, -- scroll_of_absorb-agi
            { itemid = xi.item.SCROLL_OF_ABSORB_INT,  droprate = 125 }, -- scroll_of_absorb-int
            { itemid = xi.item.SCROLL_OF_ABSORB_VIT,  droprate = 125 }, -- scroll_of_absorb-vit
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_DISPEL,      droprate = 125 }, -- scroll_of_dispel
        },

        {
            { itemid = xi.item.NONE,             droprate = 100 }, -- nothing
            { itemid = xi.item.SINGERS_SHIELD,   droprate = 150 }, -- singers_shield
            { itemid = xi.item.WARLOCKS_SHIELD,  droprate = 150 }, -- warlocks_shield
            { itemid = xi.item.MAGICIANS_SHIELD, droprate = 150 }, -- magicians_shield
            { itemid = xi.item.ASHIGARU_MANTLE,  droprate = 150 }, -- ashigaru_mantle
            { itemid = xi.item.WIZARDS_MANTLE,   droprate = 150 }, -- wizards_mantle
            { itemid = xi.item.KILLER_MANTLE,    droprate = 150 }, -- killer_mantle
        },
    },

    -- BCNM Brothers D'Aurphe
    [523] =
    {
        {
            { itemid = xi.item.CREEK_M_CLOMPS,   droprate = 125 }, -- creek_m_clomps
            { itemid = xi.item.CREEK_F_CLOMPS,   droprate = 125 }, -- creek_f_clomps
            { itemid = xi.item.MARINE_M_BOOTS,   droprate = 125 }, -- marine_m_boots
            { itemid = xi.item.MARINE_F_BOOTS,   droprate = 125 }, -- marine_f_boots
            { itemid = xi.item.WOOD_M_LEDELSENS, droprate = 125 }, -- wood_m_ledelsens
            { itemid = xi.item.WOOD_F_LEDELSENS, droprate = 125 }, -- wood_f_ledelsens
            { itemid = xi.item.DUNE_SANDALS,     droprate = 125 }, -- dune_sandals
            { itemid = xi.item.RIVER_GAITERS,    droprate = 125 }, -- river_gaiters
        },

        {
            { itemid = xi.item.CROSS_COUNTERS, droprate =  43 }, -- cross-counters
            { itemid = xi.item.CHRYSOBERYL,    droprate =  10 }, -- chrysoberyl
            { itemid = xi.item.JADEITE,        droprate =  94 }, -- jadeite
            { itemid = xi.item.SUNSTONE,       droprate = 113 }, -- sunstone
            { itemid = xi.item.ZIRCON,         droprate =  75 }, -- zircon
            { itemid = xi.item.CLEAR_CHIP,     droprate =  10 }, -- clear_chip
            { itemid = xi.item.RED_CHIP,       droprate =  38 }, -- red_chip
            { itemid = xi.item.YELLOW_CHIP,    droprate =  38 }, -- yellow_chip
            { itemid = xi.item.GOLD_INGOT,     droprate = 151 }, -- gold_ingot
            { itemid = xi.item.PURPLE_ROCK,    droprate =  19 }, -- purple_rock
            { itemid = xi.item.WHITE_ROCK,     droprate =  19 }, -- white_rock
        },

        {
            { itemid = xi.item.STEEL_INGOT,      droprate = 132 }, -- steel_ingot
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 113 }, -- translucent_rock
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate = 113 }, -- darksteel_ingot
            { itemid = xi.item.PAINITE,          droprate =  50 }, -- painite
            { itemid = xi.item.EBONY_LOG,        droprate = 132 }, -- ebony_log
            { itemid = xi.item.WHITE_CHIP,       droprate =  10 }, -- white_chip
            { itemid = xi.item.MOONSTONE,        droprate = 151 }, -- moonstone
            { itemid = xi.item.ZIRCON,           droprate =  75 }, -- zircon
            { itemid = xi.item.FLUORITE,         droprate =  57 }, -- fluorite
            { itemid = xi.item.CHRYSOBERYL,      droprate =  57 }, -- chrysoberyl
            { itemid = xi.item.GREEN_ROCK,       droprate =  38 }, -- green_rock
            { itemid = xi.item.HI_RERAISER,      droprate =  38 }, -- hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate =  38 }, -- vile_elixir_+1
        },

        {
            { itemid = xi.item.SCROLL_OF_FLARE,           droprate = 283 }, -- scroll_of_flare
            { itemid = xi.item.SCROLL_OF_VALOR_MINUET_IV, droprate = 358 }, -- scroll_of_valor_minuet_iv
            { itemid = xi.item.SCROLL_OF_RERAISE_II,      droprate = 264 }, -- scroll_of_reraise_ii
        },

        {
            { itemid = xi.item.NONE,        droprate = 957 }, -- nothing
            { itemid = xi.item.EURYTOS_BOW, droprate =  43 }, -- eurytos_bow
        },

        {
            { itemid = xi.item.NONE,          droprate = 582 }, -- nothing
            { itemid = xi.item.MYTHRIL_INGOT, droprate = 302 }, -- mythril_ingot
            { itemid = xi.item.BLUE_CHIP,     droprate =  19 }, -- blue_chip
            { itemid = xi.item.BLACK_CHIP,    droprate =  38 }, -- black_chip
            { itemid = xi.item.PURPLE_CHIP,   droprate =  10 }, -- purple_chip
            { itemid = xi.item.GREEN_CHIP,    droprate =  19 }, -- green_chip
            { itemid = xi.item.MAHOGANY_LOG,  droprate =  10 }, -- mahogany_log
            { itemid = xi.item.RED_ROCK,      droprate =  10 }, -- red_rock
            { itemid = xi.item.BLACK_ROCK,    droprate =  10 }, -- black_rock
        },

        {
            { itemid = xi.item.NONE,         droprate = 887 }, -- nothing
            { itemid = xi.item.HI_POTION_P3, droprate = 113 }, -- hi-potion_+3
        },
    },

    -- BCNM Undying Promise
    [524] =
    {
        {
            { itemid = xi.item.BONE_CHIP, droprate = 1000 }, -- bone_chip
        },

        {
            { itemid = xi.item.BONE_CHIP, droprate = 1000 }, -- bone_chip
        },

        {
            { itemid = xi.item.CALVELEYS_DAGGER, droprate = 175 }, -- calveleys_dagger
            { itemid = xi.item.JENNET_SHIELD,    droprate = 175 }, -- jennet_shield
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 175 }, -- jongleurs_dagger
            { itemid = xi.item.KAGEHIDE,         droprate = 175 }, -- kagehide
            { itemid = xi.item.OHAGURO,          droprate = 175 }, -- ohaguro
            { itemid = xi.item.EBONY_LOG,        droprate = 125 }, -- ebony_log
        },

        {
            { itemid = xi.item.BEHOURD_LANCE,  droprate = 200 }, -- behourd_lance
            { itemid = xi.item.ELEGANT_SHIELD, droprate = 200 }, -- elegant_shield
            { itemid = xi.item.MUTILATOR,      droprate = 200 }, -- mutilator
            { itemid = xi.item.RAIFU,          droprate = 200 }, -- raifu
            { itemid = xi.item.TOURNEY_PATAS,  droprate = 200 }, -- tourney_patas
        },

        {
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  60 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.GOLD_INGOT,               droprate =  60 }, -- gold_ingot
            { itemid = xi.item.GOLD_BEASTCOIN,           droprate =  60 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,        droprate =  60 }, -- mythril_beastcoin
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =  60 }, -- mythril_ingot
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  60 }, -- platinum_ingot
            { itemid = xi.item.RAM_HORN,                 droprate =  60 }, -- ram_horn
            { itemid = xi.item.SCROLL_OF_REFRESH,        droprate = 125 }, -- scroll_of_refresh
            { itemid = xi.item.RERAISER,                 droprate = 145 }, -- reraiser
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,    droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,     droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  60 }, -- handful_of_wyvern_scales
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,       droprate =  78 }, -- coral_fragment
            { itemid = xi.item.DARKSTEEL_INGOT,      droprate =  78 }, -- darksteel_ingot
            { itemid = xi.item.DEMON_HORN,           droprate =  78 }, -- demon_horn
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,    droprate =  78 }, -- chunk_of_gold_ore
            { itemid = xi.item.MYTHRIL_INGOT,        droprate =  78 }, -- mythril_ingot
            { itemid = xi.item.PETRIFIED_LOG,        droprate =  78 }, -- petrified_log
            { itemid = xi.item.RAM_HORN,             droprate =  78 }, -- ram_horn
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 125 }, -- scroll_of_phalanx
        },

        {
            { itemid = xi.item.NONE,                  droprate = 850 }, -- nothing
            { itemid = xi.item.RAM_SKIN,              droprate =  50 }, -- ram_skin
            { itemid = xi.item.MAHOGANY_LOG,          droprate =  50 }, -- mahogany_log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE, droprate =  50 }, -- platinum_ore
        },
    },

    -- BCNM Factory Rejects
    [525] =
    {
        {
            { itemid = xi.item.DOLL_SHARD, droprate = 1000 }, -- doll_shard
        },

        {
            { itemid = xi.item.VIAL_OF_MERCURY, droprate = 1000 }, -- vial_of_mercury
        },

        {
            { itemid = xi.item.NONE,           droprate = 500 }, -- nothing
            { itemid = xi.item.GOLD_BEASTCOIN, droprate = 500 }, -- gold_beastcoin
        },

        {
            { itemid = xi.item.NONE,             droprate = 250 }, -- nothing
            { itemid = xi.item.RAIFU,            droprate = 250 }, -- raifu
            { itemid = xi.item.BUZZARD_TUCK,     droprate = 250 }, -- buzzard_tuck
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 250 }, -- jongleurs_dagger
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.REARGUARD_MANTLE, droprate = 400 }, -- rearguard_mantle
            { itemid = xi.item.AGILE_MANTLE,     droprate = 400 }, -- agile_mantle
        },

        {
            { itemid = xi.item.NONE,                  droprate = 750 }, -- nothing
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
        },
    },

    -- BCNM Idol Thoughts
    [526] =
    {
        {
            { itemid = xi.item.GOLEM_SHARD, droprate = 1000 }, -- golem_shard
        },

        {
            { itemid = xi.item.SLAB_OF_GRANITE, droprate = 1000 }, -- slab_of_granite
        },

        {
            { itemid = xi.item.LIBATION_ABJURATION, droprate = 500 }, -- libation_abjuration
            { itemid = xi.item.OBLATION_ABJURATION, droprate = 500 }, -- oblation_abjuration
        },

        {
            { itemid = xi.item.NONE,             droprate = 875 }, -- nothing
            { itemid = xi.item.SCROLL_OF_FREEZE, droprate = 125 }, -- scroll_of_freeze
        },

        {
            { itemid = xi.item.NONE,           droprate = 200 }, -- nothing
            { itemid = xi.item.OPTICAL_NEEDLE, droprate = 200 }, -- optical_needle
            { itemid = xi.item.KAKANPU,        droprate = 200 }, -- kakanpu
            { itemid = xi.item.MANTRA_COIN,    droprate = 200 }, -- mantra_coin
            { itemid = xi.item.NAZAR_BONJUK,   droprate = 200 }, -- nazar_bonjuk
        },

        {
            { itemid = xi.item.NONE,                 droprate = 100 }, -- nothing
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE, droprate = 300 }, -- chunk_of_mythril_ore
            { itemid = xi.item.GOLD_INGOT,           droprate = 300 }, -- gold_ingot
            { itemid = xi.item.PLATINUM_INGOT,       droprate = 300 }, -- platinum_ingot
        },
    },

    -- BCNM An Awful Autopsy
    [527] =
    {
        {
            { itemid = xi.item.UNDEAD_SKIN, droprate = 1000 }, -- undead_skin
        },

        {
            { itemid = xi.item.NONE,         droprate = 500 }, -- nothing
            { itemid = xi.item.RIVAL_RIBBON, droprate = 250 }, -- rival_ribbon
            { itemid = xi.item.SUPER_RIBBON, droprate = 250 }, -- super_ribbon
        },

        {
            { itemid = xi.item.NONE,          droprate = 250 }, -- nothing
            { itemid = xi.item.IVORY_MITTS,   droprate = 250 }, -- ivory_mitts
            { itemid = xi.item.RUSH_GLOVES,   droprate = 250 }, -- rush_gloves
            { itemid = xi.item.SLY_GAUNTLETS, droprate = 250 }, -- sly_gauntlets
        },

        {
            { itemid = xi.item.NONE,            droprate = 200 }, -- nothing
            { itemid = xi.item.HEAVY_MANTLE,    droprate = 200 }, -- heavy_mantle
            { itemid = xi.item.ESOTERIC_MANTLE, droprate = 200 }, -- esoteric_mantle
            { itemid = xi.item.SNIPERS_MANTLE,  droprate = 200 }, -- snipers_mantle
            { itemid = xi.item.TEMPLARS_MANTLE, droprate = 200 }, -- templars_mantle
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.HATEFUL_COLLAR,   droprate = 200 }, -- hateful_collar
            { itemid = xi.item.STORM_GORGET,     droprate = 200 }, -- storm_gorget
            { itemid = xi.item.INTELLECT_TORQUE, droprate = 200 }, -- intellect_torque
            { itemid = xi.item.BENIGN_NECKLACE,  droprate = 200 }, -- benign_necklace
        },

        {
            { itemid = xi.item.NONE,            droprate = 200 }, -- nothing
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 200 }, -- darksteel_ingot
            { itemid = xi.item.EBONY_LOG,       droprate = 200 }, -- ebony_log
            { itemid = xi.item.PETRIFIED_LOG,   droprate = 200 }, -- petrified_log
            { itemid = xi.item.GOLD_INGOT,      droprate = 200 }, -- gold_ingot
        },

        {
            { itemid = xi.item.NONE,            droprate = 875 }, -- nothing
            { itemid = xi.item.SCROLL_OF_QUAKE, droprate = 125 }, -- scroll_of_quake
        },
    },

    -- BCNM Celery
    [528] =
    {
        {
            { itemid = xi.item.LIBATION_ABJURATION, droprate = 1000 }, -- libation_abjuration
        },

        {
            { itemid = xi.item.OBLATION_ABJURATION, droprate = 1000 }, -- oblation_abjuration
        },

        {
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH, droprate = 1000 }, -- square_of_rainbow_cloth
        },

        {
            { itemid = xi.item.SQUARE_OF_SILK_CLOTH, droprate = 1000 }, -- square_of_silk_cloth
        },

        {
            { itemid = xi.item.SQUARE_OF_SILK_CLOTH, droprate = 1000 }, -- square_of_silk_cloth
        },

        {
            { itemid = xi.item.SQUARE_OF_SILK_CLOTH, droprate = 1000 }, -- square_of_silk_cloth
        },

        {
            { itemid = xi.item.TELEPORT_RING_DEM, droprate = 250 }, -- teleport_ring_dem
            { itemid = xi.item.TELEPORT_RING_MEA, droprate = 250 }, -- teleport_ring_mea
            { itemid = xi.item.NURSEMAIDS_HARP,   droprate = 250 }, -- nursemaids_harp
            { itemid = xi.item.TRAILERS_KUKRI,    droprate = 250 }, -- trailers_kukri
        },

        {
            { itemid = xi.item.ELUSIVE_EARRING, droprate = 250 }, -- elusive_earring
            { itemid = xi.item.KNIGHTLY_MANTLE, droprate = 250 }, -- knightly_mantle
            { itemid = xi.item.HI_ETHER_TANK,   droprate = 250 }, -- hi-ether_tank
            { itemid = xi.item.HI_POTION_TANK,  droprate = 250 }, -- hi-potion_tank
        },

        {
            { itemid = xi.item.NONE,         droprate = 950 }, -- nothing
            { itemid = xi.item.WALKURE_MASK, droprate =  50 }, -- walkure_mask
        },

        {
            { itemid = xi.item.AQUAMARINE,       droprate =  50 }, -- aquamarine
            { itemid = xi.item.CHRYSOBERYL,      droprate =  50 }, -- chrysoberyl
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate = 100 }, -- darksteel_ingot
            { itemid = xi.item.EBONY_LOG,        droprate =  50 }, -- ebony_log
            { itemid = xi.item.FLUORITE,         droprate =  50 }, -- fluorite
            { itemid = xi.item.GOLD_INGOT,       droprate =  50 }, -- gold_ingot
            { itemid = xi.item.HI_RERAISER,      droprate =  50 }, -- hi-reraiser
            { itemid = xi.item.JADEITE,          droprate =  50 }, -- jadeite
            { itemid = xi.item.MAHOGANY_LOG,     droprate =  50 }, -- mahogany_log
            { itemid = xi.item.MOONSTONE,        droprate =  50 }, -- moonstone
            { itemid = xi.item.MYTHRIL_INGOT,    droprate =  50 }, -- mythril_ingot
            { itemid = xi.item.PAINITE,          droprate =  50 }, -- painite
            { itemid = xi.item.RED_ROCK,         droprate =  50 }, -- red_rock
            { itemid = xi.item.STEEL_INGOT,      droprate =  50 }, -- steel_ingot
            { itemid = xi.item.SUNSTONE,         droprate =  50 }, -- sunstone
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate =  50 }, -- translucent_rock
            { itemid = xi.item.WHITE_ROCK,       droprate =  50 }, -- white_rock
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate =  50 }, -- vile_elixir_+1
            { itemid = xi.item.ZIRCON,           droprate =  50 }, -- zircon
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
