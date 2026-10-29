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

#include "battle_entity.h"
#include <common/macros.h>

#include <array>

#include <common/types/flat_hash_map.h>
#include <common/types/hash_map.h>
#include <common/types/maybe.h>

#include "data/enums/behavior.h"
#include "data/enums/mob_mod.h"
#include "data/enums/mob_type.h"
#include "data/enums/roam_flag.h"
#include "data/enums/spawn_type.h"

enum class MsgBasic : uint16_t;

// forward declaration
class CMobSpellContainer;
class CMobSpellList;
class CEnmityContainer;
class RoamRegion;
class SpawnSlot;

// Per-mob spawn window in Vana'diel hours; the mob spawns only within [spawnHour, despawnHour) (wraps past midnight).
struct SpawnWindow
{
    uint8 spawnHour;
    uint8 despawnHour;
};

enum SPECIALFLAG
{
    SPECIALFLAG_NONE   = 0x0,
    SPECIALFLAG_HIDDEN = 0x1 // only use special when hidden
};

class CMobSkillState;

struct DropList_t;

class CMobEntity : public CBattleEntity
{
public:
    CMobEntity();
    ~CMobEntity() override;

    DISALLOW_COPY_AND_MOVE(CMobEntity);

    auto getEntityFlags() const -> xi::EntityFlags;   // Returns the current value in m_flags
    void setEntityFlags(xi::EntityFlags EntityFlags); // Change the current value in m_flags

    auto IsFarFromHome() const -> bool; // check if mob is too far from spawn

    auto DistanceFromHome() const -> float;                      // how far it strayed: outside its roam region, or from its spawn point when it has none
    auto GetRoamAnchor() const -> position_t;                    // the point roaming is measured from
    void setRoamRegions(std::vector<const RoamRegion*> regions); // one is picked on every spawn and its edge is the roam limit, so m_maxRoamDistance drops to 0
    auto roamRegion() const -> const RoamRegion*;                // the region picked for this life, null for a point spawner
    auto dropList() const -> const DropList_t*;
    void setPatrolRoute(std::vector<position_t> route); // walked as a loop from every spawn

    auto shouldUseTPMove(uint16 tpThreshold) -> bool; // return true to use a TP move, checked on on 400ms tick interval

    auto CanDeaggro() const -> bool;
    auto GetDespawnTime() -> timer::time_point;
    void SetDespawnTime(timer::duration _duration);
    void SetSpawnSlot(SpawnSlot* sharedSpawn);
    auto GetSpawnSlot() -> SpawnSlot*;

    // Optional per-mob spawn window; overrides the SPAWNTYPE time flags when set.
    auto spawnWindow() const -> const Maybe<SpawnWindow>&;
    void setSpawnWindow(uint8 spawnHour, uint8 despawnHour);

    auto TrySpawn() -> bool;

    auto GetRandomGil() -> uint32; // returns a random amount of gil
    auto CanRoamHome() -> bool;    // is it possible for me to walk back?
    auto CanRoam() -> bool;        // check if mob can walk around
    void TapDeaggroTime();         // call CMobController->TapDeaggroTime if PAI->GetController() is a CMobController, otherwise do nothing.

    auto CanLink(position_t* pos, int16 superLink = 0) -> bool;
    auto ShouldForceLink() -> bool;

    auto CanDropGil() const -> bool;  // mob has gil to drop
    auto CanStealGil() const -> bool; // can steal gil from mob
    void ResetGilPurse();             // reset total gil held
    auto GetEligibleSeals() const -> std::vector<uint16>;
    auto GetEligibleGeodes() const -> std::vector<uint16>;

    void setMobMod(xi::MobMod type, int16 value);
    auto getMobMod(xi::MobMod type) const -> int16;
    void addMobMod(xi::MobMod type, int16 value);
    void defaultMobMod(xi::MobMod type, int16 value); // set value if value has not been already set
    void resetMobMod(xi::MobMod type);                // resets mob mod to original value
    void saveMobModifiers();                          // save current state of modifiers
    void restoreMobModifiers();                       // restore to saved state

    void SetCallForHelpFlag(bool call);
    auto GetCallForHelpFlag() const -> bool;
    void HideHP(bool hide);
    auto IsHPHidden() const -> bool;
    void SetUntargetable(bool untargetable);
    auto GetUntargetable() const -> bool override;

