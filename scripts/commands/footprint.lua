-----------------------------------
-- func: !footprint
-- desc: Tells the the player if they've acquired a particular footprint, or tells them a random unacquired Goblin Footprint.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 'b'
}

local zonesWithGoblinFootprint =
{
    -- Vanilla areas
    xi.zone.ALTAR_ROOM,
    xi.zone.BALGAS_DAIS,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.BEADEAUX,
    xi.zone.BEAUCEDINE_GLACIER,
    xi.zone.BOSTAUNIEUX_OUBLIETTE,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.CASTLE_OZTROJA,
    xi.zone.CASTLE_ZVAHL_BAILEYS,
    xi.zone.CASTLE_ZVAHL_KEEP,
    xi.zone.CRAWLERS_NEST,
    xi.zone.DANGRUF_WADI,
    xi.zone.DAVOI,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.THE_ELDIEME_NECROPOLIS,
    xi.zone.FEIYIN,
    xi.zone.FULL_MOON_FOUNTAIN,
    xi.zone.GARLAIGE_CITADEL,
    xi.zone.GHELSBA_OUTPOST,
    xi.zone.GIDDEUS,
    xi.zone.GUSGEN_MINES,
    xi.zone.HORLAIS_PEAK,
    xi.zone.INNER_HORUTOTO_RUINS,
    xi.zone.JUGNER_FOREST,
    xi.zone.KING_RANPERRES_TOMB,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.LOWER_DELKFUTTS_TOWER,
    xi.zone.MAZE_OF_SHAKHRAMI,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.MIDDLE_DELKFUTTS_TOWER,
    xi.zone.MONASTIC_CAVERN,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.ORDELLES_CAVES,
    xi.zone.OUTER_HORUTOTO_RUINS,
    xi.zone.PALBOROUGH_MINES,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.QUBIA_ARENA,
    xi.zone.QUFIM_ISLAND,
    xi.zone.QULUN_DOME,
    xi.zone.RANGUEMONT_PASS,
    xi.zone.ROLANBERRY_FIELDS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.TORAIMARAI_CANAL,
    xi.zone.THRONE_ROOM,
    xi.zone.VALKURM_DUNES,
    xi.zone.WAUGHROON_SHRINE,
    xi.zone.WEST_RONFAURE,
    xi.zone.WEST_SARUTABARUTA,
    xi.zone.XARCABARD,
    xi.zone.YUGHOTT_GROTTO,
    xi.zone.ZERUHN_MINES,
    -- Zilart areas
    xi.zone.THE_BOYAHDA_TREE,
    xi.zone.CAPE_TERIGGAN,
    xi.zone.THE_CELESTIAL_NEXUS,
    xi.zone.CHAMBER_OF_ORACLES,
    xi.zone.CLOISTER_OF_FLAMES,
    xi.zone.CLOISTER_OF_FROST,
    xi.zone.CLOISTER_OF_GALES,
    xi.zone.CLOISTER_OF_STORMS,
    xi.zone.CLOISTER_OF_TIDES,
    xi.zone.CLOISTER_OF_TREMORS,
    xi.zone.DRAGONS_AERY,
    xi.zone.GUSTAV_TUNNEL,
    xi.zone.HALL_OF_THE_GODS,
    xi.zone.IFRITS_CAULDRON,
    xi.zone.KORROLOKA_TUNNEL,
    xi.zone.KUFTAL_TUNNEL,
    xi.zone.LALOFF_AMPHITHEATER,
    xi.zone.QUICKSAND_CAVES,
    xi.zone.ROMAEVE,
    xi.zone.RUAUN_GARDENS,
    xi.zone.SACRIFICIAL_CHAMBER,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.SEA_SERPENT_GROTTO,
    xi.zone.THE_SHRINE_OF_RUAVITAU,
    xi.zone.STELLAR_FULCRUM,
    xi.zone.TEMPLE_OF_UGGALEPIH,
    xi.zone.WESTERN_ALTEPA_DESERT,
    xi.zone.VALLEY_OF_SORROWS,
    xi.zone.YUHTUNGA_JUNGLE,
    -- Promathia areas
    xi.zone.ALTAIEU,
    xi.zone.BEARCLAW_PINNACLE,
    xi.zone.BIBIKI_BAY,
    xi.zone.BONEYARD_GULLY,
    xi.zone.CARPENTERS_LANDING,
    xi.zone.EMPYREAL_PARADOX,
    xi.zone.THE_GARDEN_OF_RUHMET,
    xi.zone.GRAND_PALACE_OF_HUXZOI,
    xi.zone.HALL_OF_TRANSFERENCE,
    xi.zone.LUFAISE_MEADOWS,
    xi.zone.MINE_SHAFT_2716,
    xi.zone.MISAREAUX_COAST,
    xi.zone.MONARCH_LINN,
    xi.zone.OLDTON_MOVALPOLOS,
    xi.zone.PHOMIUNA_AQUEDUCTS,
    xi.zone.PROMYVION_VAHZL,
    xi.zone.PSOXJA,
    xi.zone.RIVERNE_SITE_A01,
    xi.zone.RIVERNE_SITE_B01,
    xi.zone.SACRARIUM,
    xi.zone.THE_SHROUDED_MAW,
    xi.zone.SPIRE_OF_DEM,
    xi.zone.SPIRE_OF_HOLLA,
    xi.zone.SPIRE_OF_MEA,
    xi.zone.SPIRE_OF_VAHZL,
    xi.zone.ULEGUERAND_RANGE,
    -- Aht Urhgan areas
    xi.zone.ALZADAAL_UNDERSEA_RUINS,
    xi.zone.AL_ZAHBI,
    xi.zone.ARRAPAGO_REEF,
    xi.zone.AYDEEWA_SUBTERRANE,
    xi.zone.BHAFLAU_THICKETS,
    xi.zone.CAEDARVA_MIRE,
    xi.zone.HALVUNG,
    xi.zone.HAZHALM_TESTING_GROUNDS,
    xi.zone.JADE_SEPULCHER,
    xi.zone.MAMOOK,
    xi.zone.MOUNT_ZHAYOLM,
    xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    xi.zone.TALACCA_COVE,
    xi.zone.WAJAOM_WOODLANDS,
    -- Wings areas
    xi.zone.BATALLIA_DOWNS_S,
    xi.zone.BEADEAUX_S,
    xi.zone.BEAUCEDINE_GLACIER_S,
    xi.zone.CASTLE_OZTROJA_S,
    xi.zone.CASTLE_ZVAHL_BAILEYS_S,
    xi.zone.CASTLE_ZVAHL_KEEP_S,
    xi.zone.CRAWLERS_NEST_S,
    xi.zone.EAST_RONFAURE_S,
    xi.zone.THE_ELDIEME_NECROPOLIS_S,
    xi.zone.FORT_KARUGO_NARUGO_S,
    xi.zone.GARLAIGE_CITADEL_S,
    xi.zone.GRAUBERG_S,
    xi.zone.JUGNER_FOREST_S,
    xi.zone.LA_VAULE_S,
    xi.zone.MERIPHATAUD_MOUNTAINS_S,
    xi.zone.NORTH_GUSTABERG_S,
    xi.zone.PASHHOW_MARSHLANDS_S,
    xi.zone.ROLANBERRY_FIELDS_S,
    xi.zone.SAUROMUGUE_CHAMPAIGN_S,
    -- xi.zone.THRONE_ROOM_S,
    xi.zone.VUNKERL_INLET_S,
    -- xi.zone.WALK_OF_ECHOES,
    xi.zone.WEST_SARUTABARUTA_S,
    xi.zone.XARCABARD_S,
    -- Adoulin areas
    -- xi.zone.CEIZAK_BATTLEGROUNDS,
    -- xi.zone.CIRDAS_CAVERNS,
    -- xi.zone.DHO_GATES,
    -- xi.zone.FORET_DE_HENNETIEL,
    -- xi.zone.KAMIHR_DRIFTS,
    -- xi.zone.LEAFALLIA,
    -- xi.zone.MARJAMI_RAVINE,
    -- xi.zone.MOG_GARDEN,
    -- xi.zone.MOH_GATES,
    -- xi.zone.MORIMAR_BASALT_FIELDS,
    -- xi.zone.OUTER_RAKAZNAR,
    -- xi.zone.RAKAZNAR_INNER_COURT,
    -- xi.zone.RAKAZNAR_TURRIS,
    -- xi.zone.SIH_GATES,
    -- xi.zone.WOH_GATES,
    -- xi.zone.YAHSE_HUNTING_GROUNDS,
    -- xi.zone.YORCIA_WEALD,
    -- Other areas
    -- xi.zone.ABYSSEA_EMPYREAL_PARADOX,
    -- xi.zone.DESUETIA_EMPYREAL_PARADOX,
    -- xi.zone.ESCHA_RUAUN,
    -- xi.zone.ESCHA_ZITAH,
    -- xi.zone.FERETORY,
    xi.zone.PROVENANCE,
    -- xi.zone.REISENJIMA,
    -- xi.zone.REISENJIMA_SANCTORIUM,
}

