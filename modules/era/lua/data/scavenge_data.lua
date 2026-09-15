-----------------------------------
-- Data file consumed by modules/era/globals/job_utils/ranger.lua for Scavenge zone pools
-- Sources: https://ffxiclopedia.fandom.com/wiki/Scavenge/Items, https://wiki.ffo.jp/html/2985.html
-----------------------------------

-- TODO: Just Firesand shared between all zones?
local commonItems =
{
    xi.item.JAR_OF_FIRESAND,
}

-- Ammunition containers by tier
-- Source: https://wiki.ffo.jp/html/2985.html
local ammoPools =
{
    TIER_1 = { xi.item.ROTTEN_QUIVER, xi.item.RUSTY_BOLT_CASE   },
    TIER_2 = { xi.item.OLD_QUIVER,    xi.item.OLD_BOLT_BOX      },
    TIER_3 = { xi.item.OLD_QUIVER_P1, xi.item.OLD_BOLT_BOX_P1   },
    TIER_4 = { xi.item.OLD_QUIVER_P2, xi.item.OLD_BULLET_BOX    },
    TIER_5 = { xi.item.OLD_QUIVER_P3, xi.item.OLD_BOLT_BOX_P2   },
    TIER_6 = { xi.item.OLD_QUIVER_P4, xi.item.OLD_BOLT_BOX_P3   },
    TIER_7 = { xi.item.OLD_QUIVER_P5, xi.item.OLD_BOLT_BOX_P4   },
    TIER_8 = { xi.item.OLD_QUIVER_P6, xi.item.OLD_BULLET_BOX_P1 },
    TIER_9 = { xi.item.OLD_QUIVER_P7, xi.item.OLD_BOLT_BOX_P5   },
}

