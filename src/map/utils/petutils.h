/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#pragma once

#include "common/cbasetypes.h"
#include "common/mmo.h"

enum PETID
{
    PETID_FIRESPIRIT             = 0,
    PETID_ICESPIRIT              = 1,
    PETID_AIRSPIRIT              = 2,
    PETID_EARTHSPIRIT            = 3,
    PETID_THUNDERSPIRIT          = 4,
    PETID_WATERSPIRIT            = 5,
    PETID_LIGHTSPIRIT            = 6,
    PETID_DARKSPIRIT             = 7,
    PETID_CARBUNCLE              = 8,
    PETID_FENRIR                 = 9,
    PETID_IFRIT                  = 10,
    PETID_TITAN                  = 11,
    PETID_LEVIATHAN              = 12,
    PETID_GARUDA                 = 13,
    PETID_SHIVA                  = 14,
    PETID_RAMUH                  = 15,
    PETID_DIABOLOS               = 16,
    PETID_ALEXANDER              = 17,
    PETID_ODIN                   = 18,
    PETID_ATOMOS                 = 19,
    PETID_CAIT_SITH              = 20,
    PETID_SHEEP_FAMILIAR         = 21,
    PETID_HARE_FAMILIAR          = 22,
    PETID_CRAB_FAMILIAR          = 23,
    PETID_COURIER_CARRIE         = 24,
    PETID_HOMUNCULUS             = 25,
    PETID_FLYTRAP_FAMILIAR       = 26,
    PETID_TIGER_FAMILIAR         = 27,
    PETID_FLOWERPOT_BILL         = 28,
    PETID_EFT_FAMILIAR           = 29,
    PETID_LIZARD_FAMILIAR        = 30,
    PETID_MAYFLY_FAMILIAR        = 31,
    PETID_FUNGUAR_FAMILIAR       = 32,
    PETID_BEETLE_FAMILIAR        = 33,
    PETID_ANTLION_FAMILIAR       = 34,
    PETID_MITE_FAMILIAR          = 35,
    PETID_LULLABY_MELODIA        = 36,
    PETID_KEENEARED_STEFFI       = 37,
    PETID_FLOWERPOT_BEN          = 38,
    PETID_SABER_SIRAVARDE        = 39,
    PETID_COLDBLOOD_COMO         = 40,
    PETID_SHELLBUSTER_OROB       = 41,
    PETID_VORACIOUS_AUDREY       = 42,
    PETID_AMBUSHER_ALLIE         = 43,
    PETID_LIFEDRINKER_LARS       = 44,
    PETID_PANZER_GALAHAD         = 45,
    PETID_CHOPSUEY_CHUCKY        = 46,
    PETID_AMIGO_SABOTENDER       = 47,
    PETID_WYVERN                 = 48,
    PETID_CRAFTY_CLYVONNE        = 49,
    PETID_BLOODCLAW_SHASRA       = 50,
    PETID_LUCKY_LULUSH           = 51,
    PETID_FATSO_FARGANN          = 52,
    PETID_DISCREET_LOUISE        = 53,
    PETID_SWIFT_SIEGHARD         = 54,
    PETID_DIPPER_YULY            = 55,
    PETID_FLOWERPOT_MERLE        = 56,
    PETID_NURSERY_NAZUNA         = 57,
    PETID_MAILBUSTER_CETAS       = 58,
    PETID_AUDACIOUS_ANNA         = 59,
    PETID_PRESTO_JULIO           = 60,
    PETID_BUGEYED_BRONCHA        = 61,
    PETID_GOOEY_GERARD           = 62,
    PETID_GOREFANG_HOBS          = 63,
    PETID_FAITHFUL_FALCOR        = 64,
    PETID_CRUDE_RAPHIE           = 65,
    PETID_DAPPER_MAC             = 66,
    PETID_SLIPPERY_SILAS         = 67,
    PETID_TURBID_TOLOI           = 68,
    PETID_HARLEQUINFRAME         = 69,
    PETID_VALOREDGEFRAME         = 70,
    PETID_SHARPSHOTFRAME         = 71,
    PETID_STORMWAKERFRAME        = 72,
    PETID_ADVENTURING_FELLOW     = 73,
    PETID_CHOCOBO                = 74,
    PETID_LUOPAN                 = 75,
    PETID_SIREN                  = 76,
    PETID_SWEET_CAROLINE         = 77,
    PETID_AMIABLE_ROCHE          = 78,
    PETID_HEADBREAKER_KEN        = 79,
    PETID_ANKLEBITER_JEDD        = 80,
    PETID_CURSED_ANNABELLE       = 81,
    PETID_BRAINY_WALUIS          = 82,
    PETID_SLIME_FAMILIAR         = 83,
    PETID_SULTRY_PATRICE         = 84,
    PETID_GENEROUS_ARTHUR        = 85,
    PETID_REDOLENT_CANDI         = 86,
    PETID_ALLURING_HONEY         = 87,
    PETID_LYNX_FAMILIAR          = 88,
    PETID_VIVACIOUS_GASTON       = 89,
    PETID_CARING_KIYOMARU        = 90,
    PETID_VIVACIOUS_VICKIE       = 91,
    PETID_SUSPICIOUS_ALICE       = 92,
    PETID_SURGING_STORM          = 93,
    PETID_SUBMERGED_IYO          = 94,
    PETID_WARLIKE_PATRICK        = 95,
    PETID_RHYMING_SHIZUNA        = 96,
    PETID_BLACKBEARD_RANDY       = 97,
    PETID_THREESTAR_LYNN         = 98,
    PETID_HURLER_PERCIVAL        = 99,
    PETID_ACUEX_FAMILIAR         = 100,
    PETID_FLUFFY_BREDO           = 101,
    PETID_WEEVIL_FAMILIAR        = 102,
    PETID_STALWART_ANGELINA      = 103,
    PETID_FLEET_REINHARD         = 104,
    PETID_SHARPWIT_HERMES        = 105,
    PETID_PORTER_CRAB_FAMILIAR   = 106,
    PETID_JOVIAL_EDWIN           = 107,
    PETID_ATTENTIVE_IBUKI        = 108,
    PETID_SWOOPING_ZHIVAGO       = 109,
    PETID_SUNBURST_MALFIK        = 110,
    PETID_AGED_ANGUS             = 111,
    PETID_SCISSORLEG_XERIN       = 112,
    PETID_BOUNCING_BERTHA        = 113,
    PETID_SPIDER_FAMILIAR        = 114,
    PETID_GUSSY_HACHIROBE        = 115,
    PETID_COLIBRI_FAMILIAR       = 116,
    PETID_CHORAL_LEERA           = 117,
    PETID_DROOPY_DORTWIN         = 118,
    PETID_PONDERING_PETER        = 119,
    PETID_HERALD_HENRY           = 120,
    PETID_HIPPOGRYPH_FAMILIAR    = 121,
    PETID_DARING_ROLAND          = 122,
    PETID_MOSQUITO_FAMILIAR      = 123,
    PETID_LEFT_HANDED_YOKO       = 124,
    PETID_BRAVE_HERO_GLENN       = 125,
    PETID_YELLOW_BEETLE_FAMILIAR = 126,
    PETID_ENERGIZED_SEFINA       = 127,

