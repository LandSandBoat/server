/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/
===========================================================================
*/

#ifndef _CJOBPOINTS_H
#define _CJOBPOINTS_H

#include <vector>

#include "./entities/battleentity.h"
#include "ability.h"
#include "common/cbasetypes.h"
#include "modifier.h"

/************************************************************************
 *                                                                       *
 * Offsets for each job point category (main job)                        *
 *                                                                       *
 ************************************************************************/
enum JOBPOINT_CATEGORY : uint16
{
    JPCATEGORY_WAR = 0x020,
    JPCATEGORY_MNK = 0x040,
    JPCATEGORY_WHM = 0x060,
    JPCATEGORY_BLM = 0x080,
    JPCATEGORY_RDM = 0x0A0,
    JPCATEGORY_THF = 0x0C0,
    JPCATEGORY_PLD = 0x0E0,
    JPCATEGORY_DRK = 0x100,
    JPCATEGORY_BST = 0x120,
    JPCATEGORY_BRD = 0x140,
    JPCATEGORY_RNG = 0x160,
    JPCATEGORY_SAM = 0x180,
    JPCATEGORY_NIN = 0x1A0,
    JPCATEGORY_DRG = 0x1C0,
    JPCATEGORY_SMN = 0x1E0,
    JPCATEGORY_BLU = 0x200,
    JPCATEGORY_COR = 0x220,
    JPCATEGORY_PUP = 0x240,
    JPCATEGORY_DNC = 0x260,
    JPCATEGORY_SCH = 0x280,
    JPCATEGORY_GEO = 0x2A0,
    JPCATEGORY_RUN = 0x2C0,
};

/************************************************************************
 *                                                                       *
 * Bonuses for each job point                                            *
 * Matches client order in the menu. 0x2 and 0x1 are swapped.            *
 *                                                                       *
 ************************************************************************/
enum JOBPOINT_TYPE : uint16
{
    // WAR
    JP_MIGHTY_STRIKES_EFFECT = JPCATEGORY_WAR + 0x00, // p.acc +2
    JP_BRAZEN_RUSH_EFFECT    = JPCATEGORY_WAR + 0x02, // p.atk +4
    JP_BERSERK_EFFECT        = JPCATEGORY_WAR + 0x01, // p.atk +2
    JP_DEFENDER_EFFECT       = JPCATEGORY_WAR + 0x03, // p.def +3
    JP_WARCRY_EFFECT         = JPCATEGORY_WAR + 0x04, // p.atk +3
    JP_AGGRESSOR_EFFECT      = JPCATEGORY_WAR + 0x05, // p.acc +1
    JP_RETALIATION_EFFECT    = JPCATEGORY_WAR + 0x06, // retaliation chance +1
    JP_RESTRAINT_EFFECT      = JPCATEGORY_WAR + 0x07, // time to max ws bonus -2%
    JP_BLOOD_RAGE_EFFECT     = JPCATEGORY_WAR + 0x08, // crit. hit rate +1
    JP_DOUBLE_ATTACK_EFFECT  = JPCATEGORY_WAR + 0x09, // double attack p.atk +1

    // MNK
    JP_HUNDRED_FISTS_EFFECT   = JPCATEGORY_MNK + 0x00, // p.acc +2
    JP_INNER_STRENGTH_EFFECT  = JPCATEGORY_MNK + 0x02, // hp recovered +2%
    JP_DODGE_EFFECT           = JPCATEGORY_MNK + 0x01, // evasion +2
    JP_FOCUS_EFFECT           = JPCATEGORY_MNK + 0x03, // accuracy +1
    JP_CHAKRA_EFFECT          = JPCATEGORY_MNK + 0x04, // hp recovered from use +10
    JP_COUNTERSTANCE_EFFECT   = JPCATEGORY_MNK + 0x05, // DEX +2
    JP_FOOTWORK_EFFECT        = JPCATEGORY_MNK + 0x06, // kick attack dmg +1
    JP_PERFECT_COUNTER_EFFECT = JPCATEGORY_MNK + 0x07, // VIT bonus +1
    JP_IMPETUS_EFFECT         = JPCATEGORY_MNK + 0x08, // maximum p.atk +2
    JP_KICK_ATTACKS_EFFECT    = JPCATEGORY_MNK + 0x09, // kick attacks atk +2 acc +1

