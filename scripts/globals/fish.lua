-----------------------------------
-- Data for Fishing
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.fishing = xi.fishing or {}
xi.fishing.contest = xi.fishing.contest or {}

xi.fishing.contentTags =
{
    ['COP']       = xi.settings.main.ENABLE_COP,
    ['TOAU']      = xi.settings.main.ENABLE_TOAU,
    ['WOTG']      = xi.settings.main.ENABLE_WOTG,
    ['ACP']       = xi.settings.main.ENABLE_ACP,
    ['AMK']       = xi.settings.main.ENABLE_AMK,
    ['ASA']       = xi.settings.main.ENABLE_ASA,
    ['ABYSSEA']   = xi.settings.main.ENABLE_ABYSSEA,
    ['ROV']       = xi.settings.main.ENABLE_SOA,
    ['SOA']       = xi.settings.main.ENABLE_ROV,
    ['VOIDWATCH'] = xi.settings.main.ENABLE_VOIDWATCH,
    ['NEODYNA']   = xi.settings.main.ENABLE_NEODYNA,
}

xi.fishing.fish =
{
    -- A table of all fishable fish, including items that count as fish for Fisherman's Heart
    -- but excluding items and NMs that are not counted for that quest.
    -- NOTE: If you don't want certain fish included in the contest (era restrictions, or whatever),
    --   then you must comment out the lines containing unwanted fish.  The C++ core calls the
    --   random function in this file to select a fish for each contest, which uses this table.

    { id = 2216, size = "Small", name = "lamp_marimo"         , realname = "Lamp Marimo"        , tag = "TOAU"    },
    { id = 4288, size = "Small", name = "zebra_eel"           , realname = "Zebra Eel"          , tag = "TOAU"    },
    { id = 4289, size = "Small", name = "forest_carp"         , realname = "Forest Carp"        , tag = "COP"     },
    { id = 4290, size = "Small", name = "elshimo_frog"        , realname = "Elshimo Frog"       , tag = "COP"     },
    { id = 4291, size = "Small", name = "sandfish"            , realname = "Sandfish"           , tag = "TOAU"    },
    { id = 4304, size = "Large", name = "grimmonite"          , realname = "Grimmonite"         , tag = "COP"     },
    { id = 4305, size = "Small", name = "ryugu_titan"         , realname = "Ryugu Titan"        , tag = "COP"     },
    { id = 4306, size = "Large", name = "giant_donko"         , realname = "Giant Donko"        , tag = "COP"     },
    { id = 4307, size = "Large", name = "jungle_catfish"      , realname = "Jungle Catfish"     , tag = "COP"     },
    { id = 4308, size = "Small", name = "giant_chirai"        , realname = "Giant Chirai"       , tag = "COP"     },
    { id = 4309, size = "Small", name = "cave_cherax"         , realname = "Cave Cherax"        , tag = "COP"     },
    { id = 4310, size = "Small", name = "tiny_goldfish"       , realname = "Tiny Goldfish"      , tag = "TOAU"    },
    { id = 4313, size = "Small", name = "blindfish"           , realname = "Blindfish"          , tag = "COP"     },
    { id = 4314, size = "Small", name = "bibikibo"            , realname = "Bibikibo"           , tag = "COP"     },
    { id = 4315, size = "Small", name = "lungfish"            , realname = "Lungfish"           , tag = "COP"     },
    { id = 4316, size = "Large", name = "armored_pisces"      , realname = "Armored Pisces"     , tag = "COP"     },
    { id = 4317, size = "Small", name = "trilobite"           , realname = "Trilobite"          , tag = "TOAU"    },
    { id = 4318, size = "Small", name = "bibiki_urchin"       , realname = "Bibiki Urchin"      , tag = "COP"     },
    { id = 4319, size = "Large", name = "tricorn"             , realname = "Tricorn"            , tag = "COP"     },
    { id = 4354, size = "Small", name = "shining_trout"       , realname = "Shining Trout"      , tag = "COP"     },
    { id = 4360, size = "Small", name = "bastore_sardine"     , realname = "Bastore Sardine"    , tag = "COP"     },
    { id = 4361, size = "Small", name = "nebimonite"          , realname = "Nebimonite"         , tag = "COP"     },
    { id = 4379, size = "Small", name = "cheval_salmon"       , realname = "Cheval Salmon"      , tag = "COP"     },
    { id = 4383, size = "Small", name = "gold_lobster"        , realname = "Gold Lobster"       , tag = "COP"     },
    { id = 4384, size = "Small", name = "black_sole"          , realname = "Black Sole"         , tag = "COP"     },
    { id = 4385, size = "Small", name = "zafmlug_bass"        , realname = "Zafmlug Bass"       , tag = "COP"     },
    { id = 4399, size = "Small", name = "bluetail"            , realname = "Bluetail"           , tag = "COP"     },
    { id = 4401, size = "Small", name = "moat_carp"           , realname = "Moat Carp"          , tag = "COP"     },
    { id = 4402, size = "Small", name = "red_terrapin"        , realname = "Red Terrapin"       , tag = "COP"     },
    { id = 4403, size = "Small", name = "yellow_globe"        , realname = "Yellow Globe"       , tag = "COP"     },
    { id = 4426, size = "Small", name = "tricolored_carp"     , realname = "Tricolored Carp"    , tag = "COP"     },
    { id = 4427, size = "Small", name = "gold_carp"           , realname = "Gold Carp"          , tag = "COP"     },
    { id = 4428, size = "Small", name = "dark_bass"           , realname = "Dark Bass"          , tag = "COP"     },
    { id = 4429, size = "Small", name = "black_eel"           , realname = "Black Eel"          , tag = "COP"     },
    { id = 4443, size = "Small", name = "cobalt_jellyfish"    , realname = "Cobalt Jellyfish"   , tag = "COP"     },
    { id = 4451, size = "Small", name = "silver_shark"        , realname = "Silver Shark"       , tag = "COP"     },
    { id = 4454, size = "Large", name = "emperor_fish"        , realname = "Emperor Fish"       , tag = "COP"     },
    { id = 4461, size = "Small", name = "bastore_bream"       , realname = "Bastore Bream"      , tag = "COP"     },
    { id = 4462, size = "Large", name = "monke-onke"          , realname = "Monke-Onke"         , tag = "COP"     },
    { id = 4463, size = "Large", name = "takitaro"            , realname = "Takitaro"           , tag = "COP"     },
    { id = 4464, size = "Small", name = "pipira"              , realname = "Pipira"             , tag = "COP"     },
    { id = 4469, size = "Large", name = "giant_catfish"       , realname = "Giant Catfish"      , tag = "COP"     },
    { id = 4470, size = "Small", name = "icefish"             , realname = "Icefish"            , tag = "COP"     },
    { id = 4471, size = "Large", name = "bladefish"           , realname = "Bladefish"          , tag = "COP"     },
    { id = 4472, size = "Small", name = "crayfish"            , realname = "Crayfish"           , tag = "COP"     },
    { id = 4473, size = "Small", name = "crescent_fish"       , realname = "Crescent Fish"      , tag = "COP"     },
    { id = 4474, size = "Large", name = "gigant_squid"        , realname = "Gigant Squid"       , tag = "COP"     },
    { id = 4475, size = "Small", name = "sea_zombie"          , realname = "Sea zombie"         , tag = "COP"     },
    { id = 4476, size = "Small", name = "titanictus"          , realname = "Titanictus"         , tag = "COP"     },
    { id = 4477, size = "Large", name = "gavial_fish"         , realname = "Gavial Fish"        , tag = "COP"     },
    { id = 4478, size = "Large", name = "three-eyed_fish"     , realname = "Three-eyed Fish"    , tag = "COP"     },
    { id = 4479, size = "Large", name = "bhefhel_marlin"      , realname = "Bhefhel Marlin"     , tag = "COP"     },
    { id = 4480, size = "Large", name = "gugru_tuna"          , realname = "Gugru Tuna"         , tag = "COP"     },
    { id = 4481, size = "Small", name = "ogre_eel"            , realname = "Ogre Eel"           , tag = "COP"     },
    { id = 4482, size = "Small", name = "nosteau_herring"     , realname = "Nosteau Herring"    , tag = "COP"     },
    { id = 4483, size = "Small", name = "tiger_cod"           , realname = "Tiger Cod"          , tag = "COP"     },
    { id = 4484, size = "Small", name = "shall_shell"         , realname = "Shall Shell"        , tag = "COP"     },
    { id = 4485, size = "Small", name = "noble_lady"          , realname = "Noble Lady"         , tag = "COP"     },
    { id = 4500, size = "Small", name = "greedie"             , realname = "Greedie"            , tag = "COP"     },
    { id = 4501, size = "Small", name = "fat_greedie"         , realname = "Fat Greedie"        , tag = "COP"     },
    { id = 4514, size = "Small", name = "quus"                , realname = "Quus"               , tag = "COP"     },
    { id = 4515, size = "Small", name = "copper_frog"         , realname = "Copper Frog"        , tag = "COP"     },
    { id = 4528, size = "Small", name = "crystal_bass"        , realname = "Crystal Bass"       , tag = "COP"     },
    { id = 4579, size = "Small", name = "elshimo_newt"        , realname = "Elshimo Newt"       , tag = "COP"     },
    { id = 4580, size = "Small", name = "coral_butterfly"     , realname = "Coral Butterfly"    , tag = "COP"     },
    { id = 5120, size = "Large", name = "titanic_sawfish"     , realname = "Titanic Sawfish"    , tag = "COP"     },
    { id = 5121, size = "Small", name = "moorish_idol"        , realname = "Moorish Idol"       , tag = "COP"     },
    { id = 5125, size = "Small", name = "phanauet_newt"       , realname = "Phanauet Newt"      , tag = "COP"     },
    { id = 5126, size = "Small", name = "muddy_siredon"       , realname = "Muddy Siredon"      , tag = "TOAU"    },
    { id = 5127, size = "Large", name = "gugrusaurus"         , realname = "Gugrusaurus"        , tag = "COP"     },
    { id = 5128, size = "Small", name = "cone_calamary"       , realname = "Cone Calamary"      , tag = "COP"     },
    { id = 5129, size = "Large", name = "lik"                 , realname = "Lik"                , tag = "COP"     },
    { id = 5130, size = "Small", name = "tavnazian_goby"      , realname = "Tavnazian Goby"     , tag = "TOAU"    },
    { id = 5131, size = "Small", name = "vongola_clam"        , realname = "Vongola Clam"       , tag = "COP"     },
    { id = 5132, size = "Small", name = "gurnard"             , realname = "Gurnard"            , tag = "TOAU"    },
    { id = 5133, size = "Large", name = "pterygotus"          , realname = "Pterygotus"         , tag = "TOAU"    },
    { id = 5134, size = "Large", name = "mola_mola"           , realname = "Mola Mola"          , tag = "TOAU"    },
    { id = 5135, size = "Large", name = "rhinochimera"        , realname = "Rhinochimera"       , tag = "TOAU"    },
    { id = 5136, size = "Large", name = "istavrit"            , realname = "Istavrit"           , tag = "TOAU"    },
    { id = 5137, size = "Large", name = "turnabaligi"         , realname = "Turnabaligi"        , tag = "TOAU"    },
    { id = 5138, size = "Small", name = "black_ghost"         , realname = "Black Ghost"        , tag = "TOAU"    },
    { id = 5139, size = "Small", name = "betta"               , realname = "Betta"              , tag = "TOAU"    },
    { id = 5140, size = "Large", name = "kalkanbaligi"        , realname = "Kalkanbaligi"       , tag = "TOAU"    },
    { id = 5141, size = "Large", name = "veydal_wrasse"       , realname = "Veydal Wrasse"      , tag = "TOAU"    },
    { id = 5446, size = "Small", name = "red_bubble-eye"      , realname = "Red Bubble-eye"     , tag = "WOTG"    },
    { id = 5447, size = "Small", name = "denizanasi"          , realname = "Denizanasi"         , tag = "TOAU"    },
    { id = 5448, size = "Small", name = "kalamar"             , realname = "Kalamar"            , tag = "TOAU"    },
    { id = 5449, size = "Small", name = "hamsi"               , realname = "Hamsi"              , tag = "TOAU"    },
    { id = 5450, size = "Large", name = "lakerda"             , realname = "Lakerda"            , tag = "TOAU"    },
    { id = 5451, size = "Large", name = "kilicbaligi"         , realname = "Kilicbaligi"        , tag = "TOAU"    },
    { id = 5452, size = "Small", name = "uskumru"             , realname = "Uskumru"            , tag = "TOAU"    },
    { id = 5453, size = "Small", name = "istakoz"             , realname = "Istakoz"            , tag = "TOAU"    },
    { id = 5454, size = "Small", name = "mercanbaligi"        , realname = "Mercanbaligi"       , tag = "TOAU"    },
    { id = 5455, size = "Large", name = "ahtapot"             , realname = "Ahtapot"            , tag = "TOAU"    },
    { id = 5456, size = "Small", name = "istiridye"           , realname = "Istiridye"          , tag = "TOAU"    },
    { id = 5457, size = "Small", name = "dil"                 , realname = "Dil"                , tag = "TOAU"    },
    { id = 5458, size = "Small", name = "yilanbaligi"         , realname = "Yilanbaligi"        , tag = "TOAU"    },
    { id = 5459, size = "Small", name = "sazanbaligi"         , realname = "Sazanbaligi"        , tag = "TOAU"    },
    { id = 5460, size = "Small", name = "kayabaligi"          , realname = "Kayabaligi"         , tag = "TOAU"    },
    { id = 5461, size = "Small", name = "alabaligi"           , realname = "Alabaligi"          , tag = "TOAU"    },
    { id = 5462, size = "Large", name = "morinabaligi"        , realname = "Morinabaligi"       , tag = "TOAU"    },
    { id = 5463, size = "Large", name = "yayinbaligi"         , realname = "Yayinbaligi"        , tag = "TOAU"    },
    { id = 5464, size = "Small", name = "kaplumbaga"          , realname = "Kaplumbaga"         , tag = "TOAU"    },
    { id = 5465, size = "Small", name = "caedarva_frog"       , realname = "Caedarva Frog"      , tag = "TOAU"    },
    { id = 5466, size = "Small", name = "trumpet_shell"       , realname = "Trumpet Shell"      , tag = "WOTG"    },
    { id = 5467, size = "Large", name = "megalodon"           , realname = "Megalodon"          , tag = "WOTG"    },
    { id = 5468, size = "Small", name = "matsya"              , realname = "Matsya"             , tag = "WOTG"    },
    { id = 5469, size = "Small", name = "brass_loach"         , realname = "Brass Loach"        , tag = "WOTG"    },
    { id = 5470, size = "Large", name = "pirarucu"            , realname = "Pirarucu"           , tag = "WOTG"    },
    { id = 5471, size = "Large", name = "gerrothorax"         , realname = "Gerrothorax"        , tag = "WOTG"    },
    { id = 5472, size = "Small", name = "garpike"             , realname = "Garpike"            , tag = "WOTG"    },
    { id = 5473, size = "Small", name = "bastore_sweeper"     , realname = "Bastore Sweeper"    , tag = "WOTG"    },
    { id = 5474, size = "Small", name = "ca_cuong"            , realname = "Ca Cuong"           , tag = "WOTG"    },
    { id = 5475, size = "Large", name = "gigant_octopus"      , realname = "Gigant Octopus"     , tag = "WOTG"    },
    { id = 5476, size = "Small", name = "abaia"               , realname = "Abaia"              , tag = "WOTG"    },
    { id = 5534, size = "Large", name = "apkallufa"           , realname = "Apkallufa"          , tag = "TOAU"    },
    { id = 5535, size = "Small", name = "deademoiselle"       , realname = "Deademoiselle"      , tag = "ROV"     },
    { id = 5536, size = "Small", name = "yorchete"            , realname = "Yorchete"           , tag = "SOA"     },
    { id = 5537, size = "Large", name = "soryu"               , realname = "Soryu"              , tag = "ABYSSEA" },
    { id = 5538, size = "Large", name = "sekiryu"             , realname = "Sekiryu"            , tag = "ABYSSEA" },
    { id = 5539, size = "Large", name = "hakuryu"             , realname = "Hakuryu"            , tag = "ABYSSEA" },
    { id = 5540, size = "Large", name = "kokuryu"             , realname = "Kokuryu"            , tag = "ABYSSEA" },
    { id = 5812, size = "Small", name = "blowfish"            , realname = "Blowfish"           , tag = "ABYSSEA" },
    { id = 5813, size = "Large", name = "dorado_gar"          , realname = "Dorado Gar"         , tag = "ABYSSEA" },
    { id = 5814, size = "Large", name = "crocodilos"          , realname = "Crocodilos"         , tag = "ABYSSEA" },
    { id = 5815, size = "Large", name = "pelazoea"            , realname = "Pelazoea"           , tag = "ABYSSEA" },
    { id = 5816, size = "Large", name = "king_perch"          , realname = "King Perch"         , tag = "ABYSSEA" },
    { id = 5817, size = "Large", name = "tiger_shark"         , realname = "Tiger Shark"        , tag = "ABYSSEA" },
    { id = 5948, size = "Small", name = "black_prawn"         , realname = "Black Prawn"        , tag = "SOA"     },
    { id = 5949, size = "Small", name = "mussel"              , realname = "Mussel"             , tag = "ABYSSEA" },
    { id = 5950, size = "Small", name = "mackerel"            , realname = "Mackerel"           , tag = "SOA"     },
    { id = 5951, size = "Large", name = "bloodblotch"         , realname = "Bloodblotch"        , tag = "SOA"     },
    { id = 5952, size = "Small", name = "ruddy_seema"         , realname = "Ruddy Seema"        , tag = "SOA"     },
    { id = 5953, size = "Small", name = "dragonfly_trout"     , realname = "Dragonfly Trout"    , tag = "ROV"     },
    { id = 5955, size = "Large", name = "yawning_catfish"     , realname = "Yawning Catfish"    , tag = "ROV"     },
    { id = 5957, size = "Small", name = "shockfish"           , realname = "Shockfish"          , tag = "ROV"     },
    { id = 5959, size = "Small", name = "dragonfish"          , realname = "Dragonfish"         , tag = "SOA"     },
    { id = 5960, size = "Small", name = "ulbukan_lobster"     , realname = "Ulbukan Lobster"    , tag = "SOA"     },
    { id = 5961, size = "Small", name = "contortopus"         , realname = "Contortopus"        , tag = "SOA"     },
    { id = 5963, size = "Small", name = "senroh_sardine"      , realname = "Senroh Sardine"     , tag = "SOA"     },
    { id = 5993, size = "Small", name = "senroh_frog"         , realname = "Senroh Frog"        , tag = "SOA"     },
    { id = 5995, size = "Large", name = "malicious_perch"     , realname = "Malicious Perch"    , tag = "ROV"     },
    { id = 5997, size = "Large", name = "shen"                , realname = "Shen"               , tag = "SOA"     },
    { id = 6001, size = "Small", name = "clotflagration"      , realname = "Clotflagration"     , tag = "ROV"     },
    { id = 6144, size = "Small", name = "frigorifish"         , realname = "Frigorifish"        , tag = "ROV"     },
    { id = 6145, size = "Small", name = "dwarf_remora"        , realname = "Dwarf Remora"       , tag = "SOA"     },
    { id = 6146, size = "Large", name = "remora"              , realname = "Remora"             , tag = "SOA"     },
    { id = 6333, size = "Small", name = "translucent_salpa"   , realname = "Translucent Salpa"  , tag = "ROV"     },
    { id = 6334, size = "Small", name = "ra_kaznar_shellfish" , realname = "Ra'Kaznar Shellfish", tag = "SOA"     },
    { id = 6335, size = "Small", name = "white_lobster"       , realname = "White Lobster"      , tag = "SOA"     },
    { id = 6336, size = "Small", name = "bonefish"            , realname = "Bonefish"           , tag = "SOA"     },
    { id = 6337, size = "Small", name = "thysanopeltis"       , realname = "Thysanopeltis"      , tag = "SOA"     },
    { id = 6338, size = "Large", name = "cameroceras"         , realname = "Cameroceras"        , tag = "SOA"     },
    { id = 6371, size = "Large", name = "quicksilver_blade"   , realname = "Quicksilver Blade"  , tag = "SOA"     },
    { id = 6372, size = "Large", name = "lord_of_ulbuka"      , realname = "Lord of Ulbuka"     , tag = "SOA"     },
    { id = 6373, size = "Large", name = "ancient_carp"        , realname = "Ancient Carp"       , tag = "SOA"     },
    { id = 6374, size = "Large", name = "dragon_s_tabernacle" , realname = "Dragon's Tabernacle", tag = "SOA"     },
    { id = 6375, size = "Large", name = "phantom_serpent"     , realname = "Phantom Serpent"    , tag = "SOA"     },
    { id = 6376, size = "Large", name = "tusoteuthis_longa"   , realname = "Tusoteuthis Longa"  , tag = "SOA"     },
    { id = 6489, size = "Large", name = "far_east_puffer"     , realname = "Far East Puffer"    , tag = "ROV"     },
    { id = 9077, size = "Small", name = "duskcrawler"         , realname = "Duskcrawler"        , tag = "SOA"     },
    { id = 9146, size = "Small", name = "ashen_crayfish"      , realname = "Ashen Crayfish"     , tag = "SOA"     },
    { id = 9216, size = "Small", name = "voidsnapper"         , realname = "Voidsnapper"        , tag = "SOA"     },
}

