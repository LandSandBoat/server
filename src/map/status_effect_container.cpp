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

The StatusEffeectContainer manages status effects on battleentities.

When a status effect is gained twice on a player. It can do one or more of the following:

1 Overwrite if equal or higher (protect)
2 Overwrite if higher (blind)
3 Can only have one of type (physical shield, magic shield)
4 Overwrite if equal or stronger than negative (defense boost, defense down)

*/

#include "common/logging.h"
#include "common/timer.h"

#include <array>
#include <cstring>

#include "lua/luautils.h"

#include "ai/ai_container.h"
#include "ai/states/inactive_state.h"

#include "enmity_container.h"
#include "entities/automatonentity.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/trustentity.h"
#include "latent_effect_container.h"
#include "notoriety_container.h"
#include "status_effect_container.h"

#include "enums/msg_std.h"
#include "map_engine.h"
#include "packets/s2c/0x029_battle_message.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"

namespace effects
{

// Default effect of statuses are overwrite if equal or higher
struct EffectParams_t
{
    uint32      Flag;
    std::string Name;
    // type will erase all other effects that match
    // example: en- spells, spikes
    uint16 Type;
    // Negative means the new effect can only land if the negative id is weaker
    // example: haste, slow
    EFFECT NegativeId;
    // only overwrite its self if the new effect is equal or higher / higher than current
    // example: protect, blind
    EFFECTOVERWRITE Overwrite;
    // If this status effect is on the user, it will not take effect
    // example: lullaby will not take effect with sleep I
    EFFECT BlockId;
    // Will always remove this effect when landing
    EFFECT RemoveId;
    // status effect element, used in resistances
    uint8 Element;

    // minimum duration. IE: stun cannot last less than 1 second
    timer::duration MinDuration;

    // Order in which the status effect should be displayed for the player
    uint16 SortKey;

    EffectParams_t()
    : Flag(0)
    , Type(0)
    , NegativeId((EFFECT)0)
    , Overwrite(EFFECTOVERWRITE::EQUAL_HIGHER)
    , BlockId((EFFECT)0)
    , RemoveId((EFFECT)0)
    , Element(0)
    , MinDuration(0s)
    , SortKey(0)
    {
    }
};

std::array<EffectParams_t, MAX_EFFECTID> EffectsParams;

void LoadEffectsParameters()
{
    for (uint16 i = 0; i < MAX_EFFECTID; ++i)
    {
        EffectsParams[i].Flag = 0;
    }

    const auto rset = db::preparedStmt("SELECT id, name, flags, type, "
                                       "negative_id, overwrite, block_id, remove_id, "
                                       "element, min_duration, sort_key "
                                       "FROM status_effects "
                                       "WHERE id < ?",
                                       MAX_EFFECTID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto EffectID = rset->get<uint16>("id");

        EffectsParams[EffectID].Name       = rset->get<std::string>("name");
        EffectsParams[EffectID].Flag       = rset->get<uint32>("flags");
        EffectsParams[EffectID].Type       = rset->get<uint16>("type");
        EffectsParams[EffectID].NegativeId = rset->get<EFFECT>("negative_id");
        EffectsParams[EffectID].Overwrite  = rset->get<EFFECTOVERWRITE>("overwrite");
        EffectsParams[EffectID].BlockId    = rset->get<EFFECT>("block_id");
        EffectsParams[EffectID].RemoveId   = rset->get<EFFECT>("remove_id");

        EffectsParams[EffectID].Element     = rset->get<uint16>("element");
        EffectsParams[EffectID].MinDuration = std::chrono::seconds(rset->get<uint32>("min_duration"));

        const auto sortKey              = rset->get<uint16>("sort_key");
        EffectsParams[EffectID].SortKey = sortKey == 0 ? 10000 : sortKey; // default to high number to such that effects without a sort key aren't first

        auto filename = fmt::format("./scripts/effects/{}.lua", EffectsParams[EffectID].Name);
        luautils::CacheLuaObjectFromFile(filename);
    }
}

// hacky way to get element from status effect
uint16 GetEffectElement(uint16 effect)
{
    return EffectsParams[effect].Element;
}

std::string GetEffectName(uint16 effect)
{
    return EffectsParams[effect].Name;
}

} // namespace effects

bool isSortedByStartTime(uint16 effectId)
{
    return effectId >= EFFECT_FIRE_MANEUVER && effectId <= EFFECT_DARK_MANEUVER;
}

bool statusOrdering(CStatusEffect* AStatus, CStatusEffect* BStatus)
{
    // Sort by overall status effect ordering, if they have different sort keys
    uint16 ASortKey = effects::EffectsParams[AStatus->GetStatusID()].SortKey;
    uint16 BSortKey = effects::EffectsParams[BStatus->GetStatusID()].SortKey;
    if (ASortKey != BSortKey)
    {
        return ASortKey < BSortKey;
    }

    // Sort by song/roll slot
    if (AStatus->GetEffectSlot() != BStatus->GetEffectSlot())
    {
        return AStatus->GetEffectSlot() < BStatus->GetEffectSlot();
    }

    // Sort by start time
    if (isSortedByStartTime(AStatus->GetStatusID()) && isSortedByStartTime(BStatus->GetStatusID()))
    {
        auto diff = timer::count_milliseconds(AStatus->GetStartTime() - BStatus->GetStartTime());
        if (diff != 0)
        {
            return diff > 0;
        }
    }

    // Fall-back to sort by status effect ID, in case no other ordering is applied
    return AStatus->GetStatusID() < BStatus->GetStatusID();
}

CStatusEffectContainer::CStatusEffectContainer(CBattleEntity* PEntity)
: m_StatusEffectSet(statusOrdering)
{
    m_POwner = PEntity;

    if (m_POwner == nullptr)
    {
        ShowWarning("m_POwner was null.");
        return;
    }

    std::memset(m_StatusIcons, 0xFF, sizeof(m_StatusIcons));
}

CStatusEffectContainer::~CStatusEffectContainer()
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        destroy(PStatusEffect);
    }
}

uint8 CStatusEffectContainer::GetEffectsCount(EFFECT ID)
{
    uint8 count = 0;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == ID && !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

uint8 CStatusEffectContainer::GetEffectsCountWithFlag(EFFECTFLAG flag)
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

uint8 CStatusEffectContainer::GetLowestFreeSlot()
{
    uint8 lowestFreeSlot = 1;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetEffectSlot() == lowestFreeSlot && !PStatusEffect->deleted)
        {
            lowestFreeSlot++;
        }
        else if (PStatusEffect->GetEffectSlot() > lowestFreeSlot)
        {
            // Can break since the set is sorted by slot number,
            // and if we're past the lowest free one, we've found it already
            break;
        }
    }
    return lowestFreeSlot;
}