    // WHM
    JP_BENEDICTION_EFFECT     = JPCATEGORY_WHM + 0x00, // mp recovered +1%
    JP_ASYLUM_EFFECT          = JPCATEGORY_WHM + 0x02, // m.eva +4
    JP_DIVINE_SEAL_EFFECT     = JPCATEGORY_WHM + 0x01, // reduce emnity from use +3
    JP_WHM_MAGIC_ACC_BONUS    = JPCATEGORY_WHM + 0x03, // m.acc +1
    JP_AFFLATUS_SOLACE_EFFECT = JPCATEGORY_WHM + 0x04, // cure potency +2 (not %)
    JP_AFFLATUS_MISERY_EFFECT = JPCATEGORY_WHM + 0x05, // banish +2 m.dmg, miss => acc +1 dmg +1
    JP_DIVINE_CARESS_DURATION = JPCATEGORY_WHM + 0x06, // dur. +2 sec
    JP_SACROSANCTITY_EFFECT   = JPCATEGORY_WHM + 0x07, // minimum DEF +1
    JP_REGEN_DURATION         = JPCATEGORY_WHM + 0x08, // dur. +3 sec
    JP_BAR_SPELL_EFFECT       = JPCATEGORY_WHM + 0x09, // resistance +2

    // BLM
    JP_MANAFONT_EFFECT          = JPCATEGORY_BLM + 0x00, // elemental m.dmg +2
    JP_SUBTLE_SORCERY_EFFECT    = JPCATEGORY_BLM + 0x02, // spellcasting time -1%
    JP_ELEMENTAL_SEAL_EFFECT    = JPCATEGORY_BLM + 0x01, // elemental magic emnity -3
    JP_MAGIC_BURST_DMG_BONUS    = JPCATEGORY_BLM + 0x03, // magic burst dmg +1%
    JP_MANA_WALL_EFFECT         = JPCATEGORY_BLM + 0x04, // mp consumed -1%
    JP_BLM_MAGIC_ACC_BONUS      = JPCATEGORY_BLM + 0x05, // m.acc +1
    JP_EMNITY_DOUSE_RECAST      = JPCATEGORY_BLM + 0x06, // recast -3sec
    JP_MANAWELL_EFFECT          = JPCATEGORY_BLM + 0x07, // m.dmg +1
    JP_MAGIC_BURST_EMNITY_BONUS = JPCATEGORY_BLM + 0x08, // emnity -1
    JP_MAGIC_DMG_BONUS          = JPCATEGORY_BLM + 0x09, // m.dmg +1

    // RDM
    JP_CHAINSPELL_EFFECT   = JPCATEGORY_RDM + 0x00, // elem. m.dmg +2
    JP_STYMIE_EFFECT       = JPCATEGORY_RDM + 0x02, // effect dur. +1s
    JP_CONVERT_EFFECT      = JPCATEGORY_RDM + 0x01, // HP consumed -1%
    JP_RDM_MAGIC_ACC_BONUS = JPCATEGORY_RDM + 0x03, // m.acc +1
    JP_COMPOSURE_EFFECT    = JPCATEGORY_RDM + 0x04, // p.acc +1
    JP_RDM_MAGIC_ATK_BONUS = JPCATEGORY_RDM + 0x05, // MAB +1
    JP_SABOTEUR_EFFECT     = JPCATEGORY_RDM + 0x06, // enfeeble m.acc +2
    JP_ENFEEBLE_DURATION   = JPCATEGORY_RDM + 0x07, // enfeeble dur. +1s
    JP_QUICK_MAGIC_EFFECT  = JPCATEGORY_RDM + 0x08, // MP consumption -2%
    JP_ENHANCING_DURATION  = JPCATEGORY_RDM + 0x09, // dur. +1s

