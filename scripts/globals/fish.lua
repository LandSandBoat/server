-----------------------------------
-- Data for Fishing
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.fish = {}

xi.fish.data =
{
    { id = 5816, param = 0, bit = 1 , name = "king_perch"          , realname = "King Perch"           },
    { id = 4318, param = 0, bit = 2 , name = "bibiki_urchin"       , realname = "Bibiki Urchin"        },
    { id = 2216, param = 0, bit = 3 , name = "lamp_marimo"         , realname = "Lamp Marimo"          },
    { id = 5125, param = 0, bit = 4 , name = "phanauet_newt"       , realname = "Phanauet Newt"        },
    { id = 4443, param = 0, bit = 5 , name = "cobalt_jellyfish"    , realname = "Cobalt Jellyfish"     },
    { id = 5447, param = 0, bit = 6 , name = "denizanasi"          , realname = "Denizanasi"           },
    { id = 4472, param = 0, bit = 7 , name = "crayfish"            , realname = "Crayfish"             },
    { id = 4314, param = 0, bit = 8 , name = "bibikibo"            , realname = "Bibikibo"             },
    { id = 4360, param = 0, bit = 9 , name = "bastore_sardine"     , realname = "Bastore Sardine"      },
    { id = 5449, param = 0, bit = 10, name = "hamsi"               , realname = "Hamsi"                },
    { id = 4401, param = 0, bit = 11, name = "moat_carp"           , realname = "Moat Carp"            },
    { id = 5473, param = 0, bit = 12, name = "bastore_sweeper"     , realname = "Bastore Sweeper"      },
    { id = 4500, param = 0, bit = 13, name = "greedie"             , realname = "Greedie"              },
    { id = 4515, param = 0, bit = 14, name = "copper_frog"         , realname = "Copper Frog"          },
    { id = 4403, param = 0, bit = 15, name = "yellow_globe"        , realname = "Yellow Globe"         },
    { id = 5126, param = 0, bit = 16, name = "muddy_siredon"       , realname = "Muddy Siredon"        },
    { id = 5136, param = 0, bit = 17, name = "istavrit"            , realname = "Istavrit"             },
    { id = 4514, param = 0, bit = 18, name = "quus"                , realname = "Quus"                 },
    { id = 4310, param = 0, bit = 19, name = "tiny_goldfish"       , realname = "Tiny Goldfish"        },
    { id = 4289, param = 0, bit = 20, name = "forest_carp"         , realname = "Forest Carp"          },
    { id = 4379, param = 0, bit = 21, name = "cheval_salmon"       , realname = "Cheval Salmon"        },
    { id = 4501, param = 0, bit = 22, name = "fat_greedie"         , realname = "Fat Greedie"          },
    { id = 5121, param = 0, bit = 23, name = "moorish_idol"        , realname = "Moorish Idol"         },
    { id = 5132, param = 0, bit = 24, name = "gurnard"             , realname = "Gurnard"              },
    { id = 4426, param = 0, bit = 25, name = "tricolored_carp"     , realname = "Tricolored Carp"      },
    { id = 4361, param = 0, bit = 26, name = "nebimonite"          , realname = "Nebimonite"           },
    { id = 4313, param = 0, bit = 27, name = "blindfish"           , realname = "Blindfish"            },
    { id = 4464, param = 0, bit = 28, name = "pipira"              , realname = "Pipira"               },
    { id = 4483, param = 0, bit = 29, name = "tiger_cod"           , realname = "Tiger Cod"            },
    { id = 4290, param = 0, bit = 30, name = "elshimo_frog"        , realname = "Elshimo Frog"         },
    { id = 5465, param = 0, bit = 31, name = "caedarva_frog"       , realname = "Caedarva Frog"        },
    { id = 4469, param = 1, bit = 0 , name = "giant_catfish"       , realname = "Giant Catfish"        },
    { id = 5540, param = 1, bit = 1 , name = "kokuryu"             , realname = "Kokuryu"              },
    { id = 5463, param = 1, bit = 2 , name = "yayinbaligi"         , realname = "Yayinbaligi"          },
    { id = 5537, param = 1, bit = 3 , name = "soryu"               , realname = "Soryu"                },
    { id = 4315, param = 1, bit = 4 , name = "lungfish"            , realname = "Lungfish"             },
    { id = 5475, param = 1, bit = 5 , name = "gigant_octopus"      , realname = "Gigant Octopus"       },
    { id = 4428, param = 1, bit = 6 , name = "dark_bass"           , realname = "Dark Bass"            },
    { id = 4528, param = 1, bit = 7 , name = "crystal_bass"        , realname = "Crystal Bass"         },
    { id = 4481, param = 1, bit = 8 , name = "ogre_eel"            , realname = "Ogre Eel"             },
    { id = 4354, param = 1, bit = 9 , name = "shining_trout"       , realname = "Shining Trout"        },
    { id = 5461, param = 1, bit = 10, name = "alabaligi"           , realname = "Alabaligi"            },
    { id = 5141, param = 1, bit = 11, name = "veydal_wrasse"       , realname = "Veydal Wrasse"        },
    { id = 5812, param = 1, bit = 12, name = "blowfish"            , realname = "Blowfish"             },
    { id = 4482, param = 1, bit = 13, name = "nosteau_herring"     , realname = "Nosteau Herring"      },
    { id = 4580, param = 1, bit = 14, name = "coral_butterfly"     , realname = "Coral Butterfly"      },
    { id = 4480, param = 1, bit = 15, name = "gugru_tuna"          , realname = "Gugru Tuna"           },
    { id = 5450, param = 1, bit = 16, name = "lakerda"             , realname = "Lakerda"              },
    { id = 5469, param = 1, bit = 17, name = "brass_loach"         , realname = "Brass Loach"          },
    { id = 4385, param = 1, bit = 18, name = "zafmlug_bass"        , realname = "Zafmlug Bass"         },
    { id = 4383, param = 1, bit = 19, name = "gold_lobster"        , realname = "Gold Lobster"         },
    { id = 5453, param = 1, bit = 20, name = "istakoz"             , realname = "Istakoz"              },
    { id = 4429, param = 1, bit = 21, name = "black_eel"           , realname = "Black Eel"            },
    { id = 5458, param = 1, bit = 22, name = "yilanbaligi"         , realname = "Yilanbaligi"          },
    { id = 5128, param = 1, bit = 23, name = "cone_calamary"       , realname = "Cone Calamary"        },
    { id = 5448, param = 1, bit = 24, name = "kalamar"             , realname = "Kalamar"              },
    { id = 4470, param = 1, bit = 25, name = "icefish"             , realname = "Icefish"              },
    { id = 4291, param = 1, bit = 26, name = "sandfish"            , realname = "Sandfish"             },
    { id = 4306, param = 1, bit = 27, name = "giant_donko"         , realname = "Giant Donko"          },
    { id = 4462, param = 1, bit = 28, name = "monke-onke"          , realname = "Monke-Onke"           },
    { id = 4402, param = 1, bit = 29, name = "red_terrapin"        , realname = "Red Terrapin"         },
    { id = 4484, param = 1, bit = 30, name = "shall_shell"         , realname = "Shall Shell"          },
    { id = 5131, param = 1, bit = 31, name = "vongola_clam"        , realname = "Vongola Clam"         },
    { id = 5456, param = 2, bit = 0 , name = "istiridye"           , realname = "Istiridye"            },
    { id = 5464, param = 2, bit = 1 , name = "kaplumbaga"          , realname = "Kaplumbaga"           },
    { id = 4399, param = 2, bit = 2 , name = "bluetail"            , realname = "Bluetail"             },
    { id = 5452, param = 2, bit = 3 , name = "uskumru"             , realname = "Uskumru"              },
    { id = 4427, param = 2, bit = 4 , name = "gold_carp"           , realname = "Gold Carp"            },
    { id = 5459, param = 2, bit = 5 , name = "sazanbaligi"         , realname = "Sazanbaligi"          },
    { id = 5815, param = 2, bit = 6 , name = "pelazoea"            , realname = "Pelazoea"             },
    { id = 4317, param = 2, bit = 7 , name = "trilobite"           , realname = "Trilobite"            },
    { id = 4579, param = 2, bit = 8 , name = "elshimo_newt"        , realname = "Elshimo Newt"         },
    { id = 4479, param = 2, bit = 9 , name = "bhefhel_marlin"      , realname = "Bhefhel Marlin"       },
    { id = 5451, param = 2, bit = 10, name = "kilicbaligi"         , realname = "Kilicbaligi"          },
    { id = 5466, param = 2, bit = 11, name = "trumpet_shell"       , realname = "Trumpet Shell"        },
    { id = 4485, param = 2, bit = 12, name = "noble_lady"          , realname = "Noble Lady"           },
    { id = 5139, param = 2, bit = 13, name = "betta"               , realname = "Betta"                },
    { id = 4473, param = 2, bit = 14, name = "crescent_fish"       , realname = "Crescent Fish"        },
    { id = 4288, param = 2, bit = 15, name = "zebra_eel"           , realname = "Zebra Eel"            },
    { id = 4471, param = 2, bit = 16, name = "bladefish"           , realname = "Bladefish"            },
    { id = 5135, param = 2, bit = 17, name = "rhinochimera"        , realname = "Rhinochimera"         },
    { id = 5130, param = 2, bit = 18, name = "tavnazian_goby"      , realname = "Tavnazian Goby"       },
    { id = 5460, param = 2, bit = 19, name = "kayabaligi"          , realname = "Kayabaligi"           },
    { id = 4451, param = 2, bit = 20, name = "silver_shark"        , realname = "Silver Shark"         },
    { id = 5474, param = 2, bit = 21, name = "ca_cuong"            , realname = "Ca Cuong"             },
    { id = 4307, param = 2, bit = 22, name = "jungle_catfish"      , realname = "Jungle Catfish"       },
    { id = 4477, param = 2, bit = 23, name = "gavial_fish"         , realname = "Gavial Fish"          },
    { id = 4478, param = 2, bit = 24, name = "three-eyed_fish"     , realname = "Three-eyed Fish"      },
    { id = 5470, param = 2, bit = 25, name = "pirarucu"            , realname = "Pirarucu"             },
    { id = 5472, param = 2, bit = 26, name = "garpike"             , realname = "Garpike"              },
    { id = 4461, param = 2, bit = 27, name = "bastore_bream"       , realname = "Bastore Bream"        },
    { id = 5454, param = 2, bit = 28, name = "mercanbaligi"        , realname = "Mercanbaligi"         },
    { id = 5138, param = 2, bit = 29, name = "black_ghost"         , realname = "Black Ghost"          },
    { id = 5813, param = 2, bit = 30, name = "dorado_gar"          , realname = "Dorado Gar"           },
    { id = 4304, param = 2, bit = 31, name = "grimmonite"          , realname = "Grimmonite"           },
    { id = 5455, param = 3, bit = 0 , name = "ahtapot"             , realname = "Ahtapot"              },
    { id = 4454, param = 3, bit = 1 , name = "emperor_fish"        , realname = "Emperor Fish"         },
    { id = 4474, param = 3, bit = 2 , name = "gigant_squid"        , realname = "Gigant Squid"         },
    { id = 5462, param = 3, bit = 3 , name = "morinabaligi"        , realname = "Morinabaligi"         },
    { id = 5467, param = 3, bit = 4 , name = "megalodon"           , realname = "Megalodon"            },
    { id = 4384, param = 3, bit = 5 , name = "black_sole"          , realname = "Black Sole"           },
    { id = 5457, param = 3, bit = 6 , name = "dil"                 , realname = "Dil"                  },
    { id = 5133, param = 3, bit = 7 , name = "pterygotus"          , realname = "Pterygotus"           },
    { id = 4463, param = 3, bit = 8 , name = "takitaro"            , realname = "Takitaro"             },
    { id = 4475, param = 3, bit = 9 , name = "sea_zombie"          , realname = "Sea zombie"           },
    { id = 4476, param = 3, bit = 10, name = "titanictus"          , realname = "Titanictus"           },
    { id = 5140, param = 3, bit = 11, name = "kalkanbaligi"        , realname = "Kalkanbaligi"         },
    { id = 5137, param = 3, bit = 12, name = "turnabaligi"         , realname = "Turnabaligi"          },
    { id = 4316, param = 3, bit = 13, name = "armored_pisces"      , realname = "Armored Pisces"       },
    { id = 4308, param = 3, bit = 14, name = "giant_chirai"        , realname = "Giant Chirai"         },
    { id = 5814, param = 3, bit = 15, name = "crocodilos"          , realname = "Crocodilos"           },
    { id = 5446, param = 3, bit = 16, name = "red_bubble-eye"      , realname = "Red Bubble-eye"       },
    { id = 5120, param = 3, bit = 17, name = "titanic_sawfish"     , realname = "Titanic Sawfish"      },
    { id = 4319, param = 3, bit = 18, name = "tricorn"             , realname = "Tricorn"              },
    { id = 5134, param = 3, bit = 19, name = "mola_mola"           , realname = "Mola Mola"            },
    { id = 5471, param = 3, bit = 20, name = "gerrothorax"         , realname = "Gerrothorax"          },
    { id = 4305, param = 3, bit = 21, name = "ryugu_titan"         , realname = "Ryugu Titan"          },
    { id = 4309, param = 3, bit = 22, name = "cave_cherax"         , realname = "Cave Cherax"          },
    { id = 5127, param = 3, bit = 23, name = "gugrusaurus"         , realname = "Gugrusaurus"          },
    { id = 5129, param = 3, bit = 24, name = "lik"                 , realname = "Lik"                  },
    { id = 5476, param = 3, bit = 25, name = "abaia"               , realname = "Abaia"                },
    { id = 5468, param = 3, bit = 26, name = "matsya"              , realname = "Matsya"               },
    { id = 5538, param = 3, bit = 27, name = "sekiryu"             , realname = "Sekiryu"              },
    { id = 5539, param = 3, bit = 28, name = "hakuryu"             , realname = "Hakuryu"              },
    { id = 5817, param = 3, bit = 29, name = "tiger_shark"         , realname = "Tiger Shark"          },
    { id = 5960, param = 3, bit = 30, name = "ulbukan_lobster"     , realname = "Ulbukan Lobster"      },
    { id = 5963, param = 3, bit = 31, name = "senroh_sardine"      , realname = "Senroh Sardine"       },
    { id = 5950, param = 4, bit = 0 , name = "mackerel"            , realname = "Mackerel"             },
    { id = 5993, param = 4, bit = 1 , name = "senroh_frog"         , realname = "Senroh Frog"          },
    { id = 5961, param = 4, bit = 2 , name = "contortopus"         , realname = "Contortopus"          },
    { id = 5949, param = 4, bit = 4 , name = "mussel"              , realname = "Mussel"               },
    { id = 5952, param = 4, bit = 5 , name = "ruddy_seema"         , realname = "Ruddy Seema"          },
    { id = 5948, param = 4, bit = 6 , name = "black_prawn"         , realname = "Black Prawn"          },
    { id = 5955, param = 4, bit = 7 , name = "yawning_catfish"     , realname = "Yawning Catfish"      },
    { id = 5995, param = 4, bit = 8 , name = "malicious_perch"     , realname = "Malicious Perch"      },
    { id = 6001, param = 4, bit = 9 , name = "clotflagration"      , realname = "Clotflagration"       },
    { id = 5951, param = 4, bit = 10, name = "bloodblotch"         , realname = "Bloodblotch"          },
    { id = 5959, param = 4, bit = 11, name = "dragonfish"          , realname = "Dragonfish"           },
    { id = 5997, param = 4, bit = 12, name = "shen"                , realname = "Shen"                 },
    { id = 5534, param = 4, bit = 13, name = "apkallufa"           , realname = "Apkallufa"            },
    { id = 5535, param = 4, bit = 14, name = "deademoiselle"       , realname = "Deademoiselle"        },
    { id = 5536, param = 4, bit = 15, name = "yorchete"            , realname = "Yorchete"             },
    { id = 6144, param = 4, bit = 16, name = "frigorifish"         , realname = "Frigorifish"          },
    { id = 6145, param = 4, bit = 17, name = "dwarf_remora"        , realname = "Dwarf Remora"         },
    { id = 6146, param = 4, bit = 18, name = "remora"              , realname = "Remora"               },
    { id = 6333, param = 4, bit = 19, name = "translucent_salpa"   , realname = "Translucent Salpa"    },
    { id = 6334, param = 4, bit = 20, name = "ra_kaznar_shellfish" , realname = "Ra'Kaznar Shellfish"  },
    { id = 6335, param = 4, bit = 21, name = "white_lobster"       , realname = "White Lobster"        },
    { id = 6336, param = 4, bit = 22, name = "bonefish"            , realname = "Bonefish"             },
    { id = 6337, param = 4, bit = 23, name = "thysanopeltis"       , realname = "Thysanopeltis"        },
    { id = 6338, param = 4, bit = 24, name = "cameroceras"         , realname = "Cameroceras"          },
    { id = 9077, param = 4, bit = 25, name = "duskcrawler"         , realname = "Duskcrawler"          },
    { id = 6376, param = 4, bit = 26, name = "tusoteuthis_longa"   , realname = "Tusoteuthis Longa"    },
    { id = 6373, param = 4, bit = 27, name = "ancient_carp"        , realname = "Ancient Carp"         },
    { id = 6372, param = 4, bit = 28, name = "lord_of_ulbuka"      , realname = "Lord of Ulbuka"       },
    { id = 6374, param = 4, bit = 29, name = "dragon_s_tabernacle" , realname = "Dragon's Tabernacle"  },
    { id = 6371, param = 4, bit = 30, name = "quicksilver_blade"   , realname = "Quicksilver Blade"    },
    { id = 6375, param = 4, bit = 31, name = "phantom_serpent"     , realname = "Phantom Serpent"      },
    { id = 9146, param = 5, bit = 0 , name = "ashen_crayfish"      , realname = "Ashen Crayfish"       },
    { id = 5953, param = 5, bit = 1 , name = "dragonfly_trout"     , realname = "Dragonfly Trout"      },
    { id = 5957, param = 5, bit = 2 , name = "shockfish"           , realname = "Shockfish"            },
    { id = 6489, param = 5, bit = 3 , name = "far_east_puffer"     , realname = "Far East Puffer"      },
    { id = 9216, param = 5, bit = 4 , name = "voidsnapper"         , realname = "Voidsnapper"          },
}

xi.fish.countFish = function (fishTable)
    local fishCount = 0
    for _, fish in pairs(fishTable) do
        fishCount = fishCount + utils.mask.countBits(fish)
    end

    return fishCount
end

xi.fish.findFishId = function (fishName)
    for _, fish in pairs(xi.fish.data) do
        if fish['name'] == fishName then
            return fish['id']
        end
    end

    return 0
end

xi.fish.isFish = function (itemid)
    for _, fish in pairs(xi.fish.data) do
        if fish['id'] == itemid then
            return true
        end
    end

    return false
end

xi.fish.getFishName = function (itemid)
    for _, fish in pairs(xi.fish.data) do
        if fish['id'] == itemid then
            return fish['realname']
        end
    end

    return nil
end