bool CStatusEffectContainer::CanGainStatusEffect(CStatusEffect* PStatusEffect)
{
    EFFECT statusEffect = PStatusEffect->GetStatusID();
    // check for immunities first
    switch (statusEffect)
    {
        case EFFECT_SLEEP:
        case EFFECT_SLEEP_II:
        case EFFECT_LULLABY:
        {
            uint16 subPower = PStatusEffect->GetSubPower();
            if (subPower == ELEMENT_LIGHT && m_POwner->hasImmunity(IMMUNITY_LIGHT_SLEEP))
            {
                return false;
            }
            else if (subPower == ELEMENT_DARK && m_POwner->hasImmunity(IMMUNITY_DARK_SLEEP))
            {
                return false;
            }

            break;
        }
        case EFFECT_WEIGHT:
            if (m_POwner->hasImmunity(IMMUNITY_GRAVITY))
            {
                return false;
            }
            break;
        case EFFECT_BIND:
            if (m_POwner->hasImmunity(IMMUNITY_BIND))
            {
                return false;
            }
            break;
        case EFFECT_STUN:
            if (m_POwner->hasImmunity(IMMUNITY_STUN))
            {
                return false;
            }
            break;
        case EFFECT_SILENCE:
            if (m_POwner->hasImmunity(IMMUNITY_SILENCE))
            {
                return false;
            }
            break;
        case EFFECT_PARALYSIS:
            if (m_POwner->hasImmunity(IMMUNITY_PARALYZE))
            {
                return false;
            }
            break;
        case EFFECT_BLINDNESS:
            if (m_POwner->hasImmunity(IMMUNITY_BLIND))
            {
                return false;
            }
            break;
        case EFFECT_SLOW:
            if (m_POwner->hasImmunity(IMMUNITY_SLOW))
            {
                return false;
            }
            break;
        case EFFECT_POISON:
            if (m_POwner->hasImmunity(IMMUNITY_POISON))
            {
                return false;
            }
            break;
        case EFFECT_ELEGY:
            if (m_POwner->hasImmunity(IMMUNITY_ELEGY))
            {
                return false;
            }
            break;
        case EFFECT_REQUIEM:
            if (m_POwner->hasImmunity(IMMUNITY_REQUIEM))
            {
                return false;
            }
            break;
        case EFFECT_TERROR:
            if (m_POwner->hasImmunity(IMMUNITY_TERROR))
            {
                return false;
            }
            break;
        case EFFECT_PETRIFICATION:
            if (m_POwner->hasImmunity(IMMUNITY_PETRIFY))
            {
                return false;
            }
            break;
        default:
            break;
    }

    // make sure pets can't be charmed
    if ((statusEffect == EFFECT_CHARM || statusEffect == EFFECT_CHARM_II) && m_POwner->PMaster != nullptr)
    {
        return false;
    }

    // check if a status effect blocks this
    EFFECT blockId = effects::EffectsParams[statusEffect].BlockId;
    if (blockId != 0 && HasStatusEffect(blockId))
    {
        return false;
    }

    // check if negative is strong enough to stop this
    EFFECT negativeId = effects::EffectsParams[statusEffect].NegativeId;
    if (negativeId != 0)
    {
        CStatusEffect* negativeEffect = GetStatusEffect(negativeId);

        if (negativeEffect != nullptr)
        {
            if (statusEffect == EFFECT_HASTE && negativeEffect->GetStatusID() == EFFECT_SLOW && negativeEffect->GetSubPower() == 1)
            {
                // slow i remote
                return true;
            }

            if (PStatusEffect->GetTier() != 0 && negativeEffect->GetTier() != 0)
            {
                return PStatusEffect->GetTier() == negativeEffect->GetTier() ? statusEffect > negativeId : PStatusEffect->GetTier() > negativeEffect->GetTier();
            }

            // new status effect must be stronger
            return PStatusEffect->GetPower() >= negativeEffect->GetPower();
        }
    }

    CStatusEffect* existingEffect = GetStatusEffect(statusEffect);

    // check overwrite
    if (existingEffect != nullptr)
    {
        EFFECTOVERWRITE overwrite = effects::EffectsParams[statusEffect].Overwrite;

        if (overwrite == EFFECTOVERWRITE::ALWAYS || overwrite == EFFECTOVERWRITE::IGNORE_DUPLICATE)
        {
            return true;
        }
        else if (overwrite == EFFECTOVERWRITE::NEVER)
        {
            return false;
        }
        else if (overwrite == EFFECTOVERWRITE::EQUAL_HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
            {
                return PStatusEffect->GetTier() >= existingEffect->GetTier();
            }
            return PStatusEffect->GetPower() >= existingEffect->GetPower();
        }
        else if (overwrite == EFFECTOVERWRITE::HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
            {
                return PStatusEffect->GetTier() > existingEffect->GetTier();
            }
            return PStatusEffect->GetPower() > existingEffect->GetPower();
        }
        else if (overwrite == EFFECTOVERWRITE::TIER_HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
            {
                return PStatusEffect->GetTier() > existingEffect->GetTier();
            }
        }

        return false;
    }

    return true;
}

void CStatusEffectContainer::OverwriteStatusEffect(CStatusEffect* StatusEffect)
{
    uint16 statusEffect = (uint16)StatusEffect->GetStatusID();
    // remove effect
    EFFECTOVERWRITE overwrite = effects::EffectsParams[statusEffect].Overwrite;
    if (overwrite != EFFECTOVERWRITE::IGNORE_DUPLICATE)
    {
        DelStatusEffectSilent((EFFECT)statusEffect);
    }

    // remove effect by id
    EFFECT removeId = effects::EffectsParams[statusEffect].RemoveId;
    if (removeId > EFFECT_KO)
    {
        DelStatusEffectSilent(removeId);
    }

    // remove negative effect
    EFFECT negativeId = effects::EffectsParams[statusEffect].NegativeId;
    if (negativeId > EFFECT_KO)
    {
        DelStatusEffectSilent(negativeId);
    }
}

/**************************************************************************
 *                                                                         *
 *  Adding a status effect to the container                                *
 *  If I'm not mistaken, then the max. possible number of effects is 32    *
 *                                                                         *
 **************************************************************************/

bool CStatusEffectContainer::AddStatusEffect(CStatusEffect* PStatusEffect, EffectNotice notice)
{
    if (PStatusEffect == nullptr)
    {
        ShowWarning("status_effect_container::AddStatusEffect Status effect given was nullptr!");
        return false;
    }

    uint16 statusId = PStatusEffect->GetStatusID();

    if (statusId >= MAX_EFFECTID)
    {
        ShowWarning("status_effect_container::AddStatusEffect statusId given is OVER limit %d", statusId);
        return false;
    }

    if (CanGainStatusEffect(PStatusEffect))
    {
        // check for minimum duration
        if (PStatusEffect->GetDuration() < effects::EffectsParams[statusId].MinDuration)
        {
            PStatusEffect->SetDuration(effects::EffectsParams[statusId].MinDuration);
        }

        // remove clean up other effects
        OverwriteStatusEffect(PStatusEffect);

        SetEffectParams(PStatusEffect);

        // remove effects with same type
        DelStatusEffectsByType(PStatusEffect->GetEffectType());

        PStatusEffect->SetStartTime(timer::now());

        m_StatusEffectSet.insert(PStatusEffect);

        ApplyStateAlteringEffects(PStatusEffect);

        luautils::OnEffectGain(m_POwner, PStatusEffect);
        m_POwner->PAI->EventHandler.triggerListener("EFFECT_GAIN", m_POwner, PStatusEffect);

        // Set owner after triggering all "effect gain" lua actions, to ensure effect:addMod() doesn't double up mod powers on the entity
        PStatusEffect->SetOwner(m_POwner);

        m_POwner->addModifiers(&PStatusEffect->modList);

        if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER && PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER && m_POwner->objtype == TYPE_PC)
        {
            puppetutils::CheckAttachmentsForManeuver((CCharEntity*)m_POwner, PStatusEffect->GetStatusID(), true);
        }

        if (m_POwner->health.maxhp != 0) // make sure we're not in the middle of logging in
        {
            m_POwner->UpdateHealth();
        }

        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;

            if (PStatusEffect->GetIcon() != 0)
            {
                UpdateStatusIcons();
            }

            if (m_POwner->health.maxhp != 0) // make sure we're not in the middle of logging in
            {
                // check for latents
                PChar->PLatentEffectContainer->CheckLatentsFoodEffect();
                PChar->PLatentEffectContainer->CheckLatentsStatusEffect();
                PChar->PLatentEffectContainer->CheckLatentsRollSong();
                PChar->UpdateHealth();
            }
        }
        m_POwner->updatemask |= UPDATE_HP;

        return true;
    }
    else
    {
        destroy(PStatusEffect);
    }

    return false;
}