    MAX_PETID = 128,
};

struct Pet_t
{
    uint16      PetID; // ID in pet_list.sql
    look_t      look;
    std::string name;
    ECOSYSTEM   EcoSystem;

    uint8 minLevel;
    uint8 maxLevel;

    uint8           name_prefix;
    uint8           modelSize{ 0 };
    float           modelHitboxSize{ 0.0f };
    uint16          m_Family;
    timer::duration time; // Duration of pet's "life span" before despawning

    uint8 mJob;
    uint8 sJob;
    uint8 m_Element;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint16      cmbDelay;
    DAMAGE_TYPE m_dmgType;
    uint8       speed;
    // stat ranks
    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 evaRank;
    uint8 accRank;

    uint16 m_MobSkillList;

    // magic stuff
    bool   hasSpellScript;
    uint16 spellList;

    // resists
    int16 slash_sdt;
    int16 pierce_sdt;
    int16 hth_sdt;
    int16 impact_sdt;

    int16 magical_sdt;

    int16 fire_sdt;
    int16 ice_sdt;
    int16 wind_sdt;
    int16 earth_sdt;
    int16 thunder_sdt;
    int16 water_sdt;
    int16 light_sdt;
    int16 dark_sdt;

    int8 fire_res_rank;
    int8 ice_res_rank;
    int8 wind_res_rank;
    int8 earth_res_rank;
    int8 thunder_res_rank;
    int8 water_res_rank;
    int8 light_res_rank;
    int8 dark_res_rank;

