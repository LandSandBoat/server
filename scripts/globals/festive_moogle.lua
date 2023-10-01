-----------------------------------
-- Festive Moogle
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.festiveMoogle = {}

local festiveMoogleEvents =
{
    [xi.zone.PORT_BASTOK   ] = { 380, 381, 439 },
    [xi.zone.PORT_SAN_DORIA] = { 773, 774, 807 },
    [xi.zone.WINDURST_WALLS] = { 503, 504, 531 },
}

local grantedItems =
{
    [xi.item.NOMAD_CAP      ] = 'festiveMoogleNomadCap',
    [xi.item.MOOGLE_CAP     ] = 'festiveMoogleMoogleCap',
    [xi.item.MOOGLE_ROD     ] = 'festiveMoogleMoogleRod',
    [xi.item.HARPSICHORD    ] = 'festiveMoogleHarpsichord',
    [xi.item.STUFFED_CHOCOBO] = 'festiveMooglestuffedChocobo',
    [xi.item.TIDAL_TALISMAN ] = 'festiveMoogleTidalTalisman',
    [xi.item.DESTRIER_BERET ] = 'festiveMoogleDestrierBeret',
    [xi.item.CHOCOBO_SHIRT  ] = 'festiveMoogleChocoboShirt',
}

local tradeItems =
{
    [xi.item.GOLD_MOG_PELL   ] = 0,
    [xi.item.RED_MOG_PELL    ] = 1,
    [xi.item.GREEN_MOG_PELL  ] = 2,
    [xi.item.OCHRE_MOG_PELL  ] = 3,
    [xi.item.MARBLE_MOG_PELL ] = 4,
    [xi.item.RAINBOW_MOG_PELL] = 5,
    [xi.item.SILVER_MOG_PELL ] = 6,
}