    // THF
    JP_PERFECT_DODGE_EFFECT = JPCATEGORY_THF + 0x00, // m.eva +3
    JP_LARCENY_EFFECT       = JPCATEGORY_THF + 0x02, // dur. +1s
    JP_SNEAK_ATTACK_EFFECT  = JPCATEGORY_THF + 0x01, // DEX bonus +1%
    JP_TRICK_ATTACK_EFFECT  = JPCATEGORY_THF + 0x03, // AGI bonus +1%
    JP_STEAL_RECAST         = JPCATEGORY_THF + 0x04, // recast -2s
    JP_MUG_EFFECT           = JPCATEGORY_THF + 0x05, // drain HP == 5% (DEX + AGI)
    JP_DESPOIL_EFFECT       = JPCATEGORY_THF + 0x06, // drain 2% tp
    JP_CONSPIRATOR_EFFECT   = JPCATEGORY_THF + 0x07, // p.acc +1
    JP_BULLY_EFFECT         = JPCATEGORY_THF + 0x08, // intimidation chance +1%
    JP_TRIPLE_ATTACK_EFFECT = JPCATEGORY_THF + 0x09, // p.atk +1

    // PLD
    JP_INVINCIBLE_EFFECT    = JPCATEGORY_PLD + 0x00, // emnity +100
    JP_INTERVENE_EFFECT     = JPCATEGORY_PLD + 0x02, // dmg +2%
    JP_HOLY_CIRCLE_EFFECT   = JPCATEGORY_PLD + 0x01, // dmg taken -1
    JP_SENTINEL_EFFECT      = JPCATEGORY_PLD + 0x03, // emnity +1
    JP_SHIELD_BASH_EFFECT   = JPCATEGORY_PLD + 0x04, // dmg +10
    JP_COVER_DURATION       = JPCATEGORY_PLD + 0x05, // dur. +1s
    JP_DIVINE_EMBLEM_EFFECT = JPCATEGORY_PLD + 0x06, // m.dmg +2
    JP_SEPULCHER_DURATION   = JPCATEGORY_PLD + 0x07, // dur. +1s
    JP_PALISADE_EFFECT      = JPCATEGORY_PLD + 0x08, // block chance +1%
    JP_ENLIGHT_EFFECT       = JPCATEGORY_PLD + 0x09, // ae.dmg +1 p.acc +1

    // DRK
    JP_BLOOD_WEAPON_EFFECT       = JPCATEGORY_DRK + 0x00, // hp absorb +2%
    JP_SOUL_ENSLAVEMENT_EFFECT   = JPCATEGORY_DRK + 0x02, // tp absorb +1%
    JP_ARCANE_CIRCLE_EFFECT      = JPCATEGORY_DRK + 0x01, // dmg taken -1
    JP_LAST_RESORT_EFFECT        = JPCATEGORY_DRK + 0x03, // p.atk +2
    JP_SOULEATER_DURATION        = JPCATEGORY_DRK + 0x04, // dur. +1s
    JP_WEAPON_BASH_EFFECT        = JPCATEGORY_DRK + 0x05, // dmg +10
    JP_NETHER_VOID_EFFECT        = JPCATEGORY_DRK + 0x06, // absorb +2% abs-attri status +1/10
    JP_ARCANE_CREST_DURATION     = JPCATEGORY_DRK + 0x07, // dur. +1s
    JP_SCARLET_DELIRIUM_DURATION = JPCATEGORY_DRK + 0x08, // dur. +1s
    JP_ENDARK_EFFECT             = JPCATEGORY_DRK + 0x09, // p.dmg p.atk p.acc +1

