-----------------------------------
-- Data file consumed by job_adjustments.lua for Scavenge zone pools
-- Source: https://ffxiclopedia.fandom.com/wiki/Scavenge/Items
-----------------------------------

-- Items available from Scavenge in all zones
local guaranteedItems =
{
    xi.item.JAR_OF_FIRESAND,
    xi.item.OLD_QUIVER,
    xi.item.OLD_BOLT_BOX,
    xi.item.OLD_BULLET_BOX,
    xi.item.ROTTEN_QUIVER,
    xi.item.RUSTY_BOLT_CASE,
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
    HALVUNG         = { xi.item.HANDFUL_OF_DEMON_ARROWHEADS,    xi.item.HANDFUL_OF_DARKSTEEL_BOLT_HEADS, xi.item.BAG_OF_BLACK_CHOCOBO_FLETCHINGS, xi.item.PIECE_OF_ASH_LUMBER       },

    -- WotG Zones
    SANDY_WOTG      = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    BASTOK_WOTG     = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
    FORT_KARUGO_S   = { xi.item.HANDFUL_OF_ARMORED_ARROWHEADS,  xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    WINDY_WOTG      = { xi.item.HANDFUL_OF_SCORPION_ARROWHEADS, xi.item.HANDFUL_OF_MYTHRIL_BOLT_HEADS,   xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ARROWWOOD_LUMBER },
    NORTHLANDS_WOTG = { xi.item.HANDFUL_OF_DEMON_ARROWHEADS,    xi.item.HANDFUL_OF_DARKSTEEL_BOLT_HEADS, xi.item.BAG_OF_INSECT_FLETCHINGS,        xi.item.PIECE_OF_ASH_LUMBER       },
}

-- Zone-to-pool mapping
local zonePoolMap =
{
    -- Starter Zones
    [xi.zone.EAST_RONFAURE     ] = scavengePools.OUTDOOR_1,
    [xi.zone.WEST_RONFAURE     ] = scavengePools.OUTDOOR_1,
    [xi.zone.NORTH_GUSTABERG   ] = scavengePools.OUTDOOR_1,
    [xi.zone.SOUTH_GUSTABERG   ] = scavengePools.OUTDOOR_1,
    [xi.zone.WEST_SARUTABARUTA ] = scavengePools.OUTDOOR_1,
    [xi.zone.EAST_SARUTABARUTA ] = scavengePools.OUTDOOR_1,

    -- Starter Dungeons/Beastmen Zones
    [xi.zone.YUGHOTT_GROTTO       ] = scavengePools.OUTDOOR_1,
    [xi.zone.FORT_GHELSBA         ] = scavengePools.OUTDOOR_1,
    [xi.zone.GHELSBA_OUTPOST      ] = scavengePools.OUTDOOR_1,
    [xi.zone.KING_RANPERRES_TOMB  ] = scavengePools.DUNGEON_1,
    [xi.zone.DANGRUF_WADI         ] = scavengePools.OUTDOOR_1,
    [xi.zone.PALBOROUGH_MINES     ] = scavengePools.DUNGEON_1,
    [xi.zone.GIDDEUS              ] = scavengePools.OUTDOOR_1,
    [xi.zone.INNER_HORUTOTO_RUINS ] = scavengePools.DUNGEON_1,
    [xi.zone.OUTER_HORUTOTO_RUINS ] = scavengePools.DUNGEON_1,
    [xi.zone.KORROLOKA_TUNNEL     ] = scavengePools.DUNGEON_1,

    -- Intermediate Outdoor Zones
    [xi.zone.LA_THEINE_PLATEAU   ] = scavengePools.OUTDOOR_2,
    [xi.zone.KONSCHTAT_HIGHLANDS ] = scavengePools.OUTDOOR_2,
    [xi.zone.VALKURM_DUNES       ] = scavengePools.VALKURM,
    [xi.zone.TAHRONGI_CANYON     ] = scavengePools.OUTDOOR_2,
    [xi.zone.BUBURIMU_PENINSULA  ] = scavengePools.OUTDOOR_2,

    -- Intermediate Dungeons
    [xi.zone.ORDELLES_CAVES        ] = scavengePools.DUNGEON_1,
    [xi.zone.MAZE_OF_SHAKHRAMI     ] = scavengePools.DUNGEON_1,
    [xi.zone.RANGUEMONT_PASS       ] = scavengePools.DUNGEON_1,
    [xi.zone.GUSGEN_MINES          ] = scavengePools.DUNGEON_1,
    [xi.zone.LOWER_DELKFUTTS_TOWER ] = scavengePools.DUNGEON_1,

    -- Mid-level field zones
    [xi.zone.QUFIM_ISLAND           ] = scavengePools.OUTDOOR_2,
    [xi.zone.JUGNER_FOREST          ] = scavengePools.OUTDOOR_3,
    [xi.zone.PASHHOW_MARSHLANDS     ] = scavengePools.OUTDOOR_3,
    [xi.zone.MERIPHATAUD_MOUNTAINS  ] = scavengePools.OUTDOOR_3,
    [xi.zone.SAUROMUGUE_CHAMPAIGN   ] = scavengePools.OUTDOOR_3,
    [xi.zone.BIBIKI_BAY             ] = scavengePools.OUTDOOR_3,
    [xi.zone.MISAREAUX_COAST        ] = scavengePools.OUTDOOR_3,
    [xi.zone.BATALLIA_DOWNS         ] = scavengePools.OUTDOOR_4,
    [xi.zone.ROLANBERRY_FIELDS      ] = scavengePools.OUTDOOR_4,
    [xi.zone.LUFAISE_MEADOWS        ] = scavengePools.OUTDOOR_4,
    [xi.zone.THE_SANCTUARY_OF_ZITAH ] = scavengePools.OUTDOOR_4,

    -- Mid-level dungeons
    [xi.zone.DAVOI                  ] = scavengePools.OUTDOOR_4,
    [xi.zone.BEADEAUX               ] = scavengePools.OUTDOOR_4,
    [xi.zone.QULUN_DOME             ] = scavengePools.DUNGEON_2,
    [xi.zone.CASTLE_OZTROJA         ] = scavengePools.OUTDOOR_4,
    [xi.zone.THE_ELDIEME_NECROPOLIS ] = scavengePools.DUNGEON_3,
    [xi.zone.GARLAIGE_CITADEL       ] = scavengePools.DUNGEON_3,
    [xi.zone.MONASTIC_CAVERN        ] = scavengePools.DUNGEON_3,
    [xi.zone.BOSTAUNIEUX_OUBLIETTE  ] = scavengePools.DUNGEON_3,
    [xi.zone.TORAIMARAI_CANAL       ] = scavengePools.DUNGEON_3,
    [xi.zone.MIDDLE_DELKFUTTS_TOWER ] = scavengePools.DUNGEON_3,
    [xi.zone.OLDTON_MOVALPOLOS      ] = scavengePools.MOVALPOLOS,
    [xi.zone.NEWTON_MOVALPOLOS      ] = scavengePools.MOVALPOLOS,

    -- High-level field zones
    [xi.zone.BEAUCEDINE_GLACIER ] = scavengePools.OUTDOOR_5,
    [xi.zone.XARCABARD          ] = scavengePools.OUTDOOR_5,
    [xi.zone.CARPENTERS_LANDING ] = scavengePools.OUTDOOR_4,
    [xi.zone.CAPE_TERIGGAN      ] = scavengePools.OUTDOOR_5,
    [xi.zone.BEHEMOTHS_DOMINION ] = scavengePools.OUTDOOR_4,
    [xi.zone.VALLEY_OF_SORROWS  ] = scavengePools.OUTDOOR_5,
    [xi.zone.ROMAEVE            ] = scavengePools.OUTDOOR_5,
    [xi.zone.ULEGUERAND_RANGE   ] = scavengePools.OUTDOOR_5,
    [xi.zone.THE_BOYAHDA_TREE   ] = scavengePools.OUTDOOR_5,

    -- High-level dungeons
    [xi.zone.CRAWLERS_NEST         ] = scavengePools.DUNGEON_4,
    [xi.zone.SEA_SERPENT_GROTTO    ] = scavengePools.OUTDOOR_4,
    [xi.zone.FEIYIN                ] = scavengePools.OUTDOOR_4,
    [xi.zone.LABYRINTH_OF_ONZOZO   ] = scavengePools.OUTDOOR_4,
    [xi.zone.GUSTAV_TUNNEL         ] = scavengePools.OUTDOOR_4,
    [xi.zone.CASTLE_ZVAHL_BAILEYS  ] = scavengePools.OUTDOOR_5,
    [xi.zone.CASTLE_ZVAHL_KEEP     ] = scavengePools.OUTDOOR_5,
    [xi.zone.UPPER_DELKFUTTS_TOWER ] = scavengePools.OUTDOOR_5,

    -- Zilart zones
    [xi.zone.EASTERN_ALTEPA_DESERT ] = scavengePools.ROTZ_COP,
    [xi.zone.WESTERN_ALTEPA_DESERT ] = scavengePools.WEST_ALTEPA,
    [xi.zone.YUHTUNGA_JUNGLE       ] = scavengePools.ROTZ_COP,
    [xi.zone.YHOATOR_JUNGLE        ] = scavengePools.ROTZ_COP,
    [xi.zone.TEMPLE_OF_UGGALEPIH   ] = scavengePools.ROTZ_COP,
    [xi.zone.DEN_OF_RANCOR         ] = scavengePools.ROTZ_COP,
    [xi.zone.IFRITS_CAULDRON       ] = scavengePools.ROTZ_COP,
    [xi.zone.QUICKSAND_CAVES       ] = scavengePools.QUICKSAND,
    [xi.zone.KUFTAL_TUNNEL         ] = scavengePools.DUNGEON_4,

    -- Chains of Promathia zones
    [xi.zone.ATTOHWA_CHASM      ] = scavengePools.ROTZ_COP,
    [xi.zone.PSOXJA             ] = scavengePools.OUTDOOR_4,
    [xi.zone.PHOMIUNA_AQUEDUCTS ] = scavengePools.OUTDOOR_4,
    [xi.zone.SACRARIUM          ] = scavengePools.OUTDOOR_4,
    [xi.zone.RIVERNE_SITE_A01   ] = scavengePools.OUTDOOR_4,
    [xi.zone.RIVERNE_SITE_B01   ] = scavengePools.OUTDOOR_4,

    -- Aht Urhgan field zones
    [xi.zone.BHAFLAU_THICKETS ] = scavengePools.TOAU_OUTDOORS,
    [xi.zone.WAJAOM_WOODLANDS ] = scavengePools.TOAU_OUTDOORS,
    [xi.zone.CAEDARVA_MIRE    ] = scavengePools.TOAU_OUTDOORS,
    [xi.zone.ARRAPAGO_REEF    ] = scavengePools.OUTDOOR_4,
    [xi.zone.MOUNT_ZHAYOLM    ] = scavengePools.HALVUNG,

    -- Aht Urhgan dungeons
    [xi.zone.HALVUNG            ] = scavengePools.HALVUNG,
    [xi.zone.MAMOOK             ] = scavengePools.DUNGEON_4,
    [xi.zone.AYDEEWA_SUBTERRANE ] = scavengePools.DUNGEON_4,

    -- Wings of the Goddess zones
    -- San d'Oria Path
    [xi.zone.EAST_RONFAURE_S          ] = scavengePools.SANDY_WOTG,
    [xi.zone.JUGNER_FOREST_S          ] = scavengePools.OUTDOOR_4,
    [xi.zone.BATALLIA_DOWNS_S         ] = scavengePools.OUTDOOR_4,
    [xi.zone.LA_VAULE_S               ] = scavengePools.OUTDOOR_4,
    [xi.zone.THE_ELDIEME_NECROPOLIS_S ] = scavengePools.OUTDOOR_4,

    -- Bastok Path
    [xi.zone.NORTH_GUSTABERG_S    ] = scavengePools.BASTOK_WOTG,
    [xi.zone.ROLANBERRY_FIELDS_S  ] = scavengePools.BASTOK_WOTG,
    [xi.zone.BEADEAUX_S           ] = scavengePools.BASTOK_WOTG,
    [xi.zone.CRAWLERS_NEST_S      ] = scavengePools.BASTOK_WOTG,
    [xi.zone.PASHHOW_MARSHLANDS_S ] = scavengePools.BASTOK_WOTG,
    [xi.zone.VUNKERL_INLET_S      ] = scavengePools.BASTOK_WOTG,
    [xi.zone.GRAUBERG_S           ] = scavengePools.BASTOK_WOTG,

    -- Windurst Path
    [xi.zone.WEST_SARUTABARUTA_S     ] = scavengePools.WINDY_WOTG,
    [xi.zone.FORT_KARUGO_NARUGO_S    ] = scavengePools.FORT_KARUGO_S,
    [xi.zone.MERIPHATAUD_MOUNTAINS_S ] = scavengePools.WINDY_WOTG,
    [xi.zone.SAUROMUGUE_CHAMPAIGN_S  ] = scavengePools.WINDY_WOTG,
    [xi.zone.CASTLE_OZTROJA_S        ] = scavengePools.WINDY_WOTG,
    [xi.zone.GARLAIGE_CITADEL_S      ] = scavengePools.OUTDOOR_4,

    -- Northlands Path
    [xi.zone.BEAUCEDINE_GLACIER_S   ] = scavengePools.NORTHLANDS_WOTG,
    [xi.zone.XARCABARD_S            ] = scavengePools.NORTHLANDS_WOTG,
    [xi.zone.CASTLE_ZVAHL_BAILEYS_S ] = scavengePools.NORTHLANDS_WOTG,
    [xi.zone.CASTLE_ZVAHL_KEEP_S    ] = scavengePools.NORTHLANDS_WOTG,
}

return
{
    guaranteedItems = guaranteedItems,
    zonePoolMap     = zonePoolMap,
}