local zonesWithGoblinFootprintSet = {}
for _, zoneID in ipairs(zonesWithGoblinFootprint) do
    zonesWithGoblinFootprintSet[zoneID] = true
end

-----------------------------------
-- desc: List of zones with their auto-translated group and message id.
-- note: The format is as follows: groupId, messageId, zoneId
-----------------------------------
local autotranslateToZoneId =
{
    { 0x14, 0xA9, 1 }, -- Phanauet Channel
    { 0x14, 0xAA, 2 }, -- Carpenters' Landing
    { 0x14, 0x84, 3 }, -- Manaclipper
    { 0x14, 0x85, 4 }, -- Bibiki Bay
    { 0x14, 0x8A, 5 }, -- Uleguerand Range
    { 0x14, 0x8B, 6 }, -- Bearclaw Pinnacle
    { 0x14, 0x86, 7 }, -- Attohwa Chasm
    { 0x14, 0x87, 8 }, -- Boneyard Gully
    { 0x14, 0x88, 9 }, -- Pso'Xja
    { 0x14, 0x89, 10 }, -- The Shrouded Maw
    { 0x14, 0x8C, 11 }, -- Oldton Movalpolos
    { 0x14, 0x8D, 12 }, -- Newton Movalpolos
    { 0x14, 0x8E, 13 }, -- Mine Shaft #2716
    { 0x14, 0xDC, 13 }, -- Mine Shaft #2716
    { 0x14, 0xAB, 14 }, -- Hall of Transference
    { 0x14, 0x9B, 16 }, -- Promyvion - Holla
    { 0x14, 0x9A, 16 }, -- Promyvion - Holla
    { 0x14, 0x9C, 17 }, -- Spire of Holla
    { 0x14, 0x9E, 18 }, -- Promyvion - Dem
    { 0x14, 0x9D, 18 }, -- Promyvion - Dem
    { 0x14, 0x9F, 19 }, -- Spire of Dem
    { 0x14, 0xA0, 20 }, -- Promyvion - Mea
    { 0x14, 0xA1, 20 }, -- Promyvion - Mea
    { 0x14, 0xA2, 21 }, -- Spire of Mea
    { 0x14, 0xA3, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA4, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA5, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA6, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA7, 23 }, -- Spire of Vahzl
    { 0x14, 0xA8, 23 }, -- Spire of Vahzl
    { 0x14, 0x90, 24 }, -- Lufaise Meadows
    { 0x14, 0x91, 25 }, -- Misareaux Coast
    { 0x14, 0x8F, 26 }, -- Tavnazian Safehold
    { 0x14, 0x93, 27 }, -- Phomiuna Aqueducts
    { 0x14, 0x94, 28 }, -- Sacrarium
    { 0x14, 0x96, 29 }, -- Riverne - Site #B01
    { 0x14, 0x95, 29 }, -- Riverne - Site #B01
    { 0x14, 0x98, 30 }, -- Riverne - Site #A01
    { 0x14, 0x97, 30 }, -- Riverne - Site #A01
    { 0x14, 0x99, 31 }, -- Monarch Linn
    { 0x14, 0x92, 32 }, -- Sealion's Den
    { 0x14, 0xAC, 33 }, -- Al'Taieu
    { 0x14, 0xAD, 34 }, -- Grand Palace of Hu'Xzoi
    { 0x14, 0xAE, 35 }, -- The Garden of Ru'Hmet
    { 0x14, 0xB0, 36 }, -- Empyreal Paradox
    { 0x14, 0xB1, 37 }, -- Temenos
    { 0x14, 0xB2, 38 }, -- Apollyon
    { 0x14, 0xB4, 39 }, -- Dynamis - Valkurm
    { 0x14, 0xB5, 40 }, -- Dynamis - Buburimu
    { 0x14, 0xB6, 41 }, -- Dynamis - Qufim
    { 0x14, 0xB7, 42 }, -- Dynamis - Tavnazia
    { 0x14, 0xAF, 43 }, -- Diorama Abdhaljs-Ghelsba
    { 0x14, 0xB8, 44 }, -- Abdhaljs Isle-Purgonorgo
    { 0x14, 0xB9, 46 }, -- Open sea route to Al Zahbi
    { 0x14, 0xBA, 47 }, -- Open sea route to Mhaura
    { 0x14, 0xBB, 48 }, -- Al Zahbi
    { 0x14, 0xDB, 50 }, -- Aht Urhgan Whitegate
    { 0x14, 0xBC, 50 }, -- Aht Urhgan Whitegate
    { 0x14, 0xBD, 51 }, -- Wajaom Woodlands
    { 0x14, 0xBE, 52 }, -- Bhaflau Thickets
    { 0x14, 0xBF, 53 }, -- Nashmau
    { 0x14, 0xC0, 54 }, -- Arrapago Reef
    { 0x14, 0xC1, 55 }, -- Ilrusi Atoll
    { 0x14, 0xC2, 56 }, -- Periqia
    { 0x14, 0xC3, 57 }, -- Talacca Cove
    { 0x14, 0xC4, 58 }, -- Silver Sea route to Nashmau
    { 0x14, 0xC5, 59 }, -- Silver Sea route to Al Zahbi
    { 0x14, 0xC6, 60 }, -- The Ashu Talif
    { 0x14, 0xC7, 61 }, -- Mount Zhayolm
    { 0x14, 0xC8, 62 }, -- Halvung
    { 0x14, 0xC9, 63 }, -- Lebros Cavern
    { 0x14, 0xCA, 64 }, -- Navukgo Execution Chamber
    { 0x14, 0xCB, 65 }, -- Mamook
    { 0x14, 0xCC, 66 }, -- Mamool Ja Training Grounds
    { 0x14, 0xCD, 67 }, -- Jade Sepulcher
    { 0x14, 0xCE, 68 }, -- Aydeewa Subterrane
    { 0x14, 0xCF, 69 }, -- Leujaoam Sanctum
    { 0x27, 0x0F, 70 }, -- Chocobo Circuit
    { 0x27, 0x10, 71 }, -- The Colosseum
    { 0x14, 0xDD, 72 }, -- Alzadaal Undersea Ruins
    { 0x14, 0xDE, 73 }, -- Zhayolm Remnants
    { 0x14, 0xDF, 74 }, -- Arrapago Remnants
    { 0x14, 0xE0, 75 }, -- Bhaflau Remnants
    { 0x14, 0xE1, 76 }, -- Silver Sea Remnants
    { 0x14, 0xE2, 77 }, -- Nyzul Isle
    { 0x14, 0xDA, 78 }, -- Hazhalm Testing Grounds
    { 0x14, 0xD0, 79 }, -- Caedarva Mire
    { 0x27, 0x11, 80 }, -- Southern San d'Oria [S]
    { 0x27, 0x13, 81 }, -- East Ronfaure [S]
    { 0x27, 0x15, 82 }, -- Jugner Forest [S]
    { 0x27, 0x23, 83 }, -- Vunkerl Inlet [S]
    { 0x27, 0x17, 84 }, -- Batallia Downs [S]
    { 0x27, 0x3E, 85 }, -- La Vaule [S]
    { 0x27, 0x40, 85 }, -- La Vaule [S]
    { 0x27, 0x19, 86 }, -- Everbloom Hollow
    { 0x27, 0x1C, 87 }, -- Bastok Markets [S]
    { 0x27, 0x1E, 88 }, -- North Gustaberg [S]
    { 0x27, 0x20, 89 }, -- Grauberg [S]
    { 0x27, 0x25, 90 }, -- Pashhow Marshlands [S]
    { 0x27, 0x27, 91 }, -- Rolanberry Fields [S]
    { 0x27, 0x42, 92 }, -- Beadeaux [S]
    { 0x27, 0x22, 93 }, -- Ruhotz Silvermines
    { 0x27, 0x2B, 94 }, -- Windurst Waters [S]
    { 0x27, 0x2D, 95 }, -- West Sarutabaruta [S]
    { 0x27, 0x2F, 96 }, -- Fort Karugo-Narugo [S]
    { 0x27, 0x32, 97 }, -- Meriphataud Mountains [S]
    { 0x27, 0x34, 98 }, -- Sauromugue Champaign [S]
    { 0x27, 0x44, 99 }, -- Castle Oztroja [S]
    { 0x14, 0x11, 100 }, -- West Ronfaure
    { 0x14, 0x0F, 101 }, -- East Ronfaure
    { 0x14, 0x51, 102 }, -- La Theine Plateau
    { 0x14, 0x60, 103 }, -- Valkurm Dunes
    { 0x14, 0x01, 104 }, -- Jugner Forest
    { 0x14, 0x02, 105 }, -- Batallia Downs
    { 0x14, 0x64, 106 }, -- North Gustaberg
    { 0x14, 0x63, 107 }, -- South Gustaberg
    { 0x14, 0x69, 108 }, -- Konschtat Highlands
    { 0x14, 0x2B, 109 }, -- Pashhow Marshlands
    { 0x14, 0x07, 110 }, -- Rolanberry Fields
    { 0x14, 0x24, 111 }, -- Beaucedine Glacier
    { 0x14, 0x4D, 112 }, -- Xarcabard
    { 0x14, 0x3D, 113 }, -- Cape Teriggan
    { 0x14, 0x3E, 114 }, -- Eastern Altepa Desert
    { 0x14, 0x18, 115 }, -- West Sarutabaruta
    { 0x14, 0x27, 116 }, -- East Sarutabaruta
    { 0x14, 0x17, 117 }, -- Tahrongi Canyon
    { 0x14, 0x16, 118 }, -- Buburimu Peninsula
    { 0x14, 0x20, 119 }, -- Meriphataud Mountains
    { 0x14, 0x2E, 120 }, -- Sauromugue Champaign
    { 0x14, 0x3F, 121 }, -- The Sanctuary of Zi'Tah
    { 0x14, 0x7D, 122 }, -- Ro'Maeve
    { 0x14, 0x7C, 122 }, -- Ro'Maeve
    { 0x14, 0x40, 123 }, -- Yuhtunga Jungle
    { 0x14, 0x41, 124 }, -- Yhoator Jungle
    { 0x14, 0x42, 125 }, -- Western Altepa Desert
    { 0x14, 0x08, 126 }, -- Qufim Island
    { 0x14, 0x0A, 127 }, -- Behemoth's Dominion
    { 0x14, 0x43, 128 }, -- Valley of Sorrows
    { 0x27, 0x31, 129 }, -- Ghoyu's Reverie
    { 0x14, 0x6F, 130 }, -- Ru'Aun Gardens
    { 0x14, 0x82, 134 }, -- Dynamis - Beaucedine
    { 0x14, 0x83, 135 }, -- Dynamis - Xarcabard
    { 0x27, 0x46, 136 }, -- Beaucedine Glacier [S]
    { 0x27, 0x48, 137 }, -- Xarcabard [S]
    { 0x14, 0x65, 139 }, -- Horlais Peak
    { 0x14, 0x6C, 140 }, -- Ghelsba Outpost
    { 0x14, 0x1F, 141 }, -- Fort Ghelsba
    { 0x14, 0x5E, 142 }, -- Yughott Grotto
    { 0x14, 0x66, 143 }, -- Palborough Mines
    { 0x14, 0x1A, 144 }, -- Waughroon Shrine
    { 0x14, 0x21, 145 }, -- Giddeus
    { 0x14, 0x19, 146 }, -- Balga's Dais
    { 0x14, 0x2A, 147 }, -- Beadeaux
    { 0x14, 0x28, 148 }, -- Qulun Dome
    { 0x14, 0x68, 149 }, -- Davoi
    { 0x14, 0x6D, 150 }, -- Monastic Cavern
    { 0x14, 0x23, 151 }, -- Castle Oztroja
    { 0x14, 0x04, 152 }, -- Altar Room
    { 0x14, 0x44, 153 }, -- The Boyahda Tree
    { 0x14, 0x37, 154 }, -- Dragon's Aery
    { 0x14, 0x0C, 157 }, -- Middle Delkfutt's Tower
    { 0x14, 0x0B, 158 }, -- Upper Delkfutt's Tower
    { 0x14, 0x36, 159 }, -- Temple of Uggalepih
    { 0x14, 0x35, 160 }, -- Den of Rancor
    { 0x14, 0x26, 161 }, -- Castle Zvahl Baileys
    { 0x14, 0x25, 161 }, -- Castle Zvahl Baileys
    { 0x14, 0x50, 162 }, -- Castle Zvahl Keep
    { 0x14, 0x4F, 162 }, -- Castle Zvahl Keep
    { 0x14, 0x39, 163 }, -- Sacrificial Chamber
    { 0x27, 0x36, 164 }, -- Garlaige Citadel [S]
    { 0x14, 0x5D, 165 }, -- Throne Room
    { 0x14, 0x2D, 166 }, -- Ranguemont Pass
    { 0x14, 0x32, 167 }, -- Bostaunieux Oubliette
    { 0x14, 0x3B, 168 }, -- Chamber of Oracles
    { 0x14, 0x1D, 169 }, -- Toraimarai Canal
    { 0x14, 0x5C, 170 }, -- Full Moon Fountain
    { 0x27, 0x29, 171 }, -- Crawlers' Nest [S]
    { 0x14, 0x61, 172 }, -- Zeruhn Mines
    { 0x14, 0x5B, 173 }, -- Korroloka Tunnel
    { 0x14, 0x5A, 174 }, -- Kuftal Tunnel
    { 0x27, 0x1A, 175 }, -- The Eldieme Necropolis [S]
    { 0x14, 0x59, 176 }, -- Sea Serpent Grotto
    { 0x14, 0x71, 177 }, -- Ve'Lugannon Palace
    { 0x14, 0x70, 177 }, -- Ve'Lugannon Palace
    { 0x14, 0x72, 178 }, -- The Shrine of Ru'Avitau
    { 0x14, 0xB3, 179 }, -- Stellar Fulcrum
    { 0x14, 0x73, 180 }, -- La'Loff Amphitheater
    { 0x14, 0x74, 181 }, -- The Celestial Nexus
    { 0x14, 0x0D, 184 }, -- Lower Delkfutt's Tower
    { 0x14, 0x7E, 185 }, -- Dynamis - San d'Oria
    { 0x14, 0x7F, 186 }, -- Dynamis - Bastok
    { 0x14, 0x80, 187 }, -- Dynamis - Windurst
    { 0x14, 0x81, 188 }, -- Dynamis - Jeuno
    { 0x14, 0x6E, 190 }, -- King Ranperre's Tomb
    { 0x14, 0x62, 191 }, -- Dangruf Wadi
    { 0x14, 0x1C, 192 }, -- Inner Horutoto Ruins
    { 0x14, 0x03, 193 }, -- Ordelle's Caves
    { 0x14, 0x1B, 194 }, -- Outer Horutoto Ruins
    { 0x14, 0x6A, 195 }, -- The Eldieme Necropolis
    { 0x14, 0x67, 196 }, -- Gusgen Mines
    { 0x14, 0x2C, 197 }, -- Crawlers' Nest
    { 0x14, 0x15, 198 }, -- Maze of Shakhrami
    { 0x14, 0x14, 200 }, -- Garlaige Citadel
    { 0x14, 0x77, 201 }, -- Cloister of Gales
    { 0x14, 0x75, 202 }, -- Cloister of Storms
    { 0x14, 0x7A, 203 }, -- Cloister of Frost
    { 0x14, 0x4A, 204 }, -- Fei'Yin
    { 0x14, 0x58, 205 }, -- Ifrit's Cauldron
    { 0x14, 0x6B, 206 }, -- Qu'Bia Arena
    { 0x14, 0x78, 207 }, -- Cloister of Flames
    { 0x14, 0x57, 208 }, -- Quicksand Caves
    { 0x14, 0x76, 209 }, -- Cloister of Tremors
    { 0x14, 0x79, 211 }, -- Cloister of Tides
    { 0x14, 0x34, 212 }, -- Gustav Tunnel
    { 0x14, 0x33, 213 }, -- Labyrinth of Onzozo
    { 0x14, 0x4C, 230 }, -- Southern San d'Oria
    { 0x14, 0x30, 231 }, -- Northern San d'Oria
    { 0x14, 0x52, 232 }, -- Port San d'Oria
    { 0x14, 0x22, 233 }, -- Chateau d'Oraguille
    { 0x14, 0x46, 234 }, -- Bastok Mines
    { 0x14, 0x56, 235 }, -- Bastok Markets
    { 0x14, 0x3C, 236 }, -- Port Bastok
    { 0x14, 0x2F, 237 }, -- Metalworks
    { 0x14, 0x3A, 238 }, -- Windurst Waters
    { 0x14, 0x54, 239 }, -- Windurst Walls
    { 0x14, 0x45, 240 }, -- Port Windurst
    { 0x14, 0x38, 241 }, -- Windurst Woods
    { 0x14, 0x55, 242 }, -- Heavens Tower
    { 0x14, 0x13, 243 }, -- Ru'Lude Gardens
    { 0x14, 0x4E, 244 }, -- Upper Jeuno
    { 0x14, 0x0E, 245 }, -- Lower Jeuno
    { 0x14, 0x06, 246 }, -- Port Jeuno
    { 0x14, 0x31, 247 }, -- Rabao
    { 0x14, 0x5F, 248 }, -- Selbina
    { 0x14, 0x1E, 249 }, -- Mhaura
    { 0x14, 0x29, 250 }, -- Kazham
    { 0x14, 0x7B, 251 }, -- Hall of the Gods
    { 0x14, 0x09, 252 }, -- Norg
    { 0x27, 0x4C, 256 }, -- Western Adoulin
    { 0x27, 0x4D, 257 }, -- Eastern Adoulin
    { 0x27, 0x4E, 258 }, -- Rala Waterways
    { 0x27, 0x4F, 260 }, -- Yahse Hunting Grounds
    { 0x27, 0x50, 261 }, -- Ceizak Battlegrounds
    { 0x27, 0x51, 262 }, -- Foret de Hennetiel
    { 0x27, 0x56, 263 }, -- Yorcia Weald
    { 0x27, 0x52, 265 }, -- Morimar Basalt Fields
    { 0x27, 0x57, 266 }, -- Marjami Ravine
    { 0x27, 0x5C, 267 }, -- Kamihr Drifts
    { 0x27, 0x53, 268 }, -- Sih Gates
    { 0x27, 0x54, 269 }, -- Moh Gates
    { 0x27, 0x55, 270 }, -- Cirdas Caverns
    { 0x27, 0x58, 272 }, -- Dho Gates
    { 0x27, 0x5D, 273 }, -- Woh Gates
    { 0x27, 0x12, 274 }, -- Outer Ra'Kaznar
    { 0x27, 0x5A, 280 }, -- Mog Garden
    { 0x27, 0x59, 284 }, -- Celennia Memorial Library
    { 0x27, 0x5B, 285 }, -- Feretory
    { 0x14, 0x09, 288 }, -- Escha - Zi'Tah
}

