/*
===========================================================================

  Copyright //(c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  //(at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _CMERIT_H
#define _CMERIT_H

#include "../common/cbasetypes.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

enum MERIT_CATEGORY
{
    MCATEGORY_HP_MP      = 0x0040,
    MCATEGORY_ATTRIBUTES = 0x0080,
    MCATEGORY_COMBAT     = 0x00C0,
    MCATEGORY_MAGIC      = 0x0100,
    MCATEGORY_OTHERS     = 0x0140,

    MCATEGORY_WAR_1 = 0x0180,
    MCATEGORY_MNK_1 = 0x01C0,
    MCATEGORY_WHM_1 = 0x0200,
    MCATEGORY_BLM_1 = 0x0240,
    MCATEGORY_RDM_1 = 0x0280,
    MCATEGORY_THF_1 = 0x02C0,
    MCATEGORY_PLD_1 = 0x0300,
    MCATEGORY_DRK_1 = 0x0340,
    MCATEGORY_BST_1 = 0x0380,
    MCATEGORY_BRD_1 = 0x03C0,
    MCATEGORY_RNG_1 = 0x0400,
    MCATEGORY_SAM_1 = 0x0440,
    MCATEGORY_NIN_1 = 0x0480,
    MCATEGORY_DRG_1 = 0x04C0,
    MCATEGORY_SMN_1 = 0x0500,
    MCATEGORY_BLU_1 = 0x0540,
    MCATEGORY_COR_1 = 0x0580,
    MCATEGORY_PUP_1 = 0x05C0,
    MCATEGORY_DNC_1 = 0x0600,
    MCATEGORY_SCH_1 = 0x0640,

    MCATEGORY_WS = 0x0680,

    MCATEGORY_GEO_1 = 0x06C0,
    MCATEGORY_RUN_1 = 0x0700,

    MCATEGORY_UNK_1 = 0x0740,
    MCATEGORY_UNK_2 = 0x0780,
    MCATEGORY_UNK_3 = 0x07C0,

    MCATEGORY_WAR_2 = 0x0800,
    MCATEGORY_MNK_2 = 0x0840,
    MCATEGORY_WHM_2 = 0x0880,
    MCATEGORY_BLM_2 = 0x08C0,
    MCATEGORY_RDM_2 = 0x0900,
    MCATEGORY_THF_2 = 0x0940,
    MCATEGORY_PLD_2 = 0x0980,
    MCATEGORY_DRK_2 = 0x09C0,
    MCATEGORY_BST_2 = 0x0A00,
    MCATEGORY_BRD_2 = 0x0A40,
    MCATEGORY_RNG_2 = 0x0A80,
    MCATEGORY_SAM_2 = 0x0AC0,
    MCATEGORY_NIN_2 = 0x0B00,
    MCATEGORY_DRG_2 = 0x0B40,
    MCATEGORY_SMN_2 = 0x0B80,
    MCATEGORY_BLU_2 = 0x0BC0,
    MCATEGORY_COR_2 = 0x0C00,
    MCATEGORY_PUP_2 = 0x0C40,
    MCATEGORY_DNC_2 = 0x0C80,
    MCATEGORY_SCH_2 = 0x0CC0,

    MCATEGORY_UNK_4 = 0x0D00,

    MCATEGORY_GEO_2 = 0x0D40,
    MCATEGORY_RUN_2 = 0x0D80,

    MCATEGORY_START = 0x0040,
    MCATEGORY_COUNT = 0x0DC0,
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

enum MERIT_TYPE
{
    // HP
    MERIT_MAX_HP    = MCATEGORY_HP_MP + 0x00,
    MERIT_MAX_MP    = MCATEGORY_HP_MP + 0x02,
    MERIT_MAX_MERIT = MCATEGORY_HP_MP + 0x04,

    // ATTRIBUTES
    MERIT_STR = MCATEGORY_ATTRIBUTES + 0x00,
    MERIT_DEX = MCATEGORY_ATTRIBUTES + 0x02,
    MERIT_VIT = MCATEGORY_ATTRIBUTES + 0x04,
    MERIT_AGI = MCATEGORY_ATTRIBUTES + 0x06,
    MERIT_INT = MCATEGORY_ATTRIBUTES + 0x08,
    MERIT_MND = MCATEGORY_ATTRIBUTES + 0x0A,
    MERIT_CHR = MCATEGORY_ATTRIBUTES + 0x0C,

    // COMBAT SKILLS
    MERIT_H2H          = MCATEGORY_COMBAT + 0x00,
    MERIT_DAGGER       = MCATEGORY_COMBAT + 0x02,
    MERIT_SWORD        = MCATEGORY_COMBAT + 0x04,
    MERIT_GSWORD       = MCATEGORY_COMBAT + 0x06,
    MERIT_AXE          = MCATEGORY_COMBAT + 0x08,
    MERIT_GAXE         = MCATEGORY_COMBAT + 0x0A,
    MERIT_SCYTHE       = MCATEGORY_COMBAT + 0x0C,
    MERIT_POLEARM      = MCATEGORY_COMBAT + 0x0E,
    MERIT_KATANA       = MCATEGORY_COMBAT + 0x10,
    MERIT_GKATANA      = MCATEGORY_COMBAT + 0x12,
    MERIT_CLUB         = MCATEGORY_COMBAT + 0x14,
    MERIT_STAFF        = MCATEGORY_COMBAT + 0x16,
    MERIT_ARCHERY      = MCATEGORY_COMBAT + 0x18,
    MERIT_MARKSMANSHIP = MCATEGORY_COMBAT + 0x1A,
    MERIT_THROWING     = MCATEGORY_COMBAT + 0x1C,
    MERIT_GUARDING     = MCATEGORY_COMBAT + 0x1E,
    MERIT_EVASION      = MCATEGORY_COMBAT + 0x20,
    MERIT_SHIELD       = MCATEGORY_COMBAT + 0x22,
    MERIT_PARRYING     = MCATEGORY_COMBAT + 0x24,

    // MAGIC SKILLS
    MERIT_DIVINE     = MCATEGORY_MAGIC + 0x00,
    MERIT_HEALING    = MCATEGORY_MAGIC + 0x02,
    MERIT_ENHANCING  = MCATEGORY_MAGIC + 0x04,
    MERIT_ENFEEBLING = MCATEGORY_MAGIC + 0x06,
    MERIT_ELEMENTAL  = MCATEGORY_MAGIC + 0x08,
    MERIT_DARK       = MCATEGORY_MAGIC + 0x0A,
    MERIT_SUMMONING  = MCATEGORY_MAGIC + 0x0C,
    MERIT_NINJITSU   = MCATEGORY_MAGIC + 0x0E,
    MERIT_SINGING    = MCATEGORY_MAGIC + 0x10,
    MERIT_STRING     = MCATEGORY_MAGIC + 0x12,
    MERIT_WIND       = MCATEGORY_MAGIC + 0x14,
    MERIT_BLUE       = MCATEGORY_MAGIC + 0x16,
    MERIT_GEO        = MCATEGORY_MAGIC + 0x18,
    MERIT_HANDBELL   = MCATEGORY_MAGIC + 0x1A,

    // OTHERS
    MERIT_ENMITY_INCREASE        = MCATEGORY_OTHERS + 0x00,
    MERIT_ENMITY_DECREASE        = MCATEGORY_OTHERS + 0x02,
    MERIT_CRIT_HIT_RATE          = MCATEGORY_OTHERS + 0x04,
    MERIT_ENEMY_CRIT_RATE        = MCATEGORY_OTHERS + 0x06,
    MERIT_SPELL_INTERUPTION_RATE = MCATEGORY_OTHERS + 0x08,

    // WAR 1
    MERIT_BERSERK_RECAST     = MCATEGORY_WAR_1 + 0x00,
    MERIT_DEFENDER_RECAST    = MCATEGORY_WAR_1 + 0x02,
    MERIT_WARCRY_RECAST      = MCATEGORY_WAR_1 + 0x04,
    MERIT_AGGRESSOR_RECAST   = MCATEGORY_WAR_1 + 0x06,
    MERIT_DOUBLE_ATTACK_RATE = MCATEGORY_WAR_1 + 0x08,

    // MNK 1
    MERIT_FOCUS_RECAST     = MCATEGORY_MNK_1 + 0x00,
    MERIT_DODGE_RECAST     = MCATEGORY_MNK_1 + 0x02,
    MERIT_CHAKRA_RECAST    = MCATEGORY_MNK_1 + 0x04,
    MERIT_COUNTER_RATE     = MCATEGORY_MNK_1 + 0x06,
    MERIT_KICK_ATTACK_RATE = MCATEGORY_MNK_1 + 0x08,

    // WHM 1
    MERIT_DIVINE_SEAL_RECAST = MCATEGORY_WHM_1 + 0x00,
    MERIT_CURE_CAST_TIME     = MCATEGORY_WHM_1 + 0x02,
    MERIT_BAR_SPELL_EFFECT   = MCATEGORY_WHM_1 + 0x04,
    MERIT_BANISH_EFFECT      = MCATEGORY_WHM_1 + 0x06,
    MERIT_REGEN_EFFECT       = MCATEGORY_WHM_1 + 0x08,

    // BLM 1
    MERIT_ELEMENTAL_SEAL_RECAST   = MCATEGORY_BLM_1 + 0x00,
    MERIT_FIRE_MAGIC_POTENCY      = MCATEGORY_BLM_1 + 0x02,
    MERIT_ICE_MAGIC_POTENCY       = MCATEGORY_BLM_1 + 0x04,
    MERIT_WIND_MAGIC_POTENCY      = MCATEGORY_BLM_1 + 0x06,
    MERIT_EARTH_MAGIC_POTENCY     = MCATEGORY_BLM_1 + 0x08,
    MERIT_LIGHTNING_MAGIC_POTENCY = MCATEGORY_BLM_1 + 0x0A,
    MERIT_WATER_MAGIC_POTENCY     = MCATEGORY_BLM_1 + 0x0C,

    // RDM 1
    MERIT_CONVERT_RECAST           = MCATEGORY_RDM_1 + 0x00,
    MERIT_FIRE_MAGIC_ACCURACY      = MCATEGORY_RDM_1 + 0x02,
    MERIT_ICE_MAGIC_ACCURACY       = MCATEGORY_RDM_1 + 0x04,
    MERIT_WIND_MAGIC_ACCURACY      = MCATEGORY_RDM_1 + 0x06,
    MERIT_EARTH_MAGIC_ACCURACY     = MCATEGORY_RDM_1 + 0x08,
    MERIT_LIGHTNING_MAGIC_ACCURACY = MCATEGORY_RDM_1 + 0x0A,
    MERIT_WATER_MAGIC_ACCURACY     = MCATEGORY_RDM_1 + 0x0C,

    // THF 1
    MERIT_FLEE_RECAST         = MCATEGORY_THF_1 + 0x00,
    MERIT_HIDE_RECAST         = MCATEGORY_THF_1 + 0x02,
    MERIT_SNEAK_ATTACK_RECAST = MCATEGORY_THF_1 + 0x04,
    MERIT_TRICK_ATTACK_RECAST = MCATEGORY_THF_1 + 0x06,
    MERIT_TRIPLE_ATTACK_RATE  = MCATEGORY_THF_1 + 0x08,

    // PLD 1
    MERIT_SHIELD_BASH_RECAST  = MCATEGORY_PLD_1 + 0x00,
    MERIT_HOLY_CIRCLE_RECAST  = MCATEGORY_PLD_1 + 0x02,
    MERIT_SENTINEL_RECAST     = MCATEGORY_PLD_1 + 0x04,
    MERIT_COVER_EFFECT_LENGTH = MCATEGORY_PLD_1 + 0x06,
    MERIT_RAMPART_RECAST      = MCATEGORY_PLD_1 + 0x08,

    // DRK 1
    MERIT_SOULEATER_RECAST     = MCATEGORY_DRK_1 + 0x00,
    MERIT_ARCANE_CIRCLE_RECAST = MCATEGORY_DRK_1 + 0x02,
    MERIT_LAST_RESORT_RECAST   = MCATEGORY_DRK_1 + 0x04,
    MERIT_LAST_RESORT_EFFECT   = MCATEGORY_DRK_1 + 0x06,
    MERIT_WEAPON_BASH_EFFECT   = MCATEGORY_DRK_1 + 0x08,

    // BST 1
    MERIT_KILLER_EFFECTS    = MCATEGORY_BST_1 + 0x00,
    MERIT_REWARD_RECAST     = MCATEGORY_BST_1 + 0x02,
    MERIT_CALL_BEAST_RECAST = MCATEGORY_BST_1 + 0x04,
    MERIT_SIC_RECAST        = MCATEGORY_BST_1 + 0x06,
    MERIT_TAME_RECAST       = MCATEGORY_BST_1 + 0x08,

    // BRD 1
    MERIT_LULLABY_RECAST  = MCATEGORY_BRD_1 + 0x00,
    MERIT_FINALE_RECAST   = MCATEGORY_BRD_1 + 0x02,
    MERIT_MINNE_EFFECT    = MCATEGORY_BRD_1 + 0x04,
    MERIT_MINUET_EFFECT   = MCATEGORY_BRD_1 + 0x06,
    MERIT_MADRIGAL_EFFECT = MCATEGORY_BRD_1 + 0x08,

    // RNG 1
    MERIT_SCAVENGE_EFFECT       = MCATEGORY_RNG_1 + 0x00,
    MERIT_CAMOUFLAGE_RECAST     = MCATEGORY_RNG_1 + 0x02,
    MERIT_SHARPSHOT_RECAST      = MCATEGORY_RNG_1 + 0x04,
    MERIT_UNLIMITED_SHOT_RECAST = MCATEGORY_RNG_1 + 0x06,
    MERIT_RAPID_SHOT_RATE       = MCATEGORY_RNG_1 + 0x08,

    // SAM 1
    MERIT_THIRD_EYE_RECAST      = MCATEGORY_SAM_1 + 0x00,
    MERIT_WARDING_CIRCLE_RECAST = MCATEGORY_SAM_1 + 0x02,
    MERIT_STORE_TP_EFFECT       = MCATEGORY_SAM_1 + 0x04,
    MERIT_MEDITATE_RECAST       = MCATEGORY_SAM_1 + 0x06,
    MERIT_ZASHIN_ATTACK_RATE    = MCATEGORY_SAM_1 + 0x08,

    // NIN 1
    MERIT_SUBTLE_BLOW_EFFECT = MCATEGORY_NIN_1 + 0x00,
    MERIT_KATON_EFFECT       = MCATEGORY_NIN_1 + 0x02,
    MERIT_HYOTON_EFFECT      = MCATEGORY_NIN_1 + 0x04,
    MERIT_HUTON_EFFECT       = MCATEGORY_NIN_1 + 0x06,
    MERIT_DOTON_EFFECT       = MCATEGORY_NIN_1 + 0x08,
    MERIT_RAITON_EFFECT      = MCATEGORY_NIN_1 + 0x0A,
    MERIT_SUITON_EFFECT      = MCATEGORY_NIN_1 + 0x0C,

    // DRG 1
    MERIT_ANCIENT_CIRCLE_RECAST = MCATEGORY_DRG_1 + 0x00,
    MERIT_JUMP_RECAST           = MCATEGORY_DRG_1 + 0x02,
    MERIT_HIGH_JUMP_RECAST      = MCATEGORY_DRG_1 + 0x04,
    MERIT_SUPER_JUMP_RECAST     = MCATEGORY_DRG_1 + 0x06,
    MERIT_SPIRIT_LINK_RECAST    = MCATEGORY_DRG_1 + 0x08,

    // SMN 1
    MERIT_AVATAR_PHYSICAL_ACCURACY  = MCATEGORY_SMN_1 + 0x00,
    MERIT_AVATAR_PHYSICAL_ATTACK    = MCATEGORY_SMN_1 + 0x02,
    MERIT_AVATAR_MAGICAL_ACCURACY   = MCATEGORY_SMN_1 + 0x04,
    MERIT_AVATAR_MAGICAL_ATTACK     = MCATEGORY_SMN_1 + 0x06,
    MERIT_SUMMONING_MAGIC_CAST_TIME = MCATEGORY_SMN_1 + 0x08,

    // BLU 1
    MERIT_CHAIN_AFFINITY_RECAST = MCATEGORY_BLU_1 + 0x00,
    MERIT_BURST_AFFINITY_RECAST = MCATEGORY_BLU_1 + 0x02,
    MERIT_MONSTER_CORRELATION   = MCATEGORY_BLU_1 + 0x04,
    MERIT_PHYSICAL_POTENCY      = MCATEGORY_BLU_1 + 0x06,
    MERIT_MAGICAL_ACCURACY      = MCATEGORY_BLU_1 + 0x08,

    // COR 1
    MERIT_PHANTOM_ROLL_RECAST = MCATEGORY_COR_1 + 0x00,
    MERIT_QUICK_DRAW_RECAST   = MCATEGORY_COR_1 + 0x02,
    MERIT_QUICK_DRAW_ACCURACY = MCATEGORY_COR_1 + 0x04,
    MERIT_RANDOM_DEAL_RECAST  = MCATEGORY_COR_1 + 0x06,
    MERIT_BUST_DURATION       = MCATEGORY_COR_1 + 0x08,

    // PUP 1
    MERIT_AUTOMATON_SKILLS  = MCATEGORY_PUP_1 + 0x00,
    MERIT_MAINTENACE_RECAST = MCATEGORY_PUP_1 + 0x02,
    MERIT_REPAIR_EFFECT     = MCATEGORY_PUP_1 + 0x04,
    MERIT_ACTIVATE_RECAST   = MCATEGORY_PUP_1 + 0x06,
    MERIT_REPAIR_RECAST     = MCATEGORY_PUP_1 + 0x08,

    // DNC 1
    MERIT_STEP_ACCURACY            = MCATEGORY_DNC_1 + 0x00,
    MERIT_HASTE_SAMBA_EFFECT       = MCATEGORY_DNC_1 + 0x02,
    MERIT_REVERSE_FLOURISH_EFFECT  = MCATEGORY_DNC_1 + 0x04,
    MERIT_BUILDING_FLOURISH_EFFECT = MCATEGORY_DNC_1 + 0x06,

    // SCH 1
    MERIT_GRIMOIRE_RECAST        = MCATEGORY_SCH_1 + 0x00,
    MERIT_MODUS_VERITAS_DURATION = MCATEGORY_SCH_1 + 0x02,
    MERIT_HELIX_MAGIC_ACC_ATT    = MCATEGORY_SCH_1 + 0x04,
    MERIT_MAX_SUBLIMATION        = MCATEGORY_SCH_1 + 0x06,

    // GEO 1
    MERIT_FULL_CIRCLE_EFFECT    = MCATEGORY_GEO_1 + 0x00,
    MERIT_ECLIPTIC_ATT_RECAST   = MCATEGORY_GEO_1 + 0x02,
    MERIT_LIFE_CYCLE_RECAST     = MCATEGORY_GEO_1 + 0x04,
    MERIT_BLAZE_OF_GLORY_RECAST = MCATEGORY_GEO_1 + 0x06,
    MERIT_DEMATERIALIZE_RECAST  = MCATEGORY_GEO_1 + 0x08,

    // RUN 1
    MERIT_RUNE_ENHANCE     = MCATEGORY_RUN_1 + 0x00,
    MERIT_VALLATION_EFFECT = MCATEGORY_RUN_1 + 0x02,
    MERIT_LUNGE_EFFECT     = MCATEGORY_RUN_1 + 0x04,
    MERIT_PFLUG_EFFECT     = MCATEGORY_RUN_1 + 0x06,
    MERIT_GAMBIT_EFFECT    = MCATEGORY_RUN_1 + 0x08,

    // WEAPON SKILLS
    MERIT_SHIJIN_SPIRAL = MCATEGORY_WS + 0x00,
    MERIT_EXENTERATOR   = MCATEGORY_WS + 0x02,
    MERIT_REQUIESCAT    = MCATEGORY_WS + 0x04,
    MERIT_RESOLUTION    = MCATEGORY_WS + 0x06,
    MERIT_RUINATOR      = MCATEGORY_WS + 0x08,
    MERIT_UPHEAVAL      = MCATEGORY_WS + 0x0A,
    MERIT_ENTROPY       = MCATEGORY_WS + 0x0C,
    MERIT_STARDIVER     = MCATEGORY_WS + 0x0E,
    MERIT_BLADE_SHUN    = MCATEGORY_WS + 0x10,
    MERIT_TACHI_SHOHA   = MCATEGORY_WS + 0x12,
    MERIT_REALMRAZER    = MCATEGORY_WS + 0x14,
    MERIT_SHATTERSOUL   = MCATEGORY_WS + 0x16,
    MERIT_APEX_ARROW    = MCATEGORY_WS + 0x18,
    MERIT_LAST_STAND    = MCATEGORY_WS + 0x1A,

    // unknown 0
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // unknown 1
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // unknown 2
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // WAR 2
    MERIT_WARRIORS_CHARGE = MCATEGORY_WAR_2 + 0x00,
    MERIT_TOMAHAWK        = MCATEGORY_WAR_2 + 0x02,
    MERIT_SAVAGERY        = MCATEGORY_WAR_2 + 0x04,
    MERIT_AGGRESSIVE_AIM  = MCATEGORY_WAR_2 + 0x06,

    // MNK 2
    MERIT_MANTRA           = MCATEGORY_MNK_2 + 0x00,
    MERIT_FORMLESS_STRIKES = MCATEGORY_MNK_2 + 0x02,
    MERIT_INVIGORATE       = MCATEGORY_MNK_2 + 0x04,
    MERIT_PENANCE          = MCATEGORY_MNK_2 + 0x06,

    // WHM 2
    MERIT_MARTYR        = MCATEGORY_WHM_2 + 0x00,
    MERIT_DEVOTION      = MCATEGORY_WHM_2 + 0x02,
    MERIT_PROTECTRA_V   = MCATEGORY_WHM_2 + 0x04,
    MERIT_SHELLRA_V     = MCATEGORY_WHM_2 + 0x06,
    MERIT_ANIMUS_SOLACE = MCATEGORY_WHM_2 + 0x08,
    MERIT_ANIMUS_MISERY = MCATEGORY_WHM_2 + 0x0A,

    // BLM 2
    MERIT_FLARE_II                  = MCATEGORY_BLM_2 + 0x00,
    MERIT_FREEZE_II                 = MCATEGORY_BLM_2 + 0x02,
    MERIT_TORNADO_II                = MCATEGORY_BLM_2 + 0x04,
    MERIT_QUAKE_II                  = MCATEGORY_BLM_2 + 0x06,
    MERIT_BURST_II                  = MCATEGORY_BLM_2 + 0x08,
    MERIT_FLOOD_II                  = MCATEGORY_BLM_2 + 0x0A,
    MERIT_ANCIENT_MAGIC_ATK_BONUS   = MCATEGORY_BLM_2 + 0x0C,
    MERIT_ANCIENT_MAGIC_BURST_DMG   = MCATEGORY_BLM_2 + 0x0E,
    MERIT_ELEMENTAL_MAGIC_ACCURACY  = MCATEGORY_BLM_2 + 0x10,
    MERIT_ELEMENTAL_DEBUFF_DURATION = MCATEGORY_BLM_2 + 0x12,
    MERIT_ELEMENTAL_DEBUFF_EFFECT   = MCATEGORY_BLM_2 + 0x14,
    MERIT_ASPIR_ABSORPTION_AMOUNT   = MCATEGORY_BLM_2 + 0x16,

    // RDM 2
    MERIT_DIA_III                   = MCATEGORY_RDM_2 + 0x00,
    MERIT_SLOW_II                   = MCATEGORY_RDM_2 + 0x02,
    MERIT_PARALYZE_II               = MCATEGORY_RDM_2 + 0x04,
    MERIT_PHALANX_II                = MCATEGORY_RDM_2 + 0x06,
    MERIT_BIO_III                   = MCATEGORY_RDM_2 + 0x08,
    MERIT_BLIND_II                  = MCATEGORY_RDM_2 + 0x0A,
    MERIT_ENFEEBLING_MAGIC_DURATION = MCATEGORY_RDM_2 + 0x0C,
    MERIT_MAGIC_ACCURACY            = MCATEGORY_RDM_2 + 0x0E,
    MERIT_ENHANCING_MAGIC_DURATION  = MCATEGORY_RDM_2 + 0x10,
    MERIT_IMMUNOBREAK_CHANCE        = MCATEGORY_RDM_2 + 0x12,
    MERIT_ENSPELL_DAMAGE            = MCATEGORY_RDM_2 + 0x14,
    MERIT_ACCURACY                  = MCATEGORY_RDM_2 + 0x16,

    // THF 2
    MERIT_ASSASSINS_CHARGE = MCATEGORY_THF_2 + 0x00,
    MERIT_FEINT            = MCATEGORY_THF_2 + 0x02,
    MERIT_AURA_STEAL       = MCATEGORY_THF_2 + 0x04,
    MERIT_AMBUSH           = MCATEGORY_THF_2 + 0x06,

    // PLD 2
    MERIT_FEALTY    = MCATEGORY_PLD_2 + 0x00,
    MERIT_CHIVALRY  = MCATEGORY_PLD_2 + 0x02,
    MERIT_IRON_WILL = MCATEGORY_PLD_2 + 0x04,
    MERIT_GUARDIAN  = MCATEGORY_PLD_2 + 0x06,

    // DRK 2
    MERIT_DARK_SEAL       = MCATEGORY_DRK_2 + 0x00,
    MERIT_DIABOLIC_EYE    = MCATEGORY_DRK_2 + 0x02,
    MERIT_MUTED_SOUL      = MCATEGORY_DRK_2 + 0x04,
    MERIT_DESPERATE_BLOWS = MCATEGORY_DRK_2 + 0x06,

    // BST 2
    MERIT_FERAL_HOWL      = MCATEGORY_BST_2 + 0x00,
    MERIT_KILLER_INSTINCT = MCATEGORY_BST_2 + 0x02,
    MERIT_BEAST_AFFINITY  = MCATEGORY_BST_2 + 0x04,
    MERIT_BEAST_HEALER    = MCATEGORY_BST_2 + 0x06,

    // BRD 2
    MERIT_NIGHTINGALE       = MCATEGORY_BRD_2 + 0x00,
    MERIT_TROUBADOUR        = MCATEGORY_BRD_2 + 0x02,
    MERIT_FOE_SIRVENTE      = MCATEGORY_BRD_2 + 0x04,
    MERIT_ADVENTURERS_DIRGE = MCATEGORY_BRD_2 + 0x06,
    MERIT_CON_ANIMA         = MCATEGORY_BRD_2 + 0x08,
    MERIT_CON_BRIO          = MCATEGORY_BRD_2 + 0x0A,

    // RNG 2
    MERIT_STEALTH_SHOT = MCATEGORY_RNG_2 + 0x00,
    MERIT_FLASHY_SHOT  = MCATEGORY_RNG_2 + 0x02,
    MERIT_SNAPSHOT     = MCATEGORY_RNG_2 + 0x04,
    MERIT_RECYCLE      = MCATEGORY_RNG_2 + 0x06,

    // SAM 2
    MERIT_SHIKIKOYO  = MCATEGORY_SAM_2 + 0x00,
    MERIT_BLADE_BASH = MCATEGORY_SAM_2 + 0x02,
    MERIT_IKISHOTEN  = MCATEGORY_SAM_2 + 0x04,
    MERIT_OVERWHELM  = MCATEGORY_SAM_2 + 0x06,

    // NIN 2
    MERIT_SANGE                = MCATEGORY_NIN_2 + 0x00,
    MERIT_NINJA_TOOL_EXPERTISE = MCATEGORY_NIN_2 + 0x02,
    MERIT_KATON_SAN            = MCATEGORY_NIN_2 + 0x04,
    MERIT_HYOTON_SAN           = MCATEGORY_NIN_2 + 0x06,
    MERIT_HUTON_SAN            = MCATEGORY_NIN_2 + 0x08,
    MERIT_DOTON_SAN            = MCATEGORY_NIN_2 + 0x0A,
    MERIT_RAITON_SAN           = MCATEGORY_NIN_2 + 0x0C,
    MERIT_SUITON_SAN           = MCATEGORY_NIN_2 + 0x0E,
    MERIT_YONIN_EFFECT         = MCATEGORY_NIN_2 + 0x10,
    MERIT_INNIN_EFFECT         = MCATEGORY_NIN_2 + 0x12,
    MERIT_NIN_MAGIC_ACCURACY   = MCATEGORY_NIN_2 + 0x14,
    MERIT_NIN_MAGIC_BONUS      = MCATEGORY_NIN_2 + 0x16,

    // DRG 2
    MERIT_DEEP_BREATHING = MCATEGORY_DRG_2 + 0x00,
    MERIT_ANGON          = MCATEGORY_DRG_2 + 0x02,
    MERIT_EMPATHY        = MCATEGORY_DRG_2 + 0x04,
    MERIT_STRAFE_EFFECT  = MCATEGORY_DRG_2 + 0x06,

    // SMN 2
    MERIT_METEOR_STRIKE   = MCATEGORY_SMN_2 + 0x00,
    MERIT_HEAVENLY_STRIKE = MCATEGORY_SMN_2 + 0x02,
    MERIT_WIND_BLADE      = MCATEGORY_SMN_2 + 0x04,
    MERIT_GEOCRUSH        = MCATEGORY_SMN_2 + 0x06,
    MERIT_THUNDERSTORM    = MCATEGORY_SMN_2 + 0x08,
    MERIT_GRANDFALL       = MCATEGORY_SMN_2 + 0x0A,

    // BLU 2
    MERIT_CONVERGENCE  = MCATEGORY_BLU_2 + 0x00,
    MERIT_DIFFUSION    = MCATEGORY_BLU_2 + 0x02,
    MERIT_ENCHAINMENT  = MCATEGORY_BLU_2 + 0x04,
    MERIT_ASSIMILATION = MCATEGORY_BLU_2 + 0x06,

    // COR 2
    MERIT_SNAKE_EYE      = MCATEGORY_COR_2 + 0x00,
    MERIT_FOLD           = MCATEGORY_COR_2 + 0x02,
    MERIT_WINNING_STREAK = MCATEGORY_COR_2 + 0x04,
    MERIT_LOADED_DECK    = MCATEGORY_COR_2 + 0x06,

    // PUP 2
    MERIT_ROLE_REVERSAL = MCATEGORY_PUP_2 + 0x00,
    MERIT_VENTRILOQUY   = MCATEGORY_PUP_2 + 0x02,
    MERIT_FINE_TUNING   = MCATEGORY_PUP_2 + 0x04,
    MERIT_OPTIMIZATION  = MCATEGORY_PUP_2 + 0x06,

    // DNC 2
    MERIT_SABER_DANCE     = MCATEGORY_DNC_2 + 0x00,
    MERIT_FAN_DANCE       = MCATEGORY_DNC_2 + 0x02,
    MERIT_NO_FOOT_RISE    = MCATEGORY_DNC_2 + 0x04,
    MERIT_CLOSED_POSITION = MCATEGORY_DNC_2 + 0x06,

    // SCH 2
    MERIT_ALTRUISM      = MCATEGORY_SCH_2 + 0x00,
    MERIT_FOCALIZATION  = MCATEGORY_SCH_2 + 0x02,
    MERIT_TRANQUILITY   = MCATEGORY_SCH_2 + 0x04,
    MERIT_EQUANIMITY    = MCATEGORY_SCH_2 + 0x06,
    MERIT_ENLIGHTENMENT = MCATEGORY_SCH_2 + 0x08,
    MERIT_STORMSURGE    = MCATEGORY_SCH_2 + 0x0A,

    // unknown 3
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // GEO 2
    MERIT_MENDING_HALATION     = MCATEGORY_GEO_2 + 0x00,
    MERIT_RADIAL_ARCANA        = MCATEGORY_GEO_2 + 0x02,
    MERIT_CURATIVE_RECANTATION = MCATEGORY_GEO_2 + 0x04,
    MERIT_PRIMEVAL_ZEAL        = MCATEGORY_GEO_2 + 0x06,

    // RUN 2
    MERIT_BATTUTA          = MCATEGORY_RUN_2 + 0x00,
    MERIT_RAYKE            = MCATEGORY_RUN_2 + 0x02,
    MERIT_INSPIRATION      = MCATEGORY_RUN_2 + 0x04,
    MERIT_SLEIGHT_OF_SWORD = MCATEGORY_RUN_2 + 0x06,
};

#define MERITS_COUNT 305 // 5 full packages of 61 elements

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

struct Merit_t
{
    union
    {
        struct
        {
            uint16 id;    // merit id
            uint8  next;  // required merit points for next upgrade
            uint8  count; // number of upgrades
        };
        uint32 data; // data sent in packet
    };

    uint32 value;     // the coefficient of variation of the parameter that is bound to merit
    uint8  upgrade;   // maximum number of upgrades
    uint32 jobs;      // bitmask of jobs for which merit has effect
    uint8  upgradeid; // which set of upgrade values the merit will use
    uint8  catid;     // cat which merit belongs to
    uint16 spellid;   // associated spell ID to learn/unlearn
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
class CCharEntity;

class CMeritPoints
{
public:
    CMeritPoints(CCharEntity* PChar);

    uint16 GetLimitPoints() const;
    uint8  GetMeritPoints() const;
    int32  GetMeritValue(MERIT_TYPE merit, CCharEntity* PChar);
    uint16 GetMeritCountInSameCategory(MERIT_TYPE merit);

    bool AddLimitPoints(uint16 points);  // automatically adds merit points > 10000
    bool IsMeritExist(MERIT_TYPE merit); // проверяем существование merit

    void RaiseMerit(MERIT_TYPE merit); // add upgrade
    void LowerMerit(MERIT_TYPE merit); // del upgrade

    void SetLimitPoints(uint16 points); // used for loading player limit points on login
    void SetMeritPoints(uint16 points); // used for loading player merit points on login

    const Merit_t* GetMerit(MERIT_TYPE merit);
    const Merit_t* GetMeritByIndex(uint16 index); // get merit index, 0,1,2,3,4 and so on

    void LoadMeritPoints(uint32 charid); // load char applied merits
    void SaveMeritPoints(uint32 charid); // save char applied merits

private:
    uint16       m_LimitPoints;
    uint8        m_MeritPoints;
    CCharEntity* m_PChar;
    Merit_t      merits[MERITS_COUNT];

    Merit_t* GetMeritPointer(MERIT_TYPE merit);
    Merit_t* Categories[MCATEGORY_COUNT / 64 - 1]; // 51 pointers to the first merit of each catagory
};

namespace meritNameSpace
{
    void LoadMeritsList(); // load the global list of merits

    extern Merit_t GMeritsTemplate[MERITS_COUNT];
    extern int16   groupOffset[MCATEGORY_COUNT / 64 - 1]; // the first merit offset of each catagory
};                                                        // namespace meritNameSpace

#endif
