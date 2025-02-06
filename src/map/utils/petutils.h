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

#ifndef _IPETUTILS_H
#define _IPETUTILS_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

enum PETID
{
    PETID_FIRESPIRIT         = 0,
    PETID_ICESPIRIT          = 1,
    PETID_AIRSPIRIT          = 2,
    PETID_EARTHSPIRIT        = 3,
    PETID_THUNDERSPIRIT      = 4,
    PETID_WATERSPIRIT        = 5,
    PETID_LIGHTSPIRIT        = 6,
    PETID_DARKSPIRIT         = 7,
    PETID_CARBUNCLE          = 8,
    PETID_FENRIR             = 9,
    PETID_IFRIT              = 10,
    PETID_TITAN              = 11,
    PETID_LEVIATHAN          = 12,
    PETID_GARUDA             = 13,
    PETID_SHIVA              = 14,
    PETID_RAMUH              = 15,
    PETID_DIABOLOS           = 16,
    PETID_ALEXANDER          = 17,
    PETID_ODIN               = 18,
    PETID_ATOMOS             = 19,
    PETID_CAIT_SITH          = 20,
    PETID_WYVERN             = 48,
    PETID_HARLEQUINFRAME     = 69,
    PETID_VALOREDGEFRAME     = 70,
    PETID_SHARPSHOTFRAME     = 71,
    PETID_STORMWAKERFRAME    = 72,
    PETID_ADVENTURING_FELLOW = 73,
    PETID_CHOCOBO            = 74,
    PETID_LUOPAN             = 75,
    PETID_SIREN              = 76,
    MAX_PETID                = 77,
};

struct Pet_t
{
    uint16      PetID; // ID in pet_list.sql
    look_t      look;
    std::string name;
    ECOSYSTEM   EcoSystem;

    uint8 minLevel;
    uint8 maxLevel;

    uint8  name_prefix;
    uint8  radius; // Model Radius - affects melee range etc.
    uint16 m_Family;
    uint32 time; // Duration of pet's "life span" before despawning

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

    Pet_t()
    : PetID(0)
    , EcoSystem(ECOSYSTEM::ECO_ERROR)
    , minLevel(-1)
    , maxLevel(99)
    , name_prefix(0)
    , radius(0)
    , m_Family(0)
    , time(0)
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
    {
    }
};

class CBattleEntity;
class CPetEntity;

namespace petutils
{
    void LoadPetList();
    void FreePetList();

    void  SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
    void  SpawnMobPet(CBattleEntity* PMaster, uint32 PetID);
    void  DetachPet(CBattleEntity* PMaster);
    void  DespawnPet(CBattleEntity* PMaster);
    void  AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget);
    void  RetreatToMaster(CBattleEntity* PMaster);
    int16 PerpetuationCost(uint32 id, uint8 level);
    void  Familiar(CBattleEntity* PPet);
    void  LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);

    void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateAutomatonStats(CBattleEntity* PMaster, CBattleEntity* PPet);
    void CalculateLuopanStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet);

    void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet);

    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod);

    Pet_t* GetPetInfo(uint32 PetID);
}; // namespace petutils

#endif
