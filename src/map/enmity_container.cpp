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

#include "common/logging.h"
#include "common/utils.h"

#include "ai/ai_container.h"
#include "alliance.h"
#include "enmity_container.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "notoriety_container.h"
#include "packets/entity_update.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/zoneutils.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CEnmityContainer::CEnmityContainer(CMobEntity* holder)
: EnmityCap{ settings::get<int32>("map.ENMITY_CAP") }
, m_EnmityHolder(holder)
{
}

CEnmityContainer::~CEnmityContainer()
{
    Clear();
}

/************************************************************************
 *                                                                       *
 *  Clear Enmity List                                                    *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::Clear(uint32 EntityID)
{
    TracyZoneScoped;
    if (EntityID == 0)
    {
        // Iterate over all all entries and remove the relevant entry from their notoriety list
        for (const auto& listEntry : m_EnmityList)
        {
            if (const auto& maybeEntityObj = m_EnmityList.find(listEntry.first); maybeEntityObj != m_EnmityList.end())
            {
                auto entry = maybeEntityObj->second;
                if (entry.PEnmityOwner && m_EnmityHolder)
                {
                    entry.PEnmityOwner->PNotorietyContainer->remove(m_EnmityHolder);
                }
            }
        }
        m_EnmityList.clear();
        return;
    }
    else
    {
        if (const auto& maybeEntityObj = m_EnmityList.find(EntityID); maybeEntityObj != m_EnmityList.end())
        {
            auto entry = maybeEntityObj->second;
            if (entry.PEnmityOwner && m_EnmityHolder)
            {
                entry.PEnmityOwner->PNotorietyContainer->remove(m_EnmityHolder);
            }
        }
        m_EnmityList.erase(EntityID);
    }
    m_tameable = true;
}

void CEnmityContainer::LogoutReset(uint32 EntityID)
{
    if (const auto& enmity_obj = m_EnmityList.find(EntityID); enmity_obj != m_EnmityList.end())
    {
        enmity_obj->second.PEnmityOwner = nullptr;
        enmity_obj->second.active       = false;
    }
}

/************************************************************************
 *                                                                       *
 *  Minimum (base) hate value                                            *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::AddBaseEnmity(CBattleEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->getZone() != m_EnmityHolder->getZone())
    {
        return;
    }
    m_EnmityList.emplace(PChar->id, EnmityObject_t{ PChar, 0, 0, false });
    PChar->PNotorietyContainer->add(m_EnmityHolder);
}

/************************************************************************
 *                                                                       *
 *  Calculate Enmity Bonus
 *                                                                       *
 ************************************************************************/

float CEnmityContainer::CalculateEnmityBonus(CBattleEntity* PEntity)
{
    TracyZoneScoped;
    int enmityBonus = PEntity->getMod(Mod::ENMITY);

    if (auto* PChar = dynamic_cast<CCharEntity*>(PEntity))
    {
        enmityBonus += PChar->PMeritPoints->GetMeritValue(MERIT_ENMITY_INCREASE, PChar) - PChar->PMeritPoints->GetMeritValue(MERIT_ENMITY_DECREASE, PChar);

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SOULEATER))
        {
            enmityBonus -= PChar->PMeritPoints->GetMeritValue(MERIT_MUTED_SOUL, PChar);
        }
    }

    float bonus = (100.f + std::clamp(enmityBonus, -50, 100)) / 100.f;

    return bonus;
}