    int8 paralyze_res_rank;
    int8 bind_res_rank;
    int8 silence_res_rank;
    int8 slow_res_rank;
    int8 poison_res_rank;
    int8 light_sleep_res_rank;
    int8 dark_sleep_res_rank;
    int8 blind_res_rank;

    Pet_t()
    : PetID(0)
    , EcoSystem(ECOSYSTEM::ECO_ERROR)
    , minLevel(-1)
    , maxLevel(99)
    , name_prefix(0)
    , m_Family(0)
    , time(0s)
    , mJob(0)
    , sJob(0)
    , m_Element(0)
    , HPscale(0.f)
    , MPscale(0.f)
    , cmbDelay(0)
    , m_dmgType(DAMAGE_TYPE::NONE)
    , speed(0)
    , strRank(0)
    , dexRank(0)
    , vitRank(0)
    , agiRank(0)
    , intRank(0)
    , mndRank(0)
    , chrRank(0)
    , attRank(0)
    , defRank(0)
    , evaRank(0)
    , accRank(0)
    , m_MobSkillList(0)
    , hasSpellScript(false)
    , spellList(0)
    , slash_sdt(0)
    , pierce_sdt(0)
    , hth_sdt(0)
    , impact_sdt(0)
    , magical_sdt(0)
    , fire_sdt(0)
    , ice_sdt(0)
    , wind_sdt(0)
    , earth_sdt(0)
    , thunder_sdt(0)
    , water_sdt(0)
    , light_sdt(0)
    , dark_sdt(0)
    , fire_res_rank(0)
    , ice_res_rank(0)
    , wind_res_rank(0)
    , earth_res_rank(0)
    , thunder_res_rank(0)
    , water_res_rank(0)
    , light_res_rank(0)
    , dark_res_rank(0)
    , paralyze_res_rank(0)
    , bind_res_rank(0)
    , silence_res_rank(0)
    , slow_res_rank(0)
    , poison_res_rank(0)
    , light_sleep_res_rank(0)
    , dark_sleep_res_rank(0)
    , blind_res_rank(0)
    {
    }
};

class CBattleEntity;
class CPetEntity;

namespace petutils
{

void LoadPetList();
void FreePetList();

void   SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
void   SpawnMobPet(CBattleEntity* PMaster, uint32 PetID);
void   DetachPet(CBattleEntity* PMaster);
void   DespawnPet(CBattleEntity* PMaster);
void   AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget);
uint16 GetJugWeaponDamage(CPetEntity* PPet);
void   RetreatToMaster(CBattleEntity* PMaster);
int16  PerpetuationCost(uint32 id, uint8 level);
void   ExtendCharm(CBattleEntity* PPet, uint16 minSeconds, uint16 maxSeconds);
void   LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);

void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet);
void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet);
void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet);
void CalculateAutomatonStats(CBattleEntity* PMaster, CBattleEntity* PPet);
void CalculateLuopanStats(CBattleEntity* PMaster, CPetEntity* PPet);
void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet);

void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet);

bool CheckPetModType(CBattleEntity* PPet, PetModType petmod);
bool IsTandemActive(CBattleEntity* PAttacker);

Pet_t* GetPetInfo(uint32 PetID);

}; // namespace petutils
