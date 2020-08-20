-----------------------------------
-- Area: Port Jeuno
--  NPC: Sagheera
-- !pos -3 0.1 -9 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------


-----------------------------------
-- artifact armor upgrade data
-- [combinationId] = {trade = {afBase, temenosItem, apollyonItem, craftedItem}, abc = ABCsRequired, reward = afPlusOne},
-----------------------------------
local afArmorPlusOne =
{
    [  1] = {trade = {12511, 1930, 1931, 1990}, abc = 20, reward = 15225}, -- fighters_mask_+1
    [  2] = {trade = {12638, 1930, 1931, 1990}, abc = 35, reward = 14473}, -- fighters_lorica_+1
    [  3] = {trade = {13961, 1930, 1931, 1990}, abc = 15, reward = 14890}, -- fighters_mufflers_+1
    [  4] = {trade = {14214, 1930, 1931, 1990}, abc = 15, reward = 15561}, -- fighters_cuisses_+1
    [  5] = {trade = {14089, 1930, 1931, 1990}, abc = 25, reward = 15352}, -- fighters_calligae_+1
    [  6] = {trade = {12512, 1932, 1933, 1117}, abc = 25, reward = 15226}, -- temple_crown_+1
    [  7] = {trade = {12639, 1932, 1933, 1991}, abc = 40, reward = 14474}, -- temple_cyclas_+1
    [  8] = {trade = {13962, 1932, 1933, 1117}, abc = 20, reward = 14891}, -- temple_gloves_+1
    [  9] = {trade = {14215, 1932, 1933, 1117}, abc = 25, reward = 15562}, -- temple_hose_+1
    [ 10] = {trade = {14090, 1932, 1933,  855}, abc = 20, reward = 15353}, -- temple_gaiters_+1
    [ 11] = {trade = {13855, 1934, 1935, 1994}, abc = 30, reward = 15227}, -- healers_cap_+1
    [ 12] = {trade = {12640, 1934, 1935, 1992}, abc = 40, reward = 14475}, -- healers_briault_+1
    [ 13] = {trade = {13963, 1934, 1935, 1993}, abc = 20, reward = 14892}, -- healers_mitts_+1
    [ 14] = {trade = {14216, 1934, 1935, 1996}, abc = 25, reward = 15563}, -- healers_pantaloons_+1
    [ 15] = {trade = {14091, 1934, 1935, 1995}, abc = 20, reward = 15354}, -- healers_duckbills_+1
    [ 16] = {trade = {13856, 1936, 1937, 1993}, abc = 25, reward = 15228}, -- wizards_petasos_+1
    [ 17] = {trade = {12641, 1936, 1937, 1993}, abc = 25, reward = 14476}, -- wizards_coat_+1
    [ 18] = {trade = {13964, 1936, 1937, 1993}, abc = 15, reward = 14893}, -- wizards_gloves_+1
    [ 19] = {trade = {14217, 1936, 1937, 1994}, abc = 30, reward = 15564}, -- wizards_tonban_+1
    [ 20] = {trade = {14092, 1936, 1937, 1995}, abc = 20, reward = 15355}, -- wizards_sabots_+1
    [ 21] = {trade = {12513, 1938, 1939, 1996}, abc = 20, reward = 15229}, -- warlocks_chapeau_+1
    [ 22] = {trade = {12642, 1938, 1939, 1996}, abc = 30, reward = 14477}, -- warlocks_tabard_+1
    [ 23] = {trade = {13965, 1938, 1939, 1996}, abc = 15, reward = 14894}, -- warlocks_gloves_+1
    [ 24] = {trade = {14218, 1938, 1939, 1996}, abc = 20, reward = 15565}, -- warlocks_tights_+1
    [ 25] = {trade = {14093, 1938, 1939,  855}, abc = 25, reward = 15356}, -- warlocks_boots_+1
    [ 26] = {trade = {12514, 1940, 1941, 1997}, abc = 30, reward = 15230}, -- rogues_bonnet_+1
    [ 27] = {trade = {12643, 1940, 1941, 1997}, abc = 40, reward = 14478}, -- rogues_vest_+1
    [ 28] = {trade = {13966, 1940, 1941, 1998}, abc = 20, reward = 14895}, -- rogues_armlets_+1
    [ 29] = {trade = {14219, 1940, 1941, 1997}, abc = 30, reward = 15566}, -- rogues_culottes_+1
    [ 30] = {trade = {14094, 1940, 1941, 1998}, abc = 20, reward = 15357}, -- rogues_poulaines_+1
    [ 31] = {trade = {12515, 1942, 1943,  745}, abc = 25, reward = 15231}, -- gallant_coronet_+1
    [ 32] = {trade = {12644, 1942, 1943, 1999}, abc = 30, reward = 14479}, -- gallant_surcoat_+1
    [ 33] = {trade = {13967, 1942, 1943,  667}, abc = 20, reward = 14896}, -- gallant_gauntlets_+1
    [ 34] = {trade = {14220, 1942, 1943,  667}, abc = 20, reward = 15567}, -- gallant_breeches_+1
    [ 35] = {trade = {14095, 1942, 1943,  667}, abc = 20, reward = 15358}, -- gallant_leggings_+1
    [ 36] = {trade = {12516, 1944, 1945,  664}, abc = 25, reward = 15232}, -- chaos_burgeonet_+1
    [ 37] = {trade = {12645, 1944, 1945, 2001}, abc = 30, reward = 14480}, -- chaos_cuirass_+1
    [ 38] = {trade = {13968, 1944, 1945,  664}, abc = 15, reward = 14897}, -- chaos_gauntlets_+1
    [ 39] = {trade = {14221, 1944, 1945,  664}, abc = 20, reward = 15568}, -- chaos_flanchard_+1
    [ 40] = {trade = {14096, 1944, 1945,  664}, abc = 20, reward = 15359}, -- chaos_sollerets_+1
    [ 41] = {trade = {12517, 1946, 1947, 2002}, abc = 30, reward = 15233}, -- beast_helm_+1
    [ 42] = {trade = {12646, 1946, 1947, 2003}, abc = 40, reward = 14481}, -- beast_jackcoat_+1
    [ 43] = {trade = {13969, 1946, 1947, 2003}, abc = 20, reward = 14898}, -- beast_gloves_+1
    [ 44] = {trade = {14222, 1946, 1947,  848}, abc = 30, reward = 15569}, -- beast_trousers_+1
    [ 45] = {trade = {14097, 1946, 1947,  848}, abc = 20, reward = 15360}, -- beast_gaiters_+1
    [ 46] = {trade = {13857, 1948, 1949,  823}, abc = 15, reward = 15234}, -- choral_roundlet_+1
    [ 47] = {trade = {12647, 1948, 1949, 1117}, abc = 40, reward = 14482}, -- choral_justaucorps_+1
    [ 48] = {trade = {13970, 1948, 1949, 1117}, abc = 25, reward = 14899}, -- choral_cuffs_+1
    [ 49] = {trade = {14223, 1948, 1949, 1117}, abc = 25, reward = 15570}, -- choral_cannions_+1
    [ 50] = {trade = {14098, 1948, 1949, 1117}, abc = 25, reward = 15361}, -- choral_slippers_+1
    [ 51] = {trade = {12518, 1950, 1951, 2005}, abc = 25, reward = 15235}, -- hunters_beret_+1
    [ 52] = {trade = {12648, 1950, 1951, 2005}, abc = 40, reward = 14483}, -- hunters_jerkin_+1
    [ 53] = {trade = {13971, 1950, 1951,  506}, abc = 20, reward = 14900}, -- hunters_bracers_+1
    [ 54] = {trade = {14224, 1950, 1951,  506}, abc = 25, reward = 15571}, -- hunters_braccae_+1
    [ 55] = {trade = {14099, 1950, 1951,  855}, abc = 25, reward = 15362}, -- hunters_socks_+1
    [ 56] = {trade = {13868, 1952, 1953,  752}, abc = 15, reward = 15236}, -- myochin_kabuto_+1
    [ 57] = {trade = {13781, 1952, 1953, 2006}, abc = 25, reward = 14484}, -- myochin_domaru_+1
    [ 58] = {trade = {13972, 1952, 1953, 2007}, abc = 20, reward = 14901}, -- myochin_kote_+1
    [ 59] = {trade = {14225, 1952, 1953, 2007}, abc = 30, reward = 15572}, -- myochin_haidate_+1
    [ 60] = {trade = {14100, 1952, 1953, 2007}, abc = 20, reward = 15363}, -- myochin_sune-ate_+1
    [ 61] = {trade = {13869, 1954, 1955, 2008}, abc = 20, reward = 15237}, -- ninja_hatsuburi_+1
    [ 62] = {trade = {13782, 1954, 1955, 2008}, abc = 30, reward = 14485}, -- ninja_chainmail_+1
    [ 63] = {trade = {13973, 1954, 1955, 2008}, abc = 15, reward = 14902}, -- ninja_tekko_+1
    [ 64] = {trade = {14226, 1954, 1955, 2007}, abc = 30, reward = 15573}, -- ninja_hakama_+1
    [ 65] = {trade = {14101, 1954, 1955, 2008}, abc = 15, reward = 15364}, -- ninja_kyahan_+1
    [ 66] = {trade = {12519, 1956, 1957, 2012}, abc = 30, reward = 15238}, -- drachen_armet_+1
    [ 67] = {trade = {12649, 1956, 1957, 2012}, abc = 40, reward = 14486}, -- drachen_mail_+1
    [ 68] = {trade = {13974, 1956, 1957,  851}, abc = 20, reward = 14903}, -- drachen_finger_gauntlets_+1
    [ 69] = {trade = {14227, 1956, 1957,  851}, abc = 25, reward = 15574}, -- drachen_brais_+1
    [ 70] = {trade = {14102, 1956, 1957,  851}, abc = 20, reward = 15365}, -- drachen_greaves_+1
    [ 71] = {trade = {12520, 1958, 1959, 2009}, abc = 25, reward = 15239}, -- evokers_horn_+1
    [ 72] = {trade = {12650, 1958, 1959, 2010}, abc = 35, reward = 14487}, -- evokers_doublet_+1
    [ 73] = {trade = {13975, 1958, 1959, 2010}, abc = 20, reward = 14904}, -- evokers_bracers_+1
    [ 74] = {trade = {14228, 1958, 1959, 2010}, abc = 30, reward = 15575}, -- evokers_spats_+1
    [ 75] = {trade = {14103, 1958, 1959,  720}, abc = 15, reward = 15366}, -- evokers_pigaches_+1
    [ 76] = {trade = {15265, 2656, 2657, 2703}, abc = 20, reward = 11464}, -- magus_keffiyeh_+1
    [ 77] = {trade = {14521, 2656, 2657, 2289}, abc = 30, reward = 11291}, -- magus_jubbah_+1
    [ 78] = {trade = {14928, 2656, 2657, 2703}, abc = 15, reward = 15024}, -- magus_bazubands_+1
    [ 79] = {trade = {15600, 2656, 2657, 2289}, abc = 30, reward = 16345}, -- magus_shalwar_+1
    [ 80] = {trade = {15684, 2656, 2657, 2703}, abc = 15, reward = 11381}, -- magus_charuqs_+1
    [ 81] = {trade = {15266, 2658, 2659, 2012}, abc = 30, reward = 11467}, -- corsairs_tricorne_+1
    [ 82] = {trade = {14522, 2658, 2659, 2704}, abc = 30, reward = 11294}, -- corsairs_frac_+1
    [ 83] = {trade = {14929, 2658, 2659, 2704}, abc = 20, reward = 15027}, -- corsairs_gants_+1
    [ 84] = {trade = {15601, 2658, 2659, 2704}, abc = 30, reward = 16348}, -- corsairs_culottes_+1
    [ 85] = {trade = {15685, 2658, 2659, 2152}, abc = 25, reward = 11384}, -- corsairs_bottes_+1
    [ 86] = {trade = {15267, 2660, 2661, 2705}, abc = 20, reward = 11470}, -- puppetry_taj_+1
    [ 87] = {trade = {14523, 2660, 2661, 1699}, abc = 30, reward = 11297}, -- puppetry_tobe_+1
    [ 88] = {trade = {14930, 2660, 2661, 2705}, abc = 20, reward = 15030}, -- puppetry_dastanas_+1
    [ 89] = {trade = {15602, 2660, 2661, 2705}, abc = 20, reward = 16351}, -- puppetry_churidars_+1
    [ 90] = {trade = {15686, 2660, 2661, 1993}, abc = 20, reward = 11387}, -- puppetry_babouches_+1
    [ 91] = {trade = {16138, 2714, 2715,  745}, abc = 30, reward = 11475}, -- dancers_tiara_+1
    [ 92] = {trade = {14578, 2714, 2715, 1699}, abc = 35, reward = 11302}, -- dancers_casaque_+1
    [ 93] = {trade = {15002, 2714, 2715,  745}, abc = 25, reward = 15035}, -- dancers_bangles_+1
    [ 94] = {trade = {15659, 2714, 2715, 2737}, abc = 25, reward = 16357}, -- dancers_tights_+1
    [ 95] = {trade = {15746, 2714, 2715, 2737}, abc = 20, reward = 11393}, -- dancers_toe_shoes_+1
    [201] = {trade = {16139, 2714, 2715,  745}, abc = 30, reward = 11476}, -- dancers_tiara_+1
    [202] = {trade = {14579, 2714, 2715, 1699}, abc = 35, reward = 11303}, -- dancers_casaque_+1
    [203] = {trade = {15003, 2714, 2715,  745}, abc = 25, reward = 15036}, -- dancers_bangles_+1
    [204] = {trade = {15660, 2714, 2715, 2737}, abc = 25, reward = 16358}, -- dancers_tights_+1
    [205] = {trade = {15747, 2714, 2715, 2737}, abc = 20, reward = 11394}, -- dancers_toe_shoes_+1
    [ 96] = {trade = {16140, 2716, 2717, 2536}, abc = 20, reward = 11477}, -- scholars_mortarboard_+1
    [ 97] = {trade = {14580, 2716, 2717, 2530}, abc = 40, reward = 11304}, -- scholars_gown_+1
    [ 98] = {trade = {15004, 2716, 2717, 2530}, abc = 25, reward = 15037}, -- scholars_bracers_+1
    [ 99] = {trade = {16311, 2716, 2717, 1993}, abc = 25, reward = 16359}, -- scholars_pants_+1
    [100] = {trade = {15748, 2716, 2717, 2288}, abc = 25, reward = 11395}, -- scholars_loafers_+1
}

