-----------------------------------
-- Porter Moogle Utilities
-- desc: Common functionality for Porter Moogles.
-----------------------------------
require('scripts/globals/items')
-----------------------------------
xi = xi or {}
xi.porter_moogle = xi.porter_moogle or {}

-- Item IDs for all of the slips.
local slipIds =
{
    xi.items.MOOGLE_STORAGE_SLIP_01,
    xi.items.MOOGLE_STORAGE_SLIP_02,
    xi.items.MOOGLE_STORAGE_SLIP_03,
    xi.items.MOOGLE_STORAGE_SLIP_04,
    xi.items.MOOGLE_STORAGE_SLIP_05,
    xi.items.MOOGLE_STORAGE_SLIP_06,
    xi.items.MOOGLE_STORAGE_SLIP_07,
    xi.items.MOOGLE_STORAGE_SLIP_08,
    xi.items.MOOGLE_STORAGE_SLIP_09,
    xi.items.MOOGLE_STORAGE_SLIP_10,
    xi.items.MOOGLE_STORAGE_SLIP_11,
    xi.items.MOOGLE_STORAGE_SLIP_12,
    xi.items.MOOGLE_STORAGE_SLIP_13,
    xi.items.MOOGLE_STORAGE_SLIP_14,
    xi.items.MOOGLE_STORAGE_SLIP_15,
    xi.items.MOOGLE_STORAGE_SLIP_16,
    xi.items.MOOGLE_STORAGE_SLIP_17,
    xi.items.MOOGLE_STORAGE_SLIP_18,
    xi.items.MOOGLE_STORAGE_SLIP_19,
    xi.items.MOOGLE_STORAGE_SLIP_20,
    xi.items.MOOGLE_STORAGE_SLIP_21,
    xi.items.MOOGLE_STORAGE_SLIP_22,
    xi.items.MOOGLE_STORAGE_SLIP_23,
    xi.items.MOOGLE_STORAGE_SLIP_24,
    xi.items.MOOGLE_STORAGE_SLIP_25,
    xi.items.MOOGLE_STORAGE_SLIP_26,
    xi.items.MOOGLE_STORAGE_SLIP_27,
    xi.items.MOOGLE_STORAGE_SLIP_28,
}

