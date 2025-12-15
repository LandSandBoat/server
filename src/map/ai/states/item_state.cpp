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

#include "item_state.h"

#include "ai/ai_container.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"

#include "action/action.h"
#include "action/interrupts.h"
#include "enums/item_lockflg.h"
#include "item_container.h"
#include "status_effect_container.h"
#include "universal_container.h"

#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x028_battle2.h"
#include "packets/s2c/0x029_battle_message.h"

#include "utils/battleutils.h"
#include "utils/charutils.h"

CItemState::CItemState(CCharEntity* PEntity, const uint16 targid, const uint8 loc, const uint8 slotid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
, m_PItem(nullptr)
, m_location(loc)
, m_slot(slotid)
{
    auto* PItem = dynamic_cast<CItemUsable*>(m_PEntity->getStorage(loc)->GetItem(slotid));
    m_PItem     = PItem;

    if (m_PItem && m_PItem->isType(ITEM_USABLE))
    {
        if (m_PItem->isType(ITEM_EQUIPMENT))
        {
            // check if this item is equipped
            bool found = false;
            for (auto equipslot = 0; equipslot < 18; ++equipslot)
            {
                if (m_PEntity->getEquip(static_cast<SLOTTYPE>(equipslot)) == m_PItem &&
                    m_PItem->getCurrentCharges() > 0 &&
                    m_PItem->getReuseTime() == 0s)
                {
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                m_PItem = nullptr;
            }
        }
        else if (m_PItem->isSubType(ITEM_LOCKED))
        {
            m_PItem = nullptr;
        }
    }

    if (!m_PItem)
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, 0, 0, MsgBasic::UNABLE_TO_USE_ITEM));
    }

    UpdateTarget(PEntity->IsValidTarget(targid, m_PItem->getValidTarget(), m_errorMsg));
    auto* PTarget = GetTarget();

    if (!PTarget || this->HasErrorMsg())
    {
        if (this->HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }

    auto [error, param, value] = luautils::OnItemCheck(PTarget, m_PItem, ITEMCHECK::NONE, m_PEntity);
    if (error || m_PEntity->StatusEffectContainer->HasPreventActionEffect())
    {
        if (error == -1)
        {
            throw CStateInitException(nullptr);
        }
        else
        {
            if (value == 0)
            {
                param = m_PItem->getFlag() & ITEM_FLAG_SCROLL ? m_PItem->getSubID() : m_PItem->getID();
            }
            throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget ? PTarget : m_PEntity, param, value, static_cast<MsgBasic>(error)));
        }
    }

    m_PEntity->UContainer->SetType(UCONTAINER_USEITEM);
    m_PEntity->UContainer->SetItem(0, m_PItem);

    m_startPos      = m_PEntity->loc.p;
    m_castTime      = m_PItem->getActivationTime();
    m_animationTime = m_PItem->getAnimationTime();

    action_t action{
        .actorId    = m_PEntity->id,
        .actiontype = ActionCategory::ItemStart,
        .actionid   = static_cast<uint32_t>(FourCC::ItemUse),
        .targets    = {
            {
                   .actorId = PTarget->id,
                   .results = {
                    {
                           .param     = m_PItem->getID(),
                           .messageID = MsgBasic::ITEM_USE,
                    },
                },
            },
        },
    };

    m_PEntity->PAI->EventHandler.triggerListener("ITEM_START", PTarget, m_PItem, &action);
    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));

    m_PItem->setSubType(ITEM_LOCKED);

    m_PEntity->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(m_PItem, ItemLockFlg::NoSelect);
    m_PEntity->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
}

void CItemState::UpdateTarget(CBaseEntity* target)
{
    if (target != nullptr)
    {
        UpdateTarget(target->targid);
    }
}

void CItemState::UpdateTarget(const uint16 targid)
{
    CState::UpdateTarget(targid);
    CState::SetTarget(targid);

    // Special case for Soultrapper usage:
    // Valid to use on mobs that are:
    //     - unclaimed
    //     - claimed by you
    //     - claimed by someone else
    // This is handled this way to avoid bringing in a new very specialized targetting flag
    // just for soultrapping.
    if (m_PItem->isSoultrapper())
    {
        // Reset possible "already claimed" error from previous lookup
        m_errorMsg.reset();

        // Call CBattleEntity's simpler IsValidTarget()
        CState::UpdateTarget(m_PEntity->CBattleEntity::IsValidTarget(m_targid, m_PItem->getValidTarget(), m_errorMsg));
    }
}

