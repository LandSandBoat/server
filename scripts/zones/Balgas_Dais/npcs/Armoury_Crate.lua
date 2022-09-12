-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Cicrcle Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/items")
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Steamed Sprouts
    [97] =
    {
        {
            {itemid = xi.items.GOLD_BEASTCOIN,    droprate = 500},
            {itemid = xi.items.MYTHRIL_BEASTCOIN, droprate = 500},
        },
        {
            {itemid = 0, droprate =  750}, -- nothing
            {itemid = xi.items.VILE_ELIXIR, droprate =  250},
        },
        {
            {itemid =     0, droprate =  600}, -- nothing
            {itemid = xi.items.SURVIVAL_BELT,     droprate = 100},
            {itemid = xi.items.GUARDING_GORGET,   droprate = 100},
            {itemid = xi.items.ENHANCING_EARRING, droprate = 100},
            {itemid = xi.items.BALANCE_BUCKLER,   droprate = 100},
        },
        {
            {itemid = xi.items.WHITE_ROCK,       droprate = 125},
            {itemid = xi.items.TRANSLUCENT_ROCK, droprate = 125},
            {itemid = xi.items.PURPLE_ROCK,      droprate = 125},
            {itemid = xi.items.RED_ROCK,         droprate = 125},
            {itemid = xi.items.BLUE_ROCK,        droprate = 125},
            {itemid = xi.items.YELLOW_ROCK,      droprate = 125},
            {itemid = xi.items.GREEN_ROCK,       droprate = 125},
            {itemid = xi.items.BLACK_ROCK,       droprate = 125},
        },
        {
            {itemid = xi.items.GARNET,       droprate =  50},
            {itemid = xi.items.BLACK_PEARL,  droprate =  50},
            {itemid = xi.items.AMETRINE,     droprate =  50},
            {itemid = xi.items.PAINITE,      droprate =  50},
            {itemid = xi.items.PEARL,        droprate =  50},
            {itemid = xi.items.OAK_LOG,      droprate = 100},
            {itemid = xi.items.GOSHENITE,    droprate = 100},
            {itemid = xi.items.SPHENE,       droprate = 100},
            {itemid = xi.items.ROSEWOOD_LOG, droprate = 100},
            {itemid = xi.items.TURQUOISE,    droprate = 100},
            {itemid = xi.items.SAPPHIRE,     droprate = 100},
            {itemid = xi.items.PERIDOT,      droprate = 150},
        },
        {
            {itemid =     0, droprate =  125}, -- nothing
            {itemid = xi.items.SCROLL_OF_REFRESH,     droprate = 125},
            {itemid = xi.items.SCROLL_OF_ERASE,       droprate = 125},
            {itemid = xi.items.SCROLL_OF_ABSORB_INT,  droprate = 125},
            {itemid = xi.items.SCROLL_OF_PHALANX,     droprate = 125},
            {itemid = xi.items.SCROLL_OF_ICE_SPIKES,  droprate = 125},
            {itemid = xi.items.SCROLL_OF_UTSUSEMI_NI, droprate = 125},
            {itemid = xi.items.FIRE_SPIRIT_PACT,      droprate = 125},
        },
    },
    -- BCNM Divine Punishers
    [98] =
    {
        {
            {itemid = xi.items.FORSETIS_AXE,   droprate = 250},
            {itemid = xi.items.ARAMISS_RAPIER, droprate = 250},
            {itemid = xi.items.SPARTAN_CESTI,  droprate = 250},
            {itemid = xi.items.DOMINION_MACE,  droprate = 250},
        },
        {
            {itemid = 0, droprate = 250}, -- nothing
            {itemid = xi.items.FUMA_KYAHAN,      droprate = 100},
            {itemid = xi.items.PEACE_RING,       droprate = 200},
            {itemid = xi.items.ENHANCING_MANTLE, droprate = 200},
            {itemid = xi.items.MASTER_BELT,      droprate = 150},
            {itemid = xi.items.OCHIUDOS_KOTE,    droprate = 100},
        },
        {
            {itemid = 0, droprate = 850}, -- nothing
            {itemid = xi.items.HI_RERAISER,    droprate = 100},
            {itemid = xi.items.VILE_ELIXIR_P1, droprate =  50},
        },
        {
            {itemid = xi.items.PURPLE_ROCK,      droprate = 166},
            {itemid = xi.items.TRANSLUCENT_ROCK, droprate = 166},
            {itemid = xi.items.RED_ROCK,         droprate = 167},
            {itemid = xi.items.BLACK_ROCK,       droprate = 167},
            {itemid = xi.items.YELLOW_ROCK,      droprate = 167},
            {itemid = xi.items.WHITE_ROCK,       droprate = 167},
        },
        {
            {itemid = xi.items.PAINITE, droprate = 125},
            {itemid = xi.items.AQUAMARINE, droprate = 125},
            {itemid = xi.items.FLUORITE, droprate = 125},
            {itemid = xi.items.ZIRCON, droprate = 125},
            {itemid = xi.items.SUNSTONE, droprate = 125},
            {itemid = xi.items.CHRYSOBERYL, droprate = 125},
            {itemid = xi.items.MOONSTONE, droprate = 125},
            {itemid = xi.items.JADEITE, droprate = 125},
        },
        {
            {itemid = 0, droprate = 517}, -- nothing
            {itemid = xi.items.MAHOGANY_LOG, droprate = 333},
            {itemid = xi.items.EBONY_LOG,    droprate = 150},
        },
        {
            {itemid = xi.items.STEEL_INGOT, droprate = 350}, -- steel_ingot
            {itemid = xi.items.MYTHRIL_INGOT, droprate = 150}, -- mythril_ingot
            {itemid = xi.items.DARKSTEEL_INGOT, droprate = 150}, -- darksteel_ingot
            {itemid = xi.items.GOLD_INGOT, droprate = 350}, -- gold_ingot
        },
    },
    -- BCNM Treasure and Tribulations
    [100] =
    {
        {
            {itemid = xi.items.GUARDIANS_RING, droprate =  75},
            {itemid = xi.items.KAMPFER_RING,   droprate =  32},
            {itemid = xi.items.CONJURERS_RING, droprate =  54},
            {itemid = xi.items.SHINOBI_RING,   droprate =  32},
            {itemid = xi.items.SLAYERS_RING,   droprate =  97},
            {itemid = xi.items.SORCERERS_RING, droprate =  75},
            {itemid = xi.items.SOLDIERS_RING,  droprate = 108},
            {itemid = xi.items.TAMERS_RING,    droprate =  22},
            {itemid = xi.items.TRACKERS_RING,  droprate =  65},
            {itemid = xi.items.DRAKE_RING,     droprate =  32},
            {itemid = xi.items.FENCERS_RING,   droprate =  32}, -- Fencers Ring
            {itemid = xi.items.MINSTRELS_RING, droprate =  86}, -- Minstrels Ring
            {itemid = xi.items.MEDICINE_RING, droprate =  86}, -- Medicine Ring
            {itemid = xi.items.ROGUES_RING, droprate =  75}, -- Rogues Ring
            {itemid = xi.items.RONIN_RING, droprate =  11}, -- Ronin Ring
            {itemid = xi.items.PLATINUM_RING, droprate =  32}, -- Platinum Ring
        },
        {
            {itemid = xi.items.ASTRAL_RING, droprate =  376}, -- Astral Ring
            {itemid = xi.items.PLATINUM_RING, droprate =   22}, -- Platinum Ring
            {itemid = xi.items.SCROLL_OF_QUAKE, droprate =   65}, -- Scroll Of Quake
            {itemid = xi.items.RAM_SKIN, droprate =   10}, -- Ram Skin
            {itemid = xi.items.RERAISER, droprate =   11}, -- Reraiser
            {itemid = xi.items.MYTHRIL_INGOT, droprate =   22}, -- Mythril Ingot
            {itemid = xi.items.LIGHT_SPIRIT_PACT, droprate =   10}, -- Light Spirit Pact
            {itemid = xi.items.SCROLL_OF_FREEZE, droprate =   32}, -- Scroll Of Freeze
            {itemid = xi.items.SCROLL_OF_REGEN_II, droprate =   43}, -- Scroll Of Regen Iii
            {itemid = xi.items.SCROLL_OF_RAISE_II, droprate =   32}, -- Scroll Of Raise Ii
            {itemid = xi.items.PETRIFIED_LOG, droprate =   11}, -- Petrified Log
            {itemid = xi.items.CORAL_FRAGMENT, droprate =   11}, -- Coral Fragment
            {itemid = xi.items.MAHOGANY_LOG, droprate =   11}, -- Mahogany Log
            {itemid = xi.items.CHUNK_OF_PLATINUM_ORE, droprate =   43}, -- Chunk Of Platinum Ore
            {itemid = xi.items.CHUNK_OF_GOLD_ORE, droprate =  108}, -- Chunk Of Gold Ore
            {itemid = xi.items.CHUNK_OF_DARKSTEEL_ORE, droprate =   32}, -- Chunk Of Darksteel Ore
            {itemid = xi.items.CHUNK_OF_MYTHRIL_ORE, droprate =   65}, -- Chunk Of Mythril Ore
            {itemid = xi.items.GOLD_INGOT, droprate =   10}, -- Gold Ingot
            {itemid = xi.items.DARKSTEEL_INGOT, droprate =   11}, -- Darksteel Ingot
            {itemid = xi.items.PLATINUM_INGOT, droprate =   11}, -- Platinum Ingot
            {itemid = xi.items.EBONY_LOG, droprate =   11}, -- Ebony Log
            {itemid = xi.items.RAM_HORN, droprate =   11}, -- Ram Horn
            {itemid = xi.items.DEMON_HORN, droprate =   11}, -- Demon Horn
            {itemid = xi.items.MANTICORE_HIDE, droprate =    9}, -- Manticore Hide
            {itemid = xi.items.WYVERN_SKIN, droprate =   11}, -- Wyvern Skin
            {itemid = xi.items.HANDFUL_OF_WYVERN_SCALES, droprate =   11}, -- Handful Of Wyvern Scales
        },
    },
    -- BCNM Creeping Doom
    [104] =
    {
        {
            {itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate = 1000},
        },
        {
            {itemid = 65535, droprate = 1000, amount = 3000}, -- gil
        },
        {
            {itemid = 0, droprate =  700}, -- nothing
            {itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate =  300},
        },
        {
            {itemid = 0, droprate =  900}, -- nothing
            {itemid = xi.items.SPOOL_OF_SILK_THREAD, droprate =  100},
        },
        {
            {itemid = 0, droprate = 300}, -- nothing
            {itemid = xi.items.SINGERS_EARRING,   droprate = 40},
            {itemid = xi.items.ASHIGARU_EARRING,  droprate = 50},
            {itemid = xi.items.MAGICIANS_EARRING, droprate = 50},
            {itemid = xi.items.WARLOCKS_EARRING,  droprate = 50},
            {itemid = xi.items.HEALERS_EARRING,   droprate = 40},
            {itemid = xi.items.ESQUIRES_EARRING,  droprate = 45},
            {itemid = xi.items.WIZARDS_EARRING,   droprate = 50},
            {itemid = xi.items.WYVERN_EARRING,    droprate = 40},
            {itemid = xi.items.MERCENARY_EARRING, droprate = 50},
            {itemid = xi.items.KILLER_EARRING,    droprate = 45},
            {itemid = xi.items.WRESTLERS_EARRING, droprate = 45},
            {itemid = xi.items.GENIN_EARRING,     droprate = 50},
            {itemid = xi.items.BEATERS_EARRING,   droprate = 50},
            {itemid = xi.items.PILFERERS_EARRING, droprate = 45},
            {itemid = xi.items.TRIMMERS_EARRING,  droprate = 50},
        },
        {
            {itemid =     0, droprate =  700}, -- nothing
            {itemid = xi.items.SINGERS_EARRING,   droprate =   20},
            {itemid = xi.items.ASHIGARU_EARRING,  droprate =   20},
            {itemid = xi.items.MAGICIANS_EARRING, droprate =   20},
            {itemid = xi.items.WARLOCKS_EARRING,  droprate =   20},
            {itemid = xi.items.HEALERS_EARRING,   droprate =   20},
            {itemid = xi.items.ESQUIRES_EARRING,  droprate =   20},
            {itemid = xi.items.WIZARDS_EARRING,   droprate =   20},
            {itemid = xi.items.WYVERN_EARRING,    droprate =   20},
            {itemid = xi.items.MERCENARY_EARRING, droprate =   20},
            {itemid = xi.items.KILLER_EARRING,    droprate =   20},
            {itemid = xi.items.WRESTLERS_EARRING, droprate =   20},
            {itemid = xi.items.GENIN_EARRING,     droprate =   20},
            {itemid = xi.items.BEATERS_EARRING,   droprate =   20},
            {itemid = xi.items.PILFERERS_EARRING, droprate =   20},
            {itemid = xi.items.TRIMMERS_EARRING,  droprate =   20},
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid =  1134, droprate =  400}, -- sheet_of_bast_parchment
            {itemid =  4116, droprate =  100}, -- hi-potion
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid =   694, droprate =  250}, -- chestnut_log
            {itemid =  4132, droprate =  250}, -- hi-ether
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid =  4751, droprate =  150}, -- scroll_of_erase
            {itemid =  4868, droprate =  200}, -- scroll_of_dispel
            {itemid =  5070, droprate =  250}, -- scroll_of_magic_finale
            {itemid =  4947, droprate =  150}, -- scroll_of_utsusemi_ni
        },
        {
            {itemid =     0, droprate =  300}, -- nothing
            {itemid =   814, droprate =   50}, -- amber_stone
            {itemid =   645, droprate =   50}, -- chunk_of_darksteel_ore
            {itemid =   690, droprate =   50}, -- elm_log
            {itemid =   651, droprate =   50}, -- iron_ingot
            {itemid =   643, droprate =   50}, -- chunk_of_iron_ore
            {itemid =   795, droprate =   50}, -- lapis_lazuli
            {itemid =   653, droprate =   50}, -- mythril_ingot
            {itemid =   644, droprate =   50}, -- chunk_of_mythril_ore
            {itemid =   799, droprate =   50}, -- onyx
            {itemid =   807, droprate =   50}, -- sardonyx
            {itemid =   744, droprate =   50}, -- silver_ingot
            {itemid =   736, droprate =   50}, -- chunk_of_silver_ore
            {itemid =   652, droprate =   50}, -- steel_ingot
            {itemid =   806, droprate =   50}, -- tourmaline
            {itemid =   796, droprate =   50}, -- light opal
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid =   814, droprate =   30}, -- amber_stone
            {itemid =   645, droprate =   40}, -- chunk_of_darksteel_ore
            {itemid =   690, droprate =   30}, -- elm_log
            {itemid =   651, droprate =   30}, -- iron_ingot
            {itemid =   643, droprate =   40}, -- chunk_of_iron_ore
            {itemid =   795, droprate =   30}, -- lapis_lazuli
            {itemid =   653, droprate =   40}, -- mythril_ingot
            {itemid =   644, droprate =   40}, -- chunk_of_mythril_ore
            {itemid =   799, droprate =   30}, -- onyx
            {itemid =   807, droprate =   30}, -- sardonyx
            {itemid =   744, droprate =   40}, -- silver_ingot
            {itemid =   736, droprate =   30}, -- chunk_of_silver_ore
            {itemid =   652, droprate =   30}, -- steel_ingot
            {itemid =   806, droprate =   30}, -- tourmaline
            {itemid =   796, droprate =   30}, -- light opal
        },
    },
    -- BCNM Charming Trio
    [105] =
    {
        {
            {itemid = 1603, droprate = 1000}, -- Mannequin Hands
        },
        {
            {itemid = 915, droprate = 250},  -- Jar Of Toad Oil
            {itemid = 4112, droprate = 300}, -- Potion
            {itemid = 4113, droprate = 180}, -- Potion +1
            {itemid = 4898, droprate = 130}, -- Air Spirit Pact
            {itemid = 825, droprate = 280},  -- Square Of Cotton Cloth
        },
        {
            {itemid = 749, droprate = 250},  -- Mythril Beastcoin
            {itemid = 17786, droprate = 190}, -- Ganko
            {itemid = 827, droprate = 270},  -- Square Of Wool Cloth
            {itemid = 18171, droprate = 145}, -- Platoon Disc
            {itemid = 824, droprate = 295},  -- Square Of Grass Cloth
            {itemid = 826, droprate = 260},  -- Square Of Linen Cloth
        },
        {
            {itemid = 0, droprate = 800},    -- Nothing
            {itemid = 18209, droprate = 167}, -- Platoon Cutter
        },
        {
            {itemid = 0, droprate = 500},    -- Nothing
            {itemid = 924, droprate = 500},  -- Vial Of Fiend Blood
        },
        {
            {itemid = 0, droprate = 500},    -- Nothing
            {itemid = 924, droprate = 500},  -- Vial Of Fiend Blood
        },
        {
            {itemid = 18170, droprate = 235}, -- Platoon Edge
            {itemid = 17271, droprate = 235}, -- Platoon Gun
            {itemid = 17692, droprate = 235}, -- Platoon Spatha
            {itemid = 17571, droprate = 235}, -- Platoon Pole
            {itemid = 17820, droprate = 255}, -- Gunromaru
            {itemid = 1601, droprate = 260}, -- Mannequin Head
            {itemid = 4853, droprate = 250}, -- Scroll Of Drain
            {itemid = 930, droprate = 190},  -- Vial Of Beastman Blood
        },
    },
    -- BCNM Harem Scarem
    [106] =
    {
        {
            {itemid = 857, droprate = 1000}, -- dhalmel_hide
        },
        {
            {itemid =   0, droprate = 500}, -- nothing
            {itemid = 893, droprate = 500}, -- giant_femur
        },
        {
            {itemid =    0, droprate = 500}, -- nothing
            {itemid = 4359, droprate = 500}, -- slice_of_dhalmel_meat
        },
        {
            {itemid =     0, droprate = 400}, -- nothing
            {itemid = 13659, droprate = 150}, -- mercenary_mantle
            {itemid = 13669, droprate = 150}, -- beaters_mantle
            {itemid = 13665, droprate = 150}, -- esquires_mantle
            {itemid = 13661, droprate = 150}, -- healers_mantle
        },
        {
            {itemid =     0, droprate = 400}, -- nothing
            {itemid = 12392, droprate = 200}, -- wizards_shield
            {itemid = 12397, droprate = 200}, -- trimmers_aspis
            {itemid = 12402, droprate = 200}, -- wyvern_targe
        },
        {
            {itemid =     0, droprate = 200}, -- nothing
            {itemid =  4751, droprate = 200}, -- scroll_of_erase
            {itemid =  4868, droprate = 200}, -- scroll_of_dispel
            {itemid =  5070, droprate = 200}, -- scroll_of_magic_finale
            {itemid =  4947, droprate = 200}, -- scroll_of_utsusemi_ni
        },
        {
            {itemid =   0, droprate = 250}, -- nothing
            {itemid = 828, droprate = 250}, -- square_of_velvet_cloth
            {itemid = 826, droprate = 250}, -- square_of_linen_cloth
            {itemid = 827, droprate = 250}, -- square_of_wool_cloth
        },
        {
            {itemid =    0, droprate = 600}, -- nothing
            {itemid = 1601, droprate = 200}, -- mannequin_head
            {itemid = 1603, droprate = 200}, -- mannequin_hands
        },
    },
    -- KSNM Early Bird Catches the Wyrm
    [107] =
    {
        {
            {itemid = 1441, droprate = 312}, -- Libation Abjuration
            {itemid = 17694, droprate = 182}, -- Guespiere
            {itemid = 18047, droprate = 65}, -- Havoc Scythe
            {itemid = 17937, droprate = 43}, -- Leopard Axe
            {itemid = 18173, droprate = 181}, -- Nokizaru Shuriken
            {itemid = 17823, droprate = 217}, -- Shinsoku
            {itemid = 17575, droprate = 43}, -- Somnus Signa
        },
        {
            {itemid = 722, droprate = 94},   -- Divine Log
            {itemid = 1446, droprate = 196}, -- Lacquer Tree Log
            {itemid = 703, droprate = 572},  -- Petrified Log
            {itemid = 831, droprate = 43},   -- Square Of Shining Cloth
        },
        {
            {itemid = 1442, droprate = 159}, -- Oblation Abjuration
            {itemid = 17695, droprate = 151}, -- Bayards Sword
            {itemid = 18088, droprate = 167}, -- Dreizack
            {itemid = 17576, droprate = 95}, -- Grim Staff
            {itemid = 17245, droprate = 95}, -- Grosveneurs Bow
            {itemid = 17996, droprate = 56}, -- Stylet
            {itemid = 17789, droprate = 341}, -- Unsho
        },
        {
            {itemid = 4486, droprate = 522}, -- Dragon Heart
            {itemid = 4272, droprate = 346}, -- Slice Of Dragon Meat
            {itemid = 17928, droprate = 82}, -- Juggernaut
            {itemid = 13189, droprate = 59}, -- Speed Belt
        },
        {
            {itemid = 887, droprate = 32},   -- Coral Fragment
            {itemid = 645, droprate = 71},   -- Chunk Of Darksteel Ore
            {itemid = 902, droprate = 79},   -- Demon Horn
            {itemid = 702, droprate = 56},   -- Ebony Log
            {itemid = 737, droprate = 71},   -- Chunk Of Gold Ore
            {itemid = 823, droprate = 32},   -- Spool Of Gold Thread
            {itemid = 4173, droprate = 48},  -- Hi-reraiser
            {itemid = 700, droprate = 127},  -- Mahogany Log
            {itemid = 644, droprate = 111},  -- Chunk Of Mythril Ore
            {itemid = 703, droprate = 183},  -- Petrified Log
            {itemid = 942, droprate = 40},   -- Philosophers Stone
            {itemid = 738, droprate = 56},   -- Chunk Of Platinum Ore
            {itemid = 895, droprate = 24},   -- Ram Horn
            {itemid = 1132, droprate = 119}, -- Square Of Raxa
            {itemid = 4172, droprate = 56},  -- Reraiser
            {itemid = 4175, droprate = 40},  -- Vile Elixir +1
            {itemid = 866, droprate = 24},   -- Handful Of Wyvern Scales
        },
        {
            {itemid = 1526, droprate = 210}, -- Wyrm Beard
            {itemid = 1313, droprate = 775}, -- Lock Of Sirens Hair
        },
        {
            {itemid = 4209, droprate = 94},  -- Mind Potion
            {itemid = 4207, droprate = 130}, -- Intelligence Potion
            {itemid = 4211, droprate = 116}, -- Charisma Potion
            {itemid = 4213, droprate = 51},  -- Icarus Wing
            {itemid = 1132, droprate = 246}, -- Square Of Raxa
            {itemid = 17582, droprate = 246}, -- Prelatic Pole
        },
        {
            {itemid = 4135, droprate = 290}, -- Hi-ether +3
            {itemid = 4119, droprate = 225}, -- Hi-potion +3
            {itemid = 4173, droprate = 210}, -- Hi-reraiser
            {itemid = 4175, droprate = 217}, -- Vile Elixir +1
        },
        {
            {itemid = 887, droprate = 87},   -- Coral Fragment
            {itemid = 645, droprate = 80},   -- Chunk Of Darksteel Ore
            {itemid = 902, droprate = 58},   -- Demon Horn
            {itemid = 702, droprate = 72},   -- Ebony Log
            {itemid = 737, droprate = 87},   -- Chunk Of Gold Ore
            {itemid = 823, droprate = 14},   -- Spool Of Gold Thread
            {itemid = 4173, droprate = 22},  -- Hi-reraiser
            {itemid = 700, droprate = 80},   -- Mahogany Log
            {itemid = 644, droprate = 36},   -- Chunk Of Mythril Ore
            {itemid = 703, droprate = 145},  -- Petrified Log
            {itemid = 844, droprate = 7},    -- Phoenix Feather
            {itemid = 738, droprate = 51},   -- Chunk Of Platinum Ore
            {itemid = 830, droprate = 29},   -- Square Of Rainbow Cloth
            {itemid = 895, droprate = 36},   -- Ram Horn
            {itemid = 1132, droprate = 72},  -- Square Of Raxa
            {itemid = 4172, droprate = 29},  -- Reraiser
            {itemid = 4174, droprate = 29},  -- Vile Elixir
            {itemid = 4175, droprate = 7},   -- Vile Elixir +1
            {itemid = 866, droprate = 22},   -- Handful Of Wyvern Scales
        },
        {
            {itemid = 1110, droprate = 58},  -- Vial Of Black Beetle Blood
            {itemid = 836, droprate = 36},   -- Square Of Damascene Cloth
            {itemid = 658, droprate = 72},   -- Damascus Ingot
            {itemid = 837, droprate = 22},   -- Spool Of Malboro Fiber
            {itemid = 942, droprate = 275},  -- Philosophers Stone
            {itemid = 844, droprate = 196},  -- Phoenix Feather
            {itemid = 1132, droprate = 225}, -- Square Of Raxa
        },
    },

    -- BCNM Royal Succession
    [108] =
    {
        {
            {itemid =  4596, droprate = 1000}, -- bunch_of_wild_pamamas
        },
        {
            {itemid =     0, droprate =  300}, -- nothing
            {itemid = 17572, droprate =  100}, -- dusky_staff
            {itemid = 17995, droprate =  100}, -- jongleurs_dagger
            {itemid = 17994, droprate =  100}, -- calveleys_dagger
            {itemid = 17463, droprate =  100}, -- sealed_mace
            {itemid = 17821, droprate =  100}, -- himmel_stock
            {itemid = 17787, droprate =  100}, -- kagehide
            {itemid = 17787, droprate =  100}, -- ohaguro
        },
        {
            {itemid =     0, droprate =  100}, -- nothing
            {itemid = 14736, droprate =  300}, -- genin_earring
            {itemid = 13164, droprate =  300}, -- agile_gorget
            {itemid = 13165, droprate =  300}, -- jagd_gorget
        },
        {
            {itemid =     0, droprate =  370}, -- nothing
            {itemid =   798, droprate =  100}, -- turquoise
            {itemid =  4468, droprate =  100}, -- bunch_of_pamamas
            {itemid =   829, droprate =  110}, -- square_of_silk_cloth
            {itemid =   701, droprate =  140}, -- rosewood_log
            {itemid =   792, droprate =  180}, -- pearl
        },
        {
            {itemid =  4714, droprate =  250}, -- scroll_of_phalanx
            {itemid =  4874, droprate =  250}, -- scroll_of_absorb
            {itemid =  4717, droprate =  250}, -- scroll_of_refresh
            {itemid =  4751, droprate =  250}, -- scroll_of_erase
        },
        {
            {itemid =     0, droprate =  600}, -- nothing
            {itemid =   748, droprate =  400}, -- gold_beastcoin
        },
    },
    -- BCNM Rapid Raptors
    [109] =
    {
        {
            {itemid =   853, droprate = 1000}, -- raptor_skin
        },
        {
            {itemid =   655, droprate = 1000}, -- adaman_ingot
        },
        {
            {itemid =     0, droprate =  190}, -- nothing
            {itemid = 14845, droprate =  110}, -- sly_gauntlets
            {itemid = 14843, droprate =  120}, -- spiked_finger_gauntlets
            {itemid = 14844, droprate =  140}, -- rush_gloves
            {itemid = 15149, droprate =  140}, -- rival_ribbon
            {itemid = 15148, droprate =  150}, -- mana_circlet
            {itemid = 14842, droprate =  150}, -- ivory_mitts
        },
        {
            {itemid =     0, droprate =   30}, -- nothing
            {itemid = 13167, droprate =  100}, -- storm_gorget
            {itemid = 13168, droprate =  100}, -- intellect_torque
            {itemid = 13169, droprate =  120}, -- benign_necklace
            {itemid = 13676, droprate =  130}, -- heavy_mantle
            {itemid = 13166, droprate =  170}, -- hateful_collar
            {itemid = 13677, droprate =  170}, -- esoteric_mantle
            {itemid = 13679, droprate =  180}, -- templars_mantle
        },
        {
            {itemid =     0, droprate =  230}, -- nothing
            {itemid =   653, droprate =  200}, -- mythril_ingot
            {itemid =   643, droprate =  200}, -- chunk_of_iron_ore
            {itemid =   703, droprate =  370}, -- petrified_log
        },
        {
            {itemid =     0, droprate =  560}, -- nothing
            {itemid =  4172, droprate =  440}, -- reraiser
        },
    },
    -- BCNM Wild Wild Whiskers
    [110] =
    {
        {
            {itemid =  1591, droprate = 1000}, -- high-quality_coeurl_hide
        },
        {
            {itemid =  1591, droprate = 1000}, -- high-quality_coeurl_hide
        },
        {
            {itemid =  1591, droprate = 1000}, -- high-quality_coeurl_hide
        },
        {
            {itemid =   646, droprate = 1000}, -- chunk_of_adaman_ore
        },
        {
            {itemid =  5253, droprate = 1000}, -- hermes_quencher
        },
        {
            {itemid =  4213, droprate = 1000}, -- icarus_wing
        },
        {
            {itemid = 15293, droprate =  365}, -- gleemans_belt
            {itemid = 15292, droprate =  635}, -- penitents_rope
        },
        {
            {itemid = 14663, droprate =  426}, -- teleport_ring_mea
            {itemid = 14665, droprate =  574}, -- teleport_ring_yhoat
        },
        {
            {itemid =     0, droprate =  848}, -- nothing
            {itemid = 15185, droprate =   58}, -- walkure_mask
            {itemid =  4173, droprate =   78}, -- hi-reraiser
            {itemid =   702, droprate =   16}, -- ebony_log
        },
        {
            {itemid =   771, droprate =    9}, -- yellow_rock
            {itemid =   775, droprate =    9}, -- black_rock
            {itemid =   791, droprate =   16}, -- aquamarine
            {itemid =   769, droprate =   16}, -- red_rock
            {itemid =   770, droprate =   16}, -- blue_rock
            {itemid =   774, droprate =   16}, -- purple_rock
            {itemid =   700, droprate =   33}, -- mahogany_log
            {itemid =   801, droprate =   33}, -- chrysoberyl
            {itemid =   805, droprate =   33}, -- zircon
            {itemid =   652, droprate =   49}, -- steel_ingot
            {itemid =   654, droprate =   49}, -- darksteel_ingot
            {itemid =   773, droprate =   49}, -- translucent_rock
            {itemid =   803, droprate =   49}, -- sunstone
            {itemid =   802, droprate =   66}, -- moonstone
            {itemid =   653, droprate =   82}, -- mythril_ingot
            {itemid =   810, droprate =   82}, -- fluorite
            {itemid =   745, droprate =   98}, -- gold_ingot
            {itemid =   784, droprate =   98}, -- jadeite
            {itemid =   797, droprate =   98}, -- painite
            {itemid =  4175, droprate =   99}, -- vile_elixir_+1
        },
    },

    -- Seaons Greetings
    [111] =
    {
        {
            {itemid = 17589, droprate = 200}, -- Thyrsusstab
            {itemid = 18217, droprate = 200}, -- Rampager
            {itemid = 17451, droprate = 200}, -- Morgenstern
            {itemid = 18378, droprate = 200}, -- Subduer
            {itemid = 17207, droprate = 200}, -- Expunger
        },
        {
            {itemid = 17700, droprate = 250}, -- Durandal
            {itemid = 18006, droprate = 250}, -- Hoplites Harp
            {itemid = 17842, droprate = 250}, -- Sorrowful Harp
            {itemid = 14762, droprate = 250}, -- Attila's Earring
        },
        {
            {itemid = 655,   droprate = 333}, -- Adaman Ingot
            {itemid = 747,   droprate = 333}, -- Orichalcum Ingot
            {itemid = 15328, droprate = 333}, -- Root Sabots
        },
        {
            {itemid = 711,   droprate = 650}, -- Divine Log
            {itemid = 1446,  droprate =  50}, -- Lacquer Tree Log
            {itemid = 19024, droprate = 100}, -- Sword Strap
            {itemid = 19025, droprate = 100}, -- Pole Grip
            {itemid = 19026, droprate = 100}, -- Spear Strap
        },
        {
            {itemid = 644,  droprate = 66}, -- Mythril Ore
            {itemid = 645,  droprate = 66}, -- Darksteel Ore
            {itemid = 700,  droprate = 66}, -- Mahogany Log
            {itemid = 702,  droprate = 66}, -- Ebony Log
            {itemid = 703,  droprate = 76}, -- Petrified Log
            {itemid = 737,  droprate = 66}, -- Gold Ore
            {itemid = 738,  droprate = 66}, -- Platinum Ore
            {itemid = 766,  droprate = 66}, -- Wyvern Scales
            {itemid = 830,  droprate = 66}, -- Rainbow Cloth
            {itemid = 887,  droprate = 66}, -- Coral Fragment
            {itemid = 895,  droprate = 66}, -- Ram Horn
            {itemid = 902,  droprate = 66}, -- Demon Horn
            {itemid = 1132, droprate = 66}, -- Raxa
            {itemid = 4174, droprate = 66}, -- Vile Elixer
            {itemid = 4175, droprate = 66}, -- Vile Elixer +1
        },
        {
            {itemid = 658,  droprate =  50}, -- Damascus Ingot
            {itemid = 836,  droprate =  50}, -- Damascene Cloth
            {itemid = 844,  droprate = 300}, -- Phoenix Feather
            {itemid = 942,  droprate = 100}, -- Philosopher's Stone
            {itemid = 1110, droprate = 150}, -- Beetle Blood
            {itemid = 1132, droprate = 350}, -- Raxa
        },
    },

    -- Royale Ramble
    [112] =
    {
        {
            {itemid = 747, droprate = 1000}, -- Orichalcum Ingot
        },
        {
            {itemid = 17275, droprate = 200}, -- Coffinmaker
            {itemid = 17509, droprate = 300}, -- Destroyers
            {itemid = 17699, droprate = 250}, -- Dissector
            {itemid = 18097, droprate = 250}, -- Gondo-Shizunori
        },
        {
            {itemid = 15295, droprate = 200}, -- Hierarch Belt
            {itemid = 12407, droprate = 250}, -- Palmerin's Shield
            {itemid = 14871, droprate = 250}, -- Trainer's Gloves
            {itemid = 15294, droprate = 300}, -- Warwolf Belt
        },
        {
            {itemid =     0, droprate = 300}, -- Nothing
            {itemid = 19027, droprate =  70}, -- Claymore Grip
            {itemid = 19025, droprate = 100}, -- Pole Grip
            {itemid = 19024, droprate = 280}, -- Sword Strap
            {itemid = 15186, droprate = 520}, -- Trump Crown
        },
        {
            {itemid =  972, droprate = 250}, -- King of Cups (Card)
            {itemid =  985, droprate = 350}, -- King of Batons (Card)
            {itemid =  998, droprate = 250}, -- King of Swords (Card)
            {itemid = 1011, droprate = 250}, -- King of Coins (Card)
        },
        {
            {itemid =  644, droprate =  50}, -- Mythril Ore
            {itemid =  645, droprate =  50}, -- Darksteel Ore
            {itemid =  700, droprate =  80}, -- Mahogany Log
            {itemid =  702, droprate =  80}, -- Ebony Log
            {itemid =  703, droprate = 130}, -- Petrified Log
            {itemid =  737, droprate =  60}, -- Gold Ore
            {itemid =  738, droprate =  60}, -- Platinum Ore
            {itemid =  823, droprate =  60}, -- Gold Thread
            {itemid =  830, droprate =  30}, -- Rainbow Cloth
            {itemid =  837, droprate =  20}, -- Malboro Fiber
            {itemid =  866, droprate =  30}, -- Wyvern Scales
            {itemid =  887, droprate =  60}, -- Coral Fragment
            {itemid =  895, droprate =  60}, -- Ram Horn
            {itemid =  902, droprate =  60}, -- Demon Horn
            {itemid =  942, droprate =  30}, -- Philosopher's Stone
            {itemid = 1465, droprate =  20}, -- Granite
            {itemid = 4172, droprate =  40}, -- Reraiser
            {itemid = 4173, droprate =  30}, -- Hi-Reraiser
            {itemid = 4174, droprate =  40}, -- Vile Elixer
            {itemid = 4175, droprate =  10}, -- Vile Elixer +1
        },
        {
            {itemid =  658, droprate =  90}, -- Damascus Ingot
            {itemid =  836, droprate =  40}, -- Damascene Cloth
            {itemid =  837, droprate =  50}, -- Malboro Fiber
            {itemid =  844, droprate = 300}, -- Phoenix Feather
            {itemid =  942, droprate = 200}, -- Philosophers Stone
            {itemid = 1110, droprate =  60}, -- Beetle Blood
            {itemid = 1132, droprate = 260}, -- Raxa
        },
    },

    -- Moa Constrictors
     [113] =
     {
         {
             {itemid = 854, droprate = 1000}, -- Cockatrice Skin
         },
         {
             {itemid = 854, droprate = 1000}, -- Cockatrice Skin
         },
         {
             {itemid = 0,    droprate = 800}, -- Nothing
             {itemid = 1014, droprate = 200}, -- Dodo Skin
         },
         {
             {itemid = 17207, droprate = 250}, -- Expunger
             {itemid = 17451, droprate = 250}, -- Morgenstern
             {itemid = 18005, droprate = 250}, -- Heart Snatcher
             {itemid = 18053, droprate = 250}, -- Gravedigger
         },
         {
             {itemid = 14872, droprate = 250}, -- Ostreger Mitts
             {itemid = 15181, droprate = 250}, -- Pineal Hat
             {itemid = 15325, droprate = 250}, -- Evoker's Boots
             {itemid = 15387, droprate = 250}, -- Tracker's Kecks
         },
         {
             {itemid = 655,   droprate = 250}, -- Adaman Ingot
             {itemid = 747,   droprate = 350}, -- Orichalcum
             {itemid = 12408, droprate = 350}, -- Absorbing Shield
         },
         {
             {itemid = 0,     droprate = 300}, -- Nothing
             {itemid = 19025, droprate = 500}, -- Pole Grip
             {itemid = 19026, droprate = 100}, -- Spear Strap
             {itemid = 19027, droprate = 100}, -- Claymore Grip
         },
         {
             {itemid = 644,  droprate =  60}, -- Mythril Ore
             {itemid = 645,  droprate =  60}, -- Darksteel ore
             {itemid = 700,  droprate =  60}, -- Mahogany Log
             {itemid = 702,  droprate =  60}, -- Ebony Log
             {itemid = 703,  droprate =  60}, -- Petrified Log
             {itemid = 737,  droprate =  60}, -- Gold ore
             {itemid = 738,  droprate =  60}, -- Platinum ore
             {itemid = 823,  droprate =  60}, -- Gold Thread
             {itemid = 830,  droprate = 110}, -- Rainbow Cloth
             {itemid = 866,  droprate =  60}, -- Wyvern Scales
             {itemid = 887,  droprate =  60}, -- Coral Fragment
             {itemid = 895,  droprate =  60}, -- Ram Horn
             {itemid = 902,  droprate = 110}, -- Demon Horn
             {itemid = 4173, droprate =  60}, -- Hi-Reraiser
             {itemid = 4174, droprate =  60}, -- Vile Elixer
         },
         {
             {itemid = 658,  droprate =  50}, -- Damascus Ingot
             {itemid = 836,  droprate =  50}, -- Damascene Cloth
             {itemid = 844,  droprate = 300}, -- Phoenix Feather
             {itemid = 942,  droprate = 350}, -- Philosopher's Stone
             {itemid = 1110, droprate =  50}, -- Beetle Blood
             {itemid = 1132, droprate = 200}, -- Raxa
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