-- NOTE: These items are hardcoded into the events, and cannot be changed!
local rewardItems =
{
    [tradeItems[xi.item.GOLD_MOG_PELL]] =
    {
        [1] = -- Equipment
        {
            [ 0] = xi.item.RIDILL,
            [ 1] = xi.item.JOYEUSE,
            [ 2] = xi.item.BYAKKOS_HAIDATE,
            [ 3] = xi.item.GENBUS_SHIELD,
            [ 4] = xi.item.SEIRYUS_KOTE,
            [ 5] = xi.item.SUZAKUS_SUNE_ATE,
            [ 6] = xi.item.HAUTECLAIRE,
            [ 7] = xi.item.HOFUD,
            [ 8] = xi.item.VALKYRIES_FORK,
            [ 9] = xi.item.ALGOL,
            [10] = xi.item.SEVENEYES,
            [11] = xi.item.NIGHTFALL,
            [12] = xi.item.NOCTURNUS_MAIL,
            [13] = xi.item.NOCTURNUS_HELM,
            [14] = xi.item.UNDECENNIAL_RING,
        },

        [2] = -- Items
        {
            [0] = { xi.item.BEASTMENS_SEAL,              50 },
            [1] = { xi.item.KINDREDS_SEAL,               50 },
            [2] = { xi.item.KINDREDS_CREST,              50 },
            [3] = { xi.item.HIGH_KINDREDS_CREST,         50 },
            [4] = { xi.item.SACRED_KINDREDS_CREST,       50 },
            [5] = { xi.item.COPY_OF_REMS_TALE_CHAPTER_1,  3 },
            [6] = { xi.item.COPY_OF_REMS_TALE_CHAPTER_2,  3 },
            [7] = { xi.item.COPY_OF_REMS_TALE_CHAPTER_3,  3 },
            [8] = { xi.item.COPY_OF_REMS_TALE_CHAPTER_4,  3 },
            [9] = { xi.item.COPY_OF_REMS_TALE_CHAPTER_5,  3 },
        },

        [3] = -- Currency
        {
            [0] = { 'conquest_points',   50000, 'RECEIVED_CONQUEST_POINTS',    3 },
            [1] = { 'imperial_standing', 50000, 'IMPERIAL_STANDING_INCREASED', 2 },
            [2] = { 'allied_notes',      50000, 'EARNED_ALLIED_NOTES',         2 },
            [3] = { 'bayld',             50000, 'RECEIVE_BAYLD',               2 },
            [4] = { 'guild_points',      50000, 'OBTAINED_GUILD_POINTS',       2 },
        },
    },

    [tradeItems[xi.item.RED_MOG_PELL]] =
    {
        [1] = -- Equipment
        {
            [0] = xi.item.ECHAD_RING,
            [1] = xi.item.TRIZEK_RING,
        },

        [2] = -- Items
        {
            [ 0] = { xi.item.BEASTMENS_SEAL,                   40 },
            [ 1] = { xi.item.KINDREDS_SEAL,                    40 },
            [ 2] = { xi.item.KINDREDS_CREST,                   40 },
            [ 3] = { xi.item.HIGH_KINDREDS_CREST,              40 },
            [ 4] = { xi.item.SACRED_KINDREDS_CREST,            40 },
            [ 5] = { xi.item.RALA_VISAGE_IV,                    1 },
            [ 6] = { xi.item.FAITHFULS_TORSO_IV,                1 },
            [ 7] = { xi.item.PAIR_OF_FAITHFULS_LEGS_IV,         1 },
            [ 8] = { xi.item.CIRDAS_VISAGE_IV,                  1 },
            [ 9] = { xi.item.YORCIA_VISAGE_IV,                  1 },
            [10] = { xi.item.RAKAZNAR_VISAGE_IV,                1 },
            [11] = { xi.item.EUDAEMON_BLADE,                    1 },
            [12] = { xi.item.EUDAEMON_CAPE,                     1 },
            [13] = { xi.item.EUDAEMON_RING,                     1 },
            [14] = { xi.item.EUDAEMON_SASH,                     1 },
            [15] = { xi.item.EUDAEMON_SHIELD,                   1 },
            [16] = { xi.item.WAILING_STONE_P1,                 12 },
            [17] = { xi.item.SNOWSLIT_STONE_P1,                12 },
            [18] = { xi.item.LEAFSLIT_STONE_P1,                12 },
            [19] = { xi.item.DUSKSLIT_STONE_P1,                12 },
            [20] = { xi.item.SNOWTIP_STONE_P1,                 12 },
            [21] = { xi.item.LEAFTIP_STONE_P1,                 12 },
            [22] = { xi.item.DUSKTIP_STONE_P1,                 12 },
            [23] = { xi.item.SNOWDIM_STONE_P1,                 12 },
            [24] = { xi.item.LEAFDIM_STONE_P1,                 12 },
            [25] = { xi.item.DUSKDIM_STONE_P1,                 12 },
            [26] = { xi.item.SNOWORB_STONE_P1,                 12 },
            [27] = { xi.item.LEAFORB_STONE_P1,                 12 },
            [28] = { xi.item.DUSKORB_STONE_P1,                 12 },
            [29] = { xi.item.PULCHRIDOPT_WING,                  6 },
            [30] = { xi.item.LEBONDOPT_WING,                    6 },
            [31] = { xi.item.MELLIDOPT_WING,                    6 },
            [32] = { xi.item.CIPHER_OF_ZEIDS_ALTER_EGO,         1 },
            [33] = { xi.item.CIPHER_OF_LIONS_ALTER_EGO,         1 },
            [34] = { xi.item.CIPHER_OF_NAJAS_ALTER_EGO,         1 },
            [35] = { xi.item.CIPHER_OF_LEHKOS_ALTER_EGO,        1 },
            [36] = { xi.item.CIPHER_OF_LUZAFS_ALTER_EGO,        1 },
            [37] = { xi.item.CIPHER_OF_NAJELITHS_ALTER_EGO,     1 },
            [38] = { xi.item.CIPHER_OF_ALDOS_ALTER_EGO,         1 },
            [39] = { xi.item.CIPHER_OF_A_MOOGLES_ALTER_EGO,     1 },
            [40] = { xi.item.CIPHER_OF_FABLINIXS_ALTER_EGO,     1 },
            [41] = { xi.item.CIPHER_OF_D_SHANTOTTOS_ALTER_EGO,  1 },
            [42] = { xi.item.CIPHER_OF_STAR_SIBYLS_ALTER_EGO,   1 },
            [43] = { xi.item.CIPHER_OF_UKAS_ALTER_EGO,          1 },
            [44] = { xi.item.CIPHER_OF_KUYINS_ALTER_EGO,        1 },
            [45] = { xi.item.CIPHER_OF_KARAHAS_ALTER_EGO,       1 },
            [46] = { xi.item.CIPHER_OF_ABENZIOS_ALTER_EGO,      1 },
            [47] = { xi.item.CIPHER_OF_RUGHADJEENS_ALTER_EGO,   1 },
            [48] = { xi.item.CIPHER_OF_AREUHATS_ALTER_EGO,      1 },
            [49] = { xi.item.CIPHER_OF_LHES_ALTER_EGO,          1 },
            [50] = { xi.item.CIPHER_OF_MAYAKOVS_ALTER_EGO,      1 },
            [51] = { xi.item.CIPHER_OF_BRYGIDS_ALTER_EGO,       1 },
            [52] = { xi.item.CIPHER_OF_MILDAURIONS_ALTER_EGO,   1 },
            [53] = { xi.item.CIPHER_OF_RONGELOUTSS_ALTER_EGO,   1 },
            [54] = { xi.item.CIPHER_OF_KUPOFRIEDS_ALTER_EGO,    1 },
        },
    },

    [tradeItems[xi.item.GREEN_MOG_PELL]] =
    {
        [1] = -- Equipment
        {
            [ 0] = xi.item.GOBLIN_SUIT,
            [ 1] = xi.item.GREEN_MOOGLE_SUIT,
            [ 2] = xi.item.GOBLIN_MASQUE,
            [ 3] = xi.item.GREEN_MOOGLE_MASQUE,
            [ 4] = xi.item.MORBOL_CAP,
            [ 5] = xi.item.MORBOL_SHIELD,
            [ 6] = xi.item.CAIT_SITH_GUARD,
            [ 7] = xi.item.CAIT_SITH_CAP,
            [ 8] = xi.item.ALLIANCE_SHIRT,
            [ 9] = xi.item.ALLIANCE_PANTS,
            [10] = xi.item.ALLIANCE_BOOTS,
            [11] = xi.item.WORM_FEELERS,
            [12] = xi.item.WORM_MASQUE,
            [13] = xi.item.KYUKA_UCHIWA,
            [14] = xi.item.ARK_TACHI,
            [15] = xi.item.ARK_SABER,
            [16] = xi.item.ARK_SCYTHE,
            [17] = xi.item.ARK_TABAR,
            [18] = xi.item.ARK_SWORD,
            [19] = xi.item.CHOCOBO_MASQUE,
            [20] = xi.item.CHOCOBO_SUIT,
            [21] = xi.item.BOMB_MASQUE,
            [22] = xi.item.EXCALIPOOR,
            [23] = xi.item.PUPILS_SHIRT,
            [24] = xi.item.PUPILS_TROUSERS,
            [25] = xi.item.PUPILS_SHOES,
            [26] = xi.item.PUPILS_CAMISA,
            [27] = xi.item.LYCOPODIUM_MASQUE,
            [28] = xi.item.LEAFKIN_CAP,
            [29] = xi.item.SHEEP_CAP,
            [30] = xi.item.HEARTBEATER,
            [31] = xi.item.POROGGO_COAT,
            [32] = xi.item.DUODECENNIAL_RING,
            [33] = xi.item.VOCATION_RING,
        },

        [2] = -- Items
        {
            [0] = { xi.item.COPPER_AMAN_VOUCHER, 10 },
            [1] = { xi.item.CHERRY_TREE,          1 },
            [2] = { xi.item.FAR_EAST_HEARTH,      1 },
        },
    },

    [tradeItems[xi.item.OCHRE_MOG_PELL]] =
    {
        [2] = -- Items
        {
            [ 0] = { xi.item.CIPHER_OF_ZEIDS_ALTER_EGO,         1 },
            [ 1] = { xi.item.CIPHER_OF_LIONS_ALTER_EGO,         1 },
            [ 2] = { xi.item.CIPHER_OF_TENZENS_ALTER_EGO,       1 },
            [ 3] = { xi.item.CIPHER_OF_MIHLIS_ALTER_EGO,        1 },
            [ 4] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO,   1 },
            [ 5] = { xi.item.CIPHER_OF_JOACHIMS_ALTER_EGO,      1 },
            [ 6] = { xi.item.CIPHER_OF_NAJAS_ALTER_EGO,         1 },
            [ 7] = { xi.item.CIPHER_OF_LEHKOS_ALTER_EGO,        1 },
            [ 8] = { xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,       1 },
            [ 9] = { xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO,      1 },
            [10] = { xi.item.CIPHER_OF_SAKURAS_ALTER_EGO,       1 },
            [11] = { xi.item.CIPHER_OF_LUZAFS_ALTER_EGO,        1 },
            [12] = { xi.item.CIPHER_OF_NAJELITHS_ALTER_EGO,     1 },
            [13] = { xi.item.CIPHER_OF_ALDOS_ALTER_EGO,         1 },
            [14] = { xi.item.CIPHER_OF_A_MOOGLES_ALTER_EGO,     1 },
            [15] = { xi.item.CIPHER_OF_FABLINIXS_ALTER_EGO,     1 },
            [16] = { xi.item.CIPHER_OF_D_SHANTOTTOS_ALTER_EGO,  1 },
            [17] = { xi.item.CIPHER_OF_ELIVIRAS_ALTER_EGO,      1 },
            [18] = { xi.item.CIPHER_OF_NOILLURIES_ALTER_EGO,    1 },
            [19] = { xi.item.CIPHER_OF_LHUS_ALTER_EGO,          1 },
            [20] = { xi.item.CIPHER_OF_F_COFFINS_ALTER_EGO,     1 },
            [21] = { xi.item.CIPHER_OF_STAR_SIBYLS_ALTER_EGO,   1 },
            [22] = { xi.item.CIPHER_OF_MUMORS_ALTER_EGO,        1 },
            [23] = { xi.item.CIPHER_OF_UKAS_ALTER_EGO,          1 },
            [24] = { xi.item.CIPHER_OF_CIDS_ALTER_EGO,          1 },
            [25] = { xi.item.CIPHER_OF_RAHALS_ALTER_EGO,        1 },
            [26] = { xi.item.CIPHER_OF_KORU_MORUS_ALTER_EGO,    1 },
            [27] = { xi.item.CIPHER_OF_KUYINS_ALTER_EGO,        1 },
            [28] = { xi.item.CIPHER_OF_KARAHAS_ALTER_EGO,       1 },
            [29] = { xi.item.CIPHER_OF_BABBANS_ALTER_EGO,       1 },
            [30] = { xi.item.CIPHER_OF_ABENZIOS_ALTER_EGO,      1 },
            [31] = { xi.item.CIPHER_OF_RUGHADJEENS_ALTER_EGO,   1 },
            [32] = { xi.item.CIPHER_OF_KUKKIS_ALTER_EGO,        1 },
            [33] = { xi.item.CIPHER_OF_MARGRETS_ALTER_EGO,      1 },
            [34] = { xi.item.CIPHER_OF_GILGAMESHS_ALTER_EGO,    1 },
            [35] = { xi.item.CIPHER_OF_AREUHATS_ALTER_EGO,      1 },
            [36] = { xi.item.CIPHER_OF_LHES_ALTER_EGO,          1 },
            [37] = { xi.item.CIPHER_OF_MAYAKOVS_ALTER_EGO,      1 },
            [38] = { xi.item.CIPHER_OF_QULTADAS_ALTER_EGO,      1 },
            [39] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,     1 },
            [40] = { xi.item.CIPHER_OF_AMCHUCHUS_ALTER_EGO,     1 },
            [41] = { xi.item.CIPHER_OF_BRYGIDS_ALTER_EGO,       1 },
            [42] = { xi.item.CIPHER_OF_MILDAURIONS_ALTER_EGO,   1 },
            [43] = { xi.item.CIPHER_OF_RONGELOUTSS_ALTER_EGO,   1 },
            [44] = { xi.item.CIPHER_OF_KUPOFRIEDS_ALTER_EGO,    1 },
            [45] = { xi.item.CIPHER_OF_LEONOYNES_ALTER_EGO,     1 },
            [46] = { xi.item.CIPHER_OF_MAXIMILIANS_ALTER_EGO,   1 },
            [47] = { xi.item.CIPHER_OF_KAYEELS_ALTER_EGO,       1 },
            [48] = { xi.item.CIPHER_OF_ROBEL_AKBELS_ALTER_EGO,  1 },
            [49] = { xi.item.CIPHER_OF_INGRIDS_ALTER_EGO_II,    1 },
            [50] = { xi.item.CIPHER_OF_AUGUSTS_ALTER_EGO,       1 },
            [51] = { xi.item.CIPHER_OF_ROSULATIAS_ALTER_EGO,    1 },
            [52] = { xi.item.CIPHER_OF_MUMORS_ALTER_EGO_II,     1 },
            [53] = { xi.item.CIPHER_OF_ULLEGORES_ALTER_EGO,     1 },
            [54] = { xi.item.CIPHER_OF_TEODORS_ALTER_EGO,       1 },
            [55] = { xi.item.CIPHER_OF_MAKKIS_ALTER_EGO,        1 },
            [56] = { xi.item.CIPHER_OF_KINGS_ALTER_EGO,         1 },
            [57] = { xi.item.CIPHER_OF_MORIMARS_ALTER_EGO,      1 },
            [58] = { xi.item.CIPHER_OF_DARRCUILNS_ALTER_EGO,    1 },
            [59] = { xi.item.CIPHER_OF_SHANTOTTOS_ALTER_EGO_II, 1 },
        },
    },

    [tradeItems[xi.item.MARBLE_MOG_PELL]] =
    {
        [2] = -- Items
        {
            [ 0] = { xi.item.ADAMANTOISE_STATUE,     1 },
            [ 1] = { xi.item.BEHEMOTH_STATUE,        1 },
            [ 2] = { xi.item.FAFNIR_STATUE,          1 },
            [ 3] = { xi.item.NOMAD_MOOGLE_STATUE,    1 },
            [ 4] = { xi.item.SHADOW_LORD_STATUE,     1 },
            [ 5] = { xi.item.ODIN_STATUE,            1 },
            [ 6] = { xi.item.ALEXANDER_STATUE,       1 },
            [ 7] = { xi.item.ARK_ANGEL_HM_STATUE,    1 },
            [ 8] = { xi.item.ARK_ANGEL_EV_STATUE,    1 },
            [ 9] = { xi.item.ARK_ANGEL_TT_STATUE,    1 },
            [10] = { xi.item.ARK_ANGEL_MR_STATUE,    1 },
            [11] = { xi.item.ARK_ANGEL_GK_STATUE,    1 },
            [12] = { xi.item.PRISHE_STATUE,          1 },
            [13] = { xi.item.CARDIAN_STATUE,         1 },
            [14] = { xi.item.SHADOW_LORD_STATUE_II,  1 },
            [15] = { xi.item.SHADOW_LORD_STATUE_III, 1 },
            [16] = { xi.item.ATOMOS_STATUE,          1 },
            [17] = { xi.item.YOVRA_REPLICA,          1 },
            [18] = { xi.item.GOOBBUE_STATUE,         1 },
            [19] = { xi.item.LAMB_CARVING,           1 },
            [20] = { xi.item.POLISHED_LAMB_CARVING,  1 },
        },
    },

    [tradeItems[xi.item.RAINBOW_MOG_PELL]] =
    {
        [2] = -- Items
        {
            [ 0] = { xi.item.MOOGLE_ROD,            1 },
            [ 1] = { xi.item.NOMAD_MOOGLE_ROD,      1 },
            [ 2] = { xi.item.MOOGLE_CAP,            1 },
            [ 3] = { xi.item.NOMAD_CAP,             1 },
            [ 4] = { xi.item.TIDAL_TALISMAN,        1 },
            [ 5] = { xi.item.TOWN_MOOGLE_SHIELD,    1 },
            [ 6] = { xi.item.NOMAD_MOOGLE_SHIELD,   1 },
            [ 7] = { xi.item.CHOCOBO_BERET,         1 },
            [ 8] = { xi.item.DESTRIER_BERET,        1 },
            [ 9] = { xi.item.MAESTROS_BATON,        1 },
            [10] = { xi.item.MOOGLE_MASQUE,         1 },
            [11] = { xi.item.MOOGLE_SUIT,           1 },
            [12] = { xi.item.SHELL_SCEPTER,         1 },
            [13] = { xi.item.GOBBIE_GAVEL,          1 },
            [14] = { xi.item.MELOMANE_MALLET,       1 },
            [15] = { xi.item.MANDRAGUARD,           1 },
            [16] = { xi.item.CHOCOBO_SHIRT,         1 },
            [17] = { xi.item.KORRIGAN_BERET,        1 },
            [18] = { xi.item.DECAZOOM_MK_XI,        1 },
            [19] = { xi.item.ESCRITORIO,            1 },
            [20] = { xi.item.HARPSICHORD,           1 },
            [21] = { xi.item.STUFFED_CHOCOBO,       1 },
            [22] = { xi.item.SPINET,                1 },
            [23] = { xi.item.NANAA_MIHGO_STATUE,    1 },
            [24] = { xi.item.NANAA_MIHGO_STATUE_II, 1 },
        },
    },

    [tradeItems[xi.item.SILVER_MOG_PELL]] =
    {
        [1] = -- Equipment
        {
            [ 0] = xi.item.CICHOLS_MANTLE,
            [ 1] = xi.item.SEGOMOS_MANTLE,
            [ 2] = xi.item.ALAUNUSS_CAPE,
            [ 3] = xi.item.TARANUSS_CAPE,
            [ 4] = xi.item.SUCELLOSS_CAPE,
            [ 5] = xi.item.TOUTATISS_CAPE,
            [ 6] = xi.item.RUDIANOSS_MANTLE,
            [ 7] = xi.item.ANKOUS_MANTLE,
            [ 8] = xi.item.ARTIOS_MANTLE,
            [ 9] = xi.item.INTARABUSS_CAPE,
            [10] = xi.item.BELENUSS_CAPE,
            [11] = xi.item.SMERTRIOSS_MANTLE,
            [12] = xi.item.ANDARTIAS_MANTLE,
            [13] = xi.item.BRIGANTIAS_MANTLE,
            [14] = xi.item.CAMPESTRESS_CAPE,
            [15] = xi.item.ROSMERTAS_CAPE,
            [16] = xi.item.CAMULUSS_MANTLE,
            [17] = xi.item.VISUCIUSS_MANTLE,
            [18] = xi.item.SENUNAS_MANTLE,
            [19] = xi.item.LUGHS_CAPE,
            [20] = xi.item.NANTOSUELTAS_CAPE,
            [21] = xi.item.OGMAS_CAPE,
        },

        [2] = -- Items
        {
            [ 0] = { xi.item.BEASTMENS_SEAL,           60 },
            [ 1] = { xi.item.KINDREDS_SEAL,            60 },
            [ 2] = { xi.item.KINDREDS_CREST,           60 },
            [ 3] = { xi.item.HIGH_KINDREDS_CREST,      60 },
            [ 4] = { xi.item.SACRED_KINDREDS_CREST,    60 },
            [ 5] = { xi.item.ROLANBERRY_DELIGHTARU,     1 },
            [ 6] = { xi.item.HARVEST_PASTRY,            1 },
            [ 7] = { xi.item.CHERRY_TREE,               1 },
            [ 8] = { xi.item.FAR_EAST_HEARTH,           1 },
            [ 9] = { xi.item.POT_OF_WARDS,              1 },
            [10] = { xi.item.POT_OF_WHITE_CLEMATIS,     1 },
            [11] = { xi.item.POT_OF_PINK_CLEMATIS,      1 },
            [12] = { xi.item.BIRCH_TREE,                1 },
            [13] = { xi.item.SPOOL_OF_ABDHALJS_THREAD, 10 },
            [14] = { xi.item.PINCH_OF_ABDHALJS_DUST,   10 },
            [15] = { xi.item.BOTTLE_OF_ABDHALJS_SAP,    5 },
            [16] = { xi.item.POT_OF_ABDHALJS_DYE,       3 },
            [17] = { xi.item.ABDHALJS_SEAL,             2 },
            [18] = { xi.item.ABDHALJS_NEEDLE,           1 },
            [19] = { xi.item.AMBUSCADE_VOUCHER_HEAD,    1 },
            [20] = { xi.item.AMBUSCADE_VOUCHER_BODY,    1 },
            [21] = { xi.item.AMBUSCADE_VOUCHER_HANDS,   1 },
            [22] = { xi.item.AMBUSCADE_VOUCHER_LEGS,    1 },
            [23] = { xi.item.AMBUSCADE_VOUCHER_FEET,    1 },
            [24] = { xi.item.MOUNT_TIGER,               1 },
            [25] = { xi.item.MOUNT_CRAB,                1 },
            [26] = { xi.item.MOUNT_RED_CRAB,            1 },
            [27] = { xi.item.MOUNT_BOMB,                1 },
            [28] = { xi.item.MOUNT_CRAWLER,             1 },
        },
    },
}