/************************************************************************
 *                                                                       *
 *  Effects in all methods are removed equally, put this code in         *
 *  separate function. We remove icons only from CharEntity.             *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::DeleteStatusEffects()
{
    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    bool update_icons    = false;
    bool effects_removed = false;
    for (auto effect_iter = m_StatusEffectSet.begin(); effect_iter != m_StatusEffectSet.end();)
    {
        CStatusEffect* PStatusEffect = *effect_iter;
        if (PStatusEffect->deleted)
        {
            if (PStatusEffect->GetIcon() != 0)
            {
                update_icons = true;
            }
            effect_iter = m_StatusEffectSet.erase(effect_iter);
            destroy(PStatusEffect);
            effects_removed = true;
        }
        else
        {
            ++effect_iter;
        }
    }

    if (effects_removed)
    {
        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;

            if (update_icons)
            {
                UpdateStatusIcons();
            }

            // check for latents
            PChar->PLatentEffectContainer->CheckLatentsFoodEffect();
            PChar->PLatentEffectContainer->CheckLatentsStatusEffect();
            PChar->PLatentEffectContainer->CheckLatentsRollSong();
        }
        m_POwner->UpdateHealth();
    }
}

void CStatusEffectContainer::RemoveStatusEffect(CStatusEffect* PStatusEffect, EffectNotice notice)
{
    if (!PStatusEffect->deleted)
    {
        PStatusEffect->deleted = true;
        luautils::OnEffectLose(m_POwner, PStatusEffect);
        m_POwner->PAI->EventHandler.triggerListener("EFFECT_LOSE", m_POwner, PStatusEffect);

        m_POwner->delModifiers(&PStatusEffect->modList);
        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;

            if (PStatusEffect->GetIcon() != 0)
            {
                if (notice != EffectNotice::Silent && !(PStatusEffect->HasEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE)))
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PStatusEffect->GetIcon(), 0, MsgStd::EffectWearsOff);
                }
            }

            if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER && PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER)
            {
                puppetutils::CheckAttachmentsForManeuver((CCharEntity*)m_POwner, PStatusEffect->GetStatusID(), false);
            }
        }
        else
        {
            if (notice != EffectNotice::Silent && PStatusEffect->GetIcon() != 0 && (!(PStatusEffect->HasEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE))) && !m_POwner->isDead())
            {
                m_POwner->loc.zone->PushPacket(m_POwner, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_POwner, m_POwner, PStatusEffect->GetIcon(), 0, MsgStd::EffectWearsOff));
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Remove the status effect by its main and additional types.           *
 *                                                                       *
 ************************************************************************/

bool CStatusEffectContainer::DelStatusEffect(EFFECT StatusID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectSilent(EFFECT StatusID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffect(EFFECT StatusID, uint16 SubID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSubID() == SubID && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectBySource(EFFECT StatusID, EffectSourceType sourceType, uint16 sourceTypeParam)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSourceType() == sourceType && PStatusEffect->GetSourceTypeParam() == sourceTypeParam && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectByTier(EFFECT StatusID, uint16 tier)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetTier() == tier && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
            return true;
        }
    }
    return false;
}

/************************************************************************
 *                                                                       *
 *  Deletes all status effects without sending messages                  *
 *                                                                       *
 ************************************************************************/
void CStatusEffectContainer::KillAllStatusEffect()
{
    for (auto effect_iter = m_StatusEffectSet.begin(); effect_iter != m_StatusEffectSet.end();)
    {
        CStatusEffect* PStatusEffect = *effect_iter;
        if (PStatusEffect->GetDuration() != 0s)
        {
            luautils::OnEffectLose(m_POwner, PStatusEffect);

            m_POwner->delModifiers(&PStatusEffect->modList);

            effect_iter = m_StatusEffectSet.erase(effect_iter);

            destroy(PStatusEffect);
        }
        else
        {
            ++effect_iter;
        }
    }
    m_POwner->UpdateHealth();
}

// Apply any state alterations for the effect if applicable.
void CStatusEffectContainer::ApplyStateAlteringEffects(CStatusEffect* StatusEffect)
{
    EFFECT effect = StatusEffect->GetStatusID();

    if (m_POwner->isAlive())
    {
        // this should actually go into a char charm AI
        if (m_POwner->objtype == TYPE_PC)
        {
            if (effect == EFFECT_CHARM || effect == EFFECT_CHARM_II)
            {
                if (m_POwner->PPet != nullptr)
                {
                    petutils::DespawnPet(m_POwner);
                }
            }
        }

        if (effect == EFFECT_SLEEP || effect == EFFECT_SLEEP_II || effect == EFFECT_STUN || effect == EFFECT_PETRIFICATION || effect == EFFECT_TERROR ||
            effect == EFFECT_LULLABY || effect == EFFECT_PENALTY)
        {
            // change icon of sleep II and lullaby. Apparently they don't stop player movement.
            if (effect == EFFECT_SLEEP_II || effect == EFFECT_LULLABY)
            {
                StatusEffect->SetIcon(EFFECT_SLEEP);
            }
            if (!m_POwner->PAI->IsCurrentState<CInactiveState>())
            {
                m_POwner->PAI->Inactive(0ms, false);
            }
        }
    }
}

void CStatusEffectContainer::DelStatusEffectsByIcon(const uint16 BuffNo)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetIcon() == BuffNo)
        {
            // This covers all effects that client can remove. Function not used for anything the server removes.
            if (!(PStatusEffect->HasEffectFlag(EFFECTFLAG_NO_CANCEL)))
            {
                RemoveStatusEffect(PStatusEffect);
            }
        }
    }
}

void CStatusEffectContainer::DelStatusEffectsByType(uint16 Type)
{
    if (Type <= 0)
    {
        return;
    }

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetEffectType() == Type)
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
        }
    }
}

void CStatusEffectContainer::DelStatusEffectsByFlag(uint32 flag, EffectNotice notice)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag))
        {
            // If this is an NM/Mob Nightmare sleep, it can be removed explictly by a cure
            // see mobskills/nightmare.lua for full explanation
            if (
                flag & EFFECTFLAG_DAMAGE &&
                PStatusEffect->GetStatusID() == EFFECT_SLEEP &&
                PStatusEffect->GetTier() >= 5) // Tier 5 = Diabolos NM Nightmare
            {
                continue;
            }

            RemoveStatusEffect(PStatusEffect, notice);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Remove the first added negative effect with the erase flag.          *
 *                                                                       *
 ************************************************************************/

EFFECT CStatusEffectContainer::EraseStatusEffect()
{
    std::vector<CStatusEffect*> erasableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(EFFECTFLAG_ERASABLE) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            erasableList.emplace_back(PStatusEffect);
        }
    }
    if (!erasableList.empty())
    {
        auto   rndIdx = xirand::GetRandomNumber(erasableList.size());
        EFFECT result = erasableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(erasableList.at(rndIdx));
        return result;
    }
    return EFFECT_NONE;
}

EFFECT CStatusEffectContainer::HealingWaltz()
{
    std::vector<CStatusEffect*> waltzableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->HasEffectFlag(EFFECTFLAG_WALTZABLE) ||
             PStatusEffect->HasEffectFlag(EFFECTFLAG_ERASABLE)) &&
            PStatusEffect->GetDuration() > 0s &&
            !PStatusEffect->deleted)
        {
            waltzableList.emplace_back(PStatusEffect);
        }
    }
    if (!waltzableList.empty())
    {
        auto   rndIdx = xirand::GetRandomNumber(waltzableList.size());
        EFFECT result = waltzableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(waltzableList.at(rndIdx));
        return result;
    }
    return EFFECT_NONE;
}

/*
Erases all negative status effects
returns number of erased effects
*/
uint8 CStatusEffectContainer::EraseAllStatusEffect()
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(EFFECTFLAG_ERASABLE) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect);
            count++;
        }
    }
    return count;
}

/************************************************************************
 *                                                                       *
 *  Remove the first added positive effect with the dispel flag.         *
 *                                                                       *
 ************************************************************************/

EFFECT CStatusEffectContainer::DispelStatusEffect(EFFECTFLAG flag)
{
    std::vector<CStatusEffect*> dispelableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            dispelableList.emplace_back(PStatusEffect);
        }
    }
    if (!dispelableList.empty())
    {
        auto   rndIdx = xirand::GetRandomNumber(dispelableList.size());
        EFFECT result = dispelableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(dispelableList.at(rndIdx), EffectNotice::Silent);
        return result;
    }
    return EFFECT_NONE;
}

/*
Dispels all positive status effects
returns number of dispelled effects
*/
uint8 CStatusEffectContainer::DispelAllStatusEffect(EFFECTFLAG flag)
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
            count++;
        }
    }
    return count;
}

/************************************************************************
 *                                                                       *
 *  Check for the presence of a status effect in the container           *
 *                                                                       *
 ************************************************************************/

bool CStatusEffectContainer::HasStatusEffect(EFFECT StatusID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && !PStatusEffect->deleted)
        {
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::HasStatusEffectByFlag(uint32 flag)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag) && !PStatusEffect->deleted)
        {
            return true;
        }
    }
    return false;
}

/************************************************************************
 *                                                                       *
 *  Applies a bard song effect (after checking restrictions)             *
 *  Returns true if the effect is applied, false otherwise.              *
 *                                                                       *
 ************************************************************************/