local zoneNames =
{
    [0] = 'unknown',
    [1] = 'Phanauet Channel',
    [2] = 'Carpenters\' Landing',
    [3] = 'Manaclipper',
    [4] = 'Bibiki Bay',
    [5] = 'Uleguerand Range',
    [6] = 'Bearclaw Pinnacle',
    [7] = 'Attohwa Chasm',
    [8] = 'Boneyard Gully',
    [9] = 'Pso\'Xja',
    [10] = 'The Shrouded Maw',
    [11] = 'Oldton Movalpolos',
    [12] = 'Newton Movalpolos',
    [13] = 'Mine Shaft #2716',
    [14] = 'Hall of Transference',
    [15] = 'Abyssea - Konschtat',
    [16] = 'Promyvion - Holla',
    [17] = 'Spire of Holla',
    [18] = 'Promyvion - Dem',
    [19] = 'Spire of Dem',
    [20] = 'Promyvion - Mea',
    [21] = 'Spire of Mea',
    [22] = 'Promyvion - Vahzl',
    [23] = 'Spire of Vahzl',
    [24] = 'Lufaise Meadows',
    [25] = 'Misareaux Coast',
    [26] = 'Tavnazian Safehold',
    [27] = 'Phomiuna Aqueducts',
    [28] = 'Sacrarium',
    [29] = 'Riverne - Site #B01',
    [30] = 'Riverne - Site #A01',
    [31] = 'Monarch Linn',
    [32] = 'Sealion\'s Den',
    [33] = 'Al\'Taieu',
    [34] = 'Grand Palace of Hu\'Xzoi',
    [35] = 'The Garden of Ru\'Hmet',
    [36] = 'Empyreal Paradox',
    [37] = 'Temenos',
    [38] = 'Apollyon',
    [39] = 'Dynamis - Valkurm',
    [40] = 'Dynamis - Buburimu',
    [41] = 'Dynamis - Qufim',
    [42] = 'Dynamis - Tavnazia',
    [43] = 'Diorama Abdhaljs-Ghelsba',
    [44] = 'Abdhaljs Isle-Purgonorgo',
    [45] = 'Abyssea - Tahrongi',
    [46] = 'Open sea route to Al Zahbi',
    [47] = 'Open sea route to Mhaura',
    [48] = 'Al Zahbi',
    [50] = 'Aht Urhgan Whitegate',
    [51] = 'Wajaom Woodlands',
    [52] = 'Bhaflau Thickets',
    [53] = 'Nashmau',
    [54] = 'Arrapago Reef',
    [55] = 'Ilrusi Atoll',
    [56] = 'Periqia',
    [57] = 'Talacca Cove',
    [58] = 'Silver Sea route to Nashmau',
    [59] = 'Silver Sea route to Al Zahbi',
    [60] = 'The Ashu Talif',
    [61] = 'Mount Zhayolm',
    [62] = 'Halvung',
    [63] = 'Lebros Cavern',
    [64] = 'Navukgo Execution Chamber',
    [65] = 'Mamook',
    [66] = 'Mamool Ja Training Grounds',
    [67] = 'Jade Sepulcher',
    [68] = 'Aydeewa Subterrane',
    [69] = 'Leujaoam Sanctum',
    [70] = 'Chocobo Circuit',
    [71] = 'The Colosseum',
    [72] = 'Alzadaal Undersea Ruins',
    [73] = 'Zhayolm Remnants',
    [74] = 'Arrapago Remnants',
    [75] = 'Bhaflau Remnants',
    [76] = 'Silver Sea Remnants',
    [77] = 'Nyzul Isle',
    [78] = 'Hazhalm Testing Grounds',
    [79] = 'Caedarva Mire',
    [80] = 'Southern San d\'Oria [S]',
    [81] = 'East Ronfaure [S]',
    [82] = 'Jugner Forest [S]',
    [83] = 'Vunkerl Inlet [S]',
    [84] = 'Batallia Downs [S]',
    [85] = 'La Vaule [S]',
    [86] = 'Everbloom Hollow',
    [87] = 'Bastok Markets [S]',
    [88] = 'North Gustaberg [S]',
    [89] = 'Grauberg [S]',
    [90] = 'Pashhow Marshlands [S]',
    [91] = 'Rolanberry Fields [S]',
    [92] = 'Beadeaux [S]',
    [93] = 'Ruhotz Silvermines',
    [94] = 'Windurst Waters [S]',
    [95] = 'West Sarutabaruta [S]',
    [96] = 'Fort Karugo-Narugo [S]',
    [97] = 'Meriphataud Mountains [S]',
    [98] = 'Sauromugue Champaign [S]',
    [99] = 'Castle Oztroja [S]',
    [100] = 'West Ronfaure',
    [101] = 'East Ronfaure',
    [102] = 'La Theine Plateau',
    [103] = 'Valkurm Dunes',
    [104] = 'Jugner Forest',
    [105] = 'Batallia Downs',
    [106] = 'North Gustaberg',
    [107] = 'South Gustaberg',
    [108] = 'Konschtat Highlands',
    [109] = 'Pashhow Marshlands',
    [110] = 'Rolanberry Fields',
    [111] = 'Beaucedine Glacier',
    [112] = 'Xarcabard',
    [113] = 'Cape Teriggan',
    [114] = 'Eastern Altepa Desert',
    [115] = 'West Sarutabaruta',
    [116] = 'East Sarutabaruta',
    [117] = 'Tahrongi Canyon',
    [118] = 'Buburimu Peninsula',
    [119] = 'Meriphataud Mountains',
    [120] = 'Sauromugue Champaign',
    [121] = 'The Sanctuary of Zi\'Tah',
    [122] = 'Ro\'Maeve',
    [123] = 'Yuhtunga Jungle',
    [124] = 'Yhoator Jungle',
    [125] = 'Western Altepa Desert',
    [126] = 'Qufim Island',
    [127] = 'Behemoth\'s Dominion',
    [128] = 'Valley of Sorrows',
    [129] = 'Ghoyu\'s Reverie',
    [130] = 'Ru\'Aun Gardens',
    [131] = 'Mordion Gaol',
    [132] = 'Abyssea - La Theine',
    [133] = 'Outer Ra\'Kaznar [U2]',
    [134] = 'Dynamis - Beaucedine',
    [135] = 'Dynamis - Xarcabard',
    [136] = 'Beaucedine Glacier [S]',
    [137] = 'Xarcabard [S]',
    [138] = 'Castle Zvahl Baileys [S]',
    [139] = 'Horlais Peak',
    [140] = 'Ghelsba Outpost',
    [141] = 'Fort Ghelsba',
    [142] = 'Yughott Grotto',
    [143] = 'Palborough Mines',
    [144] = 'Waughroon Shrine',
    [145] = 'Giddeus',
    [146] = 'Balga\'s Dais',
    [147] = 'Beadeaux',
    [148] = 'Qulun Dome',
    [149] = 'Davoi',
    [150] = 'Monastic Cavern',
    [151] = 'Castle Oztroja',
    [152] = 'Altar Room',
    [153] = 'The Boyahda Tree',
    [154] = 'Dragon\'s Aery',
    [155] = 'Castle Zvahl Keep [S]',
    [156] = 'Throne Room [S]',
    [157] = 'Middle Delkfutt\'s Tower',
    [158] = 'Upper Delkfutt\'s Tower',
    [159] = 'Temple of Uggalepih',
    [160] = 'Den of Rancor',
    [161] = 'Castle Zvahl Baileys',
    [162] = 'Castle Zvahl Keep',
    [163] = 'Sacrificial Chamber',
    [164] = 'Garlaige Citadel [S]',
    [165] = 'Throne Room',
    [166] = 'Ranguemont Pass',
    [167] = 'Bostaunieux Oubliette',
    [168] = 'Chamber of Oracles',
    [169] = 'Toraimarai Canal',
    [170] = 'Full Moon Fountain',
    [171] = 'Crawlers\' Nest [S]',
    [172] = 'Zeruhn Mines',
    [173] = 'Korroloka Tunnel',
    [174] = 'Kuftal Tunnel',
    [175] = 'The Eldieme Necropolis [S]',
    [176] = 'Sea Serpent Grotto',
    [177] = 'Ve\'Lugannon Palace',
    [178] = 'The Shrine of Ru\'Avitau',
    [179] = 'Stellar Fulcrum',
    [180] = 'La\'Loff Amphitheater',
    [181] = 'The Celestial Nexus',
    [182] = 'Walk of Echoes',
    [183] = 'Maquette Abdhaljs-LegionA',
    [184] = 'Lower Delkfutt\'s Tower',
    [185] = 'Dynamis - San d\'Oria',
    [186] = 'Dynamis - Bastok',
    [187] = 'Dynamis - Windurst',
    [188] = 'Dynamis - Jeuno',
    [189] = 'Outer Ra\'Kaznar [U3]',
    [190] = 'King Ranperre\'s Tomb',
    [191] = 'Dangruf Wadi',
    [192] = 'Inner Horutoto Ruins',
    [193] = 'Ordelle\'s Caves',
    [194] = 'Outer Horutoto Ruins',
    [195] = 'The Eldieme Necropolis',
    [196] = 'Gusgen Mines',
    [197] = 'Crawlers\' Nest',
    [198] = 'Maze of Shakhrami',
    [200] = 'Garlaige Citadel',
    [201] = 'Cloister of Gales',
    [202] = 'Cloister of Storms',
    [203] = 'Cloister of Frost',
    [204] = 'Fei\'Yin',
    [205] = 'Ifrit\'s Cauldron',
    [206] = 'Qu\'Bia Arena',
    [207] = 'Cloister of Flames',
    [208] = 'Quicksand Caves',
    [209] = 'Cloister of Tremors',
    [211] = 'Cloister of Tides',
    [212] = 'Gustav Tunnel',
    [213] = 'Labyrinth of Onzozo',
    [215] = 'Abyssea - Attohwa',
    [216] = 'Abyssea - Misareaux',
    [217] = 'Abyssea - Vunkerl',
    [218] = 'Abyssea - Altepa',
    [220] = 'Ship bound for Selbina',
    [221] = 'Ship bound for Mhaura',
    [222] = 'Provenance',
    [223] = 'San d\'Oria-Jeuno Airship',
    [224] = 'Bastok-Jeuno Airship',
    [225] = 'Windurst-Jeuno Airship',
    [226] = 'Kazham-Jeuno Airship',
    [227] = 'Ship bound for Selbina',
    [228] = 'Ship bound for Mhaura',
    [229] = 'Throne Room [V]',
    [230] = 'Southern San d\'Oria',
    [231] = 'Northern San d\'Oria',
    [232] = 'Port San d\'Oria',
    [233] = 'Chateau d\'Oraguille',
    [234] = 'Bastok Mines',
    [235] = 'Bastok Markets',
    [236] = 'Port Bastok',
    [237] = 'Metalworks',
    [238] = 'Windurst Waters',
    [239] = 'Windurst Walls',
    [240] = 'Port Windurst',
    [241] = 'Windurst Woods',
    [242] = 'Heavens Tower',
    [243] = 'Ru\'Lude Gardens',
    [244] = 'Upper Jeuno',
    [245] = 'Lower Jeuno',
    [246] = 'Port Jeuno',
    [247] = 'Rabao',
    [248] = 'Selbina',
    [249] = 'Mhaura',
    [250] = 'Kazham',
    [251] = 'Hall of the Gods',
    [252] = 'Norg',
    [253] = 'Abyssea - Uleguerand',
    [254] = 'Abyssea - Grauberg',
    [255] = 'Abyssea - Empyreal Paradox',
    [256] = 'Western Adoulin',
    [257] = 'Eastern Adoulin',
    [258] = 'Rala Waterways',
    [259] = 'Rala Waterways [U]',
    [260] = 'Yahse Hunting Grounds',
    [261] = 'Ceizak Battlegrounds',
    [262] = 'Foret de Hennetiel',
    [263] = 'Yorcia Weald',
    [264] = 'Yorcia Weald [U]',
    [265] = 'Morimar Basalt Fields',
    [266] = 'Marjami Ravine',
    [267] = 'Kamihr Drifts',
    [268] = 'Sih Gates',
    [269] = 'Moh Gates',
    [270] = 'Cirdas Caverns',
    [271] = 'Cirdas Caverns [U]',
    [272] = 'Dho Gates',
    [273] = 'Woh Gates',
    [274] = 'Outer Ra\'Kaznar',
    [275] = 'Outer Ra\'Kaznar [U1]',
    [276] = 'Ra\'Kaznar Inner Court',
    [277] = 'Ra\'Kaznar Turris',
    [278] = 'Gwora - Corridor',
    [279] = 'Walk of Echoes [P2]',
    [280] = 'Mog Garden',
    [281] = 'Leafallia',
    [282] = 'Mount Kamihr',
    [283] = 'Silver Knife',
    [284] = 'Celennia Memorial Library',
    [285] = 'Feretory',
    [287] = 'Maquette Abdhaljs-LegionB',
    [288] = 'Escha - Zi\'Tah',
    [289] = 'Escha - Ru\'Aun',
    [290] = 'Desuetia - Empyreal Paradox',
    [291] = 'Reisenjima',
    [292] = 'Reisenjima Henge',
    [293] = 'Reisenjima Sanctorium',
    [294] = 'Dynamis - San d\'Oria [D]',
    [295] = 'Dynamis - Bastok [D]',
    [296] = 'Dynamis - Windurst [D]',
    [297] = 'Dynamis - Jeuno [D]',
    [298] = 'Walk of Echoes [P1]',
    [299] = 'Gwora - Throne Room',
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!footprint [<zone>]')
end

local function getBytePos(s, needle)
    for i = 1, string.len(s), 1 do
        if string.byte(s, i) == needle then
            return i
        end
    end

    return nil
end

commandObj.onTrigger = function(player, zone)
    if not zone then
        local unacquiredFootprints = {}
        for _, zoneID in ipairs(zonesWithGoblinFootprint) do
            if player:getVar('ghook' .. zoneID) == 0 then
                table.insert(unacquiredFootprints, zoneID)
            end
        end

        local foundCount = #zonesWithGoblinFootprint - #unacquiredFootprints
        local time       = GetSystemTime()

        if #unacquiredFootprints == 0 then
            if player:getVar('ghookHintTime') > 0 then
                -- Clear the now-unnecessary vars from the database.
                player:setVar('ghookHintTime', 0)
                player:setVar('ghookHintZone', 0)
            end

            player:printToPlayer('You have found all ' .. #zonesWithGoblinFootprint .. ' goblin footprints.')
        elseif player:getVar('ghookHintTime') > time then
            local hintZoneID = player:getVar('ghookHintZone')
            player:printToPlayer('You have found ' .. foundCount .. ' goblin footprint' .. (foundCount == 1 and '.' or 's.'))

            local hint = 'You can only get a hint once a day.'

            if hintZoneID > 0 then
                hint = hint .. ' Have you checked ' .. zoneNames[hintZoneID] .. ' yet?'
            end

            player:printToPlayer(hint)
        else
            local hintZoneID = unacquiredFootprints[math.random(#unacquiredFootprints)]
            player:setVar('ghookHintZone', hintZoneID)
            player:setVar('ghookHintTime', time + 20 * 60 * 60) -- Wait 20 hours until the next hint.
            player:printToPlayer('You have found ' .. foundCount .. ' goblin footprint' .. (foundCount == 1 and '.' or 's.'))

            player:printToPlayer('Have you checked ' .. zoneNames[hintZoneID] .. ' yet?')
        end

        return
    end

    local zoneID
    local bytes = string.sub(zone, 6)
    local atPos = getBytePos(bytes, 253)

    -- validate destination
    if atPos ~= nil then
        -- destination is an auto-translate phrase
        local groupId = string.byte(bytes, atPos + 3)
        local messageId = string.byte(bytes, atPos + 4)
        for _, v in pairs(autotranslateToZoneId) do
            if v[1] == groupId and v[2] == messageId then
                zoneID = v[3]
                break
            end
        end

        if not zoneID then
            error(player, 'Auto-translated phrase is not a zone.')
            return
        end
    else
        -- destination is a zone ID.
        zoneID = tonumber(bytes)
        if not zoneID or not zoneNames[zoneID] then
            error(player, 'Invalid zone ID.')
            return
        end
    end

    if not zonesWithGoblinFootprintSet[zoneID] then
        player:printToPlayer('There\'s no goblin footprint in ' .. zoneNames[zoneID] .. '.')
    elseif player:getVar('ghook' .. zoneID) > 0 then
        player:printToPlayer('You\'ve already found the goblin footprint in ' .. zoneNames[zoneID] .. '.')
    else
        player:printToPlayer('You haven\'t found the goblin footprint in ' .. zoneNames[zoneID] .. ' yet.')
    end
end

return commandObj
