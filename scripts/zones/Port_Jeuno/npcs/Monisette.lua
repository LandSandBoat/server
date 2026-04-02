-----------------------------------
-- Area: Port Jeuno (246)
--  NPC: Monisette
-- Type: AF/Relic/Empyrean Armor Reforging NPC
-- !pos -6.000 0.001 -11.000 246
-- Trades iLvl 109 armor (+1) with Rem's Tale chapters
-- to produce iLvl 119 (+2) version
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Rem's Tale chapter items indexed by chapter number
local remsChapters =
{
    [1] = xi.item.COPY_OF_REMS_TALE_CHAPTER_1,
    [2] = xi.item.COPY_OF_REMS_TALE_CHAPTER_2,
    [3] = xi.item.COPY_OF_REMS_TALE_CHAPTER_3,
    [4] = xi.item.COPY_OF_REMS_TALE_CHAPTER_4,
    [5] = xi.item.COPY_OF_REMS_TALE_CHAPTER_5,
}

-- Slot material indexed by chapter number
local slotMaterials =
{
    [1] = xi.item.PHOENIX_FEATHER,
    [2] = xi.item.SPOOL_OF_MALBORO_FIBER,
    [3] = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD,
    [4] = xi.item.SQUARE_OF_DAMASCENE_CLOTH,
    [5] = xi.item.PIECE_OF_OXBLOOD,
}

local remsQty = 10