bool CStatusEffectContainer::ApplyBardEffect(CStatusEffect* PStatusEffect, uint8 maxSongs)
{
    // if all match tier/id/effect then overwrite

    // if tier/effect match then overwrite //but id doesn't, NO EFFECT
    // if targ has <2 of your songs on, then just apply
    // if targ has 2 of your songs, remove oldest one and apply this one.

    uint8          numOfEffects = 0;
    CStatusEffect* oldestSong   = nullptr;
    for (CStatusEffect* ExistingStatusEffect : m_StatusEffectSet)
    {
        if (ExistingStatusEffect->GetStatusID() >= EFFECT_REQUIEM && ExistingStatusEffect->GetStatusID() <= EFFECT_NOCTURNE) // is an active brd effect
        {
            if (ExistingStatusEffect->GetTier() == PStatusEffect->GetTier() && ExistingStatusEffect->GetStatusID() == PStatusEffect->GetStatusID())
            { // same tier/type, overwrite
                // OVERWRITE
                PStatusEffect->SetEffectSlot(ExistingStatusEffect->GetEffectSlot()); // use same slot as the one it replaces
                DelStatusEffectByTier(PStatusEffect->GetStatusID(), PStatusEffect->GetTier());
            }
            if (ExistingStatusEffect->GetSubID() == PStatusEffect->GetSubID())
            { // YOUR BRD effect
                numOfEffects++;
                if (!oldestSong)
                {
                    oldestSong = ExistingStatusEffect;
                }
                else if (ExistingStatusEffect->GetStartTime() + ExistingStatusEffect->GetDuration() <
                         oldestSong->GetStartTime() + oldestSong->GetDuration())
                {
                    oldestSong = ExistingStatusEffect;
                }
            }
        }
    }

    if (numOfEffects < maxSongs)
    {
        if (PStatusEffect->GetEffectSlot() == 0)
        {
            // use lowest available slot, unless it's replacing an existing song
            PStatusEffect->SetEffectSlot(GetLowestFreeSlot());
        }
        AddStatusEffect(PStatusEffect);
        return true;
    }
    else if (oldestSong)
    {
        // overwrite oldest
        PStatusEffect->SetEffectSlot(oldestSong->GetEffectSlot());
        DelStatusEffectByTier(oldestSong->GetStatusID(), oldestSong->GetTier());
        AddStatusEffect(PStatusEffect);
        return true;
    }

    return false;
}

auto CStatusEffectContainer::ApplyCorsairEffect(CStatusEffect* PStatusEffect, uint8 maxRolls, uint8 bustDuration) -> bool
{
    // Don't process if not a COR roll.
    if (!((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL && PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
          (PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL)))
    {
        return false;
    }

    // Effect Power    = Mod Power
    // Effect SubID    = Mod ID
    // Effect SubPower = Roll #
    // Effect Tier     = Unused Currently (Previously used to store Mod ID)

    // if all match roll #/id/effect then overwrite.

    // If roll #/ effect match then overwrite, but id doesn't, NO EFFECT
    // If targ has less than 2 of your rolls on, then just apply
    // If targ already has 2 of your rolls, remove oldest one and apply this one.

    uint8          numOfEffects = 0;
    CStatusEffect* oldestRoll   = nullptr;

    for (auto&& PEffect : m_StatusEffectSet)
    {
        if ((PEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL && PEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL || PEffect->GetStatusID() == EFFECT_BUST) // is a COR effect
        {
            if (PEffect->GetStatusID() == PStatusEffect->GetStatusID() && PEffect->GetSourceTypeParam() == PStatusEffect->GetSourceTypeParam() &&
                PEffect->GetSubPower() < PStatusEffect->GetSubPower())
            { // same type, double up
                if (PStatusEffect->GetSubPower() < 12)
                {
                    PStatusEffect->SetDuration(PEffect->GetDuration());
                    PStatusEffect->SetEffectSlot(PEffect->GetEffectSlot());
                    DelStatusEffectSilent(PStatusEffect->GetStatusID());
                    AddStatusEffect(PStatusEffect, EffectNotice::Silent);
                    return true;
                }
                else // We rolled over 12 and busted.
                {
                    if (PEffect->GetSourceTypeParam() == m_POwner->id) // Check to see if this effect is from the initial caster.
                    {
                        if (!CheckForElevenRoll()) // If caster has 11 roll active, do not gain the bust effect.
                        {
                            // Pass Roll effect values into the Bust effect. Used to handle Bust debuffs in scripts/effects/bust.lua
                            timer::duration duration = 5min;
                            duration -= std::chrono::seconds(bustDuration);
                            CStatusEffect* bustEffect = new CStatusEffect(EFFECT_BUST,                  // Effect ID
                                                                          EFFECT_BUST,                  // Effect Icon
                                                                          PStatusEffect->GetPower(),    // Effect Power (Mod Power)
                                                                          0s,                           // Effect Tick
                                                                          duration,                     // Effect Duration
                                                                          PStatusEffect->GetSubID(),    // Effect SubType (Mod ID)
                                                                          PStatusEffect->GetSubPower(), // Effect SubPower (Roll #)
                                                                          PStatusEffect->GetTier());    // Effect Tier

                            bustEffect->SetSource(PEffect->GetSourceType(), PEffect->GetSourceTypeParam());
                            bustEffect->SetOriginID(PEffect->GetOriginID());

                            AddStatusEffect(bustEffect, EffectNotice::Silent);
                            DelStatusEffectSilent(EFFECT_DOUBLE_UP_CHANCE);
                        }
                    }
                    // Everyone still loses the roll effect if the caster rolled 12+(Bust).
                    DelStatusEffectSilent(PStatusEffect->GetStatusID());

                    return true;
                }
            }

            // Handle Roll/Bust ordering
            if (PEffect->GetSourceTypeParam() == PStatusEffect->GetSourceTypeParam() || PEffect->GetStatusID() == EFFECT_BUST)
            {
                // Increment if its a roll or a bust from yourself. Do not count busts when counting roll effects from others.
                if (!(PEffect->GetStatusID() == EFFECT_BUST && PStatusEffect->GetSourceTypeParam() != m_POwner->id))
                {
                    numOfEffects++;
                }

                // Only consider rolls(Not Busts) for oldest roll tracking.
                if (PEffect->GetStatusID() != EFFECT_BUST)
                {
                    if (oldestRoll == nullptr)
                    {
                        oldestRoll = PEffect;
                    }
                    else if (PEffect->GetStartTime() + PEffect->GetDuration() <
                             oldestRoll->GetStartTime() + oldestRoll->GetDuration())
                    {
                        oldestRoll = PEffect;
                    }
                }
            }
        }
    }

    if (numOfEffects < maxRolls)
    {
        PStatusEffect->SetEffectSlot(GetLowestFreeSlot());
        AddStatusEffect(PStatusEffect, EffectNotice::Silent);
        return true;
    }
    else if (oldestRoll != nullptr)
    {
        // Overwrite the oldest roll
        PStatusEffect->SetEffectSlot(oldestRoll->GetEffectSlot());
        DelStatusEffect(oldestRoll->GetStatusID());
        AddStatusEffect(PStatusEffect);
        return true;
    }
    else
    {
        // Fallback: Shouldn't get here normally.
        ShowWarning("CStatusEffectContainer::ApplyCorsairEffect reached fallback condition");
        return false;
    }
}

bool CStatusEffectContainer::HasCorsairEffect(uint32 charid)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL && PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL || PStatusEffect->GetStatusID() == EFFECT_BUST) // is a cor effect
        {
            if (PStatusEffect->GetSourceTypeParam() == charid || PStatusEffect->GetStatusID() == EFFECT_BUST)
            {
                return true;
            }
        }
    }
    return false;
}

void CStatusEffectContainer::Fold(uint32 charid)
{
    CStatusEffect* oldestRoll = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL && PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL || PStatusEffect->GetStatusID() == EFFECT_BUST) // is a cor effect
        {
            if (PStatusEffect->GetSourceTypeParam() == charid || PStatusEffect->GetStatusID() == EFFECT_BUST)
            {
                if (oldestRoll == nullptr)
                {
                    oldestRoll = PStatusEffect;
                }
                else if (PStatusEffect->GetStatusID() == EFFECT_BUST)
                {
                    if (oldestRoll->GetStatusID() == EFFECT_BUST)
                    {
                        oldestRoll = PStatusEffect->GetStartTime() > oldestRoll->GetStartTime() ? PStatusEffect : oldestRoll;
                    }
                    else
                    {
                        oldestRoll = PStatusEffect;
                    }
                }
                else if (oldestRoll->GetStatusID() != EFFECT_BUST && PStatusEffect->GetStartTime() > oldestRoll->GetStartTime())
                {
                    oldestRoll = PStatusEffect;
                }
            }
        }
    }
    if (oldestRoll != nullptr)
    {
        RemoveStatusEffect(oldestRoll);
        DelStatusEffectSilent(EFFECT_DOUBLE_UP_CHANCE);
    }
}