local function getFestiveItems(player)
    local availableItems = {}

    for itemId, varName in pairs(grantedItems) do
        if player:getCharVar(varName) == 1 then
            table.insert(availableItems, itemId)
        end
    end

    return availableItems
end

xi.festiveMoogle.onTrade = function(player, npc, trade)
    for pellItemId, pellType in pairs(tradeItems) do
        if npcUtil.tradeHasExactly(trade, pellItemId) then
            local craftingGuild = player:getCharVar('[GUILD]currentGuild') - 1
            local equipmentMask = 0

            -- Build a mask for denying the player Rare/Ex equipment that they already own.  This
            -- appears to only be valid for the equipment category, and not for items.
            if rewardItems[pellType][1] then
                for bitPos, rewardItemId in pairs(rewardItems[pellType][1]) do
                    local itemObj = GetItemByID(rewardItemId)

                    if
                        itemObj and
                        bit.band(itemObj:getFlag(), xi.itemFlag.RARE) ~= 0 and
                        player:hasItem(rewardItemId)
                    then
                        equipmentMask = utils.mask.setBit(equipmentMask, bitPos, true)
                    end
                end
            end

            player:setLocalVar('tradedPell', pellItemId)

            player:startEvent(festiveMoogleEvents[player:getZoneID()][3], 0, pellType, equipmentMask, 0, craftingGuild)
        end
    end
