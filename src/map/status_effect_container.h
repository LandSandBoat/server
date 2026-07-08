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

#include <memory>
#include <set>
#include <utility>

#include "status_effect.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CBattleEntity;

enum class EffectNotice : uint8
{
    ShowMessage = 0, // Display the "effect wears off" or "gains effect" message to the player
    Silent      = 1, // Suppress the message entirely
};

class CStatusEffectContainer final
{
public:
    CStatusEffectContainer(CBattleEntity* PEntity);
    ~CStatusEffectContainer();

    template <typename T = CStatusEffect, typename... Args>
    bool AddStatusEffect(Args&&... args);

    template <typename T = CStatusEffect, typename... Args>
    bool AddStatusEffectSilent(Args&&... args);

    template <typename F, typename... Args>
    void ForEachEffect(F func, Args&&... args);

    bool ApplyBardEffect(CStatusEffect* PStatusEffect, uint8 maxSongs);
    bool CanGainStatusEffect(CStatusEffect* PStatusEffect); // returns true if the status effect will take effect

    auto DelStatusEffect(xi::StatusEffect StatusID) -> bool;
    auto DelStatusEffectSilent(xi::StatusEffect StatusID) -> bool;
    auto DelStatusEffect(xi::StatusEffect StatusID, uint16 SubID) -> bool;
    auto DelStatusEffectBySource(xi::StatusEffect StatusID, EffectSourceType EffectSourceType, uint16 SourceTypeParam) -> bool;
    void DelStatusEffectsByFlag(xi::StatusEffectFlag flag, EffectNotice notice = EffectNotice::ShowMessage); // Remove all the status effects with the specified type
    void DelStatusEffectsByIcon(uint16 BuffNo);                                                              // Remove all effects with the specified icon
    void DelStatusEffectsByType(uint16 Type);
    auto DelStatusEffectByTier(xi::StatusEffect StatusID, uint16 power) -> bool;
    void KillAllStatusEffect();
    void HandleEffectGainSideEffects(CStatusEffect* StatusEffect);

    auto HasStatusEffect(xi::StatusEffect StatusID) -> bool;               // We check the presence of the effect
    auto HasStatusEffect(xi::StatusEffect StatusID, uint16 SubID) -> bool; // Check the presence of an effect with a unique Subid
    auto HasStatusEffect(std::initializer_list<xi::StatusEffect>) -> bool;
    auto HasStatusEffectByFlag(xi::StatusEffectFlag flag) -> bool;

    auto  EraseStatusEffect() -> xi::StatusEffect;                                                             // We delete the first negative effect
    auto  HealingWaltz() -> xi::StatusEffect;                                                                  // dancers healing waltz
    uint8 EraseAllStatusEffect();                                                                              // erases all status effects
    auto  DispelStatusEffect(xi::StatusEffectFlag flag) -> xi::StatusEffect;                                   // We delete the first positive effect
    auto  DispelAllStatusEffect(xi::StatusEffectFlag flag) -> uint8;                                           // dispels all status effects
    auto  StealStatusEffect(xi::StatusEffectFlag flag, EffectNotice notice) -> std::unique_ptr<CStatusEffect>; // dispels one effect and hands ownership to the caller

    auto GetStatusEffect(xi::StatusEffect StatusID) -> CStatusEffect*;
    auto GetStatusEffect(xi::StatusEffect StatusID, uint32 SubID) -> CStatusEffect*;
    auto GetStatusEffectBySource(xi::StatusEffect StatusID, EffectSourceType Sourcetype, uint16 SourceTypeParam) -> CStatusEffect*;

    auto GetStatusEffectsInIDRange(xi::StatusEffect start, xi::StatusEffect end) -> std::vector<xi::StatusEffect>;

    auto GetStatusEffectCountInIDRange(xi::StatusEffect start, xi::StatusEffect end) -> uint8;
    auto GetNewestStatusEffectInIDRange(xi::StatusEffect start, xi::StatusEffect end) -> xi::StatusEffect;
    void RemoveOldestStatusEffectInIDRange(xi::StatusEffect start, xi::StatusEffect end);
    void RemoveNewestStatusEffectInIDRange(xi::StatusEffect start, xi::StatusEffect end);
    void RemoveAllStatusEffectsInIDRange(xi::StatusEffect start, xi::StatusEffect end);