xi.fishing.contest.criteria =
{
    SIZE   = 0,
    WEIGHT = 1,
    BOTH   = 2,
}

xi.fishing.contest.measure =
{
    GREATEST = 0,
    SMALLEST = 1,
}

xi.fishing.contest.status =
{
    CONTESTING = 0,
    OPENING    = 1,
    ACCEPTING  = 2,
    RELEASING  = 3,
    PRESENTING = 4,
    HIATUS     = 5,
    CLOSED     = 6,
}

xi.fishing.contest.reward =
{
    -- Defines the reward at each rank
    [ 1] = { gil = 50000, item = xi.items.PELICAN_RING, title = xi.title.GOLD_HOOK    },
    [ 2] = { gil = 25000, item = xi.items.PELICAN_RING, title = xi.title.MYTHRIL_HOOK },
    [ 3] = { gil = 10000, item = xi.items.PELICAN_RING, title = xi.title.SILVER_HOOK  },
    [ 4] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 5] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 6] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 7] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 8] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 9] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [10] = { gil = 1000,  item = xi.items.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [11] = {              item = xi.items.PELICAN_RING,                               },
    [12] = {              item = xi.items.PELICAN_RING,                               },
    [13] = {              item = xi.items.PELICAN_RING,                               },
    [14] = {              item = xi.items.PELICAN_RING,                               },
    [15] = {              item = xi.items.PELICAN_RING,                               },
    [16] = {              item = xi.items.PELICAN_RING,                               },
    [17] = {              item = xi.items.PELICAN_RING,                               },
    [18] = {              item = xi.items.PELICAN_RING,                               },
    [19] = {              item = xi.items.PELICAN_RING,                               },
    [20] = {              item = xi.items.PELICAN_RING,                               },
}

