-----------------------------------
-- Abjurations
-- Used by Alphollon C Meriard
-----------------------------------
require('scripts/globals/items')
-----------------------------------

xi = xi or {}

xi.abjurations =
{
    -- (5 IDs/lines per transaction)
    --  abjuration,
    --  item,
    --  item -1,
    --  nq reward,
    --  hq reward

    xi.items.LIBATION_ABJURATION,
    xi.items.BOTTLE_OF_CURSED_BEVERAGE,
    xi.items.BOTTLE_OF_CURSED_BEVERAGE,
    xi.items.BOTTLE_OF_AMRITA,
    xi.items.BOTTLE_OF_AMRITA,

    xi.items.OBLATION_ABJURATION,
    xi.items.BOWL_OF_CURSED_SOUP,
    xi.items.BOWL_OF_CURSED_SOUP,
    xi.items.BOWL_OF_AMBROSIA,
    xi.items.BOWL_OF_AMBROSIA,

    xi.items.DRYADIC_ABJURATION_HEAD,
    xi.items.CURSED_KABUTO,
    xi.items.CURSED_KABUTO_M1,
    xi.items.SHURA_ZUNARI_KABUTO,
    xi.items.SHURA_ZUNARI_KABUTO_P1,

    xi.items.DRYADIC_ABJURATION_BODY,
    xi.items.CURSED_TOGI,
    xi.items.CURSED_TOGI_M1,
    xi.items.SHURA_TOGI,
    xi.items.SHURA_TOGI_P1,

    xi.items.DRYADIC_ABJURATION_HANDS,
    xi.items.CURSED_KOTE,
    xi.items.CURSED_KOTE_M1,
    xi.items.SHURA_KOTE,
    xi.items.SHURA_KOTE_P1,

    xi.items.DRYADIC_ABJURATION_LEGS,
    xi.items.CURSED_HAIDATE,
    xi.items.CURSED_HAIDATE_M1,
    xi.items.SHURA_HAIDATE,
    xi.items.SHURA_HAIDATE_P1,

    xi.items.DRYADIC_ABJURATION_FEET,
    xi.items.CURSED_SUNE_ATE,
    xi.items.CURSED_SUNE_ATE_M1,
    xi.items.SHURA_SUNE_ATE,
    xi.items.SHURA_SUNE_ATE_P1,

    xi.items.EARTHEN_ABJURATION_HEAD,
    xi.items.CURSED_CELATA,
    xi.items.CURSED_CELATA_M1,
    xi.items.ADAMAN_CELATA,
    xi.items.ARMADA_CELATA,

    xi.items.EARTHEN_ABJURATION_BODY,
    xi.items.CURSED_HAUBERK,
    xi.items.CURSED_HAUBERK_M1,
    xi.items.ADAMAN_HAUBERK,
    xi.items.ARMADA_HAUBERK,

    xi.items.EARTHEN_ABJURATION_HANDS,
    xi.items.CURSED_MUFFLERS,
    xi.items.CURSED_MUFFLERS_M1,
    xi.items.ADAMAN_MUFFLERS,
    xi.items.ARMADA_MUFFLERS,

    xi.items.EARTHEN_ABJURATION_LEGS,
    xi.items.CURSED_BREECHES,
    xi.items.CURSED_BREECHES_M1,
    xi.items.ADAMAN_BREECHES,
    xi.items.ARMADA_BREECHES,

    xi.items.EARTHEN_ABJURATION_FEET,
    xi.items.CURSED_SOLLERETS,
    xi.items.CURSED_SOLLERETS_M1,
    xi.items.ADAMAN_SOLLERETS,
    xi.items.ARMADA_SOLLERETS,

    xi.items.AQUARIAN_ABJURATION_HEAD,
    xi.items.CURSED_CROWN,
    xi.items.CURSED_CROWN_M1,
    xi.items.ZENITH_CROWN,
    xi.items.ZENITH_CROWN_P1,

    xi.items.AQUARIAN_ABJURATION_BODY,
    xi.items.CURSED_DALMATICA,
    xi.items.CURSED_DALMATICA_M1,
    xi.items.DALMATICA,
    xi.items.DALMATICA_P1,

    xi.items.AQUARIAN_ABJURATION_HANDS,
    xi.items.CURSED_MITTS,
    xi.items.CURSED_MITTS_M1,
    xi.items.ZENITH_MITTS,
    xi.items.ZENITH_MITTS_P1,

    xi.items.AQUARIAN_ABJURATION_LEGS,
    xi.items.CURSED_SLACKS,
    xi.items.CURSED_SLACKS_M1,
    xi.items.ZENITH_SLACKS,
    xi.items.ZENITH_SLACKS_P1,

    xi.items.AQUARIAN_ABJURATION_FEET,
    xi.items.CURSED_PUMPS,
    xi.items.CURSED_PUMPS_M1,
    xi.items.ZENITH_PUMPS,
    xi.items.ZENITH_PUMPS_P1,

    xi.items.MARTIAL_ABJURATION_HEAD,
    xi.items.CURSED_SCHALLER,
    xi.items.CURSED_SCHALLER_M1,
    xi.items.KOENIG_SCHALLER,
    xi.items.KAISER_SCHALLER,

    xi.items.MARTIAL_ABJURATION_BODY,
    xi.items.CURSED_CUIRASS,
    xi.items.CURSED_CUIRASS_M1,
    xi.items.KOENIG_CUIRASS,
    xi.items.KAISER_CUIRASS,

    xi.items.MARTIAL_ABJURATION_HANDS,
    xi.items.CURSED_HANDSCHUHS,
    xi.items.CURSED_HANDSCHUHS_M1,
    xi.items.KOENIG_HANDSCHUHS,
    xi.items.KAISER_HANDSCHUHS,

    xi.items.MARTIAL_ABJURATION_LEGS,
    xi.items.CURSED_DIECHLINGS,
    xi.items.CURSED_DIECHLINGS_M1,
    xi.items.KOENIG_DIECHLINGS,
    xi.items.KAISER_DIECHLINGS,

    xi.items.MARTIAL_ABJURATION_FEET,
    xi.items.CURSED_SCHUHS,
    xi.items.CURSED_SCHUHS_M1,
    xi.items.KOENIG_SCHUHS,
    xi.items.KAISER_SCHUHS,

    xi.items.WYRMAL_ABJURATION_HEAD,
    xi.items.CURSED_MASK,
    xi.items.CURSED_MASK_M1,
    xi.items.CRIMSON_MASK,
    xi.items.BLOOD_MASK,

    xi.items.WYRMAL_ABJURATION_BODY,
    xi.items.CURSED_MAIL,
    xi.items.CURSED_MAIL_M1,
    xi.items.CRIMSON_SCALE_MAIL,
    xi.items.BLOOD_SCALE_MAIL,

    xi.items.WYRMAL_ABJURATION_HANDS,
    xi.items.CURSED_FINGER_GAUNTLETS,
    xi.items.CURSED_FINGER_GAUNTLETS_M1,
    xi.items.CRIMSON_FINGER_GAUNTLETS,
    xi.items.BLOOD_FINGER_GAUNTLETS,

    xi.items.WYRMAL_ABJURATION_LEGS,
    xi.items.CURSED_CUISSES,
    xi.items.CURSED_CUISSES_M1,
    xi.items.CRIMSON_CUISSES,
    xi.items.BLOOD_CUISSES,

    xi.items.WYRMAL_ABJURATION_FEET,
    xi.items.CURSED_GREAVES,
    xi.items.CURSED_GREAVES_M1,
    xi.items.CRIMSON_GREAVES,
    xi.items.BLOOD_GREAVES,

    xi.items.NEPTUNAL_ABJURATION_HEAD,
    xi.items.CURSED_CAP,
    xi.items.CURSED_CAP_M1,
    xi.items.HECATOMB_CAP,
    xi.items.HECATOMB_CAP_P1,

    xi.items.NEPTUNAL_ABJURATION_BODY,
    xi.items.CURSED_HARNESS,
    xi.items.CURSED_HARNESS_M1,
    xi.items.HECATOMB_HARNESS,
    xi.items.HECATOMB_HARNESS_P1,

    xi.items.NEPTUNAL_ABJURATION_HANDS,
    xi.items.CURSED_GLOVES,
    xi.items.CURSED_GLOVES_M1,
    xi.items.HECATOMB_MITTENS,
    xi.items.HECATOMB_MITTENS_P1,

    xi.items.NEPTUNAL_ABJURATION_LEGS,
    xi.items.CURSED_SUBLIGAR,
    xi.items.CURSED_SUBLIGAR_M1,
    xi.items.HECATOMB_SUBLIGAR,
    xi.items.HECATOMB_SUBLIGAR_P1,

    xi.items.NEPTUNAL_ABJURATION_FEET,
    xi.items.CURSED_LEGGINGS,
    xi.items.CURSED_LEGGINGS_M1,
    xi.items.HECATOMB_LEGGINGS,
    xi.items.HECATOMB_LEGGINGS_P1,

    xi.items.PHANTASMAL_ABJURATION_HEAD,
    xi.items.CURSED_HELM,
    xi.items.CURSED_HELM_M1,
    xi.items.SHADOW_HELM,
    xi.items.VALKYRIES_HELM,

    xi.items.PHANTASMAL_ABJURATION_BODY,
    xi.items.CURSED_BREASTPLATE,
    xi.items.CURSED_BREASTPLATE_M1,
    xi.items.SHADOW_BREASTPLATE,
    xi.items.VALKYRIES_BREASTPLATE,

    xi.items.PHANTASMAL_ABJURATION_HANDS,
    xi.items.CURSED_GAUNTLETS,
    xi.items.CURSED_GAUNTLETS_M1,
    xi.items.SHADOW_GAUNTLETS,
    xi.items.VALKYRIES_GAUNTLETS,

    xi.items.PHANTASMAL_ABJURATION_LEGS,
    xi.items.CURSED_CUISHES,
    xi.items.CURSED_CUISHES_M1,
    xi.items.SHADOW_CUISHES,
    xi.items.VALKYRIES_CUISHES,

    xi.items.PHANTASMAL_ABJURATION_FEET,
    xi.items.CURSED_SABATONS,
    xi.items.CURSED_SABATONS_M1,
    xi.items.SHADOW_SABATONS,
    xi.items.VALKYRIES_SABATONS,
}