    void UpdateStatusIcons(); // We recall the effects of the effects
    void CheckEffectsExpiry(timer::time_point tick);
    void TickEffects(timer::time_point tick);
    void TickRegen(timer::time_point tick);

    void LoadStatusEffects();                    // We load the character effects
    void SaveStatusEffects(bool logout = false); // We keep the character effects

    auto  GetEffectsCount(xi::StatusEffect ID) -> uint8;               // We get the number of effects with the specified ID
    auto  GetEffectsCountWithFlag(xi::StatusEffectFlag flag) -> uint8; // We get the number of effects with the specified flag
    uint8 GetLowestFreeSlot();                                         // returns the lowest free slot for songs/rolls

    bool CheckForElevenRoll();
    bool HasBustEffect(uint16 id);

    uint8 GetActiveManeuverCount();
    void  RemoveOldestManeuver();
    void  RemoveAllManeuvers();

    auto GetAllRuneEffects() -> std::vector<xi::StatusEffect>;

    uint8 GetActiveRuneCount();
    auto  GetHighestRuneEffect() -> xi::StatusEffect;
    auto  GetNewestRuneEffect() -> xi::StatusEffect;
    void  RemoveOldestRune();
    void  RemoveNewestRune();
    void  RemoveAllRunes();

    void WakeUp(); // remove sleep effects
    bool IsAsleep();
    bool HasPreventActionEffect(bool ignoreCharm = false); // checks if owner has an effect that prevents actions, like stun, petrify, sleep etc

    uint16 GetConfrontationEffect();                        // gets confrontation number (bcnm, confrontation, campaign, reive mark)
    void   CopyConfrontationEffect(CBattleEntity* PEntity); // copies confrontation status (pet summoning, etc)

    [[nodiscard]] auto statusIcons() const -> const uint8*;
    [[nodiscard]] auto statusBits() const -> const uint64&;

private:
    CBattleEntity* m_POwner = nullptr;

    uint64 m_Flags{ 0 };        // Bits of overflow of bytes m_statusicons (two battles for each effect)
    uint8  m_StatusIcons[32]{}; // Icons status effects

    bool AddStatusEffect(std::unique_ptr<CStatusEffect> StatusEffect, EffectNotice = EffectNotice::ShowMessage);

    // void ReplaceStatusEffect(xi::StatusEffect effect); //this needs to be implemented
    void RemoveStatusEffect(CStatusEffect* PStatusEffect, EffectNotice notice = EffectNotice::ShowMessage); // We remove the effect by its number in the container
    void DeleteStatusEffects();
    auto SetEffectParams(CStatusEffect* StatusEffect) -> void; // We set the effect of the effect
    void HandleAura(CStatusEffect* PStatusEffect);

    void OverwriteStatusEffect(CStatusEffect* StatusEffect);

    // The container owns the lifetime of its status effects. External access is handed out as
    // observing CStatusEffect* (nullable lookups) or CStatusEffect& (iteration via ForEachEffect).
    std::multiset<std::unique_ptr<CStatusEffect>, bool (*)(const std::unique_ptr<CStatusEffect>&, const std::unique_ptr<CStatusEffect>&)> m_StatusEffectSet;
};

//
// Inline impls
//

// TODO: Now that we've extracted these into helpers, we can pre-allocate or pool these allocations

template <typename T, typename... Args>
bool CStatusEffectContainer::AddStatusEffect(Args&&... args)
{
    TracyZoneScoped;

    return AddStatusEffect(std::make_unique<T>(std::forward<Args>(args)...), EffectNotice::ShowMessage);
}

// As above, but suppresses the gain/loss messages (the EffectNotice::Silent path).
template <typename T, typename... Args>
bool CStatusEffectContainer::AddStatusEffectSilent(Args&&... args)
{
    TracyZoneScoped;

    return AddStatusEffect(std::make_unique<T>(std::forward<Args>(args)...), EffectNotice::Silent);
}

template <typename F, typename... Args>
void CStatusEffectContainer::ForEachEffect(F func, Args&&... args)
{
    TracyZoneScoped;

    // The container owns each effect; hand callers a reference to the underlying effect.
    for (auto&& PEffect : m_StatusEffectSet)
    {
        func(*PEffect, std::forward<Args>(args)...);
    }
}

//
// Helpers
//

namespace effects
{

void        LoadEffectsParameters();
uint16      GetEffectElement(uint16 effect);
std::string GetEffectName(uint16 effect);

}; // namespace effects