-----------------------------------
-- relic armor upgrade data
-- [combinationId] = {trade = {relicBase, relicMinusOne, ingredient, {currencyId, currencyAmt}}, reward = relicPlusOne},
-----------------------------------
local relicArmorPlusOne =
{
    [101] = {trade = {15072, 2033, 1990, {1455, 28}}, reward = 15245}, -- warriors_mask_+1
    [102] = {trade = {15087, 2034, 1990, {1455, 28}}, reward = 14500}, -- warriors_lorica_+1
    [103] = {trade = {15102, 2035, 1990, {1455, 28}}, reward = 14909}, -- warriors_mufflers_+1
    [104] = {trade = {15117, 2036, 1990, {1455, 28}}, reward = 15580}, -- warriors_cuisses_+1
    [105] = {trade = {15132, 2037, 1990, {1455, 28}}, reward = 15665}, -- warriors_calligae_+1
    [106] = {trade = {15073, 2038, 2122, {1455, 26}}, reward = 15246}, -- melee_crown_+1
    [107] = {trade = {15088, 2039, 1991, {1455, 26}}, reward = 14501}, -- melee_cyclas_+1
    [108] = {trade = {15103, 2040, 2122, {1455, 26}}, reward = 14910}, -- melee_gloves_+1
    [109] = {trade = {15118, 2041, 2122, {1455, 26}}, reward = 15581}, -- melee_hose_+1
    [110] = {trade = {15133, 2042, 2122, {1455, 26}}, reward = 15666}, -- melee_gaiters_+1
    [111] = {trade = {15074, 2043, 1994, {1452, 28}}, reward = 15247}, -- clerics_cap_+1
    [112] = {trade = {15089, 2044, 1992, {1452, 28}}, reward = 14502}, -- clerics_briault_+1
    [113] = {trade = {15104, 2045, 1993, {1452, 28}}, reward = 14911}, -- clerics_mitts_+1
    [114] = {trade = {15119, 2046, 1996, {1452, 26}}, reward = 15582}, -- clerics_pantaloons_+1
    [115] = {trade = {15134, 2047, 1995, {1452, 28}}, reward = 15667}, -- clerics_duckbills_+1
    [116] = {trade = {15075, 2048, 1993, {1449, 28}}, reward = 15248}, -- sorcerers_petasos_+1
    [117] = {trade = {15090, 2049, 1993, {1449, 28}}, reward = 14503}, -- sorcerers_coat_+1
    [118] = {trade = {15105, 2050, 1993, {1449, 28}}, reward = 14912}, -- sorcerers_gloves_+1
    [119] = {trade = {15120, 2051, 1994, {1449, 28}}, reward = 15583}, -- sorcerers_tonban_+1
    [120] = {trade = {15135, 2052, 1995, {1449, 28}}, reward = 15668}, -- sorcerers_sabots_+1
    [121] = {trade = {15076, 2053, 1996, {1452, 22}}, reward = 15249}, -- duelists_chapeau_+1
    [122] = {trade = {15091, 2054, 1996, {1452, 22}}, reward = 14504}, -- duelists_tabard_+1
    [123] = {trade = {15106, 2055, 1996, {1452, 22}}, reward = 14913}, -- duelists_gloves_+1
    [124] = {trade = {15121, 2056, 1996, {1452, 22}}, reward = 15584}, -- duelists_tights_+1
    [125] = {trade = {15136, 2057, 2122, {1452, 26}}, reward = 15669}, -- duelists_boots_+1
    [126] = {trade = {15077, 2058, 1997, {1449, 26}}, reward = 15250}, -- assassins_bonnet_+1
    [127] = {trade = {15092, 2059, 1997, {1449, 26}}, reward = 14505}, -- assassins_vest_+1
    [128] = {trade = {15107, 2060, 1998, {1449, 28}}, reward = 14914}, -- assassins_armlets_+1
    [129] = {trade = {15122, 2061, 1997, {1449, 26}}, reward = 15585}, -- assassins_culottes_+1
    [130] = {trade = {15137, 2062, 1998, {1449, 28}}, reward = 15670}, -- assassins_poulaines_+1
    [131] = {trade = {15078, 2063,  745, {1452, 20}}, reward = 15251}, -- valor_coronet_+1
    [132] = {trade = {15093, 2064, 1999, {1452, 20}}, reward = 14506}, -- valor_surcoat_+1
    [133] = {trade = {15108, 2065,  667, {1452, 30}}, reward = 14915}, -- valor_gauntlets_+1
    [134] = {trade = {15123, 2066,  667, {1452, 30}}, reward = 15586}, -- valor_breeches_+1
    [135] = {trade = {15138, 2067,  667, {1452, 30}}, reward = 15671}, -- valor_leggings_+1
    [136] = {trade = {15079, 2068,  664, {1455, 28}}, reward = 15252}, -- abyss_burgeonet_+1
    [137] = {trade = {15094, 2069, 2001, {1455, 20}}, reward = 14507}, -- abyss_cuirass_+1
    [138] = {trade = {15109, 2070,  664, {1455, 28}}, reward = 14916}, -- abyss_gauntlets_+1
    [139] = {trade = {15124, 2071,  664, {1455, 28}}, reward = 15587}, -- abyss_flanchard_+1
    [140] = {trade = {15139, 2072,  664, {1455, 28}}, reward = 15672}, -- abyss_sollerets_+1
    [141] = {trade = {15080, 2073, 1458, {1449, 30}}, reward = 15253}, -- monster_helm_+1
    [142] = {trade = {15095, 2074, 2125, {1449, 26}}, reward = 14508}, -- monster_jackcoat_+1
    [143] = {trade = {15110, 2075, 2125, {1449, 26}}, reward = 14917}, -- monster_gloves_+1
    [144] = {trade = {15125, 2076, 2124, {1449, 26}}, reward = 15588}, -- monster_trousers_+1
    [145] = {trade = {15140, 2077, 2124, {1449, 26}}, reward = 15673}, -- monster_gaiters_+1
    [146] = {trade = {15081, 2078,  823, {1455, 26}}, reward = 15254}, -- bards_roundlet_+1
    [147] = {trade = {15096, 2079, 1459, {1455, 28}}, reward = 14509}, -- bards_justaucorps_+1
    [148] = {trade = {15111, 2080, 1459, {1455, 28}}, reward = 14918}, -- bards_cuffs_+1
    [149] = {trade = {15126, 2081, 1459, {1455, 28}}, reward = 15589}, -- bards_cannions_+1
    [150] = {trade = {15141, 2082, 1459, {1455, 28}}, reward = 15674}, -- bards_slippers_+1
    [151] = {trade = {15082, 2083, 2005, {1449, 30}}, reward = 15255}, -- scouts_beret_+1
    [152] = {trade = {15097, 2084, 2005, {1449, 30}}, reward = 14510}, -- scouts_jerkin_+1
    [153] = {trade = {15112, 2085,  506, {1449, 30}}, reward = 14919}, -- scouts_bracers_+1
    [154] = {trade = {15127, 2086,  506, {1449, 30}}, reward = 15590}, -- scouts_braccae_+1
    [155] = {trade = {15142, 2087, 2122, {1449, 26}}, reward = 15675}, -- scouts_socks_+1
    [156] = {trade = {15083, 2088,  752, {1455, 24}}, reward = 15256}, -- saotome_kabuto_+1
    [157] = {trade = {15098, 2089, 2006, {1455, 22}}, reward = 14511}, -- saotome_domaru_+1
    [158] = {trade = {15113, 2090, 2007, {1455, 20}}, reward = 14920}, -- saotome_kote_+1
    [159] = {trade = {15128, 2091, 2007, {1455, 20}}, reward = 15591}, -- saotome_haidate_+1
    [160] = {trade = {15143, 2092, 2007, {1455, 20}}, reward = 15676}, -- saotome_sune-ate_+1
    [161] = {trade = {15084, 2093, 2008, {1455, 26}}, reward = 15257}, -- koga_hatsuburi_+1
    [162] = {trade = {15099, 2094, 2008, {1455, 26}}, reward = 14512}, -- koga_chainmail_+1
    [163] = {trade = {15114, 2095, 2008, {1455, 26}}, reward = 14921}, -- koga_tekko_+1
    [164] = {trade = {15129, 2096, 2007, {1455, 20}}, reward = 15592}, -- koga_hakama_+1
    [165] = {trade = {15144, 2097, 2008, {1455, 26}}, reward = 15677}, -- koga_kyahan_+1
    [166] = {trade = {15085, 2098, 2012, {1452, 30}}, reward = 15258}, -- wyrm_armet_+1
    [167] = {trade = {15100, 2099, 2012, {1452, 30}}, reward = 14513}, -- wyrm_mail_+1
    [168] = {trade = {15115, 2100,  851, {1452, 30}}, reward = 14922}, -- wyrm_finger_gauntlets_+1
    [169] = {trade = {15130, 2101,  851, {1452, 30}}, reward = 15593}, -- wyrm_brais_+1
    [170] = {trade = {15145, 2102,  851, {1452, 30}}, reward = 15678}, -- wyrm_greaves_+1
    [171] = {trade = {15086, 2103, 2009, {1449, 30}}, reward = 15259}, -- summoners_horn_+1
    [172] = {trade = {15101, 2104, 2010, {1449, 30}}, reward = 14514}, -- summoners_doublet_+1
    [173] = {trade = {15116, 2105, 2010, {1449, 30}}, reward = 14923}, -- summoners_bracers_+1
    [174] = {trade = {15131, 2106, 2010, {1449, 30}}, reward = 15594}, -- summoners_spats_+1
    [175] = {trade = {15146, 2107,  720, {1449, 28}}, reward = 15679}, -- summoners_pigaches_+1
    [176] = {trade = {11465, 2662, 2703, {1452, 26}}, reward = 11466}, -- mirage_keffiyeh_+1
    [177] = {trade = {11292, 2663, 1702, {1452, 26}}, reward = 11293}, -- mirage_jubbah_+1
    [178] = {trade = {15025, 2664, 2703, {1452, 26}}, reward = 15026}, -- mirage_bazubands_+1
    [179] = {trade = {16346, 2665, 1702, {1452, 26}}, reward = 16347}, -- mirage_shalwar_+1
    [180] = {trade = {11382, 2666, 2703, {1452, 26}}, reward = 11383}, -- mirage_charuqs_+1
    [181] = {trade = {11468, 2667, 2122, {1455, 30}}, reward = 11469}, -- commodore_tricorne_+1
    [182] = {trade = {11295, 2668, 2704, {1455, 30}}, reward = 11296}, -- commodore_frac_+1
    [183] = {trade = {15028, 2669, 2704, {1455, 30}}, reward = 15029}, -- commodore_gants_+1
    [184] = {trade = {16349, 2670, 2704, {1455, 30}}, reward = 16350}, -- commodore_culottes_+1
    [185] = {trade = {11385, 2671, 2152, {1455, 30}}, reward = 11386}, -- commodore_bottes_+1
    [186] = {trade = {11471, 2672, 2705, {1449, 26}}, reward = 11472}, -- pantin_taj_+1
    [187] = {trade = {11298, 2673, 1999, {1449, 26}}, reward = 11299}, -- pantin_tobe_+1
    [188] = {trade = {15031, 2674, 2705, {1449, 26}}, reward = 15032}, -- pantin_dastanas_+1
    [189] = {trade = {16352, 2675, 2705, {1449, 26}}, reward = 16353}, -- pantin_churidars_+1
    [190] = {trade = {11388, 2676, 2538, {1449, 26}}, reward = 11389}, -- pantin_babouches_+1
    [191] = {trade = {11478, 2718,  745, {1452, 30}}, reward = 11479}, -- etoile_tiara_+1
    [192] = {trade = {11305, 2719, 2537, {1452, 30}}, reward = 11306}, -- etoile_casaque_+1
    [193] = {trade = {15038, 2720,  745, {1452, 30}}, reward = 15039}, -- etoile_bangles_+1
    [194] = {trade = {16360, 2721, 1702, {1452, 30}}, reward = 16361}, -- etoile_tights_+1
    [195] = {trade = {11396, 2722, 1992, {1452, 30}}, reward = 11397}, -- etoile_toe_shoes_+1
    [196] = {trade = {11480, 2723,  746, {1455, 28}}, reward = 11481}, -- argute_mortarboard_+1
    [197] = {trade = {11307, 2724, 1699, {1455, 28}}, reward = 11308}, -- argute_gown_+1
    [198] = {trade = {15040, 2725, 2530, {1455, 28}}, reward = 15041}, -- argute_bracers_+1
    [199] = {trade = {16362, 2726, 1993, {1455, 28}}, reward = 16363}, -- argute_pants_+1
    [200] = {trade = {11398, 2727, 2424, {1455, 28}}, reward = 11399}, -- argute_loafers_+1
}

