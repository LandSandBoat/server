-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Cicrcle Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Steamed Sprouts
    [97] =
    {
        {
            { itemid = xi.items.GOLD_BEASTCOIN,    droprate = 500 },
            { itemid = xi.items.MYTHRIL_BEASTCOIN, droprate = 500 },
        },

        {
            { itemid = 0, droprate =  750 }, -- nothing
            { itemid = xi.items.VILE_ELIXIR, droprate =  250 },
        },

        {
            { itemid =     0, droprate =  600 }, -- nothing
            { itemid = xi.items.SURVIVAL_BELT,     droprate = 100 },
            { itemid = xi.items.GUARDING_GORGET,   droprate = 100 },
            { itemid = xi.items.ENHANCING_EARRING, droprate = 100 },
            { itemid = xi.items.BALANCE_BUCKLER,   droprate = 100 },
        },

        {
            { itemid = xi.items.WHITE_ROCK,       droprate = 125 },
            { itemid = xi.items.TRANSLUCENT_ROCK, droprate = 125 },
            { itemid = xi.items.PURPLE_ROCK,      droprate = 125 },
            { itemid = xi.items.RED_ROCK,         droprate = 125 },
            { itemid = xi.items.BLUE_ROCK,        droprate = 125 },
            { itemid = xi.items.YELLOW_ROCK,      droprate = 125 },
            { itemid = xi.items.GREEN_ROCK,       droprate = 125 },
            { itemid = xi.items.BLACK_ROCK,       droprate = 125 },
        },

        {
            { itemid = xi.items.GARNET,       droprate =  50 },
            { itemid = xi.items.BLACK_PEARL,  droprate =  50 },
            { itemid = xi.items.AMETRINE,     droprate =  50 },
            { itemid = xi.items.PAINITE,      droprate =  50 },
            { itemid = xi.items.PEARL,        droprate =  50 },
            { itemid = xi.items.OAK_LOG,      droprate = 100 },
            { itemid = xi.items.GOSHENITE,    droprate = 100 },
            { itemid = xi.items.SPHENE,       droprate = 100 },
            { itemid = xi.items.ROSEWOOD_LOG, droprate = 100 },
            { itemid = xi.items.TURQUOISE,    droprate = 100 },
            { itemid = xi.items.SAPPHIRE,     droprate = 100 },
            { itemid = xi.items.PERIDOT,      droprate = 150 },
        },

        {
            { itemid =     0, droprate =  125 }, -- nothing
            { itemid = xi.items.SCROLL_OF_REFRESH,     droprate = 125 },
            { itemid = xi.items.SCROLL_OF_ERASE,       droprate = 125 },
            { itemid = xi.items.SCROLL_OF_ABSORB_INT,  droprate = 125 },
            { itemid = xi.items.SCROLL_OF_PHALANX,     droprate = 125 },
            { itemid = xi.items.SCROLL_OF_ICE_SPIKES,  droprate = 125 },
            { itemid = xi.items.SCROLL_OF_UTSUSEMI_NI, droprate = 125 },
            { itemid = xi.items.FIRE_SPIRIT_PACT,      droprate = 125 },
        },
    },

    -- BCNM Divine Punishers
    [98] =
    {
        {
            { itemid = xi.items.FORSETIS_AXE,   droprate = 250 },
            { itemid = xi.items.ARAMISS_RAPIER, droprate = 250 },
            { itemid = xi.items.SPARTAN_CESTI,  droprate = 250 },
            { itemid = xi.items.DOMINION_MACE,  droprate = 250 },
        },

        {
            { itemid = 0, droprate = 250 }, -- nothing
            { itemid = xi.items.FUMA_KYAHAN,      droprate = 100 },
            { itemid = xi.items.PEACE_RING,       droprate = 200 },
            { itemid = xi.items.ENHANCING_MANTLE, droprate = 200 },
            { itemid = xi.items.MASTER_BELT,      droprate = 150 },
            { itemid = xi.items.OCHIUDOS_KOTE,    droprate = 100 },
        },

        {
            { itemid = 0, droprate = 850 }, -- nothing
            { itemid = xi.items.HI_RERAISER,    droprate = 100 },
            { itemid = xi.items.VILE_ELIXIR_P1, droprate =  50 },
        },

        {
            { itemid = xi.items.PURPLE_ROCK,      droprate = 166 },
            { itemid = xi.items.TRANSLUCENT_ROCK, droprate = 166 },
            { itemid = xi.items.RED_ROCK,         droprate = 167 },
            { itemid = xi.items.BLACK_ROCK,       droprate = 167 },
            { itemid = xi.items.YELLOW_ROCK,      droprate = 167 },
            { itemid = xi.items.WHITE_ROCK,       droprate = 167 },
        },

        {
            { itemid = xi.items.PAINITE,     droprate = 125 },
            { itemid = xi.items.AQUAMARINE,  droprate = 125 },
            { itemid = xi.items.FLUORITE,    droprate = 125 },
            { itemid = xi.items.ZIRCON,      droprate = 125 },
            { itemid = xi.items.SUNSTONE,    droprate = 125 },
            { itemid = xi.items.CHRYSOBERYL, droprate = 125 },
            { itemid = xi.items.MOONSTONE,   droprate = 125 },
            { itemid = xi.items.JADEITE,     droprate = 125 },
        },

        {
            { itemid = 0, droprate = 517 }, -- nothing
            { itemid = xi.items.MAHOGANY_LOG, droprate = 333 },
            { itemid = xi.items.EBONY_LOG,    droprate = 150 },
        },

        {
            { itemid = xi.items.STEEL_INGOT,     droprate = 350 },
            { itemid = xi.items.MYTHRIL_INGOT,   droprate = 150 },
            { itemid = xi.items.DARKSTEEL_INGOT, droprate = 150 },
            { itemid = xi.items.GOLD_INGOT,      droprate = 350 },
        },
    },

    -- BCNM Treasure and Tribulations
    [100] =
    {
        {
            { itemid = xi.items.GUARDIANS_RING, droprate =  75 },
            { itemid = xi.items.KAMPFER_RING,   droprate =  32 },
            { itemid = xi.items.CONJURERS_RING, droprate =  54 },
            { itemid = xi.items.SHINOBI_RING,   droprate =  32 },
            { itemid = xi.items.SLAYERS_RING,   droprate =  97 },
            { itemid = xi.items.SORCERERS_RING, droprate =  75 },
            { itemid = xi.items.SOLDIERS_RING,  droprate = 108 },
            { itemid = xi.items.TAMERS_RING,    droprate =  22 },
            { itemid = xi.items.TRACKERS_RING,  droprate =  65 },
            { itemid = xi.items.DRAKE_RING,     droprate =  32 },
            { itemid = xi.items.FENCERS_RING,   droprate =  32 },
            { itemid = xi.items.MINSTRELS_RING, droprate =  86 },
            { itemid = xi.items.MEDICINE_RING,  droprate =  86 },
            { itemid = xi.items.ROGUES_RING,    droprate =  75 },
            { itemid = xi.items.RONIN_RING,     droprate =  11 },
            { itemid = xi.items.PLATINUM_RING,   droprate = 32 },
        },

        {
            { itemid = xi.items.ASTRAL_RING,              droprate = 376 },
            { itemid = xi.items.PLATINUM_RING,            droprate =  22 },
            { itemid = xi.items.SCROLL_OF_QUAKE,          droprate =  65 },
            { itemid = xi.items.RAM_SKIN,                 droprate =  10 },
            { itemid = xi.items.RERAISER,                 droprate =  11 },
            { itemid = xi.items.MYTHRIL_INGOT,            droprate =  22 },
            { itemid = xi.items.LIGHT_SPIRIT_PACT,        droprate =  10 },
            { itemid = xi.items.SCROLL_OF_FREEZE,         droprate =  32 },
            { itemid = xi.items.SCROLL_OF_REGEN_II,       droprate =  43 },
            { itemid = xi.items.SCROLL_OF_RAISE_II,       droprate =  32 },
            { itemid = xi.items.PETRIFIED_LOG,            droprate =  11 },
            { itemid = xi.items.CORAL_FRAGMENT,           droprate =  11 },
            { itemid = xi.items.MAHOGANY_LOG,             droprate =  11 },
            { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate =  43 },
            { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate = 108 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate =  32 },
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate =  65 },
            { itemid = xi.items.GOLD_INGOT,               droprate =  10 },
            { itemid = xi.items.DARKSTEEL_INGOT,          droprate =  11 },
            { itemid = xi.items.PLATINUM_INGOT,           droprate =  11 },
            { itemid = xi.items.EBONY_LOG,                droprate =  11 },
            { itemid = xi.items.RAM_HORN,                 droprate =  11 },
            { itemid = xi.items.DEMON_HORN,               droprate =  11 },
            { itemid = xi.items.MANTICORE_HIDE,           droprate =   9 },
            { itemid = xi.items.WYVERN_SKIN,              droprate =  11 },
            { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =  11 },
        },
    },

    -- BCNM Creeping Doom
    [104] =
    {
        {
            { itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate = 1000 },
        },

        {
            { itemid = 65535, droprate = 1000, amount = 3000 }, -- gil
        },

        {
            { itemid = 0, droprate =  700 }, -- nothing
            { itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate =  300 },
        },

        {
            { itemid = 0, droprate =  900 }, -- nothing
            { itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate =  100 },
        },

        {
            { itemid = 0, droprate = 300 }, -- nothing
            { itemid = xi.items.SINGERS_EARRING,    droprate = 40 },
            { itemid = xi.items.ASHIGARU_EARRING,   droprate = 50 },
            { itemid = xi.items.MAGICIANS_EARRING,  droprate = 50 },
            { itemid = xi.items.WARLOCKS_EARRING,   droprate = 50 },
            { itemid = xi.items.HEALERS_EARRING,    droprate = 40 },
            { itemid = xi.items.ESQUIRES_EARRING,   droprate = 45 },
            { itemid = xi.items.WIZARDS_EARRING,    droprate = 50 },
            { itemid = xi.items.WYVERN_EARRING,     droprate = 40 },
            { itemid = xi.items.MERCENARYS_EARRING, droprate = 50 },
            { itemid = xi.items.KILLER_EARRING,     droprate = 45 },
            { itemid = xi.items.WRESTLERS_EARRING,  droprate = 45 },
            { itemid = xi.items.GENIN_EARRING,      droprate = 50 },
            { itemid = xi.items.BEATERS_EARRING,    droprate = 50 },
            { itemid = xi.items.PILFERERS_EARRING,  droprate = 45 },
            { itemid = xi.items.TRIMMERS_EARRING,   droprate = 50 },
        },

        {
            { itemid =     0, droprate =  700 }, -- nothing
            { itemid = xi.items.SINGERS_EARRING,    droprate = 20 },
            { itemid = xi.items.ASHIGARU_EARRING,   droprate = 20 },
            { itemid = xi.items.MAGICIANS_EARRING,  droprate = 20 },
            { itemid = xi.items.WARLOCKS_EARRING,   droprate = 20 },
            { itemid = xi.items.HEALERS_EARRING,    droprate = 20 },
            { itemid = xi.items.ESQUIRES_EARRING,   droprate = 20 },
            { itemid = xi.items.WIZARDS_EARRING,    droprate = 20 },
            { itemid = xi.items.WYVERN_EARRING,     droprate = 20 },
            { itemid = xi.items.MERCENARYS_EARRING, droprate = 20 },
            { itemid = xi.items.KILLER_EARRING,     droprate = 20 },
            { itemid = xi.items.WRESTLERS_EARRING,  droprate = 20 },
            { itemid = xi.items.GENIN_EARRING,      droprate = 20 },
            { itemid = xi.items.BEATERS_EARRING,    droprate = 20 },
            { itemid = xi.items.PILFERERS_EARRING,  droprate = 20 },
            { itemid = xi.items.TRIMMERS_EARRING,   droprate = 20 },
        },

        {
            { itemid = 0, droprate = 500 }, -- nothing
            { itemid = xi.items.SHEET_OF_BAST_PARCHMENT, droprate =  400 },
            { itemid = xi.items.HI_POTION,               droprate =  100 },
        },

        {
            { itemid = 0, droprate = 500 }, -- nothing
            { itemid = xi.items.CHESTNUT_LOG, droprate =  250 },
            { itemid = xi.items.HI_ETHER,     droprate =  250 },
        },

        {
            { itemid = 0, droprate = 250 }, -- nothing
            { itemid = xi.items.SCROLL_OF_ERASE,        droprate =  150 },
            { itemid = xi.items.SCROLL_OF_DISPEL,       droprate =  200 },
            { itemid = xi.items.SCROLL_OF_MAGIC_FINALE, droprate =  250 },
            { itemid = xi.items.SCROLL_OF_UTSUSEMI_NI,  droprate =  150 },
        },

        {
            { itemid = 0, droprate = 300 }, -- nothing
            { itemid = xi.items.AMBER_STONE,            droprate =   50 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE, droprate =   50 },
            { itemid = xi.items.ELM_LOG,                droprate =   50 },
            { itemid = xi.items.IRON_INGOT,             droprate =   50 },
            { itemid = xi.items.CHUNK_OF_IRON_ORE,      droprate =   50 },
            { itemid = xi.items.LAPIS_LAZULI,           droprate =   50 },
            { itemid = xi.items.MYTHRIL_INGOT,          droprate =   50 },
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,   droprate =   50 },
            { itemid = xi.items.ONYX,                   droprate =   50 },
            { itemid = xi.items.SARDONYX,               droprate =   50 },
            { itemid = xi.items.SILVER_INGOT,           droprate =   50 },
            { itemid = xi.items.CHUNK_OF_SILVER_ORE,    droprate =   50 },
            { itemid = xi.items.STEEL_INGOT,            droprate =   50 },
            { itemid = xi.items.TOURMALINE,             droprate =   50 },
            { itemid = xi.items.LIGHT_OPAL,             droprate =   50 },
        },

        {
            { itemid = 0, droprate =  300 }, -- nothing
            { itemid = xi.items.AMBER_STONE,            droprate = 50 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE, droprate = 50 },
            { itemid = xi.items.ELM_LOG,                droprate = 50 },
            { itemid = xi.items.IRON_INGOT,             droprate = 50 },
            { itemid = xi.items.CHUNK_OF_IRON_ORE,      droprate = 50 },
            { itemid = xi.items.LAPIS_LAZULI,           droprate = 50 },
            { itemid = xi.items.MYTHRIL_INGOT,          droprate = 50 },
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,   droprate = 50 },
            { itemid = xi.items.ONYX,                   droprate = 50 },
            { itemid = xi.items.SARDONYX,               droprate = 50 },
            { itemid = xi.items.SILVER_INGOT,           droprate = 50 },
            { itemid = xi.items.CHUNK_OF_SILVER_ORE,    droprate = 50 },
            { itemid = xi.items.STEEL_INGOT,            droprate = 50 },
            { itemid = xi.items.TOURMALINE,             droprate = 50 },
            { itemid = xi.items.LIGHT_OPAL,             droprate = 50 },
        },
    },

    -- BCNM Charming Trio
    [105] =
    {
        {
            { itemid = xi.items.MANNEQUIN_HANDS, droprate = 1000 },
        },

        {
            { itemid = xi.items.JAR_OF_TOAD_OIL,        droprate = 250 },
            { itemid = xi.items.POTION,                 droprate = 300 },
            { itemid = xi.items.POTION_P1,              droprate = 180 },
            { itemid = xi.items.AIR_SPIRIT_PACT,        droprate = 130 },
            { itemid = xi.items.SQUARE_OF_COTTON_CLOTH, droprate = 280 },
        },

        {
            { itemid = xi.items.MYTHRIL_BEASTCOIN,     droprate = 250 },
            { itemid = xi.items.GANKO,                 droprate = 190 },
            { itemid = xi.items.SQUARE_OF_WOOL_CLOTH,  droprate = 270 },
            { itemid = xi.items.PLATOON_DISC,          droprate = 145 },
            { itemid = xi.items.SQUARE_OF_GRASS_CLOTH, droprate = 295 },
            { itemid = xi.items.SQUARE_OF_LINEN_CLOTH, droprate = 260 },
        },

        {
            { itemid = 0, droprate = 800 },    -- Nothing
            { itemid = xi.items.PLATOON_CUTTER, droprate = 167 },
        },

        {
            { itemid = 0, droprate = 500 },    -- Nothing
            { itemid = xi.items.VIAL_OF_FIEND_BLOOD, droprate = 500 },
        },

        {
            { itemid = 0, droprate = 500 },    -- Nothing
            { itemid = xi.items.VIAL_OF_FIEND_BLOOD, droprate = 500 },
        },

        {
            { itemid = xi.items.PLATOON_EDGE,           droprate = 235 },
            { itemid = xi.items.PLATOON_GUN,            droprate = 235 },
            { itemid = xi.items.PLATOON_SPATHA,         droprate = 235 },
            { itemid = xi.items.PLATOON_POLE,           droprate = 235 },
            { itemid = xi.items.GUNROMARU,              droprate = 255 },
            { itemid = xi.items.MANNEQUIN_HEAD,         droprate = 260 },
            { itemid = xi.items.SCROLL_OF_DRAIN,        droprate = 250 },
            { itemid = xi.items.VIAL_OF_BEASTMAN_BLOOD, droprate = 190 },
        },
    },

    -- BCNM Harem Scarem
    [106] =
    {
        {
            { itemid = xi.items.DHALMEL_HIDE, droprate = 1000 },
        },

        {
            { itemid = 0, droprate = 500 }, -- nothing
            { itemid = xi.items.GIANT_FEMUR, droprate = 500 },
        },

        {
            { itemid = 0, droprate = 500 }, -- nothing
            { itemid = xi.items.SLICE_OF_DHALMEL_MEAT, droprate = 500 },
        },

        {
            { itemid = 0, droprate = 400 }, -- nothing
            { itemid = xi.items.MERCENARY_MANTLE, droprate = 150 },
            { itemid = xi.items.BEATERS_MANTLE,   droprate = 150 },
            { itemid = xi.items.ESQUIRES_MANTLE,  droprate = 150 },
            { itemid = xi.items.HEALERS_MANTLE,   droprate = 150 },
        },

        {
            { itemid = 0, droprate = 400 }, -- nothing
            { itemid = xi.items.WIZARDS_SHIELD, droprate = 200 },
            { itemid = xi.items.TRIMMERS_ASPIS, droprate = 200 },
            { itemid = xi.items.WYVERNS_TARGE,  droprate = 200 },
        },

        {
            { itemid = 0, droprate = 200 }, -- nothing
            { itemid = xi.items.SCROLL_OF_ERASE,        droprate = 200 },
            { itemid = xi.items.SCROLL_OF_DISPEL,       droprate = 200 },
            { itemid = xi.items.SCROLL_OF_MAGIC_FINALE, droprate = 200 },
            { itemid = xi.items.SCROLL_OF_UTSUSEMI_NI,  droprate = 200 },
        },

        {
            { itemid = 0, droprate = 250 }, -- nothing
            { itemid = xi.items.SQUARE_OF_VELVET_CLOTH, droprate = 250 },
            { itemid = xi.items.SQUARE_OF_LINEN_CLOTH,  droprate = 250 },
            { itemid = xi.items.SQUARE_OF_WOOL_CLOTH,   droprate = 250 },
        },

        {
            { itemid = 0, droprate = 600 }, -- nothing
            { itemid = xi.items.MANNEQUIN_HEAD,  droprate = 200 },
            { itemid = xi.items.MANNEQUIN_HANDS, droprate = 200 },
        },
    },

    -- KSNM Early Bird Catches the Wyrm
    [107] =
    {
        {
            { itemid = xi.items.LIBATION_ABJURATION, droprate = 312 },
            { itemid = xi.items.GUESPIERE,           droprate = 182 },
            { itemid = xi.items.HAVOC_SCYTHE,        droprate =  65 },
            { itemid = xi.items.LEOPARD_AXE,         droprate =  43 },
            { itemid = xi.items.NOKIZARU_SHURIKEN,   droprate = 181 },
            { itemid = xi.items.SHINSOKU,            droprate = 217 },
            { itemid = xi.items.SOMNUS_SIGNA,        droprate =  43 },
        },

        {
            { itemid = xi.items.DIVINE_LOG,              droprate =  94 },
            { itemid = xi.items.LACQUER_TREE_LOG,        droprate = 196 },
            { itemid = xi.items.PETRIFIED_LOG,           droprate = 572 },
            { itemid = xi.items.SQUARE_OF_SHINING_CLOTH, droprate =  43 },
        },

        {
            { itemid = xi.items.OBLATION_ABJURATION, droprate = 159 },
            { itemid = xi.items.BAYARDS_SWORD,       droprate = 151 },
            { itemid = xi.items.DREIZACK,            droprate = 167 },
            { itemid = xi.items.GRIM_STAFF,          droprate =  95 },
            { itemid = xi.items.GROSVENEURS_BOW,     droprate =  95 },
            { itemid = xi.items.STYLET,              droprate =  56 },
            { itemid = xi.items.UNSHO,               droprate = 341 },
        },

        {
            { itemid = xi.items.DRAGON_HEART,         droprate = 522 },
            { itemid = xi.items.SLICE_OF_DRAGON_MEAT, droprate = 346 },
            { itemid = xi.items.JUGGERNAUT,           droprate =  82 },
            { itemid = xi.items.SPEED_BELT,           droprate =  59 },
        },

        {
            { itemid = xi.items.CORAL_FRAGMENT,           droprate =  32 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate =  71 },
            { itemid = xi.items.DEMON_HORN,               droprate =  79 },
            { itemid = xi.items.EBONY_LOG,                droprate =  56 },
            { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate =  71 },
            { itemid = xi.items.SPOOL_OF_GOLD_THREAD,     droprate =  32 },
            { itemid = xi.items.HI_RERAISER,              droprate =  48 },
            { itemid = xi.items.MAHOGANY_LOG,             droprate = 127 },
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate = 111 },
            { itemid = xi.items.PETRIFIED_LOG,            droprate = 183 },
            { itemid = xi.items.PHILOSOPHERS_STONE,       droprate =  40 },
            { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate =  56 },
            { itemid = xi.items.RAM_HORN,                 droprate =  24 },
            { itemid = xi.items.SQUARE_OF_RAXA,           droprate = 119 },
            { itemid = xi.items.RERAISER,                 droprate =  56 },
            { itemid = xi.items.VILE_ELIXIR_P1,           droprate =  40 },
            { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =  24 },
        },

        {
            { itemid = xi.items.WYRM_BEARD,          droprate = 210 },
            { itemid = xi.items.LOCK_OF_SIRENS_HAIR, droprate = 775 },
        },

        {
            { itemid = xi.items.MIND_POTION,         droprate =  94 },
            { itemid = xi.items.INTELLIGENCE_POTION, droprate = 130 },
            { itemid = xi.items.CHARISMA_POTION,     droprate = 116 },
            { itemid = xi.items.ICARUS_WING,         droprate =  51 },
            { itemid = xi.items.SQUARE_OF_RAXA,      droprate = 246 },
            { itemid = xi.items.PRELATIC_POLE,       droprate = 246 },
        },

        {
            { itemid = xi.items.HI_ETHER_III,   droprate = 290 },
            { itemid = xi.items.HI_POTION_P3,   droprate = 225 },
            { itemid = xi.items.HI_RERAISER,    droprate = 210 },
            { itemid = xi.items.VILE_ELIXIR_P1, droprate = 217 },
        },

        {
            { itemid = xi.items.CORAL_FRAGMENT,           droprate =  87 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate =  80 },
            { itemid = xi.items.DEMON_HORN,               droprate =  58 },
            { itemid = xi.items.EBONY_LOG,                droprate =  72 },
            { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate =  87 },
            { itemid = xi.items.SPOOL_OF_GOLD_THREAD,     droprate =  14 },
            { itemid = xi.items.HI_RERAISER,              droprate =  22 },
            { itemid = xi.items.MAHOGANY_LOG,             droprate =  80 },
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate =  36 },
            { itemid = xi.items.PETRIFIED_LOG,            droprate = 145 },
            { itemid = xi.items.PHOENIX_FEATHER,          droprate =   7 },
            { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate =  51 },
            { itemid = xi.items.SQUARE_OF_RAINBOW_CLOTH,  droprate =  29 },
            { itemid = xi.items.RAM_HORN,                 droprate =  36 },
            { itemid = xi.items.SQUARE_OF_RAXA,           droprate =  72 },
            { itemid = xi.items.RERAISER,                 droprate =  29 },
            { itemid = xi.items.VILE_ELIXIR,              droprate =  29 },
            { itemid = xi.items.VILE_ELIXIR_P1,           droprate =   7 },
            { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =  22 },
        },

        {
            { itemid = xi.items.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  58 },
            { itemid = xi.items.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  36 },
            { itemid = xi.items.DAMASCUS_INGOT,             droprate =  72 },
            { itemid = xi.items.SPOOL_OF_MALBORO_FIBER,     droprate =  22 },
            { itemid = xi.items.PHILOSOPHERS_STONE,         droprate = 275 },
            { itemid = xi.items.PHOENIX_FEATHER,            droprate = 196 },
            { itemid = xi.items.SQUARE_OF_RAXA,             droprate = 225 },
        },
    },

    -- BCNM Royal Succession
    [108] =
    {
        {
            { itemid = xi.items.BUNCH_OF_WILD_PAMAMAS, droprate = 1000 },
        },

        {
            { itemid = 0, droprate =  300 }, -- nothing
            { itemid = xi.items.DUSKY_STAFF,      droprate =  100 },
            { itemid = xi.items.JONGLEURS_DAGGER, droprate =  100 },
            { itemid = xi.items.CALVELEYS_DAGGER, droprate =  100 },
            { itemid = xi.items.SEALED_MACE,      droprate =  100 },
            { itemid = xi.items.HIMMEL_STOCK,     droprate =  100 },
            { itemid = xi.items.KAGEHIDE,         droprate =  100 },
            { itemid = xi.items.OHAGURO,          droprate =  100 },
        },

        {
            { itemid = 0, droprate =  100 }, -- nothing
            { itemid = xi.items.GENIN_EARRING, droprate =  300 },
            { itemid = xi.items.AGILE_GORGET,  droprate =  300 },
            { itemid = xi.items.JAGD_GORGET,   droprate =  300 },
        },

        {
            { itemid = 0, droprate =  370 }, -- nothing
            { itemid = xi.items.TURQUOISE,            droprate =  100 },
            { itemid = xi.items.BUNCH_OF_PAMAMAS,     droprate =  100 },
            { itemid = xi.items.SQUARE_OF_SILK_CLOTH, droprate =  110 },
            { itemid = xi.items.ROSEWOOD_LOG,         droprate =  140 },
            { itemid = xi.items.PEARL,                droprate =  180 },
        },

        {
            { itemid = xi.items.SCROLL_OF_PHALANX,    droprate =  250 },
            { itemid = xi.items.SCROLL_OF_ABSORB_INT, droprate =  250 },
            { itemid = xi.items.SCROLL_OF_REFRESH,    droprate =  250 },
            { itemid = xi.items.SCROLL_OF_ERASE,      droprate =  250 },
        },

        {
            { itemid = 0, droprate =  600 }, -- nothing
            { itemid = xi.items.GOLD_BEASTCOIN, droprate =  400 },
        },
    },

    -- BCNM Rapid Raptors
    [109] =
    {
        {
            { itemid = xi.items.RAPTOR_SKIN, droprate = 1000 },
        },

        {
            { itemid = xi.items.ADAMAN_INGOT, droprate = 1000 },
        },

        {
            { itemid = 0, droprate =  190 }, -- nothing
            { itemid = xi.items.SLY_GAUNTLETS,           droprate =  10 },
            { itemid = xi.items.SPIKED_FINGER_GAUNTLETS, droprate = 120 },
            { itemid = xi.items.RUSH_GLOVES,             droprate = 140 },
            { itemid = xi.items.RIVAL_RIBBON,            droprate = 140 },
            { itemid = xi.items.MANA_CIRCLET,            droprate = 150 },
            { itemid = xi.items.IVORY_MITTS,             droprate = 150 },
        },

        {
            { itemid = 0, droprate =   30 }, -- nothing
            { itemid = xi.items.STORM_GORGET,     droprate = 100 },
            { itemid = xi.items.INTELLECT_TORQUE, droprate = 100 },
            { itemid = xi.items.BENIGN_NECKLACE,  droprate = 120 },
            { itemid = xi.items.HEAVY_MANTLE,     droprate = 130 },
            { itemid = xi.items.HATEFUL_COLLAR,   droprate = 170 },
            { itemid = xi.items.ESOTERIC_MANTLE,  droprate = 170 },
            { itemid = xi.items.TEMPLARS_MANTLE,  droprate = 180 },
        },

        {
            { itemid = 0, droprate =  230 }, -- nothing
            { itemid = xi.items.MYTHRIL_INGOT,     droprate =  200 },
            { itemid = xi.items.CHUNK_OF_IRON_ORE, droprate =  200 },
            { itemid = xi.items.PETRIFIED_LOG,     droprate =  370 },
        },

        {
            { itemid = 0, droprate =  560 }, -- nothing
            { itemid = xi.items.RERAISER, droprate =  440 },
        },
    },

    -- BCNM Wild Wild Whiskers
    [110] =
    {
        {
            { itemid = xi.items.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 },
        },

        {
            { itemid = xi.items.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 },
        },

        {
            { itemid = xi.items.HIGH_QUALITY_COEURL_HIDE, droprate = 1000 },
        },

        {
            { itemid = xi.items.CHUNK_OF_ADAMAN_ORE, droprate = 1000 },
        },

        {
            { itemid = xi.items.HERMES_QUENCHER, droprate = 1000 },
        },

        {
            { itemid = xi.items.ICARUS_WING, droprate = 1000 },
        },

        {
            { itemid = xi.items.GLEEMANS_BELT,  droprate = 365 },
            { itemid = xi.items.PENITENTS_ROPE, droprate = 635 },
        },

        {
            { itemid = xi.items.TELEPORT_RING_MEA,   droprate = 426 },
            { itemid = xi.items.TELEPORT_RING_YHOAT, droprate = 574 },
        },

        {
            { itemid = 0, droprate =  848 }, -- nothing
            { itemid = xi.items.WALKURE_MASK, droprate = 58 },
            { itemid = xi.items.HI_RERAISER,  droprate = 78 },
            { itemid = xi.items.EBONY_LOG,    droprate = 16 },
        },

        {
            { itemid = xi.items.YELLOW_ROCK,      droprate =  9 },
            { itemid = xi.items.BLACK_ROCK,       droprate =  9 },
            { itemid = xi.items.AQUAMARINE,       droprate = 16 },
            { itemid = xi.items.RED_ROCK,         droprate = 16 },
            { itemid = xi.items.BLUE_ROCK,        droprate = 16 },
            { itemid = xi.items.PURPLE_ROCK,      droprate = 16 },
            { itemid = xi.items.MAHOGANY_LOG,     droprate = 33 },
            { itemid = xi.items.CHRYSOBERYL,      droprate = 33 },
            { itemid = xi.items.ZIRCON,           droprate = 33 },
            { itemid = xi.items.STEEL_INGOT,      droprate = 49 },
            { itemid = xi.items.DARKSTEEL_INGOT,  droprate = 49 },
            { itemid = xi.items.TRANSLUCENT_ROCK, droprate = 49 },
            { itemid = xi.items.SUNSTONE,         droprate = 49 },
            { itemid = xi.items.MOONSTONE,        droprate = 66 },
            { itemid = xi.items.MYTHRIL_INGOT,    droprate = 82 },
            { itemid = xi.items.FLUORITE,         droprate = 82 },
            { itemid = xi.items.GOLD_INGOT,       droprate = 98 },
            { itemid = xi.items.JADEITE,          droprate = 98 },
            { itemid = xi.items.PAINITE,          droprate = 98 },
            { itemid = xi.items.VILE_ELIXIR_P1,   droprate = 99 },
        },
    },

    -- Seaons Greetings
    [111] =
    {
        {
            { itemid = xi.items.THURSUSSTAB, droprate = 200 },
            { itemid = xi.items.RAMPAGER,    droprate = 200 },
            { itemid = xi.items.MORGENSTERN, droprate = 200 },
            { itemid = xi.items.SUBDUER,     droprate = 200 },
            { itemid = xi.items.EXPUNGER,    droprate = 200 },
        },
        {
            { itemid = xi.items.DURANDAL,        droprate = 250 },
            { itemid = xi.items.HOPLITES_HARP,   droprate = 250 },
            { itemid = xi.items.SORROWFUL_HARP,  droprate = 250 },
            { itemid = xi.items.ATTILAS_EARRING, droprate = 250 },
        },
        {
            { itemid = xi.items.ADAMAN_INGOT,     droprate = 333 },
            { itemid = xi.items.ORICHALCUM_INGOT, droprate = 333 },
            { itemid = xi.items.ROOT_SABOTS,      droprate = 333 },
        },
        {
            { itemid = xi.items.DIVINE_LOG,       droprate = 650 },
            { itemid = xi.items.LACQUER_TREE_LOG, droprate =  50 },
            { itemid = xi.items.SWORD_STRAP,      droprate = 100 },
            { itemid = xi.items.POLE_GRIP,        droprate = 100 },
            { itemid = xi.items.SPEAR_STRAP,      droprate = 100 },
        },
        {
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate = 66 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate = 66 },
            { itemid = xi.items.MAHOGANY_LOG,             droprate = 66 },
            { itemid = xi.items.EBONY_LOG,                droprate = 66 },
            { itemid = xi.items.PETRIFIED_LOG,            droprate = 76 },
            { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate = 66 },
            { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate = 66 },
            { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate = 66 },
            { itemid = xi.items.SQUARE_OF_RAINBOW_CLOTH,  droprate = 66 },
            { itemid = xi.items.CORAL_FRAGMENT,           droprate = 66 },
            { itemid = xi.items.RAM_HORN,                 droprate = 66 },
            { itemid = xi.items.DEMON_HORN,               droprate = 66 },
            { itemid = xi.items.SQUARE_OF_RAXA,           droprate = 66 },
            { itemid = xi.items.VILE_ELIXIR,              droprate = 66 },
            { itemid = xi.items.VILE_ELIXIR_P1,           droprate = 66 },
        },
        {
            { itemid = xi.items.DAMASCUS_INGOT,             droprate =  50 },
            { itemid = xi.items.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  50 },
            { itemid = xi.items.PHOENIX_FEATHER,            droprate = 300 },
            { itemid = xi.items.PHILOSOPHERS_STONE,         droprate = 100 },
            { itemid = xi.items.VIAL_OF_BLACK_BEETLE_BLOOD, droprate = 150 },
            { itemid = xi.items.SQUARE_OF_RAXA,             droprate = 350 },
        },
    },

    -- Royale Ramble
    [112] =
    {
        {
            { itemid = xi.items.ORICHALCUM_INGOT, droprate = 1000 },
        },
        {
            { itemid = xi.items.COFFINMAKER,     droprate = 200 },
            { itemid = xi.items.DESTROYERS,      droprate = 300 },
            { itemid = xi.items.DISSECTOR,       droprate = 250 },
            { itemid = xi.items.GONDO_SHIZUNORI, droprate = 250 },
        },
        {
            { itemid = xi.items.HIERARCH_BELT,    droprate = 200 },
            { itemid = xi.items.PALMERINS_SHIELD, droprate = 250 },
            { itemid = xi.items.TRAINERS_GLOVES,  droprate = 250 },
            { itemid = xi.items.WARWOLF_BELT,     droprate = 300 },
        },
        {
            { itemid = 0, droprate = 300 }, -- Nothing
            { itemid = xi.items.CLAYMORE_GRIP, droprate =  70 },
            { itemid = xi.items.POLE_GRIP,     droprate = 100 },
            { itemid = xi.items.SWORD_STRAP,   droprate = 280 },
            { itemid = xi.items.TRUMP_CROWN,   droprate = 520 },
        },
        {
            { itemid = xi.items.KING_OF_CUPS_CARD,   droprate = 250 },
            { itemid = xi.items.KING_OF_BATONS_CARD, droprate = 350 },
            { itemid = xi.items.KING_OF_SWORDS_CARD, droprate = 250 },
            { itemid = xi.items.KING_OF_COINS_CARD,  droprate = 250 },
        },
        {
            { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate =  50 },
            { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate =  50 },
            { itemid = xi.items.MAHOGANY_LOG,             droprate =  80 },
            { itemid = xi.items.EBONY_LOG,                droprate =  80 },
            { itemid = xi.items.PETRIFIED_LOG,            droprate = 130 },
            { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate =  60 },
            { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate =  60 },
            { itemid = xi.items.SPOOL_OF_GOLD_THREAD,     droprate =  60 },
            { itemid = xi.items.SQUARE_OF_RAINBOW_CLOTH,  droprate =  30 },
            { itemid = xi.items.SPOOL_OF_MALBORO_FIBER,   droprate =  20 },
            { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =  30 },
            { itemid = xi.items.CORAL_FRAGMENT,           droprate =  60 },
            { itemid = xi.items.RAM_HORN,                 droprate =  60 },
            { itemid = xi.items.DEMON_HORN,               droprate =  60 },
            { itemid = xi.items.PHILOSOPHERS_STONE,       droprate =  30 },
            { itemid = xi.items.SLAB_OF_GRANITE,          droprate =  20 },
            { itemid = xi.items.RERAISER,                 droprate =  40 },
            { itemid = xi.items.HI_RERAISER,              droprate =  30 },
            { itemid = xi.items.VILE_ELIXIR,              droprate =  40 },
            { itemid = xi.items.VILE_ELIXIR_P1,           droprate =  10 },
        },
        {
            { itemid = xi.items.DAMASCUS_INGOT,             droprate =  90 },
            { itemid = xi.items.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  40 },
            { itemid = xi.items.SPOOL_OF_MALBORO_FIBER,     droprate =  50 },
            { itemid = xi.items.PHOENIX_FEATHER,            droprate = 300 },
            { itemid = xi.items.PHILOSOPHERS_STONE,         droprate = 200 },
            { itemid = xi.items.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  60 },
            { itemid = xi.items.SQUARE_OF_RAXA,             droprate = 260 },
        },
    },

    -- Moa Constrictors
     [113] =
     {
         {
             { itemid = xi.items.COCKATRICE_SKIN, droprate = 1000 },
         },
         {
             { itemid = xi.items.COCKATRICE_SKIN, droprate = 1000 },
         },
         {
             { itemid = 0, droprate = 800 }, -- Nothing
             { itemid = xi.items.DODO_SKIN, droprate = 200 },
         },
         {
             { itemid = xi.items.EXPUNGER,       droprate = 250 },
             { itemid = xi.items.MORGENSTERN,    droprate = 250 },
             { itemid = xi.items.HEART_SNATCHER, droprate = 250 },
             { itemid = xi.items.GRAVEDIGGER,    droprate = 250 },
         },
         {
             { itemid = xi.items.OSTREGER_MITTS, droprate = 250 },
             { itemid = xi.items.PINEAL_HAT,     droprate = 250 },
             { itemid = xi.items.EVOKERS_BOOTS,  droprate = 250 },
             { itemid = xi.items.TRACKERS_KECKS, droprate = 250 },
         },
         {
             { itemid = xi.items.ADAMAN_INGOT,     droprate = 250 },
             { itemid = xi.items.ORICHALCUM_INGOT, droprate = 350 },
             { itemid = xi.items.ABSORBING_SHIELD, droprate = 350 },
         },
         {
             { itemid = 0, droprate = 300 }, -- Nothing
             { itemid = xi.items.POLE_GRIP,     droprate = 500 },
             { itemid = xi.items.SPEAR_STRAP,   droprate = 100 },
             { itemid = xi.items.CLAYMORE_GRIP, droprate = 100 },
         },
         {
             { itemid = xi.items.CHUNK_OF_MYTHRIL_ORE,     droprate =  60 },
             { itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE,   droprate =  60 },
             { itemid = xi.items.MAHOGANY_LOG,             droprate =  60 },
             { itemid = xi.items.EBONY_LOG,                droprate =  60 },
             { itemid = xi.items.PETRIFIED_LOG,            droprate =  60 },
             { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate =  60 },
             { itemid = xi.items.CHUNK_OF_PLATINUM_ORE,    droprate =  60 },
             { itemid = xi.items.CHUNK_OF_GOLD_ORE,        droprate =  60 },
             { itemid = xi.items.SQUARE_OF_RAINBOW_CLOTH,  droprate = 110 },
             { itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =  60 },
             { itemid = xi.items.CORAL_FRAGMENT,           droprate =  60 },
             { itemid = xi.items.RAM_HORN,                 droprate =  60 },
             { itemid = xi.items.DEMON_HORN,               droprate = 110 },
             { itemid = xi.items.HI_RERAISER,              droprate =  60 },
             { itemid = xi.items.VILE_ELIXIR,              droprate =  60 },
         },
         {
             { itemid = xi.items.DAMASCUS_INGOT,             droprate =  50 },
             { itemid = xi.items.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  50 },
             { itemid = xi.items.PHOENIX_FEATHER,            droprate = 300 },
             { itemid = xi.items.PHILOSOPHERS_STONE,         droprate = 350 },
             { itemid = xi.items.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  50 },
             { itemid = xi.items.SQUARE_OF_RAXA,             droprate = 200 },
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