/************************************************************************
 *                                                                       *
 *  Add entity to hate list                                              *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::UpdateEnmity(CBattleEntity* PEntity, int32 CE, int32 VE, bool withMaster, bool tameable, bool directAction)
{
    TracyZoneScoped;

    if (m_EnmityHolder->objtype != ENTITYTYPE::TYPE_MOB) // pets and trusts dont have enmity.
    {
        return;
    }

    // you're too far away so i'm ignoring you
    if (!IsWithinEnmityRange(PEntity))
    {
        CE = 0;
        VE = 0;
    }

    // Apply TH only if this was a direct action
    if (directAction && PEntity->getMod(Mod::TREASURE_HUNTER) > m_EnmityHolder->m_THLvl)
    {
        m_EnmityHolder->m_THLvl = PEntity->getMod(Mod::TREASURE_HUNTER);
    }

    auto enmity_obj = m_EnmityList.find(PEntity->id);

    if (enmity_obj != m_EnmityList.end())
    {
        if (enmity_obj->second.PEnmityOwner == nullptr)
        {
            enmity_obj->second.PEnmityOwner = PEntity;
        }
        float bonus = CalculateEnmityBonus(PEntity);

        int32 newCE = (int32)(enmity_obj->second.CE + (CE > 0 ? CE * bonus : CE));
        int32 newVE = (int32)(enmity_obj->second.VE + (VE > 0 ? VE * bonus : VE));

        // Check for cap limit
        enmity_obj->second.CE     = std::clamp(newCE, 0, EnmityCap);
        enmity_obj->second.VE     = std::clamp(newVE, 0, EnmityCap);
        enmity_obj->second.active = true;
    }
    else if (CE >= 0 && VE >= 0)
    {
        bool initial = true;
        for (auto&& enmityObject : m_EnmityList)
        {
            if (enmityObject.second.active)
            {
                initial = false;
                break;
            }
        }

        if (initial)
        {
            CE += 200;
        }

        float bonus = CalculateEnmityBonus(PEntity);

        CE = std::clamp((int32)(CE * bonus), 0, EnmityCap);
        VE = std::clamp((int32)(VE * bonus), 0, EnmityCap);

        m_EnmityList.emplace(PEntity->id, EnmityObject_t{ PEntity, CE, VE, true });
        PEntity->PNotorietyContainer->add(m_EnmityHolder);

        if (withMaster && PEntity->PMaster != nullptr)
        {
            // add master to the enmity list (pet and charmed mob)
            if (PEntity->objtype == TYPE_PET || (PEntity->objtype == TYPE_MOB && PEntity->PMaster != nullptr && PEntity->PMaster->objtype == TYPE_PC))
            {
                AddBaseEnmity(PEntity->PMaster);
            }
        }
    }

    if (!tameable)
    {
        m_tameable = false;
    }
}

bool CEnmityContainer::HasID(uint32 TargetID)
{
    // clang-format off
    auto maybeID = std::find_if(m_EnmityList.begin(), m_EnmityList.end(), [TargetID](auto elem)
    {
        return elem.first == TargetID && elem.second.active;
    });
    // clang-format on

    return maybeID != m_EnmityList.end();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::UpdateEnmityFromCure(CBattleEntity* PEntity, uint8 level, int32 CureAmount, bool isCureV)
{
    TracyZoneScoped;
    if (!IsWithinEnmityRange(PEntity))
    {
        return;
    }

    int32 CE                     = 0;
    int32 VE                     = 0;
    float bonus                  = CalculateEnmityBonus(PEntity);
    float tranquilHeartReduction = 1.f - battleutils::HandleTranquilHeart(PEntity);

    if (isCureV)
    {
        CE = (int32)(300.f * bonus * tranquilHeartReduction);
        VE = (int32)(600.f * bonus * tranquilHeartReduction);
    }
    else
    {
        CureAmount = (CureAmount < 1 ? 1 : CureAmount);

        CE = (int32)(40.f / battleutils::GetEnmityModCure(level) * CureAmount * bonus * tranquilHeartReduction);
        VE = (int32)(240.f / battleutils::GetEnmityModCure(level) * CureAmount * bonus * tranquilHeartReduction);
    }

    auto enmity_obj = m_EnmityList.find(PEntity->id);

    if (enmity_obj != m_EnmityList.end())
    {
        enmity_obj->second.CE     = std::clamp(enmity_obj->second.CE + CE, 0, EnmityCap);
        enmity_obj->second.VE     = std::clamp(enmity_obj->second.VE + VE, 0, EnmityCap);
        enmity_obj->second.active = true;
    }
    else
    {
        m_EnmityList.emplace(PEntity->id, EnmityObject_t{ PEntity, std::clamp(CE, 0, EnmityCap), std::clamp(VE, 0, EnmityCap), true });
        PEntity->PNotorietyContainer->add(m_EnmityHolder);
    }
}

/************************************************************************
 *                                                                       *
 *    Lower enmity by percent %                                          *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::LowerEnmityByPercent(CBattleEntity* PEntity, uint8 percent, CBattleEntity* HateReceiver)
{
    TracyZoneScoped;
    auto enmity_obj = m_EnmityList.find(PEntity->id);

    if (enmity_obj != m_EnmityList.end())
    {
        float mod = ((float)(percent) / 100.0f);

        auto CEValue = (int16)(enmity_obj->second.CE * mod);
        enmity_obj->second.CE -= (CEValue < 0 ? 0 : CEValue);

        auto VEValue = (int16)(enmity_obj->second.VE * mod);
        enmity_obj->second.VE -= (VEValue < 0 ? 0 : VEValue);

        // transfer hate if HateReceiver not nullptr
        if (HateReceiver != nullptr)
        {
            UpdateEnmity(HateReceiver, CEValue, VEValue);
        }
    }
}

/************************************************************************
 *                                                                       *
 *    Returns the CE or VE for the current entity                        *
 *                                                                       *
 ************************************************************************/

int32 CEnmityContainer::GetCE(CBattleEntity* PEntity) const
{
    auto PEnmity = m_EnmityList.find(PEntity->id);
    return PEnmity != m_EnmityList.end() ? PEnmity->second.CE : 0;
}

int32 CEnmityContainer::GetVE(CBattleEntity* PEntity) const
{
    auto PEnmity = m_EnmityList.find(PEntity->id);
    return PEnmity != m_EnmityList.end() ? PEnmity->second.VE : 0;
}

