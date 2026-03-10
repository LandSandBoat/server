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

#include "enums/automaton.h"
#include "petentity.h"

#include <array>

struct automaton_equip_t
{
    AutomatonFrame        Frame;
    AutomatonHead         Head;
    std::array<uint8, 12> Attachments;
};

class CCharEntity;

class CAutomatonEntity : public CPetEntity
{
public:
    CAutomatonEntity();
    ~CAutomatonEntity();

    automaton_equip_t    m_Equip{};
    std::array<uint8, 8> m_ElementMax{};
    std::array<uint8, 8> m_ElementEquip{};

    auto getFrame() const -> AutomatonFrame;
    auto getHead() const -> AutomatonHead;
    auto getAttachment(uint8 slotid) const -> uint8;
    auto hasAttachment(uint8 attachment) const -> bool;

    auto getElementMax(uint8 element) const -> uint8;
    auto getElementCapacity(uint8 element) const -> uint8;

    void burdenTick();
    auto getBurden() const -> std::array<uint8, 8>;
    void setAllBurden(uint8 burden);
    void setBurdenArray(std::array<uint8, 8> burdenArray);
    auto addBurden(uint8 element, int8 burden) -> uint8;
    auto getOverloadChance(uint8 element) const -> uint8;

    void PostTick() override;

    virtual void Spawn() override;
    virtual void Die() override;

    virtual auto ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) -> bool override;

    virtual void OnMobSkillFinished(CMobSkillState&, action_t&) override;
    virtual void OnCastFinished(CMagicState&, action_t&) override;

private:
    std::array<uint8, 8> m_Burden{};
};