uint8 CStatusEffectContainer::GetActiveManeuverCount()
{
    return GetStatusEffectCountInIDRange(EFFECT_FIRE_MANEUVER, EFFECT_DARK_MANEUVER);
}

void CStatusEffectContainer::RemoveOldestManeuver()
{
    RemoveOldestStatusEffectInIDRange(EFFECT_FIRE_MANEUVER, EFFECT_DARK_MANEUVER);
}

void CStatusEffectContainer::RemoveAllManeuvers()
{
    RemoveAllStatusEffectsInIDRange(EFFECT_FIRE_MANEUVER, EFFECT_DARK_MANEUVER);
}

std::vector<EFFECT> CStatusEffectContainer::GetAllRuneEffects()
{
    return GetStatusEffectsInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

uint8 CStatusEffectContainer::GetActiveRuneCount()
{
    return GetStatusEffectCountInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

EFFECT CStatusEffectContainer::GetHighestRuneEffect()
{
    std::unordered_map<EFFECT, uint8> runeEffects;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= EFFECT_IGNIS && PStatusEffect->GetStatusID() <= EFFECT_TENEBRAE && !PStatusEffect->deleted)
        {
            if (runeEffects.count(PStatusEffect->GetStatusID()) == 0)
            {
                runeEffects[PStatusEffect->GetStatusID()] = 1;
            }
            else
            {
                runeEffects.at(PStatusEffect->GetStatusID())++;
            }
        }
    }

    EFFECT highestRune      = EFFECT_NONE;
    int    highestRuneValue = 0;

    for (auto iter = runeEffects.begin(); iter != runeEffects.end(); ++iter)
    {
        if (highestRune == EFFECT_NONE || iter->second > highestRuneValue)
        {
            highestRune      = iter->first;
            highestRuneValue = iter->second;
        }
    }

    return highestRune;
}

EFFECT CStatusEffectContainer::GetNewestRuneEffect()
{
    return GetNewestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveNewestRune()
{
    RemoveNewestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveOldestRune()
{
    RemoveOldestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveAllRunes()
{
    RemoveAllStatusEffectsInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

/************************************************************************
 *                                                                       *
 *  Check for the presence of a status effect in a container with a      *
 *  unique subid                                                         *
 *                                                                       *
 ************************************************************************/

bool CStatusEffectContainer::HasStatusEffect(EFFECT StatusID, uint16 SubID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSubID() == SubID && !PStatusEffect->deleted)
        {
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::HasStatusEffect(std::initializer_list<EFFECT> effects)
{
    for (auto&& effect_from_set : m_StatusEffectSet)
    {
        if (!effect_from_set->deleted)
        {
            for (auto&& effect_to_check : effects)
            {
                if (effect_to_check == effect_from_set->GetStatusID())
                {
                    return true;
                }
            }
        }
    }
    return false;
}

CStatusEffect* CStatusEffectContainer::GetStatusEffect(EFFECT StatusID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

CStatusEffect* CStatusEffectContainer::GetStatusEffect(EFFECT StatusID, uint32 SubID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSubID() == SubID && !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

CStatusEffect* CStatusEffectContainer::GetStatusEffectBySource(EFFECT StatusID, EffectSourceType SourceType, uint16 SourceTypeParam)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSourceType() == SourceType && PStatusEffect->GetSourceTypeParam() == SourceTypeParam && !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

/************************************************************************
 *                                                                       *
 * Dispels one effect and returns it (used in mob abilities)             *
 *                                                                       *
 ************************************************************************/

CStatusEffect* CStatusEffectContainer::StealStatusEffect(EFFECTFLAG flag, EffectNotice notice)
{
    std::vector<CStatusEffect*> dispelableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->HasEffectFlag(flag) && PStatusEffect->GetDuration() > 0s && !PStatusEffect->deleted)
        {
            dispelableList.emplace_back(PStatusEffect);
        }
    }
    if (!dispelableList.empty())
    {
        auto rndIdx = xirand::GetRandomNumber(dispelableList.size());

        CStatusEffect* oldEffect = dispelableList.at(rndIdx);

        // make a copy
        CStatusEffect* EffectCopy = new CStatusEffect(
            oldEffect->GetStatusID(),
            oldEffect->GetIcon(),
            oldEffect->GetPower(),
            oldEffect->GetTickTime(),
            oldEffect->GetDuration(),
            oldEffect->GetSubID(),
            oldEffect->GetSubPower(),
            oldEffect->GetTier(),
            oldEffect->GetEffectFlags(),
            oldEffect->GetSourceType(),
            oldEffect->GetSourceTypeParam(),
            oldEffect->GetOriginID());

        RemoveStatusEffect(oldEffect, notice);

        return EffectCopy;
    }
    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Recalculate the icons of all effects                                 *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::UpdateStatusIcons()
{
    if (m_POwner->objtype != TYPE_PC)
    {
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_POwner);

    m_Flags = 0;
    std::memset(m_StatusIcons, EFFECT_NONE, sizeof(m_StatusIcons));

    uint8 count = 0;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        uint16 icon = PStatusEffect->GetIcon();

        if (icon != 0)
        {
            if (icon >= 256 && icon < 512)
            {
                m_Flags |= 1LL << (count * 2);
            }
            if (icon >= 512)
            {
                m_Flags |= 1LL << (count * 2 + 1);
            }
            // Note: it may be possible that having both bits set is for effects over 768, but there aren't
            // that many effects as of this writing
            m_StatusIcons[count] = (uint8)icon;

            if (++count == 32)
            {
                break;
            }
        }
    }
    PChar->m_EffectsChanged = true;

    if (PChar->PParty)
    {
        PChar->PParty->EffectsChanged();
    }
}

std::vector<EFFECT> CStatusEffectContainer::GetStatusEffectsInIDRange(EFFECT start, EFFECT end)
{
    std::vector<EFFECT> effectList;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            effectList.emplace_back(PStatusEffect->GetStatusID());
        }
    }
    return effectList;
}

uint8 CStatusEffectContainer::GetStatusEffectCountInIDRange(EFFECT start, EFFECT end)
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

EFFECT CStatusEffectContainer::GetNewestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* newest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!newest || PStatusEffect->GetStartTime() > newest->GetStartTime())
            {
                newest = PStatusEffect;
            }
        }
    }
    if (newest)
    {
        return newest->GetStatusID();
    }
    return EFFECT_NONE;
}

void CStatusEffectContainer::RemoveOldestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* oldest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!oldest || PStatusEffect->GetStartTime() < oldest->GetStartTime())
            {
                oldest = PStatusEffect;
            }
        }
    }
    if (oldest)
    {
        RemoveStatusEffect(oldest, EffectNotice::Silent);
    }
}

void CStatusEffectContainer::RemoveNewestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* newest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!newest || PStatusEffect->GetStartTime() > newest->GetStartTime())
            {
                newest = PStatusEffect;
            }
        }
    }
    if (newest)
    {
        RemoveStatusEffect(newest, EffectNotice::Silent);
    }
}

void CStatusEffectContainer::RemoveAllStatusEffectsInIDRange(EFFECT start, EFFECT end)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end)
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Install the name of the effect to work with scripts                  *
 *                                                                       *
 ************************************************************************/