xi.fishing.contest.interval =
{
    -- All time intervals are relative to the BASE start time of the contest, not the previous phase
    -- These intervals indicate how long each phase lasts before being automatically progressed.
    -- These intervals must match those in fishingutils.h
    [xi.fishing.contest.status.CONTESTING] = 300,     -- 5 minutes
    [xi.fishing.contest.status.OPENING]    = 1800,    -- 30 minutes (Prev + 25 mins)
    [xi.fishing.contest.status.ACCEPTING]  = 1211400, -- 14 days, 30 minutes (Prev + 14 days)
    [xi.fishing.contest.status.RELEASING]  = 1213200, -- 14 days, 1 hour (Prev + 30 mins)
    [xi.fishing.contest.status.PRESENTING] = 2419200, -- 28 days (Prev + 13 days, 23 hours),
    [xi.fishing.contest.status.HIATUS]     = 2421300, -- 28 days, 35 minutes (Prev + 35 minutes)
}

-------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------

local function filterTable(mainTable, func)
    local filteredTable = {}

    for _, fish in pairs(mainTable) do
        if func(fish) then
            table.insert(filteredTable, fish)
        end
    end

    return filteredTable
end

local function findFishSlot(trade, fish)
    for i = 0, trade:getSlotCount()-1 do
        if trade:getItemId(i) == fish then
            return i
        end
    end

    return 0