    // BST
    JP_FAMILIAR_EFFECT    = JPCATEGORY_BST + 0x00, // all pet attr. +3
    JP_UNLEASH_EFFECT     = JPCATEGORY_BST + 0x02, // sp.atk dmg +2%
    JP_PET_ACC_BONUS      = JPCATEGORY_BST + 0x01, // pet p.acc +1
    JP_CHARM_SUCCESS_RATE = JPCATEGORY_BST + 0x03, // success rate +1%
    JP_REWARD_EFFECT      = JPCATEGORY_BST + 0x04, // pet hp recov. +1%
    JP_PET_ATK_SPD_BONUS  = JPCATEGORY_BST + 0x05, // pet atk spd +1%
    JP_READY_EFFECT       = JPCATEGORY_BST + 0x06, // pet sp.ability dmg +1%
    JP_SPUR_EFFECT        = JPCATEGORY_BST + 0x07, // pet p.atk +3
    JP_RUN_WILD_DURATION  = JPCATEGORY_BST + 0x08, // dur. +2s
    JP_PET_EMNITY_BONUS   = JPCATEGORY_BST + 0x09, // emnity +1

    // BRD
    JP_SOUL_VOICE_EFFECT   = JPCATEGORY_BRD + 0x00, // casting time -2%
    JP_CLARION_CALL_EFFECT = JPCATEGORY_BRD + 0x02, // effect dur. +2s
    JP_MINNE_EFFECT        = JPCATEGORY_BRD + 0x01, // p.def +1
    JP_MINUET_EFFECT       = JPCATEGORY_BRD + 0x03, // p.atk +1
    JP_PIANISSIMO_EFFECT   = JPCATEGORY_BRD + 0x04, // casting time -2%
    JP_SONG_ACC_BONUS      = JPCATEGORY_BRD + 0x05, // song acc +1
    JP_TENUTO_EFFECT       = JPCATEGORY_BRD + 0x06, // song dur. +1s
    JP_LULLABY_DURATION    = JPCATEGORY_BRD + 0x07, // lullaby dur. +1
    JP_MARCATO_EFFECT      = JPCATEGORY_BRD + 0x08, // song dur. +1s
    JP_REQUIEM_EFFECT      = JPCATEGORY_BRD + 0x09, // dot dmg +3

    // RNG
    JP_EAGLE_EYE_SHOT_EFFECT = JPCATEGORY_RNG + 0x00, // dmg +3%
    JP_OVERKILL_EFFECT       = JPCATEGORY_RNG + 0x02, // emnity -1
    JP_SHARPSHOT_EFFECT      = JPCATEGORY_RNG + 0x01, // r.atk +2
    JP_CAMOUFLAGE_EFFECT     = JPCATEGORY_RNG + 0x03, // crit. hit rate +1%
    JP_BARRAGE_EFFECT        = JPCATEGORY_RNG + 0x04, // r.atk +3
    JP_SHADOWBIND_DURATION   = JPCATEGORY_RNG + 0x05, // dur. +1s
    JP_VELOCITY_SHOT_EFFECT  = JPCATEGORY_RNG + 0x06, // r.atk +2
    JP_DOUBLE_SHOT_EFFECT    = JPCATEGORY_RNG + 0x07, // chance +1%
    JP_DECOY_SHOT_EFFECT     = JPCATEGORY_RNG + 0x08, // max emnity vol. +15, cum. +5
    JP_UNLIMITED_SHOT_EFFECT = JPCATEGORY_RNG + 0x09, // emnity -2

    // SAM
    JP_MEIKYO_SHISUI_EFFECT  = JPCATEGORY_SAM + 0x00, // sc dmg +2%
    JP_YAEGASUMI_EFFECT      = JPCATEGORY_SAM + 0x02, // tp bonus +30
    JP_WARDING_CIRCLE_EFFECT = JPCATEGORY_SAM + 0x01, // dmg taken -1
    JP_HASSO_EFFECT          = JPCATEGORY_SAM + 0x03, // STR +1
    JP_MEDITATE_EFFECT       = JPCATEGORY_SAM + 0x04, // tp +5 per tick
    JP_SEIGAN_EFFECT         = JPCATEGORY_SAM + 0x05, // p.def +3
    JP_KONZEN_ITTAI_EFFECT   = JPCATEGORY_SAM + 0x06, // sc dmg +1%
    JP_HAMANOHA_DURATION     = JPCATEGORY_SAM + 0x07, // dur. +1s
    JP_HAGAKURE_EFFECT       = JPCATEGORY_SAM + 0x08, // tp bonus +10
    JP_ZANSHIN_EFFECT        = JPCATEGORY_SAM + 0x09, // zanshin follow-ups p.atk +2