/************************************************************************
 *                                                                       *
 *    Sets the CE or VE for the current entity                           *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::SetCE(CBattleEntity* PEntity, const int32 amount)
{
    auto PEnmity = m_EnmityList.find(PEntity->id);
    if (PEnmity != m_EnmityList.end())
    {
        PEnmity->second.CE = std::min(amount, EnmityCap);
    }
    else
    {
        AddBaseEnmity(PEntity);
        SetCE(PEntity, amount);
    }
}

void CEnmityContainer::SetVE(CBattleEntity* PEntity, const int32 amount)
{
    auto PEnmity = m_EnmityList.find(PEntity->id);
    if (PEnmity != m_EnmityList.end())
    {
        PEnmity->second.VE = std::min(amount, EnmityCap);
    }
    else
    {
        AddBaseEnmity(PEntity);
        SetVE(PEntity, amount);
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::UpdateEnmityFromDamage(CBattleEntity* PEntity, int32 Damage)
{
    TracyZoneScoped;
    Damage          = (Damage < 1 ? 1 : Damage);
    int16 damageMod = battleutils::GetEnmityModDamage(m_EnmityHolder->GetMLevel());

    int32 CE = (int32)(80.f / damageMod * Damage);
    int32 VE = (int32)(240.f / damageMod * Damage);

    UpdateEnmity(PEntity, CE, VE);

    if (m_EnmityHolder && m_EnmityHolder->m_HiPCLvl < PEntity->GetMLevel())
    {
        m_EnmityHolder->m_HiPCLvl = PEntity->GetMLevel();
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CEnmityContainer::UpdateEnmityFromAttack(CBattleEntity* PEntity, int32 Damage)
{
    TracyZoneScoped;
    if (auto enmity_obj = m_EnmityList.find(PEntity->id); enmity_obj != m_EnmityList.end())
    {
        float reduction = (100.f - std::min<int16>(PEntity->getMod(Mod::ENMITY_LOSS_REDUCTION), 100)) / 100.f;
        int32 CE        = (int32)(-1800.f * Damage / PEntity->GetMaxHP() * reduction);

        enmity_obj->second.CE = std::clamp(enmity_obj->second.CE + CE, 0, EnmityCap);
    }
}

/************************************************************************
 *                                                                       *
 *  Decay Enmity, Get Entity with the highest enmity                     *
 *                                                                       *
 ************************************************************************/

CBattleEntity* CEnmityContainer::GetHighestEnmity()
{
    TracyZoneScoped;
    if (m_EnmityList.empty())
    {
        return nullptr;
    }
    uint32 HighestEnmity = 0;
    auto   highest       = m_EnmityList.end();
    bool   active        = false;

    for (auto it = m_EnmityList.begin(); it != m_EnmityList.end(); ++it)
    {
        const EnmityObject_t& PEnmityObject = it->second;
        uint32                Enmity        = PEnmityObject.CE + PEnmityObject.VE;

        if (Enmity >= HighestEnmity && ((PEnmityObject.active == active) || (PEnmityObject.active && !active)))
        {
            auto* POwner = PEnmityObject.PEnmityOwner;
            if (!POwner || (POwner->allegiance != m_EnmityHolder->allegiance))
            {
                active        = PEnmityObject.active;
                HighestEnmity = Enmity;
                highest       = it;
            }
        }
    }
    CBattleEntity* PEntity = nullptr;
    if (highest != m_EnmityList.end())
    {
        PEntity = highest->second.PEnmityOwner;
        if (!PEntity)
        {
            PEntity = zoneutils::GetChar(highest->first);
        }

        if (!PEntity || PEntity->getZone() != m_EnmityHolder->getZone() || PEntity->PInstance != m_EnmityHolder->PInstance)
        {
            m_EnmityList.erase(highest);
            PEntity = GetHighestEnmity();
        }
    }
    return PEntity;
}

void CEnmityContainer::DecayEnmity()
{
    for (auto& it : m_EnmityList)
    {
        EnmityObject_t& PEnmityObject = it.second;
        constexpr int   decay_amount  = (int)(60 / server_tick_rate);

        PEnmityObject.VE -= PEnmityObject.VE > decay_amount ? decay_amount : PEnmityObject.VE;
    }
}

bool CEnmityContainer::IsWithinEnmityRange(CBattleEntity* PEntity) const
{
    if (PEntity->getZone() != m_EnmityHolder->getZone())
    {
        return false;
    }
    float maxRange = square(m_EnmityHolder->m_Type == MOBTYPE_NOTORIOUS ? 28.f : 25.f);
    return distanceSquared(m_EnmityHolder->loc.p, PEntity->loc.p) <= maxRange;
}

EnmityList_t* CEnmityContainer::GetEnmityList()
{
    return &m_EnmityList;
}

bool CEnmityContainer::IsTameable() const
{
    return m_tameable;
}

void CEnmityContainer::UpdateEnmityFromCover(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser)
{
    TracyZoneScoped;
    // Update Enmity if cover ability target and cover ability user are not nullptr
    if (PCoverAbilityTarget != nullptr && PCoverAbilityUser != nullptr)
    {
        int32 currentCE = GetCE(PCoverAbilityUser);
        SetCE(PCoverAbilityUser, currentCE + 200);
        LowerEnmityByPercent(PCoverAbilityTarget, 10, nullptr);
    }
}