-----------------------------------
-- ancient beastcoin purchases
-- [menu option] = {item = itemId, abc = costInABCs}
-----------------------------------

local abcShop =
{
    [11] = {item = 15244, abc = 150}, -- flawless_ribbon
    [12] = {item = 14812, abc =  75}, -- loquacious_earring
    [13] = {item = 14813, abc =  75}, -- brutal_earring
    [14] = {item = 15475, abc = 150}, -- charger_mantle
    [15] = {item = 15476, abc = 150}, -- jaeger_mantle
    [16] = {item = 15477, abc =  75}, -- boxers_mantle
    [17] = {item = 15488, abc =  75}, -- gunners_mantle
    [18] = {item = 14815, abc =  75}, -- stealth_earring
    [19] = {item = 15961, abc =  75}, -- musical_earring
    [20] = {item =  2127, abc =  75}, -- metal_chip
}

-----------------------------------

local COSMO_READY = 2147483649 -- BITMASK for the purchase

local function getCosmoCleanseTime(player)
    local cosmoWaitTime = player:hasKeyItem(tpz.ki.RHAPSODY_IN_MAUVE) and 3600 or 72000
    local lastCosmoTime = player:getCharVar("Cosmo_Cleanse_TIME")

    if lastCosmoTime ~= 0 then
        lastCosmoTime = lastCosmoTime + cosmoWaitTime
    end

    if lastCosmoTime <= os.time() then
        return COSMO_READY
    end

    return (lastCosmoTime - 1009843200) - 39600 -- (os.time number - BITMASK for the event) - 11 hours in seconds. Only works in this format (strangely).