    // NIN
    JP_MIJIN_GAUKURE_EFFECT     = JPCATEGORY_NIN + 0x00, // dmg +3%
    JP_MIKAGE_EFFECT            = JPCATEGORY_NIN + 0x02, // p.atk +3
    JP_YONIN_EFFECT             = JPCATEGORY_NIN + 0x01, // p.eva +2
    JP_INNIN_EFFECT             = JPCATEGORY_NIN + 0x03, // p.acc +1
    JP_NINJITSU_ACC_BONUS       = JPCATEGORY_NIN + 0x04, // ninjitsu acc +1
    JP_NINJITSU_CAST_TIME_BONUS = JPCATEGORY_NIN + 0x05, // casting time -1%
    JP_FUTAE_EFFECT             = JPCATEGORY_NIN + 0x06, // m.dmg +5
    JP_ELEM_NINJITSU_EFFECT     = JPCATEGORY_NIN + 0x07, // m.dmg +2
    JP_ISSEKIGAN_EFFECT         = JPCATEGORY_NIN + 0x08, // vol. emnity +10
    JP_TACTICAL_PARRY_EFFECT    = JPCATEGORY_NIN + 0x09, // counter when parry +1%

    // DRG
    JP_SPIRIT_SURGE_EFFECT     = JPCATEGORY_DRG + 0x00, // Weapon DMG +1
    JP_FLY_HIGH_EFFECT         = JPCATEGORY_DRG + 0x02, // all jump p.atk +5
    JP_ANCIENT_CIRCLE_EFFECT   = JPCATEGORY_DRG + 0x01, // dmg taken -1
    JP_JUMP_EFFECT             = JPCATEGORY_DRG + 0x03, // jump/spirit jump p.atk +3
    JP_SPIRIT_LINK_EFFECT      = JPCATEGORY_DRG + 0x04, // hp consumption -1%
    JP_WYVERN_MAX_HP_BONUS     = JPCATEGORY_DRG + 0x05, // wyvern max hp +10
    JP_DRAGON_BREAKER_DURATION = JPCATEGORY_DRG + 0x06, // dur. +1s
    JP_WYVERN_BREATH_EFFECT    = JPCATEGORY_DRG + 0x07, // breath effect +10
    JP_HIGH_JUMP_EFFECT        = JPCATEGORY_DRG + 0x08, // high jump/soul jump atk +3
    JP_WYVERN_ATTR_BONUS       = JPCATEGORY_DRG + 0x09, // wyvern p.atk/p.def +2

    // SMN
    JP_ASTRAL_FLOW_EFFECT      = JPCATEGORY_SMN + 0x00, // all pet attr. +5
    JP_ASTRAL_CONDUIT_EFFECT   = JPCATEGORY_SMN + 0x02, // BPR: dmg +1% BPW: duration +1%
    JP_SUMMON_ACC_BONUS        = JPCATEGORY_SMN + 0x01, // pet p.acc +1
    JP_SUMMON_MAGIC_ACC_BONUS  = JPCATEGORY_SMN + 0x03, // pet m.acc +1
    JP_ELEMENTAL_SIPHON_EFFECT = JPCATEGORY_SMN + 0x04, // mp recov. +3
    JP_SUMMON_PHYS_ATK_BONUS   = JPCATEGORY_SMN + 0x05, // pet p.atk +2
    JP_MANA_CEDE_EFFECT        = JPCATEGORY_SMN + 0x06, // pet tp +50
    JP_AVATARS_FAVOR_EFFECT    = JPCATEGORY_SMN + 0x07, // favor +3s dur. bonus
    JP_SUMMON_MAGIC_DMG_BONUS  = JPCATEGORY_SMN + 0x08, // pet m.dmg +5
    JP_BLOOD_PACT_DMG_BONUS    = JPCATEGORY_SMN + 0x09, // BPR/BPW dmg +5