end

local function giveFish(player, params)
    params = params or {}
    local ID = zones[player:getZoneID()]
    local fishid = params.id
    -- does player have enough inventory space?
    if player:getFreeSlotsCount() < 1 then
        local messageId = (ID.text.ITEM_CANNOT_BE_OBTAINED + 4) or ID.text.ITEM_CANNOT_BE_OBTAINED
        player:messageSpecial(messageId, fishid)
        return false
    end

    -- give items to player
    if player:addItem(params) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, fishid)
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, fishid)
        return false
    end

    return true
end

local function getAwardInteger(awardTable)
    return bit.lshift(awardTable[4], 24) + bit.lshift(awardTable[3], 16) + bit.lshift(awardTable[2], 8) + awardTable[1]
end

local function isRewardAvailable(player, contestId)
    -- This will not permit rewarding for ongoing contests until it is ACTUALLY at the presenting stage.
    local awards = player:getAvailableContestRewards(contestId)

    if
        awards ~= nil and
        #awards > 0
    then
        if
            awards[1]['rank'] > 0 and
            awards[1]['rank'] <= 20
        then
            return 1
        end
    end

    return 0
end

-------------------------------------------------------------
-- COMMON FISH-RELATED FUNCTIONS
-------------------------------------------------------------

xi.fishing.countFish = function(fishTable)
    local fishCount = 0
    for _, fish in pairs(fishTable) do
        fishCount = fishCount + utils.mask.countBits(fish)
    end

    return fishCount