end

xi.festiveMoogle.onTrigger = function(player, npc)
    local zoneId       = player:getZoneID()
    local festiveItems = getFestiveItems(player)

    if #festiveItems > 0 then
        player:startEvent(festiveMoogleEvents[zoneId][1], unpack(festiveItems))
    else
        player:startEvent(festiveMoogleEvents[zoneId][2])
    end
end

xi.festiveMoogle.onEventUpdate = function(player, csid, option, npc)
end

xi.festiveMoogle.onEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()

    -- Granted Item was selected
    if
        csid == festiveMoogleEvents[zoneId][1] and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        local festiveItems = getFestiveItems(player)
        local itemId       = festiveItems[option]

        if npcUtil.giveItem(player, itemId) then
            player:setCharVar(grantedItems[itemId], 0)
        end

    -- Pell Item was selected
    elseif csid == festiveMoogleEvents[zoneId][3] then
        local ID = zones[zoneId]

        if option ~= utils.EVENT_CANCELLED_OPTION then
            local pellType     = bit.band(bit.rshift(option, 8), 0xFF)
            local itemCategory = bit.band(option, 0xFF)
            local selectedItem = bit.rshift(option, 16)
            local rewardEntry  = rewardItems[pellType][itemCategory][selectedItem]

            if itemCategory == 3 then
                if rewardEntry[1] == 'conquest_points' then
                    player:addCP(rewardEntry[2])
                elseif rewardEntry[1] == 'guild_points' then
                    local craftingGuild = player:getCharVar('[GUILD]currentGuild') - 1

                    player:addCurrency(xi.crafting.guildTable[craftingGuild][2], rewardEntry[2])
                else
                    player:addCurrency(rewardEntry[1], rewardEntry[2])
                end

                local messageParams = { 0, 0, 0 }

                messageParams[1]              = ID.text[rewardEntry[3]]
                messageParams[rewardEntry[4]] = rewardEntry[2]

                player:messageSpecial(unpack(messageParams))
                player:confirmTrade()
            else
                if npcUtil.giveItem(player, { rewardEntry }) then
                    player:confirmTrade()
                end
            end
        else
            player:messageSpecial(ID.text.ITEM_RETURNED, player:getLocalVar('tradedPell'))
        end
    end
end