    // BLU
    JP_AZURE_LORE_EFFECT       = JPCATEGORY_BLU + 0x00, // dmg +1
    JP_UNBRIDLED_WISDOM_EFFECT = JPCATEGORY_BLU + 0x02, // conserve mp +3
    JP_BLUE_MAGIC_POINT_BONUS  = JPCATEGORY_BLU + 0x01, // blue magic points +1
    JP_BURST_AFFINITY_BONUS    = JPCATEGORY_BLU + 0x03, // dmg +2
    JP_CHAIN_AFFINITY_EFFECT   = JPCATEGORY_BLU + 0x04, // sc dmg +1%
    JP_BLUE_PHYS_AE_ACC_BONUS  = JPCATEGORY_BLU + 0x05, // phys. add. effect acc +1
    JP_UNBRIDLED_LRN_EFFECT    = JPCATEGORY_BLU + 0x06, // dmg +1%
    JP_UNBRIDLED_LRN_EFFECT_II = JPCATEGORY_BLU + 0x07, // party enhancing dur. +1%
    JP_EFFLUX_EFFECT           = JPCATEGORY_BLU + 0x08, // tp bonus +10
    JP_BLU_MAGIC_ACC_BONUS     = JPCATEGORY_BLU + 0x09, // m.acc +1

    // COR
    JP_WILD_CARD_EFFECT      = JPCATEGORY_COR + 0x00, // probability of reset +1%
    JP_CUTTING_CARDS_EFFECT  = JPCATEGORY_COR + 0x02, // recast of party abil. -1%
    JP_PHANTOM_ROLL_DURATION = JPCATEGORY_COR + 0x01, // dur. +2s
    JP_BUST_EVASION          = JPCATEGORY_COR + 0x03, // bust chance -1%
    JP_QUICK_DRAW_EFFECT     = JPCATEGORY_COR + 0x04, // m.dmg +2
    JP_AMMO_CONSUMPTION      = JPCATEGORY_COR + 0x05, // no ammo chance +1%
    JP_RANDOM_DEAL_EFFECT    = JPCATEGORY_COR + 0x06, // 2 abil random deal +2%
    JP_COR_RANGED_ACC_BONUS  = JPCATEGORY_COR + 0x07, // r.acc +1
    JP_TRIPLE_SHOT_EFFECT    = JPCATEGORY_COR + 0x08, // triple shot chance +1%
    JP_OPTIMAL_RANGE_BONUS   = JPCATEGORY_COR + 0x09, // sweet spot dmg +1

    // PUP
    JP_OVERDRIVE_EFFECT        = JPCATEGORY_PUP + 0x00, // all pet attr. +5
    JP_HEADY_ARTIFICE_EFFECT   = JPCATEGORY_PUP + 0x02, // increase head effects (see wiki)
    JP_AUTOMATON_HP_MP_BONUS   = JPCATEGORY_PUP + 0x01, // pet hp+10, mp+5
    JP_ACTIVATE_EFFECT         = JPCATEGORY_PUP + 0x03, // burden -1
    JP_REPAIR_EFFECT           = JPCATEGORY_PUP + 0x04, // mp hot based on oil (see wiki)
    JP_DEUS_EX_AUTOMATA_RECAST = JPCATEGORY_PUP + 0x05, // recast -1s
    JP_TACTICAL_SWITCH_BONUS   = JPCATEGORY_PUP + 0x06, // tp +20
    JP_COOLDOWN_EFFECT         = JPCATEGORY_PUP + 0x07, // burden -1
    JP_DEACTIVATE_EFFECT       = JPCATEGORY_PUP + 0x08, // hp require. -1%
    JP_PUP_MARTIAL_ARTS_EFFECT = JPCATEGORY_PUP + 0x09, // delay -2