auto CStatusEffectContainer::SetEffectParams(CStatusEffect* StatusEffect) -> void
{
    if (StatusEffect->GetStatusID() >= MAX_EFFECTID)
    {
        ShowWarning("Status Effect ID (%d) exceeds MAX_EFFECTID", StatusEffect->GetStatusID());
        return;
    }

    auto subType = StatusEffect->GetSubID();

    if (StatusEffect->GetStatusID() == EFFECT_NONE && subType == 0)
    {
        ShowWarning("None-type Effect has SubID of 0");
        return;
    }

    std::string name;
    EFFECT      effect                = StatusEffect->GetStatusID();
    auto        effectSourceType      = StatusEffect->GetSourceType();
    auto        effectSourceTypeParam = StatusEffect->GetSourceTypeParam();

    // check if status effect is special case from a usable equipped item that grants enchantment
    bool effectFromItemEnchant = false;
    bool effectFromItemFood    = false;

    if (effectSourceType != EffectSourceType::SOURCE_NONE && effectSourceTypeParam > 0)
    {
        if (effectSourceType == EffectSourceType::SOURCE_EQUIPPED_ITEM)
        {
            auto PItem = itemutils::GetItemPointer(effectSourceTypeParam);
            if (PItem != nullptr)
            {
                // get the item lua script and check if it has valid functions
                auto itemName     = "items/" + PItem->getName();
                auto itemFullName = fmt::format("./scripts/{}.lua", itemName);
                auto cacheEntry   = luautils::GetCacheEntryFromFilename(itemFullName);
                auto onEffectGain = cacheEntry["onEffectGain"].get<sol::function>();
                auto onEffectLose = cacheEntry["onEffectLose"].get<sol::function>();

                effectFromItemEnchant = onEffectGain.valid() && onEffectLose.valid();

                // if it does have valid functions then set the status effect name as the script (similar to actual status effects)
                if (effectFromItemEnchant)
                {
                    name = itemName;
                }
            }
        }
        else if (effectSourceType == EffectSourceType::SOURCE_FOOD)
        {
            auto PItem = itemutils::GetItemPointer(StatusEffect->GetSourceTypeParam());
            if (PItem != nullptr)
            {
                // get the item lua script and check if it has valid functions
                auto itemName     = "items/" + PItem->getName();
                auto itemFullName = fmt::format("./scripts/{}.lua", itemName);
                auto cacheEntry   = luautils::GetCacheEntryFromFilename(itemFullName);
                auto onEffectGain = cacheEntry["onEffectGain"].get<sol::function>();
                auto onEffectLose = cacheEntry["onEffectLose"].get<sol::function>();

                effectFromItemFood = onEffectGain.valid() && onEffectLose.valid();

                // if it does have valid functions then set the status effect name as the script (similar to actual status effects)
                if (effectFromItemFood)
                {
                    name = itemName;
                }
            }
        }
    }

    // Effects that use /server/scripts/effects/ as their lua file source.
    if (!effectFromItemEnchant &&                                     // The effect is not from an item enchantment (See condition above).
        !effectFromItemFood &&                                        // The effect is not from a usable food item.
        effect != EFFECT_ENCHANTMENT &&                               // The effect is not an enchantment that has an effect source defined currently.
        effectSourceType != EffectSourceType::SOURCE_EQUIPPED_ITEM && // The source is not from an equipped item
        (effect != EFFECT_FOOD ||                                     // Exclude food effects with a sourceTypeParam > 0 (See condition below)
         (effect == EFFECT_FOOD && effectSourceTypeParam == 0)))      // Food effects from FoV/Gov Books have a subType of 0 and are handled in the scripts/effects/food.lua
    {
        name.insert(0, "effects/");
        name.insert(name.size(), effects::EffectsParams[effect].Name);
    }

    // Is an effect from a usable item not caught above.
    // Known use cases: Enchantments without an effect source.
    else
    {
        CItem* Ptem = itemutils::GetItemPointer(subType);
        if (Ptem != nullptr && subType > 0)
        {
            name.insert(0, "items/");
            name.insert(name.size(), Ptem->getName());
        }
    }

    StatusEffect->SetEffectName(name);
    StatusEffect->AddEffectFlag(effects::EffectsParams[effect].Flag);
    StatusEffect->SetEffectType(effects::EffectsParams[effect].Type);
}