end

xi.fishing.findFishId = function(fishName)
    for _, fish in pairs(xi.fishing.fish) do
        if fish['name'] == fishName then
            return fish['id']
        end
    end

    return 0
end

xi.fishing.isFish = function(itemid)
    for _, fish in pairs(xi.fishing.fish) do
        if fish['id'] == itemid then
            return true
        end
    end

    return false
end

xi.fishing.isBigFish = function(fishId)
    for _, fish in pairs(xi.fishing.fish) do
        if
            fish['size'] == "Large" and
            fish['id'] == fishId
        then
            return true
        end
    end

    return false
end

xi.fishing.getFishName = function(itemid)
    for _, fish in pairs(xi.fishing.fish) do
        if fish['id'] == itemid then
            return fish['realname']
        end
    end

    return nil
end

-------------------------------------------------------------
-- CONTEST-SPECIFIC FUNCTIONS
-------------------------------------------------------------

xi.fishing.contest.randomFish = function()
    local largeFish = filterTable (xi.fishing.fish, function(fish)
        return fish["size"] == "Large"
    end)

    if xi.settings.main.RESTRICT_CONTENT then
        largeFish = filterTable (largeFish, function(fish)
            return xi.fishing.contentTags[fish["tag"]] == 1
        end)
    end

    local index = math.random(#largeFish)
    return largeFish[index]["id"]
end

xi.fishing.contest.timeRemaining = function(changeTime)
    local timeTable = {}
    local currentTime = os.time()
    if changeTime > currentTime then
        local timeDelta = changeTime - currentTime
        timeTable =
        {
            ['days']       = math.floor(timeDelta / (60 * 60 * 24)),
            ['hours']      = math.floor((timeDelta / (60 * 60)) % 24),
            ['minutes']    = math.floor((timeDelta / 60) % 60),
        }
    else
        timeTable =
        {
            ['days']       = 0,
            ['hours']      = 0,
            ['minutes']    = 0,
        }
    end

    return timeTable
end

xi.fishing.contest.statusTime = function(startTime)
    local timeTable = {}
    timeTable =
    {
        [0] = startTime + xi.fishing.contest.interval[0], -- 5 minutes
        [1] = startTime + xi.fishing.contest.interval[1], -- 30 minutes (Prev + 25 mins)
        [2] = startTime + xi.fishing.contest.interval[2], -- 14 days, 30 minutes (Prev + 14 days)
        [3] = startTime + xi.fishing.contest.interval[3], -- 14 days, 1 hour (Prev + 30 mins)
        [4] = startTime + xi.fishing.contest.interval[4], -- 28 days (Prev + 13 days, 23 hours)
        [5] = startTime + xi.fishing.contest.interval[5], -- 28 days, 35 minutes (Prev + 35 minutes)
        [6] = 0xFFFFFFFF,
    }

    return timeTable
end

xi.fishing.contest.scoreFish = function(length, weight, criteria)
    local score = 0
    if criteria == xi.fishing.contest.criteria.SIZE then
        score = length
    elseif criteria == xi.fishing.contest.criteria.WEIGHT then
        score = weight
    else
        score = length + weight
    end

    return score
end

xi.fishing.contest.defaultStatus = function(startTime)
    local timeTable = xi.fishing.contest.statusTime(startTime)
    local timeNow = os.time()

    for i = xi.fishing.contest.status.PRESENTING, xi.fishing.contest.status.CONTESTING, -1 do
        if timeNow > timeTable[i] then
            return i + 1
        end
    end

    return 0
end

xi.fishing.contest.playerReward = function(player, contestId)
    local awards = player:getAvailableContestRewards(contestId)

    if
        awards ~= nil and
        #awards == 1
    then
        local rank  = awards[1]['rank']
        local share = awards[1]['share'] or 1
        if
            rank > 0 and
            rank <= 20
        then
            local reward = xi.fishing.contest.reward[rank]
            if reward.gil then
                reward.gil = reward.gil / share
            end

            return reward
        end
    end

    return nil
end

-------------------------------------------------------------
-- HOOKED FUNCTIONS
-------------------------------------------------------------
xi.fishing.onTrigger = function(player, npc)
    local contest = GetCurrentFishingContest()
    player:startEvent(10006, {
        [0] = contest["status"],
        [1] = contest["fishid"],   -- Fish ID for the contest
        [2] = contest["criteria"], -- 0 = Size, 1 = Weight, 2 = Size + Weight
        [3] = contest["measure"],  -- 0 = greatest, 1 = smallest
    })
end

xi.fishing.onTrade = function(player, npc, trade)
    -- Handle fish submission
    local contest = GetCurrentFishingContest()

    -- Check to see if the traded fish is the right one
    if
        contest['status'] == xi.fishing.contest.status.ACCEPTING and
        npcUtil.tradeHasExactly(trade, contest['fishid'])
    then
        local fishItem = trade:getItem(findFishSlot(trade, contest['fishid']))
        local fishData = fishItem:getFishData()

        if
            fishData['ranked'] or
            fishData['length'] == 0 or
            fishData['weight'] == 0
        then
            -- Fish has already been ranked previously
            player:startEvent(10007, { [4] = 1 })
        else
            -- Fish is a valid entry, not previously ranked
            player:setLocalVar("[FishContest]Length", fishData['length'])
            player:setLocalVar("[FishContest]Weight", fishData['weight'])
            player:startEvent(10007, {
                [5] = xi.fishing.contest.scoreFish(fishData['length'], fishData['weight'], contest['criteria']),
                [6] = player:getContestScore(),
            })
        end
    end
end

xi.fishing.onEventUpdate = function(player, csid, option)
    local contest = GetCurrentFishingContest()

    if csid == 10006 then
        if option == 147 then
        -- Award History
            player:updateEvent({ [5] = getAwardInteger(player:getAwardHistory()) })

        elseif option == 148 then
            -- Pushed by client after informing of ranking status?  Leaving open for now

        elseif option == 149 then
        -- View Current Rules | Ranking Results | Receive Award
            if contest['status'] == xi.fishing.contest.status.ACCEPTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest["fishid"],
                    [2] = contest["criteria"],
                    [3] = contest["measure"],
                })
            elseif contest['status'] == xi.fishing.contest.status.PRESENTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest["fishid"],
                    [2] = contest["criteria"],
                    [3] = contest["measure"],
                    [4] = isRewardAvailable(player, contest['id']),
                })
            end
        elseif option == 150 then
        -- Initial option
            local time = xi.fishing.contest.timeRemaining(xi.fishing.contest.statusTime(contest['starttime'])[contest['status']])
            if contest['status'] == xi.fishing.contest.status.ACCEPTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest["fishid"],
                    [2] = contest["criteria"],
                    [3] = contest["measure"],
                    [4] = isRewardAvailable(player, contest['id']),
                    [5] = time['days'],
                    [6] = time['hours'],
                    [7] = time['minutes'],
                })
            elseif contest['status'] == xi.fishing.contest.status.PRESENTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest["fishid"],
                    [2] = contest["criteria"],
                    [3] = contest["measure"],
                    [4] = isRewardAvailable(player, contest['id']),
                    [5] = time['days'],
                    [6] = time['hours'],
                    [7] = time['minutes'],
                })
            end
        elseif option == 151 then
        -- Confirm request to confirm entry
            player:updateEvent({
                [0] = contest['status'],
                [1] = contest["fishid"],
                [2] = contest["criteria"],
                [3] = contest["measure"],
                [5] = player:getContestScore(),
            })
        elseif option == 152 then
        -- Confirm request to withdraw entry
            player:withdrawContestFish()
        end

    elseif csid == 10007 then
        if option == 144 then
            if player:getGil() < 500 then
                -- Player does not have enough gil
                player:messageSpecial(7630) -- TEMP FIX FOR INSUFFICIENT GIL UNTIL PROPER PACKET FOUND
                return
            else
                player:updateEvent()
            end
        elseif option == 145 then
            player:updateEvent()
        end
    end