    // DNC
    JP_TRANCE_EFFECT       = JPCATEGORY_DNC + 0x00, // tp +100
    JP_GRAND_PAS_EFFECT    = JPCATEGORY_DNC + 0x02, // dmg +1
    JP_STEP_DURATION       = JPCATEGORY_DNC + 0x01, // dur. +1s
    JP_SAMBA_DURATION      = JPCATEGORY_DNC + 0x03, // dur. +2s
    JP_WALTZ_POTENCY_BONUS = JPCATEGORY_DNC + 0x04, // waltz potency +2 (not %)
    JP_JIG_DURATION        = JPCATEGORY_DNC + 0x05, // dur. +1s
    JP_FLOURISH_I_EFFECT   = JPCATEGORY_DNC + 0x06, // effect bonuses (see wiki)
    JP_FLOURISH_II_EFFECT  = JPCATEGORY_DNC + 0x07, // effect bonuses (see wiki)
    JP_FLOURISH_III_EFFECT = JPCATEGORY_DNC + 0x08, // CHR bonus +1%
    JP_CONTRADANCE_EFFECT  = JPCATEGORY_DNC + 0x09, // waltz tp -3%

    // SCH
    JP_TABULA_RASA_EFFECT       = JPCATEGORY_SCH + 0x00, // mp recov. +2%
    JP_CAPER_EMMISSARIUS_EFFECT = JPCATEGORY_SCH + 0x02, // hp recov. +2%
    JP_LIGHT_ARTS_EFFECT        = JPCATEGORY_SCH + 0x01, // dur. +3s
    JP_DARK_ARTS_EFFECT         = JPCATEGORY_SCH + 0x03, // dur. +3s
    JP_STRATEGEM_EFFECT_I       = JPCATEGORY_SCH + 0x04, // m.acc +1
    JP_STRATEGEM_EFFECT_II      = JPCATEGORY_SCH + 0x05, // cast time -1%
    JP_STRATEGEM_EFFECT_III     = JPCATEGORY_SCH + 0x06, // m.dmg +2
    JP_STRATEGEM_EFFECT_IV      = JPCATEGORY_SCH + 0x07, // recast -2%
    JP_MODUS_VERITAS_EFFECT     = JPCATEGORY_SCH + 0x08, // dot +3
    JP_SUBLIMATION_EFFECT       = JPCATEGORY_SCH + 0x09, // sublimation mp +3%

    // GEO
    JP_BOLSTER_EFFECT          = JPCATEGORY_GEO + 0x00, // luopan hp +3% perp. -1mp
    JP_WIDENED_COMPASS_EFFECT  = JPCATEGORY_GEO + 0x02, // cast time -3%
    JP_LIFE_CYCLE_EFFECT       = JPCATEGORY_GEO + 0x01, // luopan hp recov. +1%
    JP_BLAZE_OF_GLORY_EFFECT   = JPCATEGORY_GEO + 0x03, // luopan init. hp +1%
    JP_GEO_MAGIC_ATK_BONUS     = JPCATEGORY_GEO + 0x04, // m.att bonus +1
    JP_GEO_MAGIC_ACC_BONUS     = JPCATEGORY_GEO + 0x05, // m.acc +1
    JP_DEMATERIALIZE_DURATION  = JPCATEGORY_GEO + 0x06, // dur. +1s
    JP_THEURGIC_FOCUS_EFFECT   = JPCATEGORY_GEO + 0x07, // m.dmg +3
    JP_CONCENTRIC_PULSE_EFFECT = JPCATEGORY_GEO + 0x08, // dmg +1%
    JP_INDI_SPELL_DURATION     = JPCATEGORY_GEO + 0x09, // indi dur. +2s