auto CItemState::Update(const timer::time_point tick) -> bool
{
    if (tick > GetEntryTime() + m_castTime && !IsCompleted())
    {
        m_interrupted   = false;
        m_interruptable = false;
        UpdateTarget(m_PEntity->IsValidTarget(m_targid, m_PItem->getValidTarget(), m_errorMsg));

        action_t action{};

        // attempt to interrupt
        InterruptItem(action);

        if (!m_interrupted)
        {
            FinishItem(action);
            m_PEntity->PAI->EventHandler.triggerListener("ITEM_USE", m_PEntity, m_PItem, &action);
            // Only send packet if action was populated (e.g. interrupts return early)
            if (!action.targets.empty())
            {
                m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
            }
        }
        else
        {
            // InterruptItem handles the BATTLE2 packet already.
            m_PEntity->PAI->EventHandler.triggerListener("ITEM_USE", m_PEntity, m_PItem, &action);
        }
        Complete();
    }
    else if (IsCompleted() && tick > GetEntryTime() + m_castTime + m_animationTime)
    {
        if (m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = m_PEntity;
            PChar->m_charHistory.itemsUsed++;
        }
        m_PEntity->PAI->EventHandler.triggerListener("ITEM_STATE_EXIT", m_PEntity, m_PItem);
        return true;
    }
    return false;
}

void CItemState::Cleanup(timer::time_point tick)
{
    m_PEntity->UContainer->Clean();

    if ((m_interrupted || !IsCompleted()) && !m_PItem->isType(ITEM_EQUIPMENT))
    {
        m_PItem->setSubType(ITEM_UNLOCKED);
    }

    auto* PItem = m_PEntity->getStorage(m_location)->GetItem(m_slot);

    if (PItem && PItem == m_PItem)
    {
        m_PEntity->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(m_PItem, ItemLockFlg::Normal);
    }
    else
    {
        m_PItem = nullptr;
    }

    m_PEntity->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(m_PItem, static_cast<CONTAINER_ID>(m_location), m_slot);
    m_PEntity->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
}

auto CItemState::CanChangeState() -> bool
{
    return false;
}

void CItemState::TryInterrupt(CBattleEntity* PTarget)
{
    // todo: interrupt on being hit

    if (PTarget)
    {
        UpdateTarget(m_PEntity->IsValidTarget(PTarget->targid, m_PItem->getValidTarget(), m_errorMsg));
    }
    else
    {
        UpdateTarget(m_PEntity->IsValidTarget(m_targid, m_PItem->getValidTarget(), m_errorMsg));
    }

    auto msg = MsgBasic::CANNOT_USE_ITEMS;

    if (HasMoved() || m_PEntity->StatusEffectContainer->HasPreventActionEffect())
    {
        ActionInterrupts::ItemInterrupt(m_PEntity);
        msg           = MsgBasic::ITEM_FAILS_TO_ACTIVATE;
        m_interrupted = true;
    }
    else if (battleutils::IsParalyzed(m_PEntity))
    {
        ActionInterrupts::ItemParalyzed(m_PEntity, PTarget);
        msg           = MsgBasic::NONE; // The action packet already notifies.
        m_interrupted = true;
    }
    else if (!GetTarget())
    {
        m_interrupted = true;
    }
    else if (battleutils::IsIntimidated(m_PEntity, static_cast<CBattleEntity*>(GetTarget())))
    {
        ActionInterrupts::ItemIntimidated(m_PEntity, PTarget);
        msg           = MsgBasic::NONE; // The action packet already notifies.
        m_interrupted = true;
    }

    if (m_interrupted && !m_errorMsg && msg != MsgBasic::NONE)
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, m_PItem->getID(), 0, static_cast<MsgBasic>(msg));
    }
}

auto CItemState::GetItem() const -> CItemUsable*
{
    return m_PItem;
}

void CItemState::InterruptItem(action_t& action)
{
    TryInterrupt(static_cast<CBattleEntity*>(GetTarget()));

    if (m_interrupted)
    {
        if (this->HasErrorMsg())
        {
            m_PEntity->pushPacket(m_errorMsg->copy());
        }
    }
}

void CItemState::FinishItem(action_t& action)
{
    m_PEntity->OnItemFinish(*this, action);
}

auto CItemState::HasMoved() const -> bool
{
    return floorf(m_startPos.x * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.x * 10 + 0.5f) / 10 ||
           floorf(m_startPos.z * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.z * 10 + 0.5f) / 10;
}
