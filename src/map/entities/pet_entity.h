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

#include "mob_entity.h"

class CPetSkillState;

enum class PET_TYPE : uint8
{
    AVATAR             = 0,
    WYVERN             = 1,
    JUG_PET            = 2,
    CHARMED_MOB        = 3,
    AUTOMATON          = 4,
    ADVENTURING_FELLOW = 5,
    CHOCOBO            = 6,
    LUOPAN             = 7,
};

enum class WYVERN_TYPE : uint8
{
    NONE         = 0,
    DEFENSIVE    = 1,
    MULTIPURPOSE = 2,
    OFFENSIVE    = 3
};

class CPetEntity : public CMobEntity
{
public:
    CPetEntity(PET_TYPE petType, uint32 petID);
    ~CPetEntity() override;

    auto petID() const -> uint32;
    auto getPetType() const -> PET_TYPE;
    auto getSpawnLevel() const -> uint8;
    void setSpawnLevel(uint8 level);
    auto getJugSpawnTime() -> timer::time_point;  // initial spawn time of this pet if it's a jug pet
    auto getJugDuration() -> timer::duration;     // duration of this jug pet in seconds
    void setJugDuration(timer::duration seconds); // sets the duration of this jug pet in seconds
    auto isBstPet() const -> bool;
    auto GetScriptName() const -> std::string;
    auto getWyvernType() -> WYVERN_TYPE;

    auto shouldPersistThroughZone() -> bool; // if true, zoning should not cause a currently active pet to despawn
    void loadPetZoningInfo();                // loads info from previous zone (hp / mp / tp / spawn time). This MUST be called after Spawn()

    void OnPetSkillFinished(CPetSkillState& state, action_t& action);

    //
    // CMobEntity, CBattleEntity, etc.
    //

    void PostTick() override;
    void FadeOut() override;
    void Die() override;
    void Spawn() override;
    void OnAbility(CAbilityState&, action_t&) override;
    auto ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) -> bool override;
    auto CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg) -> bool override;

private:
    uint32            petID_;
    PET_TYPE          m_PetType;      // the type of pet e.g. avatar/wyvern/jugpet etc
    uint8             m_spawnLevel;   // The level the pet was spawned at
    timer::time_point m_jugSpawnTime; // original spawn time of a jug pet
    timer::duration   m_jugDuration;  // Time before the jug is despawned after being called

    void setJugSpawnTime(timer::time_point spawnTime); // sets the initial spawn time of this pet
};