end

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    local afUpgrade = player:getCharVar("AFupgrade")

    -- store ancient beastcoins
    if trade:hasItemQty(1875, count) then
        local total = player:getCurrency("ancient_beastcoin") + count

        if total < 9999 then -- store max 9999 ancient beastcoins
            player:addCurrency("ancient_beastcoin", count)
            player:tradeComplete()
            player:startEvent(311, count, 0, 0, 0, 0, 0, 0, total)
        else
            player:messageSpecial(ID.text.SAGHEERA_MAX_ABCS)
        end

    -- af and relic upgrade trades
    elseif afUpgrade == 0 then
        local tradedCombo = 0
        local storedABCs  = player:getCurrency("ancient_beastcoin")

        -- check for af upgrade trades
        for k, v in pairs(afArmorPlusOne) do
            if npcUtil.tradeHasExactly(trade, v.trade) then
                if v.abc <= storedABCs then
                    player:delCurrency("ancient_beastcoin", v.abc)
                    tradedCombo = k
                else
                    player:messageSpecial(ID.text.SAGHEERA_LACK_ABCS)
                end
                break
            end
        end

        -- check for relic upgrade trades
        if tradedCombo == 0 then
            for k, v in pairs(relicArmorPlusOne) do
                if npcUtil.tradeHasExactly(trade, v.trade) then
                    tradedCombo = k
                    break
                end
            end
        end

        -- found a match
        if tradedCombo > 0 then
            local time = os.date("*t")

            player:confirmTrade()
            player:setCharVar("AFupgrade", tradedCombo)
            player:setCharVar("AFupgradeDay", os.time() + (3600 - time.min * 60)) -- Current time + Remaining minutes in the hour in seconds (Day Change)
            player:startEvent(312)
        end
    end