/************************************************************************
 *                                                                       *
 *  Load character effects                                               *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::LoadStatusEffects()
{
    if (m_POwner->objtype != TYPE_PC)
    {
        ShowWarning("Non-PC calling function (%s).", m_POwner->getName());
        return;
    }

    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    std::vector<CStatusEffect*> PEffectList;

    const auto rset = db::preparedStmt("SELECT effectid, icon, power, tick, "
                                       "duration, subid, subpower, tier, "
                                       "flags, timestamp, sourcetype, sourcetypeparam, originid "
                                       "FROM char_effects "
                                       "WHERE charid = ?",
                                       m_POwner->id);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto      flags    = rset->get<uint32>("flags");
        timer::duration duration = std::chrono::seconds(rset->get<uint32>("duration"));
        const auto      effectID = rset->get<EFFECT>("effectid");

        if (flags & EFFECTFLAG_OFFLINE_TICK)
        {
            auto currentTime = timer::now();
            auto startTime   = timer::from_utc(earth_time::time_point(std::chrono::seconds(rset->get<uint32>("timestamp"))));
            auto endTime     = startTime + duration;
            if (currentTime < endTime)
            {
                duration = endTime - currentTime;
            }
            else if (effectID == EFFECT::EFFECT_VISITANT)
            {
                // Visitant effect expired while offline, but there's other logic to handle.
                // Set duration to 1 so that it expires after zoning in, and the player is ejected.
                duration = 1s;
            }
            else
            {
                // Effect expired while offline
                continue;
            }
        }
        auto* PStatusEffect =
            new CStatusEffect(effectID,
                              rset->get<uint16>("icon"),
                              rset->get<uint16>("power"),
                              std::chrono::seconds(rset->get<uint16>("tick")),
                              duration,
                              rset->get<uint16>("subid"),
                              rset->get<uint16>("subpower"),
                              rset->get<uint16>("tier"),
                              flags,
                              rset->get<uint16>("sourcetype"),
                              rset->get<uint32>("sourcetypeparam"),
                              rset->get<uint32>("originid"));

        PEffectList.emplace_back(PStatusEffect);

        // load shadows left
        if (PStatusEffect->GetStatusID() == EFFECT_COPY_IMAGE)
        {
            m_POwner->setModifier(Mod::UTSUSEMI, PStatusEffect->GetSubPower());
        }
        else if (PStatusEffect->GetStatusID() == EFFECT_BLINK)
        {
            m_POwner->setModifier(Mod::BLINK, PStatusEffect->GetPower());
        }
    }

    for (auto&& PStatusEffect : PEffectList)
    {
        AddStatusEffect(PStatusEffect);
    }

    m_POwner->UpdateHealth(); // after loading the effects, recalculate the maximum amount of HP/MP
}

/************************************************************************
 *                                                                       *
 *  Save temporary character effects                                     *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::SaveStatusEffects(bool logout)
{
    // Print entity name and bail out if entity isn't a player.
    if (m_POwner->objtype != TYPE_PC)
    {
        ShowDebug("Non-player entity %s (ID: %d) attempt to save Status Effect.", m_POwner->getName(), m_POwner->id);

        return;
    }

    db::preparedStmt("DELETE FROM char_effects WHERE charid = ?", m_POwner->id);

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((logout && PStatusEffect->HasEffectFlag(EFFECTFLAG_LOGOUT)) || (!logout && PStatusEffect->HasEffectFlag(EFFECTFLAG_ON_ZONE)))
        {
            RemoveStatusEffect(PStatusEffect, EffectNotice::Silent);
            continue;
        }

        if (PStatusEffect->deleted)
        {
            continue;
        }

        const auto durationSeconds     = timer::count_seconds(PStatusEffect->GetDuration());
        const auto realDurationSeconds = timer::count_seconds(PStatusEffect->GetStartTime() + PStatusEffect->GetDuration() - timer::now());

        if (realDurationSeconds > 0 || durationSeconds == 0)
        {
            // save power of utsusemi and blink
            if (PStatusEffect->GetStatusID() == EFFECT_COPY_IMAGE)
            {
                PStatusEffect->SetSubPower(m_POwner->getMod(Mod::UTSUSEMI));
            }
            else if (PStatusEffect->GetStatusID() == EFFECT_BLINK)
            {
                PStatusEffect->SetPower(m_POwner->getMod(Mod::BLINK));
            }
            else if (PStatusEffect->GetStatusID() == EFFECT_STONESKIN)
            {
                PStatusEffect->SetPower(m_POwner->getMod(Mod::STONESKIN));
            }

            uint32 duration = 0;

            if (durationSeconds > 0)
            {
                if (PStatusEffect->HasEffectFlag(EFFECTFLAG_OFFLINE_TICK))
                {
                    duration = static_cast<uint32>(durationSeconds);
                }
                else
                {
                    if (realDurationSeconds > 0)
                    {
                        duration = static_cast<uint32>(realDurationSeconds);
                    }
                    else
                    {
                        continue;
                    }
                }
            }

            uint32 tick      = static_cast<uint32>(timer::count_seconds(PStatusEffect->GetTickTime()));
            auto   timestamp = earth_time::timestamp(timer::to_utc(PStatusEffect->GetStartTime()));

            db::preparedStmt("INSERT INTO char_effects (charid, effectid, icon, power, tick, duration, subid, subpower, tier, flags, timestamp, sourcetype, sourcetypeparam, originid) "
                             "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                             m_POwner->id,
                             PStatusEffect->GetStatusID(),
                             PStatusEffect->GetIcon(),
                             PStatusEffect->GetPower(),
                             tick,
                             duration,
                             PStatusEffect->GetSubID(),
                             PStatusEffect->GetSubPower(),
                             PStatusEffect->GetTier(),
                             PStatusEffect->GetEffectFlags(),
                             timestamp,
                             PStatusEffect->GetSourceType(),
                             PStatusEffect->GetSourceTypeParam(),
                             PStatusEffect->GetOriginID());
        }
    }
    DeleteStatusEffects();
}

/************************************************************************
 *                                                                       *
 *  Expires status effects                                               *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::CheckEffectsExpiry(timer::time_point tick)
{
    if (m_POwner == nullptr)
    {
        ShowWarning("m_POwner was null.");
        return;
    }

    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetDuration() != 0s && PStatusEffect->GetStartTime() + PStatusEffect->GetDuration() <= tick)
        {
            RemoveStatusEffect(PStatusEffect);
        }
    }
    DeleteStatusEffects();
}

void CStatusEffectContainer::HandleAura(CStatusEffect* PStatusEffect)
{
    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    CBattleEntity* PEntity    = m_POwner;
    AURA_TARGET    auraTarget = static_cast<AURA_TARGET>(PStatusEffect->GetTier());

    if (PEntity->objtype == TYPE_PET || PEntity->objtype == TYPE_TRUST)
    {
        PEntity = PEntity->PMaster;
    }

    float aura_range = 6.25 + (PEntity->getMod(Mod::AURA_SIZE) / 100); // Adding to this mod should be the value you want * 100

    if (PEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(PEntity);
        if (auraTarget == AURA_TARGET::ALLIES)
        {
            // clang-format off
            PChar->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (PMember != nullptr &&
                    m_POwner->loc.zone &&
                    PMember->loc.zone &&
                    m_POwner->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                    distance(m_POwner->loc.p, PMember->loc.p) <= aura_range &&
                    !PMember->isDead())
                {
                    CStatusEffect* PEffect = PMember->StatusEffectContainer->GetStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()));

                    if (PEffect && (PEffect->GetEffectFlags() & EFFECTFLAG_ALWAYS_EXPIRING) != 0)
                    {
                        PEffect->SetStartTime(timer::now());

                        // Effect updated, probably from Ecliptic Attrition
                        // Update status effect with new potency.
                        // Take care to design your "owning" effects such as the EFFECT::EFFECT_COLURE_ACTIVE to control the subpower, rather than the resulting effect ticking down.
                        // Otherwise odd things may happen
                        if (PEffect->GetPower() != PStatusEffect->GetSubPower())
                        {
                            luautils::OnEffectLose(PMember, PEffect);
                            PEffect->SetPower(PStatusEffect->GetSubPower());
                            luautils::OnEffectGain(PMember, PEffect);
                        }
                    }
                    else
                    {
                        PEffect = new CStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()), // Effect ID
                                                    PStatusEffect->GetSubID(),                      // Effect Icon (Associated with ID)
                                                    PStatusEffect->GetSubPower(),                   // Power
                                                    3s,                                              // Tick
                                                    4s);                                             // Duration
                        PEffect->AddEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                        PEffect->AddEffectFlag(EFFECTFLAG_ALWAYS_EXPIRING);
                        PMember->StatusEffectContainer->AddStatusEffect(PEffect, EffectNotice::Silent);
                    }
                }
            });
            // clang-format on
        }
        else if (auraTarget == AURA_TARGET::ENEMIES)
        {
            for (CBattleEntity* PTarget : *PEntity->PNotorietyContainer)
            { // Check for trust here so negitive effects wont affect trust
                if (PTarget != nullptr &&
                    PTarget->loc.zone &&
                    PEntity->loc.zone &&
                    PTarget->objtype != TYPE_TRUST && PEntity->loc.zone->GetID() == PTarget->loc.zone->GetID() && distance(m_POwner->loc.p, PTarget->loc.p) <= aura_range &&
                    !PTarget->isDead())
                {
                    CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()));

                    if (PEffect && (PEffect->GetEffectFlags() & EFFECTFLAG_ALWAYS_EXPIRING) != 0)
                    {
                        PEffect->SetStartTime(timer::now());

                        // Effect updated, probably from Ecliptic Attrition
                        // Update status effect with new potency.
                        // Take care to design your "owning" effects such as the EFFECT::EFFECT_COLURE_ACTIVE to control the subpower, rather than the resulting effect ticking down.
                        // Otherwise odd things may happen
                        if (PEffect->GetPower() != PStatusEffect->GetSubPower())
                        {
                            luautils::OnEffectLose(PTarget, PEffect);
                            PEffect->SetPower(PStatusEffect->GetSubPower());
                            luautils::OnEffectGain(PTarget, PEffect);
                        }
                    }
                    else
                    {
                        PEffect = new CStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()), // Effect ID
                                                    PStatusEffect->GetSubID(),                      // Effect Icon (Associated with ID)
                                                    PStatusEffect->GetSubPower(),                   // Power
                                                    3s,                                             // Tick
                                                    4s);                                            // Duration
                        PEffect->AddEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                        PEffect->AddEffectFlag(EFFECTFLAG_ALWAYS_EXPIRING);
                        PTarget->StatusEffectContainer->AddStatusEffect(PEffect, EffectNotice::Silent);
                    }
                }
            }
        }
    }
    else if (PEntity->objtype == TYPE_MOB)
    {
        if (auraTarget == AURA_TARGET::ALLIES)
        {
            // clang-format off
            PEntity->ForParty([&](CBattleEntity* PMember)
            {
                if (PMember != nullptr &&
                    m_POwner->loc.zone &&
                    PMember->loc.zone &&
                    PEntity->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(m_POwner->loc.p, PMember->loc.p) <= aura_range &&
                    !PMember->isDead())
                {
                    CStatusEffect* PEffect = PMember->StatusEffectContainer->GetStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()));

                    if (PEffect && (PEffect->GetEffectFlags() & EFFECTFLAG_ALWAYS_EXPIRING) != 0)
                    {
                        PEffect->SetStartTime(timer::now());

                        // Effect updated, probably from Ecliptic Attrition
                        // Update status effect with new potency.
                        // Take care to design your "owning" effects such as the EFFECT::EFFECT_COLURE_ACTIVE to control the subpower, rather than the resulting effect ticking down.
                        // Otherwise odd things may happen
                        if (PEffect->GetPower() != PStatusEffect->GetSubPower())
                        {
                            luautils::OnEffectLose(PMember, PEffect);
                            PEffect->SetPower(PStatusEffect->GetSubPower());
                            luautils::OnEffectGain(PMember, PEffect);
                        }
                    }
                    else
                    {
                        PEffect = new CStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()), // Effect ID
                                                    PStatusEffect->GetSubID(),                      // Effect Icon (Associated with ID)
                                                    PStatusEffect->GetSubPower(),                   // Power
                                                    3s,                                              // Tick
                                                    4s);                                             // Duration
                        PEffect->AddEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                        PEffect->AddEffectFlag(EFFECTFLAG_ALWAYS_EXPIRING);
                        PMember->StatusEffectContainer->AddStatusEffect(PEffect, EffectNotice::Silent);
                    }
                }
            });
            // clang-format on
        }
        else if (auraTarget == AURA_TARGET::ENEMIES)
        {
            auto* PMob       = static_cast<CMobEntity*>(PEntity);
            auto* enmityList = PMob->PEnmityContainer->GetEnmityList();
            for (auto& enmityPair : *enmityList)
            {
                auto* PTarget = enmityPair.second.PEnmityOwner;
                if (PTarget != nullptr &&
                    PTarget->loc.zone &&
                    PEntity->loc.zone &&
                    PEntity->loc.zone->GetID() == PTarget->loc.zone->GetID() && distance(m_POwner->loc.p, PTarget->loc.p) <= aura_range &&
                    !PTarget->isDead())
                {
                    CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()));

                    if (PEffect && (PEffect->GetEffectFlags() & EFFECTFLAG_ALWAYS_EXPIRING) != 0)
                    {
                        PEffect->SetStartTime(timer::now());

                        // Effect updated, probably from Ecliptic Attrition
                        // Update status effect with new potency.
                        // Take care to design your "owning" effects such as the EFFECT::EFFECT_COLURE_ACTIVE to control the subpower, rather than the resulting effect ticking down.
                        // Otherwise odd things may happen
                        if (PEffect->GetPower() != PStatusEffect->GetSubPower())
                        {
                            luautils::OnEffectLose(PTarget, PEffect);
                            PEffect->SetPower(PStatusEffect->GetSubPower());
                            luautils::OnEffectGain(PTarget, PEffect);
                        }
                    }
                    else
                    {
                        PEffect = new CStatusEffect(static_cast<EFFECT>(PStatusEffect->GetSubID()), // Effect ID
                                                    PStatusEffect->GetSubID(),                      // Effect Icon (Associated with ID)
                                                    PStatusEffect->GetSubPower(),                   // Power
                                                    3s,                                             // Tick
                                                    4s);                                            // Duration
                        PEffect->AddEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                        PEffect->AddEffectFlag(EFFECTFLAG_ALWAYS_EXPIRING);
                        PTarget->StatusEffectContainer->AddStatusEffect(PEffect, EffectNotice::Silent);
                    }
                }
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Run OnEffectTick for all status effects                              *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::TickEffects(timer::time_point tick)
{
    if (m_POwner == nullptr)
    {
        ShowWarning("CStatusEffectContainer::TickRegen() - m_POwner is null.");
        return;
    }

    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    if (!m_POwner->isDead())
    {
        for (const auto& PStatusEffect : m_StatusEffectSet)
        {
            if (PStatusEffect->GetTickTime() != 0s &&
                PStatusEffect->GetElapsedTickCount() < (tick - PStatusEffect->GetStartTime()) / PStatusEffect->GetTickTime())
            {
                if (PStatusEffect->HasEffectFlag(EFFECTFLAG_AURA))
                {
                    HandleAura(PStatusEffect);
                }
                PStatusEffect->IncrementElapsedTickCount();
                luautils::OnEffectTick(m_POwner, PStatusEffect);
            }
        }
    }
    DeleteStatusEffects();
    m_POwner->PAI->EventHandler.triggerListener("EFFECTS_TICK", m_POwner);
}

/************************************************************************
 *                                                                       *
 *  Tick regen/refresh/regain effects                                    *
 *                                                                       *
 ************************************************************************/