-- Item IDs for the items stored on each slip. Zero-based index in the table represents the bit indicating if the slip has the item stored.
local slipItems =
{
    [xi.items.MOOGLE_STORAGE_SLIP_01] =
    {
        xi.items.ARES_MASK,
        xi.items.ARES_CUIRASS,
        xi.items.ARES_GAUNTLETS,
        xi.items.ARES_FLANCHARD,
        xi.items.ARES_SOLLERETS,
        xi.items.ENYOS_MASK,
        xi.items.ENYOS_BREASTPLATE,
        xi.items.ENYOS_GAUNTLETS,
        xi.items.ENYOS_CUISSES,
        xi.items.ENYOS_LEGGINGS,
        xi.items.PHOBOSS_MASK,
        xi.items.PHOBOSS_CUIRASS,
        xi.items.PHOBOSS_GAUNTLETS,
        xi.items.PHOBOSS_CUISSES,
        xi.items.PHOBOSS_SABATONS,
        xi.items.DEIMOSS_MASK,
        xi.items.DEIMOSS_CUIRASS,
        xi.items.DEIMOSS_GAUNTLETS,
        xi.items.DEIMOSS_CUISSES,
        xi.items.DEIMOSS_LEGGINGS,
        xi.items.SKADIS_VISOR,
        xi.items.SKADIS_CUIRIE,
        xi.items.SKADIS_BAZUBANDS,
        xi.items.SKADIS_CHAUSSES,
        xi.items.SKADIS_JAMBEAUX,
        xi.items.NJORDS_MASK,
        xi.items.NJORDS_JERKIN,
        xi.items.NJORDS_GLOVES,
        xi.items.NJORDS_TROUSERS,
        xi.items.NJORDS_LEDELSENS,
        xi.items.FREYRS_MASK,
        xi.items.FREYRS_JERKIN,
        xi.items.FREYRS_GLOVES,
        xi.items.FREYRS_TROUSERS,
        xi.items.FREYRS_LEDELSENS,
        xi.items.FREYAS_MASK,
        xi.items.FREYAS_JERKIN,
        xi.items.FREYAS_GLOVES,
        xi.items.FREYAS_TROUSERS,
        xi.items.FREYAS_LEDELSENS,
        xi.items.USUKANE_SOMEN,
        xi.items.USUKANE_HARAMAKI,
        xi.items.USUKANE_GOTE,
        xi.items.USUKANE_HIZAYOROI,
        xi.items.USUKANE_SUNE_ATE,
        xi.items.HOSHIKAZU_HACHIMAKI,
        xi.items.HOSHIKAZU_GI,
        xi.items.HOSHIKAZU_TEKKO,
        xi.items.HOSHIKAZU_HAKAMA,
        xi.items.HOSHIKAZU_KYAHAN,
        xi.items.TSUKIKAZU_JINPACHI,
        xi.items.TSUKIKAZU_TOGI,
        xi.items.TSUKIKAZU_GOTE,
        xi.items.TSUKIKAZU_HAIDATE,
        xi.items.TSUKIKAZU_SUNE_ATE,
        xi.items.HIKAZU_KABUTO,
        xi.items.HIKAZU_HARA_ATE,
        xi.items.HIKAZU_GOTE,
        xi.items.HIKAZU_HAKAMA,
        xi.items.HIKAZU_SUNE_ATE,
        xi.items.MARDUKS_TIARA,
        xi.items.MARDUKS_JUBBAH,
        xi.items.MARDUKS_DASTANAS,
        xi.items.MARDUKS_SHALWAR,
        xi.items.MARDUKS_CRACKOWS,
        xi.items.ANUS_TIARA,
        xi.items.ANUS_DOUBLET,
        xi.items.ANUS_GAGES,
        xi.items.ANUS_BRAIS,
        xi.items.ANUS_GAITERS,
        xi.items.EAS_TIARA,
        xi.items.EAS_DOUBLET,
        xi.items.EAS_DASTANAS,
        xi.items.EAS_BRAIS,
        xi.items.EAS_CRACKOWS,
        xi.items.ENLILS_TIARA,
        xi.items.ENLILS_GAMBISON,
        xi.items.ENLILS_KOLLUKS,
        xi.items.ENLILS_BRAYETTES,
        xi.items.ENLILS_CRACKOWS,
        xi.items.MORRIGANS_CORONAL,
        xi.items.MORRIGANS_ROBE,
        xi.items.MORRIGANS_CUFFS,
        xi.items.MORRIGANS_SLOPS,
        xi.items.MORRIGANS_PIGACHES,
        xi.items.NEMAINS_CROWN,
        xi.items.NEMAINS_ROBE,
        xi.items.NEMAINS_CUFFS,
        xi.items.NEMAINS_SLOPS,
        xi.items.NEMAINS_SABOTS,
        xi.items.BODBS_CROWN,
        xi.items.BODBS_ROBE,
        xi.items.BODBS_CUFFS,
        xi.items.BODBS_SLOPS,
        xi.items.BODBS_PIGACHES,
        xi.items.MACHAS_CROWN,
        xi.items.MACHAS_COAT,
        xi.items.MACHAS_CUFFS,
        xi.items.MACHAS_SLOPS,
        xi.items.MACHAS_PIGACHES,
        xi.items.ASKAR_ZUCCHETTO,
        xi.items.ASKAR_KORAZIN,
        xi.items.ASKAR_MANOPOLAS,
        xi.items.ASKAR_DIRS,
        xi.items.ASKAR_GAMBIERAS,
        xi.items.DENALI_BONNET,
        xi.items.DENALI_JACKET,
        xi.items.DENALI_WRISTBANDS,
        xi.items.DENALI_KECKS,
        xi.items.DENALI_GAMASHES,
        xi.items.GOLIARD_CHAPEAU,
        xi.items.GOLIARD_SAIO,
        xi.items.GOLIARD_CUFFS,
        xi.items.GOLIARD_TREWS,
        xi.items.GOLIARD_CLOGS,
        xi.items.PERDU_SWORD,
        xi.items.PERDU_HANGER,
        xi.items.PERDU_BLADE,
        xi.items.PERDU_VOULGE,
        xi.items.PERDU_STAFF,
        xi.items.PERDU_BOW,
        xi.items.PERDU_CROSSBOW,
        xi.items.PERDU_WAND,
        xi.items.PERDU_SICKLE,
        xi.items.PAHLUWAN_QALANSUWA,
        xi.items.PAHLUWAN_KHAZAGAND,
        xi.items.PAHLUWAN_DASTANAS,
        xi.items.PAHLUWAN_SERAWEELS,
        xi.items.PAHLUWAN_CRACKOWS,
        xi.items.AMIR_PUGGAREE,
        xi.items.AMIR_KORAZIN,
        xi.items.AMIR_KOLLUKS,
        xi.items.AMIR_DIRS,
        xi.items.AMIR_BOOTS,
        xi.items.YIGIT_TURBAN,
        xi.items.YIGIT_GOMLEK,
        xi.items.YIGIT_GAGES,
        xi.items.YIGIT_SERAWEELS,
        xi.items.YIGIT_CRACKOWS,
        xi.items.IMPERIAL_KAMAN,
        xi.items.STORM_ZAGHNAL,
        xi.items.STORM_FIFE,
        xi.items.IMPERIAL_GUN,
        xi.items.KHANJAR,
        xi.items.HOTARUMARU,
        xi.items.IMPERIAL_NEZA,
        xi.items.STORM_TABAR,
        xi.items.STORM_TULWAR,
        xi.items.IMPERIAL_BHUJ,
        xi.items.YIGIT_BULAWA,
        xi.items.PAHLUWAN_PATAS,
        xi.items.IMPERIAL_POLE,
        xi.items.SAYOSAMONJI,
        xi.items.DOOMBRINGER,
        xi.items.RITTER_GORGET,
        xi.items.KUBIRA_BEAD_NECKLACE,
        xi.items.MORGANAS_CHOKER,
        xi.items.ASLAN_CAPE,
        xi.items.GLEEMANS_CAPE,
        xi.items.BUCCANEERS_BELT,
        xi.items.IOTA_RING,
        xi.items.OMEGA_RING,
        xi.items.DELTA_EARRING,
        xi.items.HOFUD,
        xi.items.VALKYRIES_FORK,
        xi.items.VALHALLA_HELM,
        xi.items.VALHALLA_BREASTPLATE,
        xi.items.ANIMATOR_P1,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_01] =
    {
        xi.items.KOENIG_SCHALLER,
        xi.items.KOENIG_CUIRASS,
        xi.items.KOENIG_HANDSCHUHS,
        xi.items.KOENIG_DIECHLINGS,
        xi.items.KOENIG_SCHUHS,
        xi.items.KAISER_SCHALLER,
        xi.items.KAISER_CUIRASS,
        xi.items.KAISER_HANDSCHUHS,
        xi.items.KAISER_DIECHLINGS,
        xi.items.KAISER_SCHUHS,
        xi.items.ADAMAN_CELATA,
        xi.items.ADAMAN_HAUBERK,
        xi.items.ADAMAN_MUFFLERS,
        xi.items.ADAMAN_BREECHES,
        xi.items.ADAMAN_SOLLERETS,
        xi.items.ARMADA_CELATA,
        xi.items.ARMADA_HAUBERK,
        xi.items.ARMADA_MUFFLERS,
        xi.items.ARMADA_BREECHES,
        xi.items.ARMADA_SOLLERETS,
        xi.items.SHURA_ZUNARI_KABUTO,
        xi.items.SHURA_TOGI,
        xi.items.SHURA_KOTE,
        xi.items.SHURA_HAIDATE,
        xi.items.SHURA_SUNE_ATE,
        xi.items.SHURA_ZUNARI_KABUTO_P1,
        xi.items.SHURA_TOGI_P1,
        xi.items.SHURA_KOTE_P1,
        xi.items.SHURA_HAIDATE_P1,
        xi.items.SHURA_SUNE_ATE_P1,
        xi.items.ZENITH_CROWN,
        xi.items.DALMATICA,
        xi.items.ZENITH_MITTS,
        xi.items.ZENITH_SLACKS,
        xi.items.ZENITH_PUMPS,
        xi.items.ZENITH_CROWN_P1,
        xi.items.DALMATICA_P1,
        xi.items.ZENITH_MITTS_P1,
        xi.items.ZENITH_SLACKS_P1,
        xi.items.ZENITH_PUMPS_P1,
        xi.items.CRIMSON_MASK,
        xi.items.CRIMSON_SCALE_MAIL,
        xi.items.CRIMSON_FINGER_GAUNTLETS,
        xi.items.CRIMSON_CUISSES,
        xi.items.CRIMSON_GREAVES,
        xi.items.BLOOD_MASK,
        xi.items.BLOOD_SCALE_MAIL,
        xi.items.BLOOD_FINGER_GAUNTLETS,
        xi.items.BLOOD_CUISSES,
        xi.items.BLOOD_GREAVES,
        xi.items.SHADOW_HELM,
        xi.items.SHADOW_BREASTPLATE,
        xi.items.SHADOW_GAUNTLETS,
        xi.items.SHADOW_CUISHES,
        xi.items.SHADOW_SABATONS,
        xi.items.SHADOW_HAT,
        xi.items.SHADOW_COAT,
        xi.items.SHADOW_CUFFS,
        xi.items.SHADOW_TREWS,
        xi.items.SHADOW_CLOGS,
        xi.items.VALKYRIES_HELM,
        xi.items.VALKYRIES_BREASTPLATE,
        xi.items.VALKYRIES_GAUNTLETS,
        xi.items.VALKYRIES_CUISHES,
        xi.items.VALKYRIES_SABATONS,
        xi.items.VALKYRIES_HAT,
        xi.items.VALKYRIES_COAT,
        xi.items.VALKYRIES_CUFFS,
        xi.items.VALKYRIES_TREWS,
        xi.items.VALKYRIES_CLOGS,
        xi.items.BYAKKOS_HAIDATE,
        xi.items.BYAKKOS_AXE,
        xi.items.SUZAKUS_SUNE_ATE,
        xi.items.SUZAKUS_SCYTHE,
        xi.items.SEIRYUS_KOTE,
        xi.items.SEIRYUS_SWORD,
        xi.items.GENBUS_SHIELD,
        xi.items.GENBUS_KABUTO,
        xi.items.MERCIFUL_CAPE,
        xi.items.ALTRUISTIC_CAPE,
        xi.items.ASTUTE_CAPE,
        xi.items.JUSTICE_TORQUE,
        xi.items.HOPE_TORQUE,
        xi.items.PRUDENCE_TORQUE,
        xi.items.FORTITUDE_TORQUE,
        xi.items.FAITH_TORQUE,
        xi.items.TEMPERANCE_TORQUE,
        xi.items.LOVE_TORQUE,
        xi.items.JUSTICE_SWORD,
        xi.items.HOPE_STAFF,
        xi.items.PRUDENCE_ROD,
        xi.items.FAITH_BAGHNAKHS,
        xi.items.FORTITUDE_AXE,
        xi.items.TEMPERANCE_AXE,
        xi.items.LOVE_HALBERD,
        xi.items.CHARGER_MANTLE,
        xi.items.JAEGER_MANTLE,
        xi.items.BOXERS_MANTLE,
        xi.items.GUNNERS_MANTLE,
        xi.items.MUSICAL_EARRING,
        xi.items.STEALTH_EARRING,
        xi.items.LOQUACIOUS_EARRING,
        xi.items.BRUTAL_EARRING,
        xi.items.FLAWLESS_RIBBON,
        xi.items.HOMAM_ZUCCHETTO,
        xi.items.HOMAM_CORAZZA,
        xi.items.HOMAM_MANOPOLAS,
        xi.items.HOMAM_COSCIALES,
        xi.items.HOMAM_GAMBIERAS,
        xi.items.NASHIRA_TURBAN,
        xi.items.NASHIRA_MANTEEL,
        xi.items.NASHIRA_GAGES,
        xi.items.NASHIRA_SERAWEELS,
        xi.items.NASHIRA_CRACKOWS,
        xi.items.HECATOMB_CAP,
        xi.items.HECATOMB_HARNESS,
        xi.items.HECATOMB_MITTENS,
        xi.items.HECATOMB_SUBLIGAR,
        xi.items.HECATOMB_LEGGINGS,
        xi.items.HECATOMB_CAP_P1,
        xi.items.HECATOMB_HARNESS_P1,
        xi.items.HECATOMB_MITTENS_P1,
        xi.items.HECATOMB_SUBLIGAR_P1,
        xi.items.HECATOMB_LEGGINGS_P1,
        xi.items.ENIF_ZUCCHETTO,
        xi.items.ENIF_CORAZZA,
        xi.items.ENIF_MANOPOLAS,
        xi.items.ENIF_COSCIALES,
        xi.items.ENIF_GAMBIERAS,
        xi.items.ADHARA_TURBAN,
        xi.items.ADHARA_MANTEEL,
        xi.items.ADHARA_GAGES,
        xi.items.ADHARA_SERAWEELS,
        xi.items.ADHARA_CRACKOWS,
        xi.items.MURZIM_ZUCCHETTO,
        xi.items.MURZIM_CORAZZA,
        xi.items.MURZIM_MANOPOLAS,
        xi.items.MURZIM_COSCIALES,
        xi.items.MURZIM_GAMBIERAS,
        xi.items.SHEDIR_TURBAN,
        xi.items.SHEDIR_MANTEEL,
        xi.items.SHEDIR_GAGES,
        xi.items.SHEDIR_SERAWEELS,
        xi.items.SHEDIR_CRACKOWS,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_03] =
    {
        xi.items.AURUM_ARMET,
        xi.items.AURUM_CUIRASS,
        xi.items.AURUM_GAUNTLETS,
        xi.items.AURUM_CUISSES,
        xi.items.AURUM_SABATONS,
        xi.items.ORACLES_CAP,
        xi.items.ORACLES_ROBE,
        xi.items.ORACLES_GLOVES,
        xi.items.ORACLES_BRACONI,
        xi.items.ORACLES_PIGACHES,
        xi.items.ENKIDUS_CAP,
        xi.items.ENKIDUS_HARNESS,
        xi.items.ENKIDUS_MITTENS,
        xi.items.ENKIDUS_SUBLIGAR,
        xi.items.ENKIDUS_LEGGINGS,
        xi.items.COBRA_UNIT_CAP,
        xi.items.COBRA_UNIT_HARNESS,
        xi.items.COBRA_UNIT_MITTENS,
        xi.items.COBRA_UNIT_SUBLIGAR,
        xi.items.COBRA_UNIT_LEGGINGS,
        xi.items.COBRA_UNIT_HAT,
        xi.items.COBRA_UNIT_ROBE,
        xi.items.COBRA_UNIT_GLOVES,
        xi.items.COBRA_UNIT_TREWS,
        xi.items.COBRA_UNIT_CRACKOWS,
        xi.items.IRON_RAM_SALLET,
        xi.items.IRON_RAM_HAUBERK,
        xi.items.IRON_RAM_DASTANAS,
        xi.items.IRON_RAM_HOSE,
        xi.items.IRON_RAM_GREAVES,
        xi.items.FOURTH_DIVISION_HAUBE,
        xi.items.FOURTH_DIVISION_BRUNNE,
        xi.items.FOURTH_DIVISION_HENTZES,
        xi.items.FOURTH_DIVISION_SCHOSS,
        xi.items.FOURTH_DIVISION_SCHUHS,
        xi.items.FOX_EARRING,
        xi.items.TEMPLE_EARRING,
        xi.items.ROSE_STRAP,
        xi.items.GRIFFINCLAW,
        xi.items.LEX_TALIONIS,
        xi.items.ROYAL_KNIGHT_SIGIL_RING,
        xi.items.PATRONUS_RING,
        xi.items.CRIMSON_BELT,
        xi.items.ARRESTOR_MANTLE,
        xi.items.SONIAS_PLECTRUM,
        xi.items.STURMS_REPORT,
        xi.items.SHIELD_COLLAR,
        xi.items.BULL_NECKLACE,
        xi.items.ARIESIAN_GRIP,
        xi.items.CAPRICORNIAN_ROPE,
        xi.items.COUGAR_PENDANT,
        xi.items.CROCODILE_COLLAR,
        xi.items.EARTHY_BELT,
        xi.items.SAMUDRA,
        xi.items.MERCENARY_MAJOR_CHARM,
        xi.items.FOURTH_DIVISION_MANTLE,
        xi.items.GNADBHODS_HELM,
        xi.items.ZHAGOS_BARBUT,
        xi.items.REE_HABALOS_HEADGEAR,
        xi.items.COBRA_UNIT_CLOCHE,
        xi.items.COBRA_UNIT_COAT,
        xi.items.COBRA_UNIT_CUFFS,
        xi.items.COBRA_UNIT_SLOPS,
        xi.items.COBRA_UNIT_PIGACHES,
        xi.items.IRON_RAM_HELM,
        xi.items.IRON_RAM_CHAINMAIL,
        xi.items.IRON_RAM_MUFFLERS,
        xi.items.IRON_RAM_BREECHES,
        xi.items.IRON_RAM_SOLLERETS,
        xi.items.FOURTH_DIVISION_ARMET,
        xi.items.FOURTH_DIVISION_CUIRASS,
        xi.items.FOURTH_DIVISION_GAUNTLETS,
        xi.items.FOURTH_DIVISION_CUISSES,
        xi.items.FOURTH_DIVISION_SABATONS,
        xi.items.OGIERS_HELM,
        xi.items.OGIERS_SURCOAT,
        xi.items.OGIERS_GAUNTLETS,
        xi.items.OGIERS_BREECHES,
        xi.items.OGIERS_LEGGINGS,
        xi.items.ATHOSS_CHAPEAU,
        xi.items.ATHOSS_TABARD,
        xi.items.ATHOSS_GLOVES,
        xi.items.ATHOSS_TIGHTS,
        xi.items.ATHOSS_BOOTS,
        xi.items.RUBEUS_BANDEAU,
        xi.items.RUBEUS_JACKET,
        xi.items.RUBEUS_GLOVES,
        xi.items.RUBEUS_SPATS,
        xi.items.RUBEUS_BOOTS,
        xi.items.TWILIGHT_KNIFE,
        xi.items.TWILIGHT_SCYTHE,
        xi.items.TWILIGHT_HELM,
        xi.items.TWILIGHT_MAIL,
        xi.items.TWILIGHT_CLOAK,
        xi.items.TWILIGHT_TORQUE,
        xi.items.TWILIGHT_BELT,
        xi.items.TWILIGHT_CAPE,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_04] =
    {
        xi.items.FIGHTERS_MASK,
        xi.items.FIGHTERS_LORICA,
        xi.items.FIGHTERS_MUFFLERS,
        xi.items.FIGHTERS_CUISSES,
        xi.items.FIGHTERS_CALLIGAE,
        xi.items.TEMPLE_CROWN,
        xi.items.TEMPLE_CYCLAS,
        xi.items.TEMPLE_GLOVES,
        xi.items.TEMPLE_HOSE,
        xi.items.TEMPLE_GAITERS,
        xi.items.HEALERS_CAP,
        xi.items.HEALERS_BRIAULT,
        xi.items.HEALERS_MITTS,
        xi.items.HEALERS_PANTALOONS,
        xi.items.HEALERS_DUCKBILLS,
        xi.items.WIZARDS_PETASOS,
        xi.items.WIZARDS_COAT,
        xi.items.WIZARDS_GLOVES,
        xi.items.WIZARDS_TONBAN,
        xi.items.WIZARDS_SABOTS,
        xi.items.WARLOCKS_CHAPEAU,
        xi.items.WARLOCKS_TABARD,
        xi.items.WARLOCKS_GLOVES,
        xi.items.WARLOCKS_TIGHTS,
        xi.items.WARLOCKS_BOOTS,
        xi.items.ROGUES_BONNET,
        xi.items.ROGUES_VEST,
        xi.items.ROGUES_ARMLETS,
        xi.items.ROGUES_CULOTTES,
        xi.items.ROGUES_POULAINES,
        xi.items.GALLANT_CORONET,
        xi.items.GALLANT_SURCOAT,
        xi.items.GALLANT_GAUNTLETS,
        xi.items.GALLANT_BREECHES,
        xi.items.GALLANT_LEGGINGS,
        xi.items.CHAOS_BURGEONET,
        xi.items.CHAOS_CUIRASS,
        xi.items.CHAOS_GAUNTLETS,
        xi.items.CHAOS_FLANCHARD,
        xi.items.CHAOS_SOLLERETS,
        xi.items.BEAST_HELM,
        xi.items.BEAST_JACKCOAT,
        xi.items.BEAST_GLOVES,
        xi.items.BEAST_TROUSERS,
        xi.items.BEAST_GAITERS,
        xi.items.CHORAL_ROUNDLET,
        xi.items.CHORAL_JUSTAUCORPS,
        xi.items.CHORAL_CUFFS,
        xi.items.CHORAL_CANNIONS,
        xi.items.CHORAL_SLIPPERS,
        xi.items.HUNTERS_BERET,
        xi.items.HUNTERS_JERKIN,
        xi.items.HUNTERS_BRACERS,
        xi.items.HUNTERS_SOCKS,
        xi.items.HUNTERS_BRACCAE,
        xi.items.MYOCHIN_KABUTO,
        xi.items.MYOCHIN_DOMARU,
        xi.items.MYOCHIN_KOTE,
        xi.items.MYOCHIN_HAIDATE,
        xi.items.MYOCHIN_SUNE_ATE,
        xi.items.NINJA_HATSUBURI,
        xi.items.NINJA_CHAINMAIL,
        xi.items.NINJA_TEKKO,
        xi.items.NINJA_HAKAMA,
        xi.items.NINJA_KYAHAN,
        xi.items.DRACHEN_ARMET,
        xi.items.DRACHEN_MAIL,
        xi.items.DRACHEN_FINGER_GAUNTLETS,
        xi.items.DRACHEN_BRAIS,
        xi.items.DRACHEN_GREAVES,
        xi.items.EVOKERS_HORN,
        xi.items.EVOKERS_DOUBLET,
        xi.items.EVOKERS_BRACERS,
        xi.items.EVOKERS_SPATS,
        xi.items.EVOKERS_PIGACHES,
        xi.items.MAGUS_KEFFIYEH,
        xi.items.MAGUS_JUBBAH,
        xi.items.MAGUS_BAZUBANDS,
        xi.items.MAGUS_SHALWAR,
        xi.items.MAGUS_CHARUQS,
        xi.items.CORSAIRS_TRICORNE,
        xi.items.CORSAIRS_FRAC,
        xi.items.CORSAIRS_GANTS,
        xi.items.CORSAIRS_CULOTTES,
        xi.items.CORSAIRS_BOTTES,
        xi.items.PUPPETRY_TAJ,
        xi.items.PUPPETRY_TOBE,
        xi.items.PUPPETRY_DASTANAS,
        xi.items.PUPPETRY_CHURIDARS,
        xi.items.PUPPETRY_BABOUCHES,
        xi.items.DANCERS_TIARA,
        xi.items.DANCERS_CASAQUE,
        xi.items.DANCERS_BANGLES,
        xi.items.DANCERS_TIGHTS,
        xi.items.DANCERS_TOE_SHOES,
        xi.items.DANCERS_TIARA,
        xi.items.DANCERS_CASAQUE,
        xi.items.DANCERS_BANGLES,
        xi.items.DANCERS_TIGHTS,
        xi.items.DANCERS_TOE_SHOES,
        xi.items.SCHOLARS_MORTARBOARD,
        xi.items.SCHOLARS_GOWN,
        xi.items.SCHOLARS_BRACERS,
        xi.items.SCHOLARS_PANTS,
        xi.items.SCHOLARS_LOAFERS,
        xi.items.RAZOR_AXE,
        xi.items.BEAT_CESTI,
        xi.items.BLESSED_HAMMER,
        xi.items.CASTING_WAND,
        xi.items.FENCING_DEGEN,
        xi.items.MARAUDERS_KNIFE,
        xi.items.HONOR_SWORD,
        xi.items.RAVEN_SCYTHE,
        xi.items.BARBAROI_AXE,
        xi.items.PAPER_KNIFE,
        xi.items.SNIPING_BOW,
        xi.items.MAGOROKU,
        xi.items.ANJU,
        xi.items.ZUSHIO,
        xi.items.PEREGRINE,
        xi.items.KUKULCANS_STAFF,
        xi.items.IMMORTALS_SCIMITAR,
        xi.items.TRUMP_GUN,
        xi.items.TURBO_ANIMATOR,
        xi.items.WAR_HOOP,
        xi.items.FILIAE_BELL,
        xi.items.DOWSERS_WAND,
        xi.items.BEORC_SWORD,
        xi.items.GEOMANCY_GALERO,
        xi.items.GEOMANCY_TUNIC,
        xi.items.GEOMANCY_MITAINES,
        xi.items.GEOMANCY_PANTS,
        xi.items.GEOMANCY_SANDALS,
        xi.items.RUNEIST_BANDEAU,
        xi.items.RUNEIST_COAT,
        xi.items.RUNEIST_MITONS,
        xi.items.RUNEIST_TROUSERS,
        xi.items.RUNEIST_BOTTES,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_05] =
    {
        xi.items.FIGHTERS_MASK_P1,
        xi.items.FIGHTERS_LORICA_P1,
        xi.items.FIGHTERS_MUFFLERS_P1,
        xi.items.FIGHTERS_CUISSES_P1,
        xi.items.FIGHTERS_CALLIGAE_P1,
        xi.items.TEMPLE_CROWN_P1,
        xi.items.TEMPLE_CYCLAS_P1,
        xi.items.TEMPLE_GLOVES_P1,
        xi.items.TEMPLE_HOSE_P1,
        xi.items.TEMPLE_GAITERS_P1,
        xi.items.HEALERS_CAP_P1,
        xi.items.HEALERS_BRIAULT_P1,
        xi.items.HEALERS_MITTS_P1,
        xi.items.HEALERS_PANTALOONS_P1,
        xi.items.HEALERS_DUCKBILLS_P1,
        xi.items.WIZARDS_PETASOS_P1,
        xi.items.WIZARDS_COAT_P1,
        xi.items.WIZARDS_GLOVES_P1,
        xi.items.WIZARDS_TONBAN_P1,
        xi.items.WIZARDS_SABOTS_P1,
        xi.items.WARLOCKS_CHAPEAU_P1,
        xi.items.WARLOCKS_TABARD_P1,
        xi.items.WARLOCKS_GLOVES_P1,
        xi.items.WARLOCKS_TIGHTS_P1,
        xi.items.WARLOCKS_BOOTS_P1,
        xi.items.ROGUES_BONNET_P1,
        xi.items.ROGUES_VEST_P1,
        xi.items.ROGUES_ARMLETS_P1,
        xi.items.ROGUES_CULOTTES_P1,
        xi.items.ROGUES_POULAINES_P1,
        xi.items.GALLANT_CORONET_P1,
        xi.items.GALLANT_SURCOAT_P1,
        xi.items.GALLANT_GAUNTLETS_P1,
        xi.items.GALLANT_BREECHES_P1,
        xi.items.GALLANT_LEGGINGS_P1,
        xi.items.CHAOS_BURGEONET_P1,
        xi.items.CHAOS_CUIRASS_P1,
        xi.items.CHAOS_GAUNTLETS_P1,
        xi.items.CHAOS_FLANCHARD_P1,
        xi.items.CHAOS_SOLLERETS_P1,
        xi.items.BEAST_HELM_P1,
        xi.items.BEAST_JACKCOAT_P1,
        xi.items.BEAST_GLOVES_P1,
        xi.items.BEAST_TROUSERS_P1,
        xi.items.BEAST_GAITERS_P1,
        xi.items.CHORAL_ROUNDLET_P1,
        xi.items.CHORAL_JUSTAUCORPS_P1,
        xi.items.CHORAL_CUFFS_P1,
        xi.items.CHORAL_CANNIONS_P1,
        xi.items.CHORAL_SLIPPERS_P1,
        xi.items.HUNTERS_BERET_P1,
        xi.items.HUNTERS_JERKIN_P1,
        xi.items.HUNTERS_BRACERS_P1,
        xi.items.HUNTERS_SOCKS_P1,
        xi.items.HUNTERS_BRACCAE_P1,
        xi.items.MYOCHIN_KABUTO_P1,
        xi.items.MYOCHIN_DOMARU_P1,
        xi.items.MYOCHIN_KOTE_P1,
        xi.items.MYOCHIN_HAIDATE_P1,
        xi.items.MYOCHIN_SUNE_ATE_P1,
        xi.items.NINJA_HATSUBURI_P1,
        xi.items.NINJA_CHAINMAIL_P1,
        xi.items.NINJA_TEKKO_P1,
        xi.items.NINJA_HAKAMA_P1,
        xi.items.NINJA_KYAHAN_P1,
        xi.items.DRACHEN_ARMET_P1,
        xi.items.DRACHEN_MAIL_P1,
        xi.items.DRACHEN_FINGER_GAUNTLETS_P1,
        xi.items.DRACHEN_BRAIS_P1,
        xi.items.DRACHEN_GREAVES_P1,
        xi.items.EVOKERS_HORN_P1,
        xi.items.EVOKERS_DOUBLET_P1,
        xi.items.EVOKERS_BRACERS_P1,
        xi.items.EVOKERS_SPATS_P1,
        xi.items.EVOKERS_PIGACHES_P1,
        xi.items.MAGUS_KEFFIYEH_P1,
        xi.items.MAGUS_JUBBAH_P1,
        xi.items.MAGUS_BAZUBANDS_P1,
        xi.items.MAGUS_SHALWAR_P1,
        xi.items.MAGUS_CHARUQS_P1,
        xi.items.CORSAIRS_TRICORNE_P1,
        xi.items.CORSAIRS_FRAC_P1,
        xi.items.CORSAIRS_GANTS_P1,
        xi.items.CORSAIRS_CULOTTES_P1,
        xi.items.CORSAIRS_BOTTES_P1,
        xi.items.PUPPETRY_TAJ_P1,
        xi.items.PUPPETRY_TOBE_P1,
        xi.items.PUPPETRY_DASTANAS_P1,
        xi.items.PUPPETRY_CHURIDARS_P1,
        xi.items.PUPPETRY_BABOUCHES_P1,
        xi.items.DANCERS_TIARA_P1,
        xi.items.DANCERS_CASAQUE_P1,
        xi.items.DANCERS_BANGLES_P1,
        xi.items.DANCERS_TIGHTS_P1,
        xi.items.DANCERS_TOE_SHOES_P1,
        xi.items.DANCERS_TIARA_P1,
        xi.items.DANCERS_CASAQUE_P1,
        xi.items.DANCERS_BANGLES_P1,
        xi.items.DANCERS_TIGHTS_P1,
        xi.items.DANCERS_TOE_SHOES_P1,
        xi.items.SCHOLARS_MORTARBOARD_P1,
        xi.items.SCHOLARS_GOWN_P1,
        xi.items.SCHOLARS_BRACERS_P1,
        xi.items.SCHOLARS_PANTS_P1,
        xi.items.SCHOLARS_LOAFERS_P1,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_06] =
    {
        xi.items.WARRIORS_MASK,
        xi.items.WARRIORS_LORICA,
        xi.items.WARRIORS_MUFFLERS,
        xi.items.WARRIORS_CUISSES,
        xi.items.WARRIORS_CALLIGAE,
        xi.items.WARRIORS_STONE,
        xi.items.MELEE_CROWN,
        xi.items.MELEE_CYCLAS,
        xi.items.MELEE_GLOVES,
        xi.items.MELEE_HOSE,
        xi.items.MELEE_GAITERS,
        xi.items.MELEE_CAPE,
        xi.items.CLERICS_CAP,
        xi.items.CLERICS_BRIAULT,
        xi.items.CLERICS_MITTS,
        xi.items.CLERICS_PANTALOONS,
        xi.items.CLERICS_DUCKBILLS,
        xi.items.CLERICS_BELT,
        xi.items.SORCERERS_PETASOS,
        xi.items.SORCERERS_COAT,
        xi.items.SORCERERS_GLOVES,
        xi.items.SORCERERS_TONBAN,
        xi.items.SORCERERS_SABOTS,
        xi.items.SORCERERS_BELT,
        xi.items.DUELISTS_CHAPEAU,
        xi.items.DUELISTS_TABARD,
        xi.items.DUELISTS_GLOVES,
        xi.items.DUELISTS_TIGHTS,
        xi.items.DUELISTS_BOOTS,
        xi.items.DUELISTS_BELT,
        xi.items.ASSASSINS_BONNET,
        xi.items.ASSASSINS_VEST,
        xi.items.ASSASSINS_ARMLETS,
        xi.items.ASSASSINS_CULOTTES,
        xi.items.ASSASSINS_POULAINES,
        xi.items.ASSASSINS_CAPE,
        xi.items.VALOR_CORONET,
        xi.items.VALOR_SURCOAT,
        xi.items.VALOR_GAUNTLETS,
        xi.items.VALOR_BREECHES,
        xi.items.VALOR_LEGGINGS,
        xi.items.VALOR_CAPE,
        xi.items.ABYSS_BURGEONET,
        xi.items.ABYSS_CUIRASS,
        xi.items.ABYSS_GAUNTLETS,
        xi.items.ABYSS_FLANCHARD,
        xi.items.ABYSS_SOLLERETS,
        xi.items.ABYSS_CAPE,
        xi.items.MONSTER_HELM,
        xi.items.MONSTER_JACKCOAT,
        xi.items.MONSTER_GLOVES,
        xi.items.MONSTER_TROUSERS,
        xi.items.MONSTER_GAITERS,
        xi.items.MONSTER_BELT,
        xi.items.BARDS_ROUNDLET,
        xi.items.BARDS_JUSTAUCORPS,
        xi.items.BARDS_CUFFS,
        xi.items.BARDS_CANNIONS,
        xi.items.BARDS_SLIPPERS,
        xi.items.BARDS_CAPE,
        xi.items.SCOUTS_BERET,
        xi.items.SCOUTS_JERKIN,
        xi.items.SCOUTS_BRACERS,
        xi.items.SCOUTS_BRACCAE,
        xi.items.SCOUTS_SOCKS,
        xi.items.SCOUTS_BELT,
        xi.items.SAOTOME_KABUTO,
        xi.items.SAOTOME_DOMARU,
        xi.items.SAOTOME_KOTE,
        xi.items.SAOTOME_HAIDATE,
        xi.items.SAOTOME_SUNE_ATE,
        xi.items.SAOTOME_KOSHI_ATE,
        xi.items.KOGA_HATSUBURI,
        xi.items.KOGA_CHAINMAIL,
        xi.items.KOGA_TEKKO,
        xi.items.KOGA_HAKAMA,
        xi.items.KOGA_KYAHAN,
        xi.items.KOGA_SARASHI,
        xi.items.WYRM_ARMET,
        xi.items.WYRM_MAIL,
        xi.items.WYRM_FINGER_GAUNTLETS,
        xi.items.WYRM_BRAIS,
        xi.items.WYRM_GREAVES,
        xi.items.WYRM_BELT,
        xi.items.SUMMONERS_HORN,
        xi.items.SUMMONERS_DOUBLET,
        xi.items.SUMMONERS_BRACERS,
        xi.items.SUMMONERS_SPATS,
        xi.items.SUMMONERS_PIGACHES,
        xi.items.SUMMONERS_CAPE,
        xi.items.MIRAGE_KEFFIYEH,
        xi.items.MIRAGE_JUBBAH,
        xi.items.MIRAGE_BAZUBANDS,
        xi.items.MIRAGE_SHALWAR,
        xi.items.MIRAGE_CHARUQS,
        xi.items.MIRAGE_MANTLE,
        xi.items.COMMODORE_TRICORNE,
        xi.items.COMMODORE_FRAC,
        xi.items.COMMODORE_GANTS,
        xi.items.COMMODORE_TREWS,
        xi.items.COMMODORE_BOTTES,
        xi.items.COMMODORE_BELT,
        xi.items.PANTIN_TAJ,
        xi.items.PANTIN_TOBE,
        xi.items.PANTIN_DASTANAS,
        xi.items.PANTIN_CHURIDARS,
        xi.items.PANTIN_BABOUCHES,
        xi.items.PANTIN_CAPE,
        xi.items.ETOILE_TIARA,
        xi.items.ETOILE_CASAQUE,
        xi.items.ETOILE_BANGLES,
        xi.items.ETOILE_TIGHTS,
        xi.items.ETOILE_TOE_SHOES,
        xi.items.ETOILE_CAPE,
        xi.items.ARGUTE_MORTARBOARD,
        xi.items.ARGUTE_GOWN,
        xi.items.ARGUTE_BRACERS,
        xi.items.ARGUTE_PANTS,
        xi.items.ARGUTE_LOAFERS,
        xi.items.ARGUTE_BELT,
    },

    [xi.items.MOOGLE_STORAGE_SLIP_07] =
    {

    },

    [xi.items.MOOGLE_STORAGE_SLIP_08] =
    {

    },

    [xi.items.MOOGLE_STORAGE_SLIP_09] =
    {

    },

    [slipIds[7]]  = { 15245, 14500, 14909, 15580, 15665, 15246, 14501, 14910, 15581, 15666, 15247, 14502, 14911, 15582, 15667, 15248, 14503, 14912, 15583, 15668, 15249, 14504, 14913, 15584, 15669, 15250, 14505, 14914, 15585, 15670, 15251, 14506, 14915, 15586, 15671, 15252, 14507, 14916, 15587, 15672, 15253, 14508, 14917, 15588, 15673, 15254, 14509, 14918, 15589, 15674, 15255, 14510, 14919, 15590, 15675, 15256, 14511, 14920, 15591, 15676, 15257, 14512, 14921, 15592, 15677, 15258, 14513, 14922, 15593, 15678, 15259, 14514, 14923, 15594, 15679, 11466, 11293, 15026, 16347, 11383, 11469, 11296, 15029, 16350, 11386, 11472, 11299, 15032, 16353, 11389, 11479, 11306, 15039, 16361, 11397, 11481, 11308, 15041, 16363, 11399 },
    [slipIds[8]]  = { 12008, 12028, 12048, 12068, 12088, 11591, 19253, 12009, 12029, 12049, 12069, 12089, 11592, 19254, 12010, 12030, 12050, 12070, 12090, 11615, 11554, 12011, 12031, 12051, 12071, 12091, 11593, 16203, 12012, 12032, 12052, 12072, 12092, 11594, 16204, 12013, 12033, 12053, 12073, 12093, 11736, 19260, 12014, 12034, 12054, 12074, 12094, 11595, 11750, 12015, 12035, 12055, 12075, 12095, 11616, 11737, 12016, 12036, 12056, 12076, 12096, 11617, 11555, 12017, 12037, 12057, 12077, 12097, 11618, 11738, 12018, 12038, 12058, 12078, 12098, 11596, 16205, 12019, 12039, 12059, 12079, 12099, 11597, 16206, 12020, 12040, 12060, 12080, 12100, 11598, 16207, 12021, 12041, 12061, 12081, 12101, 11599, 16208, 12022, 12042, 12062, 12082, 12102, 11619, 11739, 12023, 12043, 12063, 12083, 12103, 11600, 19255, 12024, 12044, 12064, 12084, 12104, 11601, 16209, 12025, 12045, 12065, 12085, 12105, 11602, 11751, 12026, 12046, 12066, 12086, 12106, 11603, 19256, 12027, 12047, 12067, 12087, 12107, 11620, 19247, 11703, 11704, 11705, 11706, 11707, 11708, 11709, 11710, 11711, 11712, 11713, 11714, 11715, 11716, 11717, 11718, 11719, 11720, 11721, 11722 },
    [slipIds[9]]  = { 11164, 11184, 11204, 11224, 11244, 11165, 11185, 11205, 11225, 11245, 11166, 11186, 11206, 11226, 11246, 11167, 11187, 11207, 11227, 11247, 11168, 11188, 11208, 11228, 11248, 11169, 11189, 11209, 11229, 11249, 11170, 11190, 11210, 11230, 11250, 11171, 11191, 11211, 11231, 11251, 11172, 11192, 11212, 11232, 11252, 11173, 11193, 11213, 11233, 11253, 11174, 11194, 11214, 11234, 11254, 11175, 11195, 11215, 11235, 11255, 11176, 11196, 11216, 11236, 11256, 11177, 11197, 11217, 11237, 11257, 11178, 11198, 11218, 11238, 11258, 11179, 11199, 11219, 11239, 11259, 11180, 11200, 11220, 11240, 11260, 11181, 11201, 11221, 11241, 11261, 11182, 11202, 11222, 11242, 11262, 11183, 11203, 11223, 11243, 11263 },
    [slipIds[10]] = { 11064, 11084, 11104, 11124, 11144, 11065, 11085, 11105, 11125, 11145, 11066, 11086, 11106, 11126, 11146, 11067, 11087, 11107, 11127, 11147, 11068, 11088, 11108, 11128, 11148, 11069, 11089, 11109, 11129, 11149, 11070, 11090, 11110, 11130, 11150, 11071, 11091, 11111, 11131, 11151, 11072, 11092, 11112, 11132, 11152, 11073, 11093, 11113, 11133, 11153, 11074, 11094, 11114, 11134, 11154, 11075, 11095, 11115, 11135, 11155, 11076, 11096, 11116, 11136, 11156, 11077, 11097, 11117, 11137, 11157, 11078, 11098, 11118, 11138, 11158, 11079, 11099, 11119, 11139, 11159, 11080, 11100, 11120, 11140, 11160, 11081, 11101, 11121, 11141, 11161, 11082, 11102, 11122, 11142, 11162, 11083, 11103, 11123, 11143, 11163 },
    [slipIds[11]] = { 15297, 15298, 15299, 15919, 15929, 15921, 18871, 16273, 18166, 18167, 18256, 13216, 13217, 13218, 15455, 15456, 181, 182, 183, 184, 129, 11499, 18502, 18855, 19274, 18763, 19110, 15008, 17764, 19101, 365, 366, 367, 15860, 272, 273, 274, 275, 276, 11853, 11956, 11854, 11957, 11811, 11812, 11861, 11862, 3676, 18879, 3647, 3648, 3649, 3677, 18880, 18863, 18864, 15178, 14519, 10382, 11965, 11967, 15752, 15179, 14520, 10383, 11966, 11968, 15753, 10875, 3619, 3620, 3621, 3650, 3652, 10430, 10251, 10593, 10431, 10252, 10594, 10432, 10253, 10595, 10433, 10254, 10596, 10429, 10250, 17031, 17032, 10807, 18881, 10256, 10330, 10257, 10331, 10258, 10332, 10259, 10333, 10260, 10334, 10261, 10335, 10262, 10336, 10263, 10337, 10264, 10338, 10265, 10339, 10266, 10340, 10267, 10341, 10268, 10342, 10269, 10343, 10270, 10344, 10271, 10345, 10446, 10447, 426, 10808, 3654, 265, 266, 267, 269, 270, 271, 18464, 18545, 18563, 18912, 18913, 10293, 10809, 10810, 10811, 10812, 27803, 28086, 27804, 28087, 27805, 28088, 27806, 28089, 27765, 27911, 27760, 27906, 27759, 28661, 286, 27757, 27758, 287, 27899, 28185, 28324, 27898, 28655, 27756, 28511, 21118, 27902, 100, 21117, 87, 20953, 21280, 28652, 28650, 27726, 28509, 28651, 27727, 28510, 27872, 21113, 27873, 21114, 20532, 20533, 27717, 27718 },
    [slipIds[12]] = { 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2046, 2047, 2048, 2049, 2050, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2062, 2063, 2064, 2065, 2066, 2067, 2068, 2069, 2070, 2071, 2072, 2073, 2074, 2075, 2076, 2077, 2078, 2079, 2080, 2081, 2082, 2083, 2084, 2085, 2086, 2087, 2088, 2089, 2090, 2091, 2092, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2662, 2663, 2664, 2665, 2666, 2667, 2668, 2669, 2670, 2671, 2672, 2673, 2674, 2675, 2676, 2718, 2719, 2720, 2721, 2722, 2723, 2724, 2725, 2726, 2727 },
    [slipIds[13]] = { 10650, 10670, 10690, 10710, 10730, 10651, 10671, 10691, 10711, 10731, 10652, 10672, 10692, 10712, 10732, 10653, 10673, 10693, 10713, 10733, 10654, 10674, 10694, 10714, 10734, 10655, 10675, 10695, 10715, 10735, 10656, 10676, 10696, 10716, 10736, 10657, 10677, 10697, 10717, 10737, 10658, 10678, 10698, 10718, 10738, 10659, 10679, 10699, 10719, 10739, 10660, 10680, 10700, 10720, 10740, 10661, 10681, 10701, 10721, 10741, 10662, 10682, 10702, 10722, 10742, 10663, 10683, 10703, 10723, 10743, 10664, 10684, 10704, 10724, 10744, 10665, 10685, 10705, 10725, 10745, 10666, 10686, 10706, 10726, 10746, 10667, 10687, 10707, 10727, 10747, 10668, 10688, 10708, 10728, 10748, 10669, 10689, 10709, 10729, 10749 },
    [slipIds[14]] = { 10901, 10474, 10523, 10554, 10620, 10906, 10479, 10528, 10559, 10625, 10911, 10484, 10533, 10564, 10630, 19799, 18916, 10442, 10280, 16084, 27788, 27928, 28071, 28208, 27649, 27789, 27929, 28072, 28209, 27650, 27790, 27930, 28073, 28210, 27651, 27791, 27931, 28074, 28211, 27652, 27792, 27932, 28075, 28212, 27653, 27793, 27933, 28076, 28213, 27654, 27794, 27934, 28077, 28214, 27655, 27795, 27935, 28078, 28215, 27656, 27796, 27936, 28079, 28216, 27657, 27797, 27937, 28080, 28217, 27658, 27798, 27938, 28081, 28218, 27659, 27799, 27939, 28082, 28219, 27660, 27800, 27940, 28083, 28220, 27661, 27801, 27941, 28084, 28221, 27662, 27802, 27942, 28085, 28222 },
    [slipIds[15]] = { 27663, 27807, 27943, 28090, 28223, 27664, 27808, 27944, 28091, 28224, 27665, 27809, 27945, 28092, 28225, 27666, 27810, 27946, 28093, 28226, 27667, 27811, 27947, 28094, 28227, 27668, 27812, 27948, 28095, 28228, 27669, 27813, 27949, 28096, 28229, 27670, 27814, 27950, 28097, 28230, 27671, 27815, 27951, 28098, 28231, 27672, 27816, 27952, 28099, 28232, 27673, 27817, 27953, 28100, 28233, 27674, 27818, 27954, 28101, 28234, 27675, 27819, 27955, 28102, 28235, 27676, 27820, 27956, 28103, 28236, 27677, 27821, 27957, 28104, 28237, 27678, 27822, 27958, 28105, 28238, 27679, 27823, 27959, 28106, 28239, 27680, 27824, 27960, 28107, 28240, 27681, 27825, 27961, 28108, 28241, 27682, 27826, 27962, 28109, 28242, 27683, 27827, 27963, 28110, 28243 },
    [slipIds[16]] = { 27684, 27828, 27964, 28111, 28244, 27685, 27829, 27965, 28112, 28245, 27686, 27830, 27966, 28113, 28246, 28246, 27831, 27967, 28114, 28247, 27688, 27832, 27968, 28115, 28248, 27689, 27833, 27969, 28116, 28249, 27690, 27834, 27970, 28117, 28250, 27691, 27835, 27971, 28118, 28251, 27692, 27836, 27972, 28119, 28252, 27693, 27837, 27973, 28120, 28253, 27694, 27838, 27974, 28121, 28254, 27695, 27839, 27975, 28122, 28255, 27696, 27840, 27976, 28123, 28256, 27697, 27841, 27977, 28124, 28257, 27698, 27842, 27978, 28125, 28258, 27699, 27843, 27979, 28126, 28259, 27700, 27844, 27980, 28127, 28260, 27701, 27845, 27981, 28128, 28261, 27702, 27846, 27982, 28129, 28262, 27703, 27847, 27983, 28130, 28263, 27704, 27848, 27984, 28131, 28264, 27705, 27849, 27985, 28132, 28265, 27706, 27850, 27986, 28133, 28266 },
    [slipIds[17]] = { 26624, 26800, 26976, 27152, 27328, 26626, 26802, 26978, 27154, 27330, 26628, 26804, 26980, 27156, 27332, 26630, 26806, 26982, 27158, 27334, 26632, 26808, 26984, 27160, 27336, 26634, 26810, 26986, 27162, 27338, 26636, 26812, 26988, 27164, 27340, 26638, 26814, 26990, 27166, 27342, 26640, 26816, 26992, 27168, 27344, 26642, 26818, 26994, 27170, 27346, 26644, 26820, 26996, 27172, 27348, 26646, 26822, 26998, 27174, 27350, 26648, 26824, 27000, 27176, 27352, 26650, 26826, 27002, 27178, 27354, 26652, 26828, 27004, 27180, 27356, 26654, 26830, 27006, 27182, 27358, 26656, 26832, 27008, 27184, 27360, 26658, 26834, 27010, 27186, 27362, 26660, 26836, 27012, 27188, 27364, 26662, 26838, 27014, 27190, 27366, 26664, 26840, 27016, 27192, 27368, 26666, 26842, 27018, 27194, 27370 },
    [slipIds[18]] = { 26625, 26801, 26977, 27153, 27329, 26627, 26803, 26979, 27155, 27331, 26629, 26805, 26981, 27157, 27333, 26631, 26807, 26983, 27159, 27335, 26633, 26809, 26985, 27161, 27337, 26635, 26811, 26987, 27163, 27339, 26637, 26813, 26989, 27165, 27341, 26639, 26815, 26991, 27167, 27343, 26641, 26817, 26993, 27169, 27345, 26643, 26819, 26995, 27171, 27347, 26645, 26821, 26997, 27173, 27349, 26647, 26823, 26999, 27175, 27351, 26649, 26825, 27001, 27177, 27353, 26651, 26827, 27003, 27179, 27355, 26653, 26829, 27005, 27181, 27357, 26655, 26831, 27007, 27183, 27359, 26657, 26833, 27009, 27185, 27361, 26659, 26835, 27011, 27187, 27363, 26661, 26837, 27013, 27189, 27365, 26663, 26839, 27015, 27191, 27367, 26665, 26841, 27017, 27193, 27369, 26667, 26843, 27019, 27195, 27371 },
    [slipIds[19]] = { 27715, 27866, 27716, 27867, 278, 281, 284, 3680, 3681, 27859, 28149, 27860, 28150, 21107, 21108, 27625, 27626, 26693, 26694, 26707, 26708, 27631, 27632, 26705, 26706, 27854, 27855, 26703, 26704, 3682, 3683, 3684, 3685, 3686, 3687, 3688, 3689, 3690, 3691, 3692, 3693, 3694, 3695, 21097, 21098, 26717, 26718, 26728, 26719, 26720, 26889, 26890, 21095, 21096, 26738, 26739, 26729, 26730, 26788, 26946, 27281, 27455, 26789, 3698, 20713, 20714, 26798, 26954, 26799, 26955, 3706, 26956, 26957, 3705, 26964, 26965, 27291, 26967, 27293, 26966, 27292, 26968, 27294, 21153, 21154, 21086, 21087, 25606, 26974, 27111, 27296, 27467, 25607, 26975, 27112, 27297, 27468, 14195, 14830, 14831, 13945, 13946, 14832, 13947, 17058, 13948, 14400, 14392, 14393, 14394, 14395, 14396, 14397, 14398, 14399, 11337, 11329, 11330, 11331, 11332, 11333, 11334, 11335, 11336, 15819, 15820, 15821, 15822, 15823, 15824, 15825, 15826, 3670, 3672, 3661, 3595, 3665, 3668, 3663, 3674, 3667, 191, 28, 153, 151, 198, 202, 142, 134, 137, 340, 341, 334, 335, 337, 339, 336, 342, 338, 3631, 3632, 3625, 3626, 3628, 3630, 3627, 3633, 3629, 25632, 25633, 25604, 25713, 27325, 25714, 27326, 3651, 25711, 25712, 10925, 10948, 10949, 10950, 10951, 10952, 10953, 10954, 10955, 25657, 25756, 25658, 25757, 25909 },
    [slipIds[20]] = { 26740, 26898, 27052, 27237, 27411, 26742, 26900, 27054, 27239, 27413, 26744, 26902, 27056, 27241, 27415, 26746, 26904, 27058, 27243, 27417, 26748, 26906, 27060, 27245, 27419, 26750, 26908, 27062, 27247, 27421, 26752, 26910, 27064, 27249, 27423, 26754, 26912, 27066, 27251, 27425, 26756, 26914, 27068, 27253, 27427, 26758, 26916, 27070, 27255, 27429, 26760, 26918, 27072, 27257, 27431, 26762, 26920, 27074, 27259, 27433, 26764, 26922, 27076, 27261, 27435, 26766, 26924, 27078, 27263, 27437, 26768, 26926, 27080, 27265, 27439, 26770, 26928, 27082, 27267, 27441, 26772, 26930, 27084, 27269, 27443, 26774, 26932, 27086, 27271, 27445, 26776, 26934, 27088, 27273, 27447, 26778, 26936, 27090, 27275, 27449, 26780, 26938, 27092, 27277, 27451, 26782, 26940, 27094, 27279, 27453 },
    [slipIds[21]] = { 26741, 26899, 27053, 27238, 27412, 26743, 26901, 27055, 27240, 27414, 26745, 26903, 27057, 27242, 27416, 26747, 26905, 27059, 27244, 27418, 26749, 26907, 27061, 27246, 27420, 26751, 26909, 27063, 27248, 27422, 26753, 26911, 27065, 27250, 27424, 26755, 26913, 27067, 27252, 27426, 26757, 26915, 27069, 27254, 27428, 26759, 26917, 27071, 27256, 27430, 26761, 26919, 27073, 27258, 27432, 26763, 26921, 27075, 27260, 27434, 26765, 26923, 27077, 27262, 27436, 26767, 26925, 27079, 27264, 27438, 26769, 26927, 27081, 27266, 27440, 26771, 26929, 27083, 27268, 27442, 26773, 26931, 27085, 27270, 27444, 26775, 26933, 27087, 27272, 27446, 26777, 26935, 27089, 27274, 27448, 26779, 26937, 27091, 27276, 27450, 26781, 26939, 27093, 27278, 27452, 26783, 26941, 27095, 27280, 27454 },
    [slipIds[22]] = { 25639, 25715, 25638, 3707, 3708, 21074, 26406, 25645, 25726, 25648, 25649, 25650, 25758, 25759, 25672, 25673, 282, 279, 280, 268, 25670, 25671, 26520, 25652, 25653, 22017, 22018, 25586, 25587, 10384, 10385, 22019, 22020, 25722, 25585, 25776, 25677, 25677, 25675, 25676, 20668, 20669, 22069, 25755, 37222, 21608, 3713, 3714, 3715, 3717, 3727, 3728, 20577, 3726, 20666, 20667, 21741, 21609, 3723, 26410, 26411, 25850, 21509, 3725, 3720, 21658, 26524, 20665, 26412, 21965, 21966, 21967, 25774, 25838, 25775, 25839, 3724, 3721, 21682, 22072, 21820, 21821, 23731, 26517, 23730, 20573, 20674, 21742, 21860, 22065, 22039, 22124, 22132, 3719, 3738, 26518, 27623, 21867, 21868, 22283, 26516, 20933, 20578, 20568, 3739 },
    [slipIds[23]] = { 25659, 25745, 25800, 25858, 25925, 25660, 25746, 25801, 25859, 25926, 25663, 25749, 25804, 25862, 25929, 25664, 25750, 25805, 25863, 25930, 25665, 25751, 25806, 25865, 25931, 25666, 25752, 25807, 25866, 25932, 25661, 25747, 25802, 25860, 25927, 25662, 25748, 25803, 25861, 25928, 25667, 25753, 25808, 25867, 25933, 25668, 25754, 25809, 25868, 25934, 25579, 25779, 25818, 25873, 25940, 25580, 25780, 25819, 25874, 25941, 25590, 25764, 25812, 25871, 25937, 25591, 25765, 25813, 25872, 25938, 25581, 25781, 25820, 25875, 25942, 25582, 25782, 25821, 25876, 25943, 25588, 25762, 25810, 25869, 25935, 25589, 25763, 25811, 25870, 25936, 25583, 25783, 25822, 25877, 25944, 25584, 25784, 25823, 25878, 25945, 25574, 25790, 25828, 25879, 25946, 25575, 25791, 25829, 25880, 25947, 25576, 25792, 25830, 25881, 25948, 25577, 25793, 25831, 25882, 25949, 25578, 25794, 25832, 25883, 25950, 26204, 26205, 26206, 26207, 26208, 25569, 25797, 25835, 25886, 25953, 25573, 25796, 25834, 25885, 25952, 25570, 25798, 25836, 25887, 25954, 25572, 25795, 25833, 25884, 25951, 25571, 25799, 25837, 25888, 25955, 26211, 26210, 26212, 26209, 26213, 21863, 22004, 21744, 21272, 20576, 21761, 26409, 22070 },
    [slipIds[24]] = { 23040, 23107, 23174, 23241, 23308, 23041, 23108, 23175, 23242, 23309, 23042, 23109, 23176, 23243, 23310, 23043, 23110, 23177, 23244, 23311, 23044, 23111, 23178, 23245, 23312, 23045, 23112, 23179, 23246, 23313, 23046, 23113, 23180, 23247, 23314, 23047, 23114, 23181, 23248, 23315, 23048, 23115, 23182, 23249, 23316, 23049, 23116, 23183, 23250, 23317, 23050, 23117, 23184, 23251, 23318, 23051, 23118, 23185, 23252, 23319, 23052, 23119, 23186, 23253, 23320, 23053, 23120, 23187, 23254, 23321, 23054, 23121, 23188, 23255, 23322, 23055, 23122, 23189, 23256, 23323, 23056, 23123, 23190, 23257, 23324, 23057, 23124, 23191, 23258, 23325, 23058, 23125, 23192, 23259, 23326, 23059, 23126, 23193, 23260, 23327, 23060, 23127, 23194, 23261, 23328, 23061, 23128, 23195, 23262, 23329, 23062, 23129, 23196, 23263, 23330 },
    [slipIds[25]] = { 23375, 23442, 23509, 23576, 23643, 23376, 23443, 23510, 23577, 23644, 23377, 23444, 23511, 23578, 23645, 23378, 23445, 23512, 23579, 23646, 23379, 23446, 23513, 23580, 23647, 23380, 23447, 23514, 23581, 23648, 23381, 23448, 23515, 23582, 23649, 23382, 23449, 23516, 23583, 23650, 23383, 23450, 23517, 23584, 23651, 23384, 23451, 23518, 23585, 23652, 23385, 23452, 23519, 23586, 23653, 23386, 23453, 23520, 23587, 23654, 23387, 23454, 23521, 23588, 23655, 23388, 23455, 23522, 23589, 23656, 23389, 23456, 23523, 23590, 23657, 23390, 23457, 23524, 23591, 23658, 23391, 23458, 23525, 23592, 23659, 23392, 23459, 23526, 23593, 23660, 23393, 23460, 23527, 23594, 23661, 23394, 23461, 23528, 23595, 23662, 23395, 23462, 23529, 23596, 23663, 23396, 23463, 23530, 23597, 23664, 23397, 23464, 23531, 23598, 23665 },
    [slipIds[26]] = { 23063, 23130, 23197, 23264, 23331, 23064, 23131, 23198, 23265, 23332, 23065, 23132, 23199, 23266, 23333, 23066, 23133, 23200, 23267, 23334, 23067, 23134, 23201, 23268, 23335, 23068, 23135, 23202, 23269, 23336, 23069, 23136, 23203, 23270, 23337, 23070, 23137, 23204, 23271, 23338, 23071, 23138, 23205, 23272, 23339, 23072, 23139, 23206, 23273, 23340, 23073, 23140, 23207, 23274, 23341, 23074, 23141, 23208, 23275, 23342, 23075, 23142, 23209, 23276, 23343, 23076, 23143, 23210, 23277, 23344, 23077, 23144, 23211, 23278, 23345, 23078, 23145, 23212, 23279, 23346, 23079, 23146, 23213, 23280, 23347, 23080, 23147, 23214, 23281, 23348, 23081, 23148, 23215, 23282, 23349, 23082, 23149, 23216, 23283, 23350, 23083, 23150, 23217, 23284, 23351, 23084, 23151, 23218, 23285, 23352 },
    [slipIds[27]] = { 23398, 23465, 23532, 23599, 23666, 23399, 23466, 23533, 23600, 23667, 23400, 23467, 23534, 23601, 23668, 23401, 23468, 23535, 23602, 23669, 23402, 23469, 23536, 23603, 23670, 23403, 23470, 23537, 23604, 23671, 23404, 23471, 23538, 23605, 23672, 23405, 23472, 23539, 23606, 23673, 23406, 23473, 23540, 23607, 23674, 23407, 23474, 23541, 23608, 23675, 23408, 23475, 23542, 23609, 23676, 23409, 23476, 23543, 23610, 23677, 23410, 23477, 23544, 23611, 23678, 23411, 23478, 23545, 23612, 23679, 23412, 23479, 23546, 23613, 23680, 23413, 23480, 23547, 23614, 23681, 23414, 23481, 23548, 23615, 23682, 23415, 23482, 23549, 23616, 23683, 23416, 23483, 23550, 23617, 23684, 23417, 23484, 23551, 23618, 23685, 23418, 23485, 23552, 23619, 23686, 23419, 23486, 23553, 23620, 23687 },
    [slipIds[28]] = { 21515, 21561, 21617, 21670, 21718, 21775, 21826, 21879, 21918, 21971, 22027, 22082, 22108, 22214, 21516, 21562, 21618, 21671, 21719, 21776, 21827, 21880, 21919, 21972, 22028, 22083, 22109, 22215, 21517, 21563, 21619, 21672, 21720, 21777, 21828, 21881, 21920, 21973, 22029, 22084, 22110, 22216, 21518, 21564, 21620, 21673, 21721, 21778, 21829, 21882, 21921, 21974, 22030, 22085, 22111, 22217, 21519, 21565, 21621, 21674, 21722, 21779, 21830, 21883, 21922, 21975, 22031, 22086, 22112, 22218 }
}