    // RUN
    JP_ELEMENTAL_SFORZO_EFFECT = JPCATEGORY_RUN + 0x00, // dmg absorb +2%
    JP_ODYLLIC_SUBTER_EFFECT   = JPCATEGORY_RUN + 0x02, // enemy m.att bonus -2
    JP_RUNE_ENCHANTMENT_EFFECT = JPCATEGORY_RUN + 0x01, // rune resist +1
    JP_VALLATION_DURATION      = JPCATEGORY_RUN + 0x03, // dur. +1s
    JP_SWORDPLAY_EFFECT        = JPCATEGORY_RUN + 0x04, // max p.acc/p.eva +2
    JP_SWIPE_EFFECT            = JPCATEGORY_RUN + 0x05, // swipe/lunge dmg (skill) +1%
    JP_EMBOLDEN_EFFECT         = JPCATEGORY_RUN + 0x06, // enhanc. mag effect +1
    JP_VIVACIOUS_PULSE_EFFECT  = JPCATEGORY_RUN + 0x07, // viv. pulse => hp +1%
    JP_ONE_FOR_ALL_DURATION    = JPCATEGORY_RUN + 0x08, // dur. +1s
    JP_GAMBIT_DURATION         = JPCATEGORY_RUN + 0x09, // dur +1s
};

#define JOBPOINTS_CATEGORY_COUNT      22
#define JOBPOINTS_CATEGORY_START      0x020
#define JOBPOINTS_JPTYPE_COUNT        220
#define JOBPOINTS_JPTYPE_PER_CATEGORY 10
#define JOBPOINTS_MAX                 500
#define JOBPOINTS_CAPACITY_MAX        30000
#define JOBPOINTS_SQL_COLUMN_OFFSET   5

#define JobPointsCategoryByJobId(jobid)         (JOBPOINTS_CATEGORY_START * jobid)
#define JobPointsCategoryIndexByJpType(jp_type) (jp_type >> 5)
#define JobPointTypeIndex(id)                   (id & 0x1F)
#define JobPointCost(value)                     ((value + 1) % 21)
#define JobPointValueFormat(value)              (value << 2)

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

struct JobPointType_t
{
    uint16 id;
    uint8  value;
};

struct JobPoints_t
{
    uint16         jobId;
    uint16         jobCategory;
    uint16         capacityPoints;
    uint16         currentJp;
    uint16         totalJpSpent;
    JobPointType_t job_point_types[JOBPOINTS_JPTYPE_PER_CATEGORY]{};
};

struct JobPointGifts_t
{
    uint16 jpRequired;
    uint16 modId;
    int16  value;
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
class CCharEntity;

class CJobPoints
{
public:
    CJobPoints(CCharEntity* PChar);
    bool   IsJobPointExist(JOBPOINT_TYPE jpType); // Check to see if JP exists
    void   RaiseJobPoint(JOBPOINT_TYPE jpType);   // Add upgrade
    uint16 GetJobPoints();                        // Get unspent job points for current job
    uint16 GetJobPointsByJob(uint8 jobID);        // get current job points for a players specified job
    void   SetJobPoints(int16 amount);            // Set job points for current job

    void AddJobPoints(uint8 jobID, uint16 amount); // Add jobpoints to a players specififed job
    void DelJobPoints(uint8 jobID, int16 amount);  // Del jobpoints to a players specified job

    JobPoints_t*    GetJobPointsByType(JOBPOINT_TYPE jpType);
    JobPointType_t* GetJobPointType(JOBPOINT_TYPE jpType);

    void LoadJobPoints(); // load JPs for char from db

    JobPoints_t* GetAllJobPoints();

    uint16 GetJobPointsSpent();

    bool   AddCapacityPoints(uint16 amount); // Add Capacity Points for current job, and increase JP as needed
    uint32 GetCapacityPoints();              // Get Capacity Points for Character's Current Job
    void   SetCapacityPoints(uint16 amount); // Set Capacity Points for Character's Current Job, does not handle JP increase!

    // Returns the level of a given job point type. Will return 0 if the type doesn't match the
    // player's main job or if their main job is not 99
    uint8 GetJobPointValue(JOBPOINT_TYPE jpType);

    std::vector<CModifier> current_gifts;

private:
    CCharEntity* m_PChar;
    JobPoints_t  m_jobPoints[MAX_JOBTYPE]{};
};

namespace jobpointutils
{
    void                                LoadGifts();
    void                                RefreshGiftMods(CCharEntity* PChar);
    extern std::vector<JobPointGifts_t> jpGifts[MAX_JOBTYPE];
} // namespace jobpointutils

#endif
