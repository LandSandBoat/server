-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Circle Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Steamed Sprouts
    [97] =
    {
        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.NONE,        droprate = 750 }, -- nothing
            { itemid = xi.item.VILE_ELIXIR, droprate = 250 }, -- vile_elixir
        },

        {
            { itemid = xi.item.NONE,              droprate = 600 }, -- nothing
            { itemid = xi.item.SURVIVAL_BELT,     droprate = 100 }, -- survival_belt
            { itemid = xi.item.GUARDING_GORGET,   droprate = 100 }, -- guarding_gorget
            { itemid = xi.item.ENHANCING_EARRING, droprate = 100 }, -- enhancing_earring
            { itemid = xi.item.BALANCE_BUCKLER,   droprate = 100 }, -- balance_buckler
        },

        {
            { itemid = xi.item.WHITE_ROCK,       droprate = 125 }, -- white_rock
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 125 }, -- translucent_rock
            { itemid = xi.item.PURPLE_ROCK,      droprate = 125 }, -- purple_rock
            { itemid = xi.item.RED_ROCK,         droprate = 125 }, -- red_rock
            { itemid = xi.item.BLUE_ROCK,        droprate = 125 }, -- blue_rock
            { itemid = xi.item.YELLOW_ROCK,      droprate = 125 }, -- yellow_rock
            { itemid = xi.item.GREEN_ROCK,       droprate = 125 }, -- green_rock
            { itemid = xi.item.BLACK_ROCK,       droprate = 125 }, -- black_rock
        },

        {
            { itemid = xi.item.GARNET,       droprate =  50 }, -- garnet
            { itemid = xi.item.BLACK_PEARL,  droprate =  50 }, -- black_pearl
            { itemid = xi.item.AMETRINE,     droprate =  50 }, -- ametrine
            { itemid = xi.item.PAINITE,      droprate =  50 }, -- painite
            { itemid = xi.item.PEARL,        droprate =  50 }, -- pearl
            { itemid = xi.item.OAK_LOG,      droprate = 100 }, -- oak_log
            { itemid = xi.item.GOSHENITE,    droprate = 100 }, -- goshenite
            { itemid = xi.item.SPHENE,       droprate = 100 }, -- sphene
            { itemid = xi.item.ROSEWOOD_LOG, droprate = 100 }, -- rosewood_log
            { itemid = xi.item.TURQUOISE,    droprate = 100 }, -- turquoise
            { itemid = xi.item.SAPPHIRE,     droprate = 100 }, -- sapphire
            { itemid = xi.item.PERIDOT,      droprate = 150 }, -- peridot
        },

        {
            { itemid = xi.item.NONE,                  droprate = 125 }, -- nothing
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 125 }, -- scroll_of_refresh
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
        },
    },

    -- BCNM Divine Punishers
    [98] =
    {
        {
            { itemid = xi.item.FORSETIS_AXE, droprate = 250 }, -- forsetis_axe
            { itemid = xi.item.ARAMISS_RAPIER, droprate = 250 }, -- aramiss_rapier
            { itemid = xi.item.SPARTAN_CESTI, droprate = 250 }, -- spartan_cesti
            { itemid = xi.item.DOMINION_MACE, droprate = 250 }, -- dominion_mace
        },

        {
            { itemid = xi.item.NONE,             droprate = 250 }, -- nothing
            { itemid = xi.item.FUMA_KYAHAN,      droprate = 100 }, -- fuma_kyahan
            { itemid = xi.item.PEACE_RING,       droprate = 200 }, -- peace_ring
            { itemid = xi.item.ENHANCING_MANTLE, droprate = 200 }, -- enhancing_mantle
            { itemid = xi.item.MASTER_BELT,      droprate = 150 }, -- master_belt
            { itemid = xi.item.OCHIUDOS_KOTE,    droprate = 100 }, -- ochiudos_kote
        },

        {
            { itemid = xi.item.NONE,           droprate = 850 }, -- nothing
            { itemid = xi.item.HI_RERAISER,    droprate = 100 }, -- hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  50 }, -- vile_elixir_+1
        },

        {
            { itemid = xi.item.PURPLE_ROCK,      droprate = 166 }, -- purple_rock
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 166 }, -- translucent_rock
            { itemid = xi.item.RED_ROCK,         droprate = 167 }, -- red_rock
            { itemid = xi.item.BLACK_ROCK,       droprate = 167 }, -- black_rock
            { itemid = xi.item.YELLOW_ROCK,      droprate = 167 }, -- yellow_rock
            { itemid = xi.item.WHITE_ROCK,       droprate = 167 }, -- white_rock
        },

        {
            { itemid = xi.item.PAINITE,     droprate = 125 }, -- painite
            { itemid = xi.item.AQUAMARINE,  droprate = 125 }, -- aquamarine
            { itemid = xi.item.FLUORITE,    droprate = 125 }, -- fluorite
            { itemid = xi.item.ZIRCON,      droprate = 125 }, -- zircon
            { itemid = xi.item.SUNSTONE,    droprate = 125 }, -- sunstone
            { itemid = xi.item.CHRYSOBERYL, droprate = 125 }, -- chrysoberyl
            { itemid = xi.item.MOONSTONE,   droprate = 125 }, -- moonstone
            { itemid = xi.item.JADEITE,     droprate = 125 }, -- jadeite
        },

        {
            { itemid = xi.item.NONE,         droprate = 517 }, -- nothing
            { itemid = xi.item.MAHOGANY_LOG, droprate = 333 }, -- mahogany_log
            { itemid = xi.item.EBONY_LOG,    droprate = 150 }, -- ebony_log
        },

        {
            { itemid = xi.item.STEEL_INGOT,     droprate = 350 }, -- steel_ingot
            { itemid = xi.item.MYTHRIL_INGOT,   droprate = 150 }, -- mythril_ingot
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 150 }, -- darksteel_ingot
            { itemid = xi.item.GOLD_INGOT,      droprate = 350 }, -- gold_ingot
        },
    },

    -- BCNM Treasure and Tribulations
    [100] =
    {
        {
            { itemid = xi.item.GUARDIANS_RING, droprate =  75 }, -- Guardians Ring
            { itemid = xi.item.KAMPFER_RING,   droprate =  32 }, -- Kampfer Ring
            { itemid = xi.item.CONJURERS_RING, droprate =  54 }, -- Conjurers Ring
            { itemid = xi.item.SHINOBI_RING,   droprate =  32 }, -- Shinobi Ring
            { itemid = xi.item.SLAYERS_RING,   droprate =  97 }, -- Slayers Ring
            { itemid = xi.item.SORCERERS_RING, droprate =  75 }, -- Sorcerers Ring
            { itemid = xi.item.SOLDIERS_RING,  droprate = 108 }, -- Soldiers Ring
            { itemid = xi.item.TAMERS_RING,    droprate =  22 }, -- Tamers Ring
            { itemid = xi.item.TRACKERS_RING,  droprate =  65 }, -- Trackers Ring
            { itemid = xi.item.DRAKE_RING,     droprate =  32 }, -- Drake Ring
            { itemid = xi.item.FENCERS_RING,   droprate =  32 }, -- Fencers Ring
            { itemid = xi.item.MINSTRELS_RING, droprate =  86 }, -- Minstrels Ring
            { itemid = xi.item.MEDICINE_RING,  droprate =  86 }, -- Medicine Ring
            { itemid = xi.item.ROGUES_RING,    droprate =  75 }, -- Rogues Ring
            { itemid = xi.item.RONIN_RING,     droprate =  11 }, -- Ronin Ring
            { itemid = xi.item.PLATINUM_RING,  droprate =  32 }, -- Platinum Ring
        },

        {
            { itemid = xi.item.ASTRAL_RING,              droprate = 376 }, -- Astral Ring
            { itemid = xi.item.PLATINUM_RING,            droprate =  22 }, -- Platinum Ring
            { itemid = xi.item.SCROLL_OF_QUAKE,          droprate =  65 }, -- Scroll Of Quake
            { itemid = xi.item.RAM_SKIN,                 droprate =  10 }, -- Ram Skin
            { itemid = xi.item.RERAISER,                 droprate =  11 }, -- Reraiser
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =  22 }, -- Mythril Ingot
            { itemid = xi.item.LIGHT_SPIRIT_PACT,        droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,         droprate =  32 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III,      droprate =  43 }, -- Scroll Of Regen Iii
            { itemid = xi.item.SCROLL_OF_RAISE_II,       droprate =  32 }, -- Scroll Of Raise Ii
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  11 }, -- Petrified Log
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  11 }, -- Coral Fragment
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  11 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  43 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 108 }, -- Chunk Of Gold Ore
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  32 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  65 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.GOLD_INGOT,               droprate =  10 }, -- Gold Ingot
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  11 }, -- Darksteel Ingot
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  11 }, -- Platinum Ingot
            { itemid = xi.item.EBONY_LOG,                droprate =  11 }, -- Ebony Log
            { itemid = xi.item.RAM_HORN,                 droprate =  11 }, -- Ram Horn
            { itemid = xi.item.DEMON_HORN,               droprate =  11 }, -- Demon Horn
            { itemid = xi.item.MANTICORE_HIDE,           droprate =   9 }, -- Manticore Hide
            { itemid = xi.item.WYVERN_SKIN,              droprate =  11 }, -- Wyvern Skin
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  11 }, -- Handful Of Wyvern Scales
        },
    },

    -- BCNM Creeping Doom
    [104] =
    {
        {
            { itemid = xi.item.SPOOL_OF_SILK_THREAD, droprate = 1000 }, -- spool_of_silk_thread
        },

        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 3000 }, -- gil
        },

        {
            { itemid = xi.item.NONE,                 droprate = 700 }, -- nothing
            { itemid = xi.item.SPOOL_OF_SILK_THREAD, droprate = 300 }, -- spool_of_silk_thread
        },

        {
            { itemid = xi.item.NONE,                 droprate = 900 }, -- nothing
            { itemid = xi.item.SPOOL_OF_SILK_THREAD, droprate = 100 }, -- spool_of_silk_thread
        },

        {
            { itemid = xi.item.NONE,               droprate = 300 }, -- nothing
            { itemid = xi.item.SINGERS_EARRING,    droprate =  40 }, -- singers_earring
            { itemid = xi.item.ASHIGARU_EARRING,   droprate =  50 }, -- ashigaru_earring
            { itemid = xi.item.MAGICIANS_EARRING,  droprate =  50 }, -- magicians_earring
            { itemid = xi.item.WARLOCKS_EARRING,   droprate =  50 }, -- warlocks_earring
            { itemid = xi.item.HEALERS_EARRING,    droprate =  40 }, -- healers_earring
            { itemid = xi.item.ESQUIRES_EARRING,   droprate =  45 }, -- esquires_earring
            { itemid = xi.item.WIZARDS_EARRING,    droprate =  50 }, -- wizards_earring
            { itemid = xi.item.WYVERN_EARRING,     droprate =  40 }, -- wyvern_earring
            { itemid = xi.item.MERCENARYS_EARRING, droprate =  50 }, -- mercenarys_earring
            { itemid = xi.item.KILLER_EARRING,     droprate =  45 }, -- killer_earring
            { itemid = xi.item.WRESTLERS_EARRING,  droprate =  45 }, -- wrestlers_earring
            { itemid = xi.item.GENIN_EARRING,      droprate =  50 }, -- genin_earring
            { itemid = xi.item.BEATERS_EARRING,    droprate =  50 }, -- beaters_earring
            { itemid = xi.item.PILFERERS_EARRING,  droprate =  45 }, -- pilferers_earring
            { itemid = xi.item.TRIMMERS_EARRING,   droprate =  50 }, -- trimmers_earring
        },

        {
            { itemid = xi.item.NONE,               droprate = 700 }, -- nothing
            { itemid = xi.item.SINGERS_EARRING,    droprate =  20 }, -- singers_earring
            { itemid = xi.item.ASHIGARU_EARRING,   droprate =  20 }, -- ashigaru_earring
            { itemid = xi.item.MAGICIANS_EARRING,  droprate =  20 }, -- magicians_earring
            { itemid = xi.item.WARLOCKS_EARRING,   droprate =  20 }, -- warlocks_earring
            { itemid = xi.item.HEALERS_EARRING,    droprate =  20 }, -- healers_earring
            { itemid = xi.item.ESQUIRES_EARRING,   droprate =  20 }, -- esquires_earring
            { itemid = xi.item.WIZARDS_EARRING,    droprate =  20 }, -- wizards_earring
            { itemid = xi.item.WYVERN_EARRING,     droprate =  20 }, -- wyvern_earring
            { itemid = xi.item.MERCENARYS_EARRING, droprate =  20 }, -- mercenarys_earring
            { itemid = xi.item.KILLER_EARRING,     droprate =  20 }, -- killer_earring
            { itemid = xi.item.WRESTLERS_EARRING,  droprate =  20 }, -- wrestlers_earring
            { itemid = xi.item.GENIN_EARRING,      droprate =  20 }, -- genin_earring
            { itemid = xi.item.BEATERS_EARRING,    droprate =  20 }, -- beaters_earring
            { itemid = xi.item.PILFERERS_EARRING,  droprate =  20 }, -- pilferers_earring
            { itemid = xi.item.TRIMMERS_EARRING,   droprate =  20 }, -- trimmers_earring
        },

        {
            { itemid = xi.item.NONE,                    droprate = 500 }, -- nothing
            { itemid = xi.item.SHEET_OF_BAST_PARCHMENT, droprate = 400 }, -- sheet_of_bast_parchment
            { itemid = xi.item.HI_POTION,               droprate = 100 }, -- hi-potion
        },

        {
            { itemid = xi.item.NONE,         droprate = 500 }, -- nothing
            { itemid = xi.item.CHESTNUT_LOG, droprate = 250 }, -- chestnut_log
            { itemid = xi.item.HI_ETHER,     droprate = 250 }, -- hi-ether
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 150 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 200 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 250 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 150 }, -- scroll_of_utsusemi_ni
        },

        {
            { itemid = xi.item.NONE,                   droprate = 300 }, -- nothing
            { itemid = xi.item.AMBER_STONE,            droprate =  50 }, -- amber_stone
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate =  50 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.ELM_LOG,                droprate =  50 }, -- elm_log
            { itemid = xi.item.IRON_INGOT,             droprate =  50 }, -- iron_ingot
            { itemid = xi.item.CHUNK_OF_IRON_ORE,      droprate =  50 }, -- chunk_of_iron_ore
            { itemid = xi.item.LAPIS_LAZULI,           droprate =  50 }, -- lapis_lazuli
            { itemid = xi.item.MYTHRIL_INGOT,          droprate =  50 }, -- mythril_ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,   droprate =  50 }, -- chunk_of_mythril_ore
            { itemid = xi.item.ONYX,                   droprate =  50 }, -- onyx
            { itemid = xi.item.SARDONYX,               droprate =  50 }, -- sardonyx
            { itemid = xi.item.SILVER_INGOT,           droprate =  50 }, -- silver_ingot
            { itemid = xi.item.CHUNK_OF_SILVER_ORE,    droprate =  50 }, -- chunk_of_silver_ore
            { itemid = xi.item.STEEL_INGOT,            droprate =  50 }, -- steel_ingot
            { itemid = xi.item.TOURMALINE,             droprate =  50 }, -- tourmaline
            { itemid = xi.item.LIGHT_OPAL,             droprate =  50 }, -- light opal
        },

        {
            { itemid = xi.item.NONE,                   droprate = 500 }, -- nothing
            { itemid = xi.item.AMBER_STONE,            droprate =  30 }, -- amber_stone
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate =  40 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.ELM_LOG,                droprate =  30 }, -- elm_log
            { itemid = xi.item.IRON_INGOT,             droprate =  30 }, -- iron_ingot
            { itemid = xi.item.CHUNK_OF_IRON_ORE,      droprate =  40 }, -- chunk_of_iron_ore
            { itemid = xi.item.LAPIS_LAZULI,           droprate =  30 }, -- lapis_lazuli
            { itemid = xi.item.MYTHRIL_INGOT,          droprate =  40 }, -- mythril_ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,   droprate =  40 }, -- chunk_of_mythril_ore
            { itemid = xi.item.ONYX,                   droprate =  30 }, -- onyx
            { itemid = xi.item.SARDONYX,               droprate =  30 }, -- sardonyx
            { itemid = xi.item.SILVER_INGOT,           droprate =  40 }, -- silver_ingot
            { itemid = xi.item.CHUNK_OF_SILVER_ORE,    droprate =  30 }, -- chunk_of_silver_ore
            { itemid = xi.item.STEEL_INGOT,            droprate =  30 }, -- steel_ingot
            { itemid = xi.item.TOURMALINE,             droprate =  30 }, -- tourmaline
            { itemid = xi.item.LIGHT_OPAL,             droprate =  30 }, -- light opal
        },
    },

    -- BCNM Charming Trio
    [105] =
    {
        {
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 1000 }, -- Mannequin Hands
        },

        {
            { itemid = xi.item.JAR_OF_TOAD_OIL,        droprate = 250 }, -- Jar Of Toad Oil
            { itemid = xi.item.POTION,                 droprate = 300 }, -- Potion
            { itemid = xi.item.POTION_P1,              droprate = 180 }, -- Potion +1
            { itemid = xi.item.AIR_SPIRIT_PACT,        droprate = 130 }, -- Air Spirit Pact
            { itemid = xi.item.SQUARE_OF_COTTON_CLOTH, droprate = 280 }, -- Square Of Cotton Cloth
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 250 }, -- Mythril Beastcoin
            { itemid = xi.item.GANKO,                 droprate = 190 }, -- Ganko
            { itemid = xi.item.SQUARE_OF_WOOL_CLOTH,  droprate = 270 }, -- Square Of Wool Cloth
            { itemid = xi.item.PLATOON_DISC,          droprate = 145 }, -- Platoon Disc
            { itemid = xi.item.SQUARE_OF_GRASS_CLOTH, droprate = 295 }, -- Square Of Grass Cloth
            { itemid = xi.item.SQUARE_OF_LINEN_CLOTH, droprate = 260 }, -- Square Of Linen Cloth
        },

        {
            { itemid = xi.item.NONE,           droprate = 800 }, -- Nothing
            { itemid = xi.item.PLATOON_CUTTER, droprate = 167 }, -- Platoon Cutter
        },

        {
            { itemid = xi.item.NONE,                droprate = 500 },  -- Nothing
            { itemid = xi.item.VIAL_OF_FIEND_BLOOD, droprate = 500 },  -- Vial Of Fiend Blood
        },

        {
            { itemid = xi.item.NONE,                droprate = 500 },  -- Nothing
            { itemid = xi.item.VIAL_OF_FIEND_BLOOD, droprate = 500 },  -- Vial Of Fiend Blood
        },

        {
            { itemid = xi.item.PLATOON_EDGE,           droprate = 235 }, -- Platoon Edge
            { itemid = xi.item.PLATOON_GUN,            droprate = 235 }, -- Platoon Gun
            { itemid = xi.item.PLATOON_SPATHA,         droprate = 235 }, -- Platoon Spatha
            { itemid = xi.item.PLATOON_POLE,           droprate = 235 }, -- Platoon Pole
            { itemid = xi.item.GUNROMARU,              droprate = 255 }, -- Gunromaru
            { itemid = xi.item.MANNEQUIN_HEAD,         droprate = 260 }, -- Mannequin Head
            { itemid = xi.item.SCROLL_OF_DRAIN,        droprate = 250 }, -- Scroll Of Drain
            { itemid = xi.item.VIAL_OF_BEASTMAN_BLOOD, droprate = 190 }, -- Vial Of Beastman Blood
        },
    },

    -- BCNM Harem Scarem
    [106] =
    {
        {
            { itemid = xi.item.DHALMEL_HIDE, droprate = 1000 }, -- dhalmel_hide
        },

        {
            { itemid = xi.item.NONE,        droprate =  500 }, -- nothing
            { itemid = xi.item.GIANT_FEMUR, droprate =  500 }, -- giant_femur
        },

        {
            { itemid = xi.item.NONE,                  droprate = 500 }, -- nothing
            { itemid = xi.item.SLICE_OF_DHALMEL_MEAT, droprate = 500 }, -- slice_of_dhalmel_meat
        },

        {
            { itemid = xi.item.NONE,             droprate = 400 }, -- nothing
            { itemid = xi.item.MERCENARY_MANTLE, droprate = 150 }, -- mercenary_mantle
            { itemid = xi.item.BEATERS_MANTLE,   droprate = 150 }, -- beaters_mantle
            { itemid = xi.item.ESQUIRES_MANTLE,  droprate = 150 }, -- esquires_mantle
            { itemid = xi.item.HEALERS_MANTLE,   droprate = 150 }, -- healers_mantle
        },

        {
            { itemid = xi.item.NONE,           droprate = 400 }, -- nothing
            { itemid = xi.item.WIZARDS_SHIELD, droprate = 200 }, -- wizards_shield
            { itemid = xi.item.TRIMMERS_ASPIS, droprate = 200 }, -- trimmers_aspis
            { itemid = xi.item.WYVERN_TARGE,   droprate = 200 }, -- wyvern_targe
        },

        {
            { itemid = xi.item.NONE,                   droprate = 200 }, -- nothing
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 200 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 200 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 200 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 200 }, -- scroll_of_utsusemi_ni
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.SQUARE_OF_VELVET_CLOTH, droprate = 250 }, -- square_of_velvet_cloth
            { itemid = xi.item.SQUARE_OF_LINEN_CLOTH,  droprate = 250 }, -- square_of_linen_cloth
            { itemid = xi.item.SQUARE_OF_WOOL_CLOTH,   droprate = 250 }, -- square_of_wool_cloth
        },

        {
            { itemid = xi.item.NONE,            droprate = 600 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 200 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 200 }, -- mannequin_hands
        },
    },

    -- KSNM Early Bird Catches the Wyrm
    [107] =
    {
        {
            { itemid = xi.item.JUG_OF_HONEY_WINE, droprate = 1000 }, -- Jug Of Honey Wine
        },

        {
            { itemid = xi.item.LIBATION_ABJURATION, droprate = 312 }, -- Libation Abjuration
            { itemid = xi.item.GUESPIERE,           droprate = 182 }, -- Guespiere
            { itemid = xi.item.HAVOC_SCYTHE,        droprate =  65 }, -- Havoc Scythe
            { itemid = xi.item.LEOPARD_AXE,         droprate =  43 }, -- Leopard Axe
            { itemid = xi.item.NOKIZARU_SHURIKEN,   droprate = 181 }, -- Nokizaru Shuriken
            { itemid = xi.item.SHINSOKU,            droprate = 217 }, -- Shinsoku
            { itemid = xi.item.SOMNUS_SIGNA,        droprate =  43 }, -- Somnus Signa
        },

        {
            { itemid = xi.item.DIVINE_LOG,              droprate =  94 }, -- Divine Log
            { itemid = xi.item.LACQUER_TREE_LOG,        droprate = 196 }, -- Lacquer Tree Log
            { itemid = xi.item.PETRIFIED_LOG,           droprate = 572 }, -- Petrified Log
            { itemid = xi.item.SQUARE_OF_SHINING_CLOTH, droprate =  43 }, -- Square Of Shining Cloth
        },

        {
            { itemid = xi.item.OBLATION_ABJURATION,  droprate = 159 }, -- Oblation Abjuration
            { itemid = xi.item.BAYARDS_SWORD,        droprate = 151 }, -- Bayards Sword
            { itemid = xi.item.DREIZACK,             droprate = 167 }, -- Dreizack
            { itemid = xi.item.GRIM_STAFF,           droprate =  95 }, -- Grim Staff
            { itemid = xi.item.GROSVENEURS_BOW,      droprate =  95 }, -- Grosveneurs Bow
            { itemid = xi.item.STYLET,               droprate =  56 }, -- Stylet
            { itemid = xi.item.UNSHO,                droprate = 341 }, -- Unsho
        },

        {
            { itemid = xi.item.DRAGON_HEART,         droprate = 522 }, -- Dragon Heart
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 346 }, -- Slice Of Dragon Meat
            { itemid = xi.item.JUGGERNAUT,           droprate =  82 }, -- Juggernaut
            { itemid = xi.item.SPEED_BELT,           droprate =  59 }, -- Speed Belt
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  32 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  71 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  79 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  56 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  71 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  32 }, -- Spool Of Gold Thread
            { itemid = xi.item.HI_RERAISER,              droprate =  48 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,             droprate = 127 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate = 111 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 183 }, -- Petrified Log
            { itemid = xi.item.PHILOSOPHERS_STONE,       droprate =  40 }, -- Philosophers Stone
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  56 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.RAM_HORN,                 droprate =  24 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate = 119 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                 droprate =  56 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  40 }, -- Vile Elixir +1
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  24 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = xi.item.WYRM_BEARD,          droprate = 210 }, -- Wyrm Beard
            { itemid = xi.item.LOCK_OF_SIRENS_HAIR, droprate = 775 }, -- Lock Of Sirens Hair
        },

        {
            { itemid = xi.item.MIND_POTION,         droprate =  94 }, -- Mind Potion
            { itemid = xi.item.INTELLIGENCE_POTION, droprate = 130 }, -- Intelligence Potion
            { itemid = xi.item.CHARISMA_POTION,     droprate = 116 }, -- Charisma Potion
            { itemid = xi.item.ICARUS_WING,         droprate =  51 }, -- Icarus Wing
            { itemid = xi.item.SQUARE_OF_RAXA,      droprate = 246 }, -- Square Of Raxa
            { itemid = xi.item.PRELATIC_POLE,       droprate = 246 }, -- Prelatic Pole
        },

        {
            { itemid = xi.item.HI_ETHER_P3,    droprate = 290 }, -- Hi-ether +3
            { itemid = xi.item.HI_POTION_P3,   droprate = 225 }, -- Hi-potion +3
            { itemid = xi.item.HI_RERAISER,    droprate = 210 }, -- Hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1, droprate = 217 }, -- Vile Elixir +1
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  87 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  80 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  58 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  72 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  87 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  14 }, -- Spool Of Gold Thread
            { itemid = xi.item.HI_RERAISER,              droprate =  22 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  80 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  36 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 145 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,          droprate =   7 }, -- Phoenix Feather
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  51 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  29 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                 droprate =  36 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate =  72 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                 droprate =  29 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,              droprate =  29 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =   7 }, -- Vile Elixir +1
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  22 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  58 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  36 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  72 }, -- Damascus Ingot
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  22 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 275 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 196 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 225 }, -- Square Of Raxa
        },
    },

    -- BCNM Royal Succession
    [108] =
    {
        {
            { itemid = xi.item.BUNCH_OF_WILD_PAMAMAS, droprate = 1000 }, -- bunch_of_wild_pamamas
        },

        {
            { itemid = xi.item.NONE,             droprate = 300 }, -- nothing
            { itemid = xi.item.DUSKY_STAFF,      droprate = 100 }, -- dusky_staff
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 100 }, -- jongleurs_dagger
            { itemid = xi.item.CALVELEYS_DAGGER, droprate = 100 }, -- calveleys_dagger
            { itemid = xi.item.SEALED_MACE,      droprate = 100 }, -- sealed_mace
            { itemid = xi.item.HIMMEL_STOCK,     droprate = 100 }, -- himmel_stock
            { itemid = xi.item.KAGEHIDE,         droprate = 100 }, -- kagehide
            { itemid = xi.item.OHAGURO,          droprate = 100 }, -- ohaguro
        },

        {
            { itemid =     xi.item.NONE, droprate = 100 }, -- nothing
            { itemid = xi.item.GENIN_EARRING, droprate = 300 }, -- genin_earring
            { itemid = xi.item.AGILE_GORGET, droprate = 300 }, -- agile_gorget
            { itemid = xi.item.JAGD_GORGET, droprate = 300 }, -- jagd_gorget
        },

        {
            { itemid =    xi.item.NONE, droprate = 370 }, -- nothing
            { itemid =  xi.item.TURQUOISE, droprate = 100 }, -- turquoise
            { itemid = xi.item.BUNCH_OF_PAMAMAS, droprate = 100 }, -- bunch_of_pamamas
            { itemid =  xi.item.SQUARE_OF_SILK_CLOTH, droprate = 110 }, -- square_of_silk_cloth
            { itemid =  xi.item.ROSEWOOD_LOG, droprate = 140 }, -- rosewood_log
            { itemid =  xi.item.PEARL, droprate = 180 }, -- pearl
        },

        {
            { itemid = xi.item.SCROLL_OF_PHALANX, droprate = 250 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 250 }, -- scroll_of_absorb
            { itemid = xi.item.SCROLL_OF_REFRESH, droprate = 250 }, -- scroll_of_refresh
            { itemid = xi.item.SCROLL_OF_ERASE, droprate = 250 }, -- scroll_of_erase
        },

        {
            { itemid =   xi.item.NONE, droprate = 600 }, -- nothing
            { itemid = xi.item.GOLD_BEASTCOIN, droprate = 400 }, -- gold_beastcoin
        },
    },

    -- BCNM Rapid Raptors
    [109] =
    {
        {
            { itemid = xi.item.RAPTOR_SKIN, droprate = 1000 }, -- raptor_skin
        },

        {
            { itemid = xi.item.ADAMAN_INGOT, droprate = 1000 }, -- adaman_ingot
        },

        {
            { itemid = xi.item.NONE,                    droprate = 190 }, -- nothing
            { itemid = xi.item.SLY_GAUNTLETS,           droprate = 110 }, -- sly_gauntlets
            { itemid = xi.item.SPIKED_FINGER_GAUNTLETS, droprate = 120 }, -- spiked_finger_gauntlets
            { itemid = xi.item.RUSH_GLOVES,             droprate = 140 }, -- rush_gloves
            { itemid = xi.item.RIVAL_RIBBON,            droprate = 140 }, -- rival_ribbon
            { itemid = xi.item.MANA_CIRCLET,            droprate = 150 }, -- mana_circlet
            { itemid = xi.item.IVORY_MITTS,             droprate = 150 }, -- ivory_mitts
        },

        {
            { itemid = xi.item.NONE,             droprate =  30 }, -- nothing
            { itemid = xi.item.STORM_GORGET,     droprate = 100 }, -- storm_gorget
            { itemid = xi.item.INTELLECT_TORQUE, droprate = 100 }, -- intellect_torque
            { itemid = xi.item.BENIGN_NECKLACE,  droprate = 120 }, -- benign_necklace
            { itemid = xi.item.HEAVY_MANTLE,     droprate = 130 }, -- heavy_mantle
            { itemid = xi.item.HATEFUL_COLLAR,   droprate = 170 }, -- hateful_collar
            { itemid = xi.item.ESOTERIC_MANTLE,  droprate = 170 }, -- esoteric_mantle
            { itemid = xi.item.TEMPLARS_MANTLE,  droprate = 180 }, -- templars_mantle
        },

        {
            { itemid = xi.item.NONE,              droprate = 230 }, -- nothing
            { itemid = xi.item.MYTHRIL_INGOT,     droprate = 200 }, -- mythril_ingot
            { itemid = xi.item.CHUNK_OF_IRON_ORE, droprate = 200 }, -- chunk_of_iron_ore
            { itemid = xi.item.PETRIFIED_LOG,     droprate = 370 }, -- petrified_log
        },

        {
            { itemid = xi.item.NONE,     droprate = 560 }, -- nothing
            { itemid = xi.item.RERAISER, droprate = 440 }, -- reraiser
        },
    },

    -- BCNM Wild Wild Whiskers
    [110] =
    {
        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 }, -- high-quality_coeurl_hide
        },

        {
            { itemid = xi.item.CHUNK_OF_ADAMAN_ORE, droprate = 1000 }, -- chunk_of_adaman_ore
        },

        {
            { itemid = xi.item.HERMES_QUENCHER, droprate = 1000 }, -- hermes_quencher
        },

        {
            { itemid = xi.item.ICARUS_WING, droprate = 1000 }, -- icarus_wing
        },

        {
            { itemid = xi.item.GLEEMANS_BELT,  droprate = 365 }, -- gleemans_belt
            { itemid = xi.item.PENITENTS_ROPE, droprate = 635 }, -- penitents_rope
        },

        {
            { itemid = xi.item.TELEPORT_RING_MEA,   droprate = 426 }, -- teleport_ring_mea
            { itemid = xi.item.TELEPORT_RING_YHOAT, droprate = 574 }, -- teleport_ring_yhoat
        },

        {
            { itemid = xi.item.NONE,         droprate = 848 }, -- nothing
            { itemid = xi.item.WALKURE_MASK, droprate =  58 }, -- walkure_mask
            { itemid = xi.item.HI_RERAISER,  droprate =  78 }, -- hi-reraiser
            { itemid = xi.item.EBONY_LOG,    droprate =  16 }, -- ebony_log
        },

        {
            { itemid = xi.item.YELLOW_ROCK,      droprate =  9 }, -- yellow_rock
            { itemid = xi.item.BLACK_ROCK,       droprate =  9 }, -- black_rock
            { itemid = xi.item.AQUAMARINE,       droprate = 16 }, -- aquamarine
            { itemid = xi.item.RED_ROCK,         droprate = 16 }, -- red_rock
            { itemid = xi.item.BLUE_ROCK,        droprate = 16 }, -- blue_rock
            { itemid = xi.item.PURPLE_ROCK,      droprate = 16 }, -- purple_rock
            { itemid = xi.item.MAHOGANY_LOG,     droprate = 33 }, -- mahogany_log
            { itemid = xi.item.CHRYSOBERYL,      droprate = 33 }, -- chrysoberyl
            { itemid = xi.item.ZIRCON,           droprate = 33 }, -- zircon
            { itemid = xi.item.STEEL_INGOT,      droprate = 49 }, -- steel_ingot
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate = 49 }, -- darksteel_ingot
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 49 }, -- translucent_rock
            { itemid = xi.item.SUNSTONE,         droprate = 49 }, -- sunstone
            { itemid = xi.item.MOONSTONE,        droprate = 66 }, -- moonstone
            { itemid = xi.item.MYTHRIL_INGOT,    droprate = 82 }, -- mythril_ingot
            { itemid = xi.item.FLUORITE,         droprate = 82 }, -- fluorite
            { itemid = xi.item.GOLD_INGOT,       droprate = 98 }, -- gold_ingot
            { itemid = xi.item.JADEITE,          droprate = 98 }, -- jadeite
            { itemid = xi.item.PAINITE,          droprate = 98 }, -- painite
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate = 99 }, -- vile_elixir_+1
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