-- Reforge map: P1 input ID -> { P2 output ID, chapter number }
local reforgeMap =
{
    [15252] = { 10657, 1 }, -- ABYSS_BURGEONET
    [14507] = { 10677, 2 }, -- ABYSS_CUIRASS
    [15587] = { 10717, 4 }, -- ABYSS_FLANCHARD
    [14916] = { 10697, 3 }, -- ABYSS_GAUNTLETS
    [15672] = { 10737, 5 }, -- ABYSS_SOLLERETS
    [27984] = { 23194, 3 }, -- ACADEMICS_BRACERS
    [27848] = { 23127, 2 }, -- ACADEMICS_GOWN
    [28264] = { 23328, 5 }, -- ACADEMICS_LOAFERS
    [27704] = { 23060, 1 }, -- ACADEMICS_MORTARBOARD
    [28131] = { 23261, 4 }, -- ACADEMICS_PANTS
    [27329] = { 23331, 5 }, -- AGOGE_CALLIGAE
    [27153] = { 23264, 4 }, -- AGOGE_CUISSES
    [26801] = { 23130, 2 }, -- AGOGE_LORICA
    [26625] = { 23063, 1 }, -- AGOGE_MASK
    [26977] = { 23197, 3 }, -- AGOGE_MUFFLERS
    [27685] = { 23041, 1 }, -- ANCHORITES_CROWN
    [27829] = { 23108, 2 }, -- ANCHORITES_CYCLAS
    [28245] = { 23309, 5 }, -- ANCHORITES_GAITERS
    [27965] = { 23175, 3 }, -- ANCHORITES_GLOVES
    [28112] = { 23242, 4 }, -- ANCHORITES_HOSE
    [27345] = { 23339, 5 }, -- ANKUSA_GAITERS
    [26993] = { 23205, 3 }, -- ANKUSA_GLOVES
    [26641] = { 23071, 1 }, -- ANKUSA_HELM
    [26817] = { 23138, 2 }, -- ANKUSA_JACKCOAT
    [27169] = { 23272, 4 }, -- ANKUSA_TROUSERS
    [11173] = { 11073, 1 }, -- AOIDOS_CALOT
    [11253] = { 11153, 5 }, -- AOIDOS_COTHURNES
    [11193] = { 11093, 2 }, -- AOIDOS_HONGRELINE
    [11213] = { 11113, 3 }, -- AOIDOS_MANCHETTES
    [11233] = { 11133, 4 }, -- AOIDOS_RHINGRAVE
    [26645] = { 23073, 1 }, -- ARCADIAN_BERET
    [27173] = { 23274, 4 }, -- ARCADIAN_BRACCAE
    [26997] = { 23207, 3 }, -- ARCADIAN_BRACERS
    [26821] = { 23140, 2 }, -- ARCADIAN_JERKIN
    [27349] = { 23341, 5 }, -- ARCADIAN_SOCKS
    [26807] = { 23133, 2 }, -- ARCHMAGES_COAT
    [26983] = { 23200, 3 }, -- ARCHMAGES_GLOVES
    [26631] = { 23066, 1 }, -- ARCHMAGES_PETASOS
    [27335] = { 23334, 5 }, -- ARCHMAGES_SABOTS
    [27159] = { 23267, 4 }, -- ARCHMAGES_TONBAN
    [15041] = { 10709, 3 }, -- ARGUTE_BRACERS
    [11308] = { 10689, 2 }, -- ARGUTE_GOWN
    [11399] = { 10749, 5 }, -- ARGUTE_LOAFERS
    [11481] = { 10669, 1 }, -- ARGUTE_MORTARBOARD
    [16363] = { 10729, 4 }, -- ARGUTE_PANTS
    [14914] = { 10695, 2 }, -- ASSASSINS_ARMLETS
    [15250] = { 10655, 1 }, -- ASSASSINS_BONNET
    [15585] = { 10715, 3 }, -- ASSASSINS_CULOTTES
    [15670] = { 10735, 4 }, -- ASSASSINS_POULAINES
    [14505] = { 10675, 2 }, -- ASSASSINS_VEST
    [27979] = { 23189, 3 }, -- ASSIMILATORS_BAZUBANDS
    [28259] = { 23323, 5 }, -- ASSIMILATORS_CHARUQS
    [27843] = { 23122, 2 }, -- ASSIMILATORS_JUBBAH
    [27699] = { 23055, 1 }, -- ASSIMILATORS_KEFFIYEH
    [28126] = { 23256, 4 }, -- ASSIMILATORS_SHALWAR
    [28248] = { 23312, 5 }, -- ATROPHY_BOOTS
    [27688] = { 23044, 1 }, -- ATROPHY_CHAPEAU
    [27968] = { 23178, 3 }, -- ATROPHY_GLOVES
    [27832] = { 23111, 2 }, -- ATROPHY_TABARD
    [28115] = { 23245, 4 }, -- ATROPHY_TIGHTS
    [26665] = { 23083, 1 }, -- BAGUA_GALERO
    [27017] = { 23217, 3 }, -- BAGUA_MITAINES
    [27193] = { 23284, 4 }, -- BAGUA_PANTS
    [27369] = { 23351, 5 }, -- BAGUA_SANDALS
    [26841] = { 23150, 2 }, -- BAGUA_TUNIC
    [11171] = { 11071, 1 }, -- BALE_BURGEONET
    [11191] = { 11091, 2 }, -- BALE_CUIRASS
    [11231] = { 11131, 4 }, -- BALE_FLANCHARD
    [11211] = { 11111, 3 }, -- BALE_GAUNTLETS
    [11251] = { 11151, 5 }, -- BALE_SOLLERETS
    [15589] = { 10719, 4 }, -- BARDS_CANNIONS
    [14918] = { 10699, 3 }, -- BARDS_CUFFS
    [14509] = { 10679, 2 }, -- BARDS_JUSTAUCORPS
    [15254] = { 10659, 1 }, -- BARDS_ROUNDLET
    [15674] = { 10739, 5 }, -- BARDS_SLIPPERS
    [27171] = { 23273, 4 }, -- BIHU_CANNIONS
    [26995] = { 23206, 3 }, -- BIHU_CUFFS
    [26819] = { 23139, 2 }, -- BIHU_JUSTAUCORPS
    [26643] = { 23072, 1 }, -- BIHU_ROUNDLET
    [27347] = { 23340, 5 }, -- BIHU_SLIPPERS
    [28120] = { 23250, 4 }, -- BRIOSO_CANNIONS
    [27973] = { 23183, 3 }, -- BRIOSO_CUFFS
    [27837] = { 23116, 2 }, -- BRIOSO_JUSTAUCORPS
    [27693] = { 23049, 1 }, -- BRIOSO_ROUNDLET
    [28253] = { 23317, 5 }, -- BRIOSO_SLIPPERS
    [27165] = { 23270, 4 }, -- CABALLARIUS_BREECHES
    [26637] = { 23069, 1 }, -- CABALLARIUS_CORONET
    [26989] = { 23203, 3 }, -- CABALLARIUS_GAUNTLETS
    [27341] = { 23337, 5 }, -- CABALLARIUS_LEGGINGS
    [26813] = { 23136, 2 }, -- CABALLARIUS_SURCOAT
    [11218] = { 11118, 3 }, -- CALLERS_BRACERS
    [11198] = { 11098, 2 }, -- CALLERS_DOUBLET
    [11178] = { 11078, 1 }, -- CALLERS_HORN
    [11258] = { 11158, 5 }, -- CALLERS_PIGACHES
    [11238] = { 11138, 4 }, -- CALLERS_SPATS
    [11222] = { 11122, 3 }, -- CHARIS_BANGLES
    [11202] = { 11102, 2 }, -- CHARIS_CASAQUE
    [11182] = { 11082, 1 }, -- CHARIS_TIARA
    [11242] = { 11142, 4 }, -- CHARIS_TIGHTS
    [11262] = { 11162, 5 }, -- CHARIS_TOE_SHOES
    [11181] = { 11081, 1 }, -- CIRQUE_CAPPELLO
    [11201] = { 11101, 2 }, -- CIRQUE_FARSETTO
    [11221] = { 11121, 3 }, -- CIRQUE_GUANTI
    [11241] = { 11141, 4 }, -- CIRQUE_PANTALONI
    [11261] = { 11161, 5 }, -- CIRQUE_SCARPE
    [14502] = { 10672, 1 }, -- CLERICS_BLIAUT
    [15247] = { 10652, 1 }, -- CLERICS_CAP
    [15667] = { 10732, 4 }, -- CLERICS_DUCKBILLS
    [14911] = { 10692, 2 }, -- CLERICS_MITTS
    [15582] = { 10712, 3 }, -- CLERICS_PANTALOONS
    [11386] = { 10746, 5 }, -- COMMODORE_BOTTES
    [11296] = { 10686, 2 }, -- COMMODORE_FRAC
    [15029] = { 10706, 3 }, -- COMMODORE_GANTS
    [16350] = { 10726, 4 }, -- COMMODORE_TREWS
    [27978] = { 23188, 3 }, -- CONVOKERS_BRACERS
    [27842] = { 23121, 2 }, -- CONVOKERS_DOUBLET
    [27698] = { 23054, 1 }, -- CONVOKERS_HORN
    [28258] = { 23322, 5 }, -- CONVOKERS_PIGACHES
    [28125] = { 23255, 4 }, -- CONVOKERS_SPATS
    [11170] = { 11070, 1 }, -- CREED_ARMET
    [11190] = { 11090, 2 }, -- CREED_CUIRASS
    [11230] = { 11130, 4 }, -- CREED_CUISSES
    [11210] = { 11110, 3 }, -- CREED_GAUNTLETS
    [11250] = { 11150, 5 }, -- CREED_SABATONS
    [15669] = { 10734, 4 }, -- DUELISTS_BOOTS
    [15249] = { 10654, 1 }, -- DUELISTS_CHAPEAU
    [14913] = { 10694, 2 }, -- DUELISTS_GLOVES
    [14504] = { 10674, 2 }, -- DUELISTS_TABARD
    [15584] = { 10714, 3 }, -- DUELISTS_TIGHTS
    [11168] = { 11068, 1 }, -- ESTOQUEURS_CHAPPEL
    [11228] = { 11128, 4 }, -- ESTOQUEURS_FUSEAU
    [11208] = { 11108, 3 }, -- ESTOQUEURS_GANTHEROTS
    [11248] = { 11148, 5 }, -- ESTOQUEURS_HOUSEAUX
    [11188] = { 11088, 2 }, -- ESTOQUEURS_SAYON
    [15039] = { 10708, 3 }, -- ETOILE_BANGLES
    [11306] = { 10688, 2 }, -- ETOILE_CASAQUE
    [11479] = { 10668, 1 }, -- ETOILE_TIARA
    [16361] = { 10728, 4 }, -- ETOILE_TIGHTS
    [11397] = { 10748, 5 }, -- ETOILE_TOE_SHOES
    [26639] = { 23070, 1 }, -- FALLENS_BURGEONET
    [26815] = { 23137, 2 }, -- FALLENS_CUIRASS
    [26991] = { 23204, 3 }, -- FALLENS_FINGER_GAUNTLETS
    [27167] = { 23271, 4 }, -- FALLENS_FLANCHARD
    [27343] = { 23338, 5 }, -- FALLENS_SOLLERETS
    [11172] = { 11072, 1 }, -- FERINE_CABASSET
    [11192] = { 11092, 2 }, -- FERINE_GAUSAPE
    [11212] = { 11112, 3 }, -- FERINE_MANOPLAS
    [11252] = { 11152, 5 }, -- FERINE_OCREAE
    [11232] = { 11132, 4 }, -- FERINE_QUIJOTES
    [28261] = { 23325, 5 }, -- FOIRE_BABOUCHES
    [28128] = { 23258, 4 }, -- FOIRE_CHURIDARS
    [27981] = { 23191, 3 }, -- FOIRE_DASTANAS
    [27701] = { 23057, 1 }, -- FOIRE_TAJ
    [27845] = { 23124, 2 }, -- FOIRE_TOBE
    [26667] = { 23084, 1 }, -- FUTHARK_BANDEAU
    [27371] = { 23352, 5 }, -- FUTHARK_BOOTS
    [26843] = { 23151, 2 }, -- FUTHARK_COAT
    [27019] = { 23218, 3 }, -- FUTHARK_MITONS
    [27195] = { 23285, 4 }, -- FUTHARK_TROUSERS
    [27705] = { 23061, 1 }, -- GEOMANCY_GALERO
    [27985] = { 23195, 3 }, -- GEOMANCY_MITAINES
    [28132] = { 23262, 4 }, -- GEOMANCY_PANTS
    [28265] = { 23329, 5 }, -- GEOMANCY_SANDALS
    [27849] = { 23128, 2 }, -- GEOMANCY_TUNIC
    [27005] = { 23211, 3 }, -- GLYPHIC_BRACERS
    [26829] = { 23144, 2 }, -- GLYPHIC_DOUBLET
    [26653] = { 23077, 1 }, -- GLYPHIC_HORN
    [27357] = { 23345, 5 }, -- GLYPHIC_PIGACHES
    [27181] = { 23278, 4 }, -- GLYPHIC_SPATS
    [11227] = { 11127, 4 }, -- GOETIA_CHAUSSES
    [11187] = { 11087, 2 }, -- GOETIA_COAT
    [11207] = { 11107, 3 }, -- GOETIA_GLOVES
    [11167] = { 11067, 1 }, -- GOETIA_PETASOS
    [11247] = { 11147, 5 }, -- GOETIA_SABOTS
    [27840] = { 23119, 2 }, -- HACHIYA_CHAINMAIL
    [28123] = { 23253, 4 }, -- HACHIYA_HAKAMA
    [27696] = { 23052, 1 }, -- HACHIYA_HATSUBURI
    [28256] = { 23320, 5 }, -- HACHIYA_KYAHAN
    [27976] = { 23186, 3 }, -- HACHIYA_TEKKO
    [26627] = { 23064, 1 }, -- HESYCHASTS_CROWN
    [26803] = { 23131, 2 }, -- HESYCHASTS_CYCLAS
    [27331] = { 23332, 5 }, -- HESYCHASTS_GAITERS
    [26979] = { 23198, 3 }, -- HESYCHASTS_GLOVES
    [27155] = { 23265, 4 }, -- HESYCHASTS_HOSE
    [27013] = { 23215, 3 }, -- HOROS_BANGLES
    [26837] = { 23148, 2 }, -- HOROS_CASAQUE
    [26661] = { 23081, 1 }, -- HOROS_TIARA
    [27189] = { 23282, 4 }, -- HOROS_TIGHTS
    [27365] = { 23349, 5 }, -- HOROS_TOE_SHOES
    [11236] = { 11136, 4 }, -- IGA_HAKAMA
    [11256] = { 11156, 5 }, -- IGA_KYAHAN
    [11196] = { 11096, 2 }, -- IGA_NINGI
    [11216] = { 11116, 3 }, -- IGA_TEKKO
    [11176] = { 11076, 1 }, -- IGA_ZUKIN
    [27691] = { 23047, 1 }, -- IGNOMINY_BURGEONET
    [27835] = { 23114, 2 }, -- IGNOMINY_CUIRASS
    [28118] = { 23248, 4 }, -- IGNOMINY_FLANCHARD
    [27971] = { 23181, 3 }, -- IGNOMINY_GAUNTLETS
    [28251] = { 23315, 5 }, -- IGNOMINY_SOLLERETS
    [14512] = { 10682, 2 }, -- KOGA_CHAINMAIL
    [15592] = { 10722, 4 }, -- KOGA_HAKAMA
    [15257] = { 10662, 1 }, -- KOGA_HATSUBURI
    [15677] = { 10742, 5 }, -- KOGA_KYAHAN
    [14921] = { 10702, 3 }, -- KOGA_TEKKO
    [28260] = { 23324, 5 }, -- LAKSAMANAS_BOTTES
    [27844] = { 23123, 2 }, -- LAKSAMANAS_FRAC
    [28127] = { 23257, 4 }, -- LAKSAMANAS_TREWS
    [27700] = { 23056, 1 }, -- LAKSAMANAS_TRICORNE
    [11237] = { 11137, 4 }, -- LANCERS_CUISSOTS
    [11177] = { 11077, 1 }, -- LANCERS_MEZAIL
    [11197] = { 11097, 2 }, -- LANCERS_PLACKART
    [11257] = { 11157, 5 }, -- LANCERS_SCHYNBALDS
    [11217] = { 11117, 3 }, -- LANCERS_VAMBRACES
    [27361] = { 23347, 5 }, -- LANUN_BOTTES
    [26833] = { 23146, 2 }, -- LANUN_FRAC
    [27009] = { 23213, 3 }, -- LANUN_GANTS
    [26657] = { 23079, 1 }, -- LANUN_TRICORNE
    [27007] = { 23212, 3 }, -- LUHLAZA_BAZUBANDS
    [27359] = { 23346, 5 }, -- LUHLAZA_CHARUQS
    [26831] = { 23145, 2 }, -- LUHLAZA_JUBBAH
    [26655] = { 23078, 1 }, -- LUHLAZA_KEFFIYEH
    [27183] = { 23279, 4 }, -- LUHLAZA_SHALWAR
    [11259] = { 11159, 5 }, -- MAVI_BASMAK
    [11219] = { 11119, 3 }, -- MAVI_BAZUBANDS
    [11179] = { 11079, 1 }, -- MAVI_KAVUK
    [11199] = { 11099, 2 }, -- MAVI_MINTAN
    [11239] = { 11139, 4 }, -- MAVI_TAYT
    [27983] = { 23193, 3 }, -- MAXIXI_BANGLES_F
    [27982] = { 23192, 3 }, -- MAXIXI_BANGLES_M
    [27847] = { 23126, 2 }, -- MAXIXI_CASAQUE_F
    [27846] = { 23125, 2 }, -- MAXIXI_CASAQUE_M
    [27703] = { 23059, 1 }, -- MAXIXI_TIARA_F
    [27702] = { 23058, 1 }, -- MAXIXI_TIARA_M
    [28130] = { 23260, 4 }, -- MAXIXI_TIGHTS_F
    [28129] = { 23259, 4 }, -- MAXIXI_TIGHTS_M
    [28263] = { 23327, 5 }, -- MAXIXI_TOE_SHOES_F
    [28262] = { 23326, 5 }, -- MAXIXI_TOE_SHOES_M
    [15246] = { 10651, 1 }, -- MELEE_CROWN
    [14501] = { 10671, 1 }, -- MELEE_CYCLAS
    [15666] = { 10731, 4 }, -- MELEE_GAITERS
    [14910] = { 10691, 2 }, -- MELEE_GLOVES
    [15581] = { 10711, 3 }, -- MELEE_HOSE
    [15026] = { 10705, 3 }, -- MIRAGE_BAZUBANDS
    [11383] = { 10745, 5 }, -- MIRAGE_CHARUQS
    [11293] = { 10685, 2 }, -- MIRAGE_JUBBAH
    [11466] = { 10665, 1 }, -- MIRAGE_KEFFIYEH
    [16347] = { 10725, 4 }, -- MIRAGE_SHALWAR
    [26825] = { 23142, 2 }, -- MOCHIZUKI_CHAINMAIL
    [27177] = { 23276, 4 }, -- MOCHIZUKI_HAKAMA
    [26649] = { 23075, 1 }, -- MOCHIZUKI_HATSUBURI
    [27353] = { 23343, 5 }, -- MOCHIZUKI_KYAHAN
    [27001] = { 23209, 3 }, -- MOCHIZUKI_TEKKO
    [15673] = { 10738, 5 }, -- MONSTER_GAITERS
    [14917] = { 10698, 3 }, -- MONSTER_GLOVES
    [15253] = { 10658, 1 }, -- MONSTER_HELM
    [14508] = { 10678, 2 }, -- MONSTER_JACKCOAT
    [15588] = { 10718, 4 }, -- MONSTER_TROUSERS
    [11260] = { 11160, 5 }, -- NAVARCHS_BOTTES
    [11240] = { 11140, 4 }, -- NAVARCHS_CULOTTES
    [11200] = { 11100, 2 }, -- NAVARCHS_FRAC
    [11220] = { 11120, 3 }, -- NAVARCHS_GANTS
    [11180] = { 11080, 1 }, -- NAVARCHS_TRICORNE
    [27694] = { 23050, 1 }, -- ORION_BERET
    [28121] = { 23251, 4 }, -- ORION_BRACCAE
    [27974] = { 23184, 3 }, -- ORION_BRACERS
    [27838] = { 23117, 2 }, -- ORION_JERKIN
    [28254] = { 23318, 5 }, -- ORION_SOCKS
    [11186] = { 11086, 2 }, -- ORISON_BLIAUD
    [11166] = { 11066, 1 }, -- ORISON_CAP
    [11246] = { 11146, 5 }, -- ORISON_DUCKBILLS
    [11206] = { 11106, 3 }, -- ORISON_MITTS
    [11226] = { 11126, 4 }, -- ORISON_PANTALOONS
    [11389] = { 10747, 5 }, -- PANTIN_BABOUCHES
    [16353] = { 10727, 4 }, -- PANTIN_CHURIDARS
    [15032] = { 10707, 3 }, -- PANTIN_DASTANAS
    [11472] = { 10667, 1 }, -- PANTIN_TAJ
    [11299] = { 10687, 2 }, -- PANTIN_TOBE
    [27015] = { 23216, 3 }, -- PEDAGOGY_BRACERS
    [26839] = { 23149, 2 }, -- PEDAGOGY_GOWN
    [27367] = { 23350, 5 }, -- PEDAGOGY_LOAFERS
    [26663] = { 23082, 1 }, -- PEDAGOGY_MORTARBOARD
    [27191] = { 23283, 4 }, -- PEDAGOGY_PANTS
    [26805] = { 23132, 2 }, -- PIETY_BLIAUT
    [26629] = { 23065, 1 }, -- PIETY_CAP
    [27333] = { 23333, 5 }, -- PIETY_DUCKBILLS
    [26981] = { 23199, 3 }, -- PIETY_MITTS
    [27157] = { 23266, 4 }, -- PIETY_PANTALOONS
    [27969] = { 23179, 3 }, -- PILLAGERS_ARMLETS
    [27689] = { 23045, 1 }, -- PILLAGERS_BONNET
    [28116] = { 23246, 4 }, -- PILLAGERS_CULOTTES
    [28249] = { 23313, 5 }, -- PILLAGERS_POULAINES
    [27833] = { 23112, 2 }, -- PILLAGERS_VEST
    [27363] = { 23348, 5 }, -- PITRE_BABOUCHES
    [27187] = { 23281, 4 }, -- PITRE_CHURIDARS
    [27011] = { 23214, 3 }, -- PITRE_DASTANAS
    [26659] = { 23080, 1 }, -- PITRE_TAJ
    [26835] = { 23147, 2 }, -- PITRE_TOBE
    [26987] = { 23202, 3 }, -- PLUNDERERS_ARMLETS
    [26635] = { 23068, 1 }, -- PLUNDERERS_BONNET
    [27163] = { 23269, 4 }, -- PLUNDERERS_CULOTTES
    [27339] = { 23336, 5 }, -- PLUNDERERS_POULAINES
    [26811] = { 23135, 2 }, -- PLUNDERERS_VEST
    [26651] = { 23076, 1 }, -- PTEROSLAVER_ARMET
    [27179] = { 23277, 4 }, -- PTEROSLAVER_BRAIS
    [27003] = { 23210, 3 }, -- PTEROSLAVER_FINGER_GAUNTLETS
    [27355] = { 23344, 5 }, -- PTEROSLAVER_GREAVES
    [26827] = { 23143, 2 }, -- PTEROSLAVER_MAIL
    [28244] = { 23308, 5 }, -- PUMMELERS_CALLIGAE
    [28111] = { 23241, 4 }, -- PUMMELERS_CUISSES
    [27828] = { 23107, 2 }, -- PUMMELERS_LORICA
    [27684] = { 23040, 1 }, -- PUMMELERS_MASK
    [27964] = { 23174, 3 }, -- PUMMELERS_MUFFLERS
    [11209] = { 11109, 3 }, -- RAIDERS_ARMLETS
    [11169] = { 11069, 1 }, -- RAIDERS_BONNET
    [11229] = { 11129, 4 }, -- RAIDERS_CULOTTES
    [11249] = { 11149, 5 }, -- RAIDERS_POULAINES
    [11189] = { 11089, 2 }, -- RAIDERS_VEST
    [11244] = { 11144, 5 }, -- RAVAGERS_CALLIGAE
    [11224] = { 11124, 4 }, -- RAVAGERS_CUISSES
    [11184] = { 11084, 2 }, -- RAVAGERS_LORICA
    [11164] = { 11064, 1 }, -- RAVAGERS_MASK
    [11204] = { 11104, 3 }, -- RAVAGERS_MUFFLERS
    [28117] = { 23247, 4 }, -- REVERENCE_BREECHES
    [27690] = { 23046, 1 }, -- REVERENCE_CORONET
    [27970] = { 23180, 3 }, -- REVERENCE_GAUNTLETS
    [28250] = { 23314, 5 }, -- REVERENCE_LEGGINGS
    [27834] = { 23113, 2 }, -- REVERENCE_SURCOAT
    [27706] = { 23062, 1 }, -- RUNEIST_BANDEAU
    [28266] = { 23330, 5 }, -- RUNEIST_BOTTES
    [27850] = { 23129, 2 }, -- RUNEIST_COAT
    [27986] = { 23196, 3 }, -- RUNEIST_MITONS
    [26823] = { 23141, 2 }, -- SAKONJI_DOMARU
    [27175] = { 23275, 4 }, -- SAKONJI_HAIDATE
    [26647] = { 23074, 1 }, -- SAKONJI_KABUTO
    [26999] = { 23208, 3 }, -- SAKONJI_KOTE
    [27351] = { 23342, 5 }, -- SAKONJI_SUNE_ATE
    [14511] = { 10681, 2 }, -- SAOTOME_DOMARU
    [15591] = { 10721, 4 }, -- SAOTOME_HAIDATE
    [15256] = { 10661, 1 }, -- SAOTOME_KABUTO
    [14920] = { 10701, 3 }, -- SAOTOME_KOTE
    [15676] = { 10741, 5 }, -- SAOTOME_SUNE_ATE
    [11183] = { 11083, 1 }, -- SAVANTS_BONNET
    [11223] = { 11123, 3 }, -- SAVANTS_BRACERS
    [11203] = { 11103, 2 }, -- SAVANTS_GOWN
    [11263] = { 11163, 5 }, -- SAVANTS_LOAFERS
    [11243] = { 11143, 4 }, -- SAVANTS_PANTS
    [15255] = { 10660, 1 }, -- SCOUTS_BERET
    [15590] = { 10720, 4 }, -- SCOUTS_BRACCAE
    [14919] = { 10700, 3 }, -- SCOUTS_BRACERS
    [14510] = { 10680, 2 }, -- SCOUTS_JERKIN
    [15675] = { 10740, 5 }, -- SCOUTS_SOCKS
    [14503] = { 10673, 1 }, -- SORCERERS_COAT
    [14912] = { 10693, 2 }, -- SORCERERS_GLOVES
    [15248] = { 10653, 1 }, -- SORCERERS_PETASOS
    [15668] = { 10733, 4 }, -- SORCERERS_SABOTS
    [15583] = { 10713, 3 }, -- SORCERERS_TONBAN
    [27831] = { 23110, 2 }, -- SPAEKONAS_COAT
    [27967] = { 23177, 3 }, -- SPAEKONAS_GLOVES
    [27687] = { 23043, 1 }, -- SPAEKONAS_PETASOS
    [28247] = { 23311, 5 }, -- SPAEKONAS_SABOTS
    [28114] = { 23244, 4 }, -- SPAEKONAS_TONBAN
    [14923] = { 10704, 3 }, -- SUMMONERS_BRACERS
    [14514] = { 10684, 2 }, -- SUMMONERS_DOUBLET
    [15259] = { 10664, 1 }, -- SUMMONERS_HORN
    [15679] = { 10744, 5 }, -- SUMMONERS_PIGACHES
    [15594] = { 10724, 4 }, -- SUMMONERS_SPATS
    [11254] = { 11154, 5 }, -- SYLVAN_BOTTILLONS
    [11234] = { 11134, 4 }, -- SYLVAN_BRAGUES
    [11194] = { 11094, 2 }, -- SYLVAN_CABAN
    [11174] = { 11074, 1 }, -- SYLVAN_GAPETTE
    [11214] = { 11114, 3 }, -- SYLVAN_GLOVELETTES
    [11165] = { 11065, 1 }, -- TANTRA_CROWN
    [11185] = { 11085, 2 }, -- TANTRA_CYCLAS
    [11245] = { 11145, 5 }, -- TANTRA_GAITERS
    [11205] = { 11105, 3 }, -- TANTRA_GLOVES
    [11225] = { 11125, 4 }, -- TANTRA_HOSE
    [27830] = { 23109, 2 }, -- THEOPHANY_BLIAUT
    [27686] = { 23042, 1 }, -- THEOPHANY_CAP
    [28246] = { 23310, 5 }, -- THEOPHANY_DUCKBILLS
    [27966] = { 23176, 3 }, -- THEOPHANY_MITTS
    [28113] = { 23243, 4 }, -- THEOPHANY_PANTALOONS
    [28252] = { 23316, 5 }, -- TOTEMIC_GAITERS
    [27972] = { 23182, 3 }, -- TOTEMIC_GLOVES
    [27692] = { 23048, 1 }, -- TOTEMIC_HELM
    [27836] = { 23115, 2 }, -- TOTEMIC_JACKCOAT
    [28119] = { 23249, 4 }, -- TOTEMIC_TROUSERS
    [11195] = { 11095, 2 }, -- UNKAI_DOMARU
    [11235] = { 11135, 4 }, -- UNKAI_HAIDATE
    [11175] = { 11075, 1 }, -- UNKAI_KABUTO
    [11215] = { 11115, 3 }, -- UNKAI_KOTE
    [11255] = { 11155, 5 }, -- UNKAI_SUNE_ATE
    [15586] = { 10716, 4 }, -- VALOR_BREECHES
    [15251] = { 10656, 1 }, -- VALOR_CORONET
    [14915] = { 10696, 3 }, -- VALOR_GAUNTLETS
    [15671] = { 10736, 5 }, -- VALOR_LEGGINGS
    [14506] = { 10676, 2 }, -- VALOR_SURCOAT
    [27697] = { 23053, 1 }, -- VISHAP_ARMET
    [28124] = { 23254, 4 }, -- VISHAP_BRAIS
    [27977] = { 23187, 3 }, -- VISHAP_FINGER_GAUNTLETS
    [28257] = { 23321, 5 }, -- VISHAP_GREAVES
    [27841] = { 23120, 2 }, -- VISHAP_MAIL
    [27337] = { 23335, 5 }, -- VITIATION_BOOTS
    [26633] = { 23067, 1 }, -- VITIATION_CHAPEAU
    [26985] = { 23201, 3 }, -- VITIATION_GLOVES
    [26809] = { 23134, 2 }, -- VITIATION_TABARD
    [27161] = { 23268, 4 }, -- VITIATION_TIGHTS
    [27839] = { 23118, 2 }, -- WAKIDO_DOMARU
    [28122] = { 23252, 4 }, -- WAKIDO_HAIDATE
    [27695] = { 23051, 1 }, -- WAKIDO_KABUTO
    [27975] = { 23185, 3 }, -- WAKIDO_KOTE
    [28255] = { 23319, 5 }, -- WAKIDO_SUNE_ATE
    [15665] = { 10730, 4 }, -- WARRIORS_CALLIGAE
    [15580] = { 10710, 3 }, -- WARRIORS_CUISSES
    [14500] = { 10670, 1 }, -- WARRIORS_LORICA
    [15245] = { 10650, 1 }, -- WARRIORS_MASK
    [14909] = { 10690, 2 }, -- WARRIORS_MUFFLERS
    [15258] = { 10663, 1 }, -- WYRM_ARMET
    [15593] = { 10723, 4 }, -- WYRM_BRAIS
    [14922] = { 10703, 3 }, -- WYRM_FINGER_GAUNTLETS
    [15678] = { 10743, 5 }, -- WYRM_GREAVES
    [14513] = { 10683, 2 }, -- WYRM_MAIL
}

entity.onTrade = function(player, npc, trade)
    for p1Id, data in pairs(reforgeMap) do
        local p2Id = data[1]
        local chapter = data[2]
        local remsItem = remsChapters[chapter]
        local slotMat = slotMaterials[chapter]

        if
            trade:hasItemQty(p1Id, 1) and
            trade:hasItemQty(remsItem, remsQty) and
            trade:hasItemQty(slotMat, 1) and
            trade:getItemCount() == 1 + remsQty + 1
        then
            if npcUtil.giveItem(player, p2Id) then
                player:confirmTrade()
                player:printToPlayer('Monisette: Your armor has been reforged to its full potential!', xi.msg.channel.NS_SAY)
            end

            return
        end
    end
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Monisette: I can reforge artifact armor to unlock its true power.', xi.msg.channel.NS_SAY)
    player:printToPlayer('Monisette: Trade me your iLvl 109 armor with the required materials:', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - The armor piece to reforge', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - 10x Rems Tale Chapter (1=Head, 2=Body, 3=Hands, 4=Legs, 5=Feet)', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - 1x Slot material (Phoenix Feather / Malboro Fiber / Beetle Blood / Damascene Cloth / Oxblood)', xi.msg.channel.NS_SAY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
