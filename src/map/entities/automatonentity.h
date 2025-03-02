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

#ifndef _CAUTOMATONENTITY_H
#define _CAUTOMATONENTITY_H

#include "petentity.h"
#include <array>

enum AUTOFRAMETYPE
{
    FRAME_HARLEQUIN  = 0x20,
    FRAME_VALOREDGE  = 0x21,
    FRAME_SHARPSHOT  = 0x22,
    FRAME_STORMWAKER = 0x23
};

enum AUTOHEADTYPE
{
    HEAD_HARLEQUIN    = 0x01,
    HEAD_VALOREDGE    = 0x02,
    HEAD_SHARPSHOT    = 0x03,
    HEAD_STORMWAKER   = 0x04,
    HEAD_SOULSOOTHER  = 0x05,
    HEAD_SPIRITREAVER = 0x06
};

struct automaton_equip_t
{
    uint8                 Frame{ 0 };
    uint8                 Head{ 0 };
    std::array<uint8, 12> Attachments{};
};

class CCharEntity;

class CAutomatonEntity : public CPetEntity
{
public:
    CAutomatonEntity();
    ~CAutomatonEntity();

    automaton_equip_t    m_Equip;
    std::array<uint8, 8> m_ElementMax{};
    std::array<uint8, 8> m_ElementEquip{};

    AUTOFRAMETYPE getFrame() const;
    AUTOHEADTYPE  getHead() const;
    uint8         getAttachment(uint8 slot);
    bool          hasAttachment(uint8 attachment);

    uint8 getElementMax(uint8 element);
    uint8 getElementCapacity(uint8 element);

    void  burdenTick();
    auto  getBurden() -> std::array<uint8, 8>;
    void  setAllBurden(uint8 burden);
    void  setBurdenArray(std::array<uint8, 8> burdenArray);
    uint8 addBurden(uint8 element, int8 burden);
    uint8 getOverloadChance(uint8 element);

    void PostTick() override;

    virtual void Spawn() override;
    virtual void Die() override;

    virtual bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;

    virtual void OnMobSkillFinished(CMobSkillState&, action_t&) override;
    virtual void OnCastFinished(CMagicState&, action_t&) override;

private:
    std::array<uint8, 8> m_Burden{};
};

#endif