    void PostTick() override;
    auto GetRoamDistance() const -> float;
    auto ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) -> bool override;

    void HandleErrorMessage(std::unique_ptr<CBasicPacket>&) override
    {
    }

    void Die() override;

    auto getfTPModifierOverride(uint16 skillId) -> Maybe<std::array<float, 3>>;
    void setfTPModifierOverride(uint16 skillId, float ftp1, float ftp2, float ftp3);

    void OnWeaponSkillFinished(CWeaponSkillState&, action_t&) override;
    void OnMobSkillFinished(CMobSkillState&, action_t&) override;
    void OnEngage(CAttackState&) override;

    auto GetRangedAttackRange() -> float override;
    auto OnAttack(CAttackState&, action_t&) -> bool override;
    auto CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg) -> bool override;
    void OnCastFinished(CMagicState&, action_t&) override;
    void OnCastInterrupted(CMagicState&, action_t&, MsgBasic msg, bool blockedCast) override;

    void OnDisengage(CAttackState&) override;
    void OnDeathTimer() override;

    void OnDespawn(CDespawnState&) override;

    void Spawn() override;
    void FadeOut() override;
    auto isWideScannable() -> bool override;

    bool            m_AllowRespawn; // If true, this mob or another mob in the same slot is allowed to spawn
    bool            m_CanSpawn;     // If true, it can currently spawn (usually based on time of day or weather)
    timer::duration m_RespawnTime;  // respawn time
    timer::duration m_DropItemTime; // time until monster death animation

    uint32            m_DropID;     // global drop list from SQL. To be deprecated
    const DropList_t* m_DropList{}; // shared by every spawn of one template, null when the template has no loot

    uint8  m_minLevel; // lowest possible level of the mob
    uint8  m_maxLevel; // highest possible level of the mob
    uint32 HPmodifier; // HP in Database (mob_groups)
    uint32 MPmodifier; // MP in Database (mob_groups)

    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    xi::RoamFlag m_roamFlags;    // defines its roaming behavior
    uint8        m_specialFlags; // flags for special skill

    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 accRank;
    uint8 evaRank;

    uint16 m_dmgMult;

    // aggro ranges
    bool  m_disableScent;    // stop detecting by scent
    float m_maxRoamDistance; // maximum distance mob can be from spawn before despawning

    xi::MobType   m_Type; // mob type
    bool          m_Aggro;
    bool          m_TrueDetection; // Has true sight or sound
    uint8         m_Link;          // link with mobs of it's family
    bool          m_isAggroable;   // Can be aggroed by other monsters when in the player allegiance
    xi::Behavior  m_Behavior;      // mob behavior
    xi::SpawnType m_SpawnType;     // condition for mob to spawn

    int8   m_battlefieldID; // battlefield belonging to
    uint16 m_bcnmID;        // belongs to which battlefield
    bool   m_giveExp;       // prevent exp gain
    bool   m_neutral;       // stop linking / aggroing

    position_t m_SpawnPoint; // spawn point of mob

    uint8  m_Element;
    uint8  m_HiPCLvl;        // Highest Level of Player Character that hit the Monster
    uint8  m_HiPartySize;    // Largest party size that hit the Monster
    int16  m_THLvl;          // Highest Level of Treasure Hunter that apply to drops
    int16  m_GilfinderLevel; // Highest Level of Gilfinderthat apply to drops
    bool   m_ItemStolen;     // if true, mob has already been robbed. reset on respawn. also used for thf maat fight
    bool   m_ItemDespoiled;  // if true, mob has already been despoiled. reset on respawn.
    uint16 m_Species;
    uint16 m_Family;
    uint16 m_MobSkillList; // Mob skill list defined from mob_pools
    uint32 m_Pool;         // pool the mob came from

    CMobSpellList*           m_SpellListContainer; // The spells list container for this mob
    std::map<uint16, uint16> m_UsedSkillIds;       // mob skill ids used (key) along with mob level (value)

    xi::EntityFlags m_flags;       // includes the CFH flag and whether the HP bar should be shown or not (e.g. Yilgeban doesnt)
    uint8           m_name_prefix; // The ding bats VS Ding bats

    bool m_CallForHelpBlocked;

    CEnmityContainer* PEnmityContainer;

    CMobSpellContainer* SpellContainer;

    bool m_IsPathingHome;

    static constexpr float sound_range{ 8.f };
    static constexpr float sight_range{ 15.f };
    static constexpr float magic_range{ 20.f };

protected:
    void DistributeRewards();
    void DropItems(CCharEntity* PChar);

private:
    timer::time_point                     m_DespawnTimer{ timer::time_point::min() }; // Despawn Timer to despawn mob after set duration
    FlatHashMap<xi::MobMod, int16>        m_mobModStat;
    FlatHashMap<xi::MobMod, int16>        m_mobModStatSave;
    HashMap<uint16, std::array<float, 3>> m_fTPModifierOverrides;
    static constexpr float                roam_home_distance{ 60.f };
    SpawnSlot*                            spawnSlot = nullptr;
    Maybe<SpawnWindow>                    spawnWindow_;
    std::vector<const RoamRegion*>        roamRegions_;           // areas it may spawn in, owned by the zone
    const RoamRegion*                     roamRegion_{ nullptr }; // the one picked for this life
    std::vector<position_t>               patrolRoute_;           // waypoints it loops while roaming, empty for a free roamer
};