end

xi.fishing.onEventFinish = function(player, csid, option)
    local contest = GetCurrentFishingContest()

    if csid == 10007 then
        -- Give the player back a fish with the same stats, but tagged for Ranking
        if option == 145 then
            local length = player:getLocalVar("[FishContest]Length")
            local weight = player:getLocalVar("[FishContest]Weight")
            local obtained = giveFish(player, { id = contest['fishid'],
                                                quantity = 1,
                                                exdata =
                                                {
                                                    [0] = bit.band(length, 0x00FF),
                                                    [1] = bit.rshift(bit.band(length, 0xFF00), 8),
                                                    [2] = bit.band(weight, 0x00FF),
                                                    [3] = bit.rshift(bit.band(weight, 0xFF00), 8),
                                                    [4] = 1, -- Flags fish as ranked
                                                } })
            if obtained then
                player:confirmTrade()
                player:delGil(500) -- Pay the registration fee of 500 gil.
                player:submitContestFish(xi.fishing.contest.scoreFish(length, weight, contest['criteria']))
                player:setLocalVar("[FishContest]Length", 0)
                player:setLocalVar("[FishContest]Weight", 0)
            end
        end

    elseif csid == 10006 then
        if
            option == 149 and
            isRewardAvailable(player, contest['id']) > 0 and
            contest['status'] == xi.fishing.contest.status.PRESENTING
        then
            -- Issue the player a reward and flag it as awarded.
            local reward = xi.fishing.contest.playerReward(player, contest['id'])
            if
                reward ~= nil and
                npcUtil.giveReward(player, reward)
            then
                player:giveContestReward(contest['id'])
            end
        end
    end
end