void CStatusEffectContainer::TickRegen(timer::time_point tick)
{
    if (m_POwner == nullptr)
    {
        ShowWarning("CStatusEffectContainer::TickRegen() - m_POwner is null.");
        return;
    }

    TracyZoneScoped;
    TracyZoneString(m_POwner->getName());

    if (!m_POwner->isDead())
    {
        CCharEntity* PChar = nullptr;
        if (m_POwner->objtype == TYPE_PC)
        {
            PChar = (CCharEntity*)m_POwner;
        }

        int16 regen   = m_POwner->getMod(Mod::REGEN);
        int16 poison  = m_POwner->getMod(Mod::REGEN_DOWN);
        int16 refresh = m_POwner->getMod(Mod::REFRESH) - m_POwner->getMod(Mod::REFRESH_DOWN);
        int16 regain  = m_POwner->getMod(Mod::REGAIN) - m_POwner->getMod(Mod::REGAIN_DOWN);
        m_POwner->addHP(regen);

        if (poison)
        {
            int16 damage = battleutils::HandleStoneskin(m_POwner, poison);

            if (damage > 0)
            {
                DelStatusEffectSilent(EFFECT_HEALING);
                m_POwner->takeDamage(damage);

                // If target has nightmare sleep. Don't break sleep from REGEN_DOWN damage
                // see mobskills/nightmare.lua for full explanation
                if (
                    !(
                        m_POwner->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP) &&
                        m_POwner->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP)->GetTier() >= 4)) // Tier 4 = Player Avatar Nightmare
                {
                    WakeUp();
                }
            }
        }

        if (m_POwner->getMod(Mod::AVATAR_PERPETUATION) > 0 && (m_POwner->objtype == TYPE_PC))
        {
            int16 perpetuation = m_POwner->getMod(Mod::AVATAR_PERPETUATION);

            if (m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_ASTRAL_FLOW))
            {
                perpetuation = 0;
            }
            else
            {
                if (m_POwner->PPet != nullptr && PChar != nullptr)
                {
                    if (m_POwner->PPet->objtype == TYPE_PET)
                    {
                        CPetEntity* PPet  = (CPetEntity*)m_POwner->PPet;
                        CItem*      hands = PChar->getEquip(SLOT_HANDS);

                        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AVATARS_FAVOR) &&
                            ((PPet->m_PetID >= PETID_CARBUNCLE && PPet->m_PetID <= PETID_CAIT_SITH) || PPet->m_PetID == PETID_SIREN))
                        {
                            perpetuation = static_cast<int16>(perpetuation * 1.2);
                        }

                        // carbuncle mitts only work on carbuncle
                        if (hands && hands->getID() == 14062 && PPet->m_PetID == PETID_CARBUNCLE)
                        {
                            perpetuation /= 2;
                        }
                    }

                    perpetuation -= charutils::AvatarPerpetuationReduction(PChar);

                    if (perpetuation < 1)
                    {
                        perpetuation = 1;
                    }
                }
            }

            m_POwner->addMP(refresh - perpetuation);

            if (m_POwner->health.mp == 0 && m_POwner->PPet != nullptr && m_POwner->PPet->objtype == TYPE_PET)
            {
                CPetEntity* PPet = (CPetEntity*)m_POwner->PPet;
                if (PPet->getPetType() == PET_TYPE::AVATAR)
                {
                    petutils::DespawnPet(m_POwner);
                }
            }
        }
        else
        {
            m_POwner->addMP(refresh);
        }

        if (m_POwner->objtype != TYPE_MOB || m_POwner->PAI->IsEngaged())
        {
            m_POwner->addTP(regain);
        }

        if (m_POwner->PPet)
        {
            if (auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(m_POwner->PPet))
            {
                PAutomaton->burdenTick();
            }
        }
    }
}

bool CStatusEffectContainer::HasPreventActionEffect(bool ignoreCharm)
{
    if (ignoreCharm)
    {
        return HasStatusEffect(
            { EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_PETRIFICATION, EFFECT_LULLABY, EFFECT_PENALTY, EFFECT_STUN, EFFECT_TERROR });
    }
    return HasStatusEffect(
        { EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_PETRIFICATION, EFFECT_LULLABY, EFFECT_CHARM, EFFECT_CHARM_II, EFFECT_PENALTY, EFFECT_STUN, EFFECT_TERROR });
}

uint16 CStatusEffectContainer::GetConfrontationEffect()
{
    for (auto* PEffect : m_StatusEffectSet)
    {
        if (PEffect->HasEffectFlag(EFFECTFLAG_CONFRONTATION))
        {
            return PEffect->GetPower();
        }
    }
    return 0;
}

void CStatusEffectContainer::CopyConfrontationEffect(CBattleEntity* PEntity)
{
    for (auto* PEffect : m_StatusEffectSet)
    {
        if (PEffect->HasEffectFlag(EFFECTFLAG_CONFRONTATION))
        {
            PEntity->StatusEffectContainer->AddStatusEffect(new CStatusEffect(*PEffect));
        }
    }
}

bool CStatusEffectContainer::CheckForElevenRoll()
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL && PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL &&
             PStatusEffect->GetSubPower() == 11) ||
            (PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL && PStatusEffect->GetSubPower() == 11))
        {
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::IsAsleep()
{
    return HasStatusEffect({ EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_LULLABY });
}

void CStatusEffectContainer::WakeUp()
{
    DelStatusEffect(EFFECT_SLEEP);
    DelStatusEffect(EFFECT_SLEEP_II);
    DelStatusEffect(EFFECT_LULLABY);
}

bool CStatusEffectContainer::HasBustEffect(uint16 id)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == EFFECT_BUST && PStatusEffect->GetSubPower() == id)
        {
            return true;
        }
    }
    return false;
}