-----------------------------------
-- desc : Checks if the supplied item is a Moogle Storage Slip.
-----------------------------------
local function isSlip(itemId)
    return (slipItems[itemId] ~= nil)
end

-----------------------------------
-- desc : Checks if the supplied slip can store the supplied item.
-----------------------------------
local function isStorableOn(slipId, itemId)
    for _, id in ipairs(slipItems[slipId]) do
        if (id == itemId) then
            return true
        end
    end

    printf('Item %s is not storable on %s', itemId, slipId)
    return false
end

-----------------------------------
-- desc : Gets IDs of retrievable items from the extra data on a slip.
-----------------------------------
local function getItemsOnSlip(extra, slipId)
    local slip = slipItems[slipId]

    local itemsOnSlip = {}
    local x = 1
    for k, v in ipairs(slip) do
        local byte = extra[math.floor((k - 1) / 8) + 1]
        if byte < 0 then
            byte = byte + 256
        end

        if (bit.band(bit.rshift(byte, (k - 1) % 8), 1) ~= 0) then
            itemsOnSlip[x] = v
            x = x + 1
        end
    end

    return itemsOnSlip
end

-----------------------------------
-- desc : Finds the key in table t where the value equals i.
-----------------------------------
local function find(t, i)
  for k, v in ipairs(t) do
    if v == i then
      return k
    end
  end
  return nil