-- Zone-specific scavenge pools: arrowheads, bolt heads, fletchings, and lumber per zone tier
local scavengePools =
{
    -- General Zone Pool Tiers
    OUTDOOR_1       = { xi.item.HANDFUL_OF_STONE_ARROWHEADS,    xi.item.HANDFUL_OF_BRONZE_BOLT_HEADS,    xi.item.BAG_OF_CHOCOBO_FLETCHINGS,       xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    OUTDOOR_2       = { xi.item.HANDFUL_OF_BONE_ARROWHEADS,     xi.item.HANDFUL_OF_BLIND_BOLT_HEADS,     xi.item.BAG_OF_YAGUDO_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    OUTDOOR_3       = { xi.item.HANDFUL_OF_FANG_ARROWHEADS,     xi.item.HANDFUL_OF_ACID_BOLT_HEADS,      xi.item.BAG_OF_YAGUDO_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    OUTDOOR_4       = { xi.item.HANDFUL_OF_SILVER_ARROWHEADS,   xi.item.HANDFUL_OF_VENOM_BOLT_HEADS,     xi.item.BAG_OF_YAGUDO_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    OUTDOOR_5       = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_DARKSTEEL_BOLT_HEADS, xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    DUNGEON_1       = { xi.item.HANDFUL_OF_BONE_ARROWHEADS,     xi.item.HANDFUL_OF_BLIND_BOLT_HEADS,     xi.item.BAG_OF_CHOCOBO_FLETCHINGS,       xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    DUNGEON_2       = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_VENOM_BOLT_HEADS,     xi.item.BAG_OF_BLACK_CHOCOBO_FLETCHINGS, xi.item.PIECE_OF_ASH_LUMBER       },
    DUNGEON_3       = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    DUNGEON_4       = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },

    -- Zone Specific Pools
    ROTZ_COP        = { xi.item.HANDFUL_OF_HORN_ARROWHEADS,     xi.item.HANDFUL_OF_HOLY_BOLT_HEADS,      xi.item.BAG_OF_BIRD_FLETCHINGS,          xi.item.PIECE_OF_ASH_LUMBER       },
    VALKURM         = { xi.item.HANDFUL_OF_BONE_ARROWHEADS,     xi.item.HANDFUL_OF_ACID_BOLT_HEADS,      xi.item.BAG_OF_YAGUDO_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    MOVALPOLOS      = { xi.item.HANDFUL_OF_SILVER_ARROWHEADS,   xi.item.HANDFUL_OF_VENOM_BOLT_HEADS,     xi.item.BAG_OF_YAGUDO_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    WEST_ALTEPA     = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_HOLY_BOLT_HEADS,      xi.item.BAG_OF_BIRD_FLETCHINGS,          xi.item.PIECE_OF_ASH_LUMBER       },
    QUICKSAND       = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_HOLY_BOLT_HEADS,      xi.item.BAG_OF_BIRD_FLETCHINGS,          xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    TOAU_OUTDOORS   = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_VENOM_BOLT_HEADS,     xi.item.BAG_OF_BLACK_CHOCOBO_FLETCHINGS, xi.item.PIECE_OF_ASH_LUMBER       },
    HALVUNG_TULIA   = { xi.item.HANDFUL_OF_DEMON_ARROWHEADS,    xi.item.HANDFUL_OF_DARKSTEEL_BOLT_HEADS, xi.item.BAG_OF_BLACK_CHOCOBO_FLETCHINGS, xi.item.PIECE_OF_ASH_LUMBER       },

    -- WotG Zones
    SANDY_WOTG      = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    BASTOK_WOTG     = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    FORT_KARUGO_S   = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    WINDY_WOTG      = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    NORTHLANDS_WOTG = { xi.item.HANDFUL_OF_DEMON_ARROWHEADS,    xi.item.HANDFUL_OF_DARKSTEEL_BOLT_HEADS, xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
}

-- Zone-to-pool mapping
local function zonePool(scavengePool, ammoPool)
    return
    {
        scavengePool = scavengePool,
        ammoPool     = ammoPool,
    }
end

local zonePoolMap =
{
    -- Starter Zones
    [xi.zone.EAST_RONFAURE            ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.WEST_RONFAURE            ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.NORTH_GUSTABERG          ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.SOUTH_GUSTABERG          ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.WEST_SARUTABARUTA        ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.EAST_SARUTABARUTA        ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),

    -- Starter Dungeons/Beastmen Zones
    [xi.zone.YUGHOTT_GROTTO           ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_2),
    [xi.zone.FORT_GHELSBA             ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_2),
    [xi.zone.GHELSBA_OUTPOST          ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_2),
    [xi.zone.KING_RANPERRES_TOMB      ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_2),
    [xi.zone.DANGRUF_WADI             ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_1),
    [xi.zone.PALBOROUGH_MINES         ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_2),
    [xi.zone.GIDDEUS                  ] = zonePool(scavengePools.OUTDOOR_1,       ammoPools.TIER_2),
    [xi.zone.INNER_HORUTOTO_RUINS     ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_1),
    [xi.zone.OUTER_HORUTOTO_RUINS     ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_1),
    [xi.zone.KORROLOKA_TUNNEL         ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_4),

    -- Intermediate Outdoor Zones
    [xi.zone.LA_THEINE_PLATEAU        ] = zonePool(scavengePools.OUTDOOR_2,       ammoPools.TIER_2),
    [xi.zone.KONSCHTAT_HIGHLANDS      ] = zonePool(scavengePools.OUTDOOR_2,       ammoPools.TIER_2),
    [xi.zone.VALKURM_DUNES            ] = zonePool(scavengePools.VALKURM,         ammoPools.TIER_3),
    [xi.zone.TAHRONGI_CANYON          ] = zonePool(scavengePools.OUTDOOR_2,       ammoPools.TIER_2),
    [xi.zone.BUBURIMU_PENINSULA       ] = zonePool(scavengePools.OUTDOOR_2,       ammoPools.TIER_3),

    -- Intermediate Dungeons
    [xi.zone.ORDELLES_CAVES           ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_3),
    [xi.zone.MAZE_OF_SHAKHRAMI        ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_3),
    [xi.zone.RANGUEMONT_PASS          ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_1),
    [xi.zone.GUSGEN_MINES             ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_3),
    [xi.zone.LOWER_DELKFUTTS_TOWER    ] = zonePool(scavengePools.DUNGEON_1,       ammoPools.TIER_4),

    -- Mid-level field zones
    [xi.zone.QUFIM_ISLAND             ] = zonePool(scavengePools.OUTDOOR_2,       ammoPools.TIER_4),
    [xi.zone.JUGNER_FOREST            ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_3),
    [xi.zone.PASHHOW_MARSHLANDS       ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_3),
    [xi.zone.MERIPHATAUD_MOUNTAINS    ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_3),
    [xi.zone.SAUROMUGUE_CHAMPAIGN     ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_4),
    [xi.zone.BIBIKI_BAY               ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_5),
    [xi.zone.MISAREAUX_COAST          ] = zonePool(scavengePools.OUTDOOR_3,       ammoPools.TIER_4),
    [xi.zone.BATALLIA_DOWNS           ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.ROLANBERRY_FIELDS        ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.LUFAISE_MEADOWS          ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_6),
    [xi.zone.THE_SANCTUARY_OF_ZITAH   ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),

    -- Mid-level dungeons
    [xi.zone.DAVOI                    ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.BEADEAUX                 ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.QULUN_DOME               ] = zonePool(scavengePools.DUNGEON_2,       ammoPools.TIER_5),
    [xi.zone.CASTLE_OZTROJA           ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.THE_ELDIEME_NECROPOLIS   ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_6),
    [xi.zone.GARLAIGE_CITADEL         ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_6),
    [xi.zone.MONASTIC_CAVERN          ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_5),
    [xi.zone.BOSTAUNIEUX_OUBLIETTE    ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_8),
    [xi.zone.TORAIMARAI_CANAL         ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_7),
    [xi.zone.MIDDLE_DELKFUTTS_TOWER   ] = zonePool(scavengePools.DUNGEON_3,       ammoPools.TIER_4),
    [xi.zone.OLDTON_MOVALPOLOS        ] = zonePool(scavengePools.MOVALPOLOS,      ammoPools.TIER_4),
    [xi.zone.NEWTON_MOVALPOLOS        ] = zonePool(scavengePools.MOVALPOLOS,      ammoPools.TIER_9),

    -- High-level field zones
    [xi.zone.BEAUCEDINE_GLACIER       ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_5),
    [xi.zone.XARCABARD                ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_7),
    [xi.zone.CARPENTERS_LANDING       ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_3),
    [xi.zone.CAPE_TERIGGAN            ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_9),
    [xi.zone.BEHEMOTHS_DOMINION       ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_5),
    [xi.zone.VALLEY_OF_SORROWS        ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_9),
    [xi.zone.ROMAEVE                  ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_9),
    [xi.zone.ULEGUERAND_RANGE         ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_9),
    [xi.zone.THE_BOYAHDA_TREE         ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_9),

    -- High-level dungeons
    [xi.zone.CRAWLERS_NEST            ] = zonePool(scavengePools.DUNGEON_4,       ammoPools.TIER_6),
    [xi.zone.SEA_SERPENT_GROTTO       ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_5),
    [xi.zone.FEIYIN                   ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_6),
    [xi.zone.LABYRINTH_OF_ONZOZO      ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),
    [xi.zone.GUSTAV_TUNNEL            ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_6),
    [xi.zone.CASTLE_ZVAHL_BAILEYS     ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_7),
    [xi.zone.CASTLE_ZVAHL_KEEP        ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_7),
    [xi.zone.UPPER_DELKFUTTS_TOWER    ] = zonePool(scavengePools.OUTDOOR_5,       ammoPools.TIER_5),

    -- Zilart zones
    [xi.zone.EASTERN_ALTEPA_DESERT    ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_5),
    [xi.zone.WESTERN_ALTEPA_DESERT    ] = zonePool(scavengePools.WEST_ALTEPA,     ammoPools.TIER_6),
    [xi.zone.YUHTUNGA_JUNGLE          ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_4),
    [xi.zone.YHOATOR_JUNGLE           ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_5),
    [xi.zone.TEMPLE_OF_UGGALEPIH      ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_8),
    [xi.zone.DEN_OF_RANCOR            ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_8),
    [xi.zone.IFRITS_CAULDRON          ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_9),
    [xi.zone.QUICKSAND_CAVES          ] = zonePool(scavengePools.QUICKSAND,       ammoPools.TIER_8),
    [xi.zone.KUFTAL_TUNNEL            ] = zonePool(scavengePools.DUNGEON_4,       ammoPools.TIER_8),
    [xi.zone.DRAGONS_AERY             ] = zonePool(scavengePools.HALVUNG_TULIA,   ammoPools.TIER_9),
    [xi.zone.RUAUN_GARDENS            ] = zonePool(scavengePools.HALVUNG_TULIA,   ammoPools.TIER_9),

    -- Chains of Promathia zones
    [xi.zone.ATTOHWA_CHASM            ] = zonePool(scavengePools.ROTZ_COP,        ammoPools.TIER_5),
    [xi.zone.PSOXJA                   ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_6),
    [xi.zone.PHOMIUNA_AQUEDUCTS       ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_4),
    [xi.zone.SACRARIUM                ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_6),
    [xi.zone.RIVERNE_SITE_A01         ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_5),
    [xi.zone.RIVERNE_SITE_B01         ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),

    -- Aht Urhgan field zones
    [xi.zone.BHAFLAU_THICKETS         ] = zonePool(scavengePools.TOAU_OUTDOORS,   ammoPools.TIER_8),
    [xi.zone.WAJAOM_WOODLANDS         ] = zonePool(scavengePools.TOAU_OUTDOORS,   ammoPools.TIER_8),
    [xi.zone.CAEDARVA_MIRE            ] = zonePool(scavengePools.TOAU_OUTDOORS,   ammoPools.TIER_8),
    [xi.zone.ARRAPAGO_REEF            ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),
    [xi.zone.MOUNT_ZHAYOLM            ] = zonePool(scavengePools.HALVUNG_TULIA,   ammoPools.TIER_9),

    -- Aht Urhgan dungeons
    [xi.zone.HALVUNG                  ] = zonePool(scavengePools.HALVUNG_TULIA,   ammoPools.TIER_9),
    [xi.zone.MAMOOK                   ] = zonePool(scavengePools.DUNGEON_4,       ammoPools.TIER_8),
    [xi.zone.AYDEEWA_SUBTERRANE       ] = zonePool(scavengePools.DUNGEON_4,       ammoPools.TIER_8),

    -- Wings of the Goddess zones
    -- San d'Oria Path
    [xi.zone.EAST_RONFAURE_S          ] = zonePool(scavengePools.SANDY_WOTG,      ammoPools.TIER_7),
    [xi.zone.JUGNER_FOREST_S          ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),
    [xi.zone.BATALLIA_DOWNS_S         ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),
    [xi.zone.LA_VAULE_S               ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),
    [xi.zone.THE_ELDIEME_NECROPOLIS_S ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),

    -- Bastok Path
    [xi.zone.NORTH_GUSTABERG_S        ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_7),
    [xi.zone.ROLANBERRY_FIELDS_S      ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),
    [xi.zone.BEADEAUX_S               ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),
    [xi.zone.CRAWLERS_NEST_S          ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),
    [xi.zone.PASHHOW_MARSHLANDS_S     ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),
    [xi.zone.VUNKERL_INLET_S          ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),
    [xi.zone.GRAUBERG_S               ] = zonePool(scavengePools.BASTOK_WOTG,     ammoPools.TIER_8),

    -- Windurst Path
    [xi.zone.WEST_SARUTABARUTA_S      ] = zonePool(scavengePools.WINDY_WOTG,      ammoPools.TIER_7),
    [xi.zone.FORT_KARUGO_NARUGO_S     ] = zonePool(scavengePools.FORT_KARUGO_S,   ammoPools.TIER_8),
    [xi.zone.MERIPHATAUD_MOUNTAINS_S  ] = zonePool(scavengePools.WINDY_WOTG,      ammoPools.TIER_8),
    [xi.zone.SAUROMUGUE_CHAMPAIGN_S   ] = zonePool(scavengePools.WINDY_WOTG,      ammoPools.TIER_8),
    [xi.zone.CASTLE_OZTROJA_S         ] = zonePool(scavengePools.WINDY_WOTG,      ammoPools.TIER_8),
    [xi.zone.GARLAIGE_CITADEL_S       ] = zonePool(scavengePools.OUTDOOR_4,       ammoPools.TIER_8),

    -- Northlands Path
    [xi.zone.BEAUCEDINE_GLACIER_S     ] = zonePool(scavengePools.NORTHLANDS_WOTG, ammoPools.TIER_9),
    [xi.zone.XARCABARD_S              ] = zonePool(scavengePools.NORTHLANDS_WOTG, ammoPools.TIER_9),
    [xi.zone.CASTLE_ZVAHL_BAILEYS_S   ] = zonePool(scavengePools.NORTHLANDS_WOTG, ammoPools.TIER_9),
    [xi.zone.CASTLE_ZVAHL_KEEP_S      ] = zonePool(scavengePools.NORTHLANDS_WOTG, ammoPools.TIER_9),
}

return
{
    commonItems = commonItems,
    zonePoolMap = zonePoolMap,
}