end

function onTrigger(player, npc)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")

    -- LURE OF THE WILDCAT
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(wildcatJeuno, 19) then
        player:startEvent(313)

    -- DEFAULT DIALOG (menu)
    else
        -- event parameters
        local arg3 = 0
        local arg4 = 0
        local afUpgrade = player:getCharVar("AFupgrade")
        local gil = player:getGil()
        local hasCosmoCleanse = 0
        local storedABCs = player:getCurrency("ancient_beastcoin")

        -- if player is waiting for an upgraded af or relic
        if afUpgrade > 0 then
            arg3 = afUpgrade
            if player:getCharVar("AFupgradeDay") > os.time() then
                arg4 = afUpgrade
            end
        end

        -- calculate cosmocleanse parameters
        local cosmoTime = 0

        if player:hasKeyItem(tpz.ki.COSMOCLEANSE) then
            hasCosmoCleanse = 1
        else
            cosmoTime = getCosmoCleanseTime(player)
        end

        player:startEvent(310, 3, arg3, arg4, gil, cosmoTime, 1, hasCosmoCleanse, storedABCs)
    end
end

function onEventUpdate(player, csid, option)
    -- info about af armor upgrades
    if csid == 310 and afArmorPlusOne[option] then
        local info = afArmorPlusOne[option]
        local trade = info.trade
        player:updateEvent(info.reward, trade[1], trade[2], trade[3], trade[4], 0, 0, info.abc)

    -- info about relic armor upgrades
    elseif csid == 310 and relicArmorPlusOne[option] then
        local info = relicArmorPlusOne[option]
        local trade = info.trade
        player:updateEvent(info.reward, trade[1], trade[2], trade[3], trade[4][1], trade[4][2], 0, 0)
    end
end

function onEventFinish(player, csid, option)
    -- LURE OF THE WILDCAT
    if csid == 313 then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 19, true)

    -- purchase cosmocleanse
    elseif csid == 310 and option == 3 then
        local cosmoTime = getCosmoCleanseTime(player)
        if cosmoTime == COSMO_READY and player:delGil(15000) then
            npcUtil.giveKeyItem(player, tpz.ki.COSMOCLEANSE)
        end

    -- purchase item using ancient beastcoins
    elseif csid == 310 and abcShop[option] then
        local purchase = abcShop[option]

        if player:getCurrency("ancient_beastcoin") >= purchase.abc and npcUtil.giveItem(player, purchase.item) then
            player:delCurrency("ancient_beastcoin", purchase.abc)
        end

    -- get upgrade
    elseif csid == 310 and option == 100 then
        local afUpgrade = player:getCharVar("AFupgrade")
        local info = afArmorPlusOne[afUpgrade]
        if info == nil then
            info = relicArmorPlusOne[afUpgrade]
        end

        -- found a valid reward
        if info and npcUtil.giveItem(player, info.reward) then
            player:setCharVar("AFupgrade", 0)
            player:setCharVar("AFupgradeDay", 0)
        end
    end
end