end

-----------------------------------
-- desc : Converts the 8 bit extra data into 32 bit params for events.
-----------------------------------
local function int8ToInt32(extra)
    local params = {}
    local int32 = ''

    for k, v in ipairs(extra) do
        int32 = string.format('%02x%s', v, int32)
        if (k % 4 == 0) then
            params[#params + 1] = tonumber(int32, 16)
            int32 = ''
        end
    end

    if (int32 ~= '') then
        params[#params + 1] = tonumber(int32, 16)
    end

    return params
end

-----------------------------------
-- desc : Gets Storage Slip ID from the trade window (does nothing
--        if there are two or more Storage Slips in the trade and no
--        storable items.
-----------------------------------
local function getSlipId(trade)
    local slipId = 0
    local slips = 0

    for _, itemId in ipairs(slipIds) do
        if (trade:hasItemQty(itemId, 1)) then
            slips = slips + 1
            if (slipId == 0) then
                slipId = itemId
            end
        end
    end

    if (slips == trade:getItemCount() and slips > 1) then
        slipId = 0
    end

    return slipId, slips
end

-----------------------------------
-- desc : Gets all items in the trade window that are storable on the
--        slip in the trade window.
-----------------------------------
local function getStorableItems(player, trade, slipId)
    local storableItemIds = { }

    for i = 0, 7 do
        local slotItemId = trade:getItemId(i)
        if (slotItemId ~= 0 and isSlip(slotItemId) ~= true and player:hasItem(slotItemId)) then
            if (isStorableOn(slipId, slotItemId)) then
                storableItemIds[#storableItemIds+1] = slotItemId
            end
        end
    end

    return storableItemIds
end

-----------------------------------
-- desc : Stores the items on the Storage Slip extra data and starts
--        the event indicating that the storage was successful.
-----------------------------------
local function storeItems(player, storableItemIds, slipId, e)
    if (#storableItemIds > 0) then
        local param0 = 0
        local param1 = 0
        if (#storableItemIds == 1) then
            param0 = storableItemIds[1]
            param1 = 0
        else
            param0 = #storableItemIds
            param1 = 1
        end

        -- idk
        local extra = { }
        for i = 0, 23 do
            extra[i] = 0
        end

        for k, v in ipairs(slipItems[slipId]) do
            if find(storableItemIds, v) ~= nil then
                local bitmask = extra[math.floor((k - 1) / 8)]
                if bitmask < 0 then
                    bitmask = bitmask + 256
                end
                extra[math.floor((k - 1) / 8)] = bit.bor(bitmask, bit.lshift(1, (k - 1) % 8))
            end
        end

        local result = player:storeWithPorterMoogle(slipId, extra, storableItemIds)

        if (result == 0) then
            player:startEvent(e.STORE_EVENT_ID, param0, param1)
        elseif (result == 1) then
            player:startEvent(e.ALREADY_STORED_ID)
        elseif (result == 2) then
            player:startEvent(e.MAGIAN_TRIAL_ID)
        end
    end
end

-----------------------------------
-- desc : Returns a zero-based identifier for the slip (Storage Slip 1
--        is index 0, Storage Slip 2 is index 1, etc).
-----------------------------------
local function getSlipIndex(slipId)
    return find(slipIds, slipId) - 1
end

-----------------------------------
-- desc : Gets the extra data from the traded slip and starts the
--        retrieval event.
-----------------------------------
local function startRetrieveProcess(player, eventId, slipId)
    local extra = player:getRetrievableItemsForSlip(slipId)
    local params = int8ToInt32(extra)
    local slipIndex = getSlipIndex(slipId)

    player:setLocalVar('slipId', slipId)
    player:startEvent(eventId, params[1], params[2], params[3], params[4], params[5], params[6], nil, slipIndex)
end

-----------------------------------
-- desc : Begins the storage or retrieval process based on the items
--        supplied in the trade.
-----------------------------------
function porterMoogleTrade(player, trade, e)
    local slipId, slipCount = getSlipId(trade)
    if (slipId == 0 or slipCount > 1) then return end

    local storableItemIds = getStorableItems(player, trade, slipId)

    if (#storableItemIds > 0) then
        storeItems(player, storableItemIds, slipId, e)
    else
        startRetrieveProcess(player, e.RETRIEVE_EVENT_ID, slipId)
    end
end

-----------------------------------
-- desc : Retrieves the selected item from storage, removes it from
--        the slip's extra data, displays a message to the user, and
--        updates the user's event data.
-----------------------------------
function porterEventUpdate(player, csid, option, RETRIEVE_EVENT_ID)
    local slipId = player:getLocalVar('slipId')
    if (csid == RETRIEVE_EVENT_ID and slipId ~= 0 and slipId ~= nil) then
        local extra = player:getRetrievableItemsForSlip(slipId)
        local itemsOnSlip = getItemsOnSlip(extra, slipId)
        local retrievedItemId = itemsOnSlip[option + 1]

        if (player:hasItem(retrievedItemId) or player:getFreeSlotsCount() == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, retrievedItemId)
        else
            local k = find(slipItems[slipId], retrievedItemId)
            local extraId = math.floor((k - 1) / 8)
            local bitmask = extra[extraId + 1]
            if bitmask < 0 then
                bitmask = bitmask + 256
            end
            bitmask = bit.band(bitmask, bit.bnot(bit.lshift(1, (k - 1) % 8)))
            extra[extraId + 1] = bitmask

            player:retrieveItemFromSlip(slipId, retrievedItemId, extraId, bitmask)
            player:messageSpecial(zones[player:getZoneID()].text.RETRIEVE_DIALOG_ID, retrievedItemId, nil, nil, retrievedItemId, false)
        end

        local params = int8ToInt32(extra)
        player:updateEvent(params[1], params[2], params[3], params[4], params[5], params[6], slipId)
    end
end

-----------------------------------
-- desc : Completes the event.
-----------------------------------
function porterEventFinish(player, csid, option, TALK_EVENT_ID)
    if (csid == TALK_EVENT_ID and option < 1000) then
        -- This is just because hilarious.
        option = math.floor(option / 16) + (option % 16)
        local hasItem = player:hasItem(slipIds[option])
        if (hasItem or player:getFreeSlotsCount() == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, slipIds[option])
            return
        end

        if (player:delGil(1000)) then
            player:addItem(slipIds[option])
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, slipIds[option])
        else
            player:messageSpecial(zones[player:getZoneID()].text.NOT_HAVE_ENOUGH_GIL, slipIds[option])
            return
        end
    else
        player:setLocalVar('slipId', 0)
    end
end
