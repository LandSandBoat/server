/*
===========================================================================

  Copyright //(c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  //(at your option) any later version.

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
#include "data/enums/merit.h"
#include "data/enums/merit_category.h"
#include "data/enums/skill_type.h"

#include <optional>

constexpr uint16 kMeritPacketSlots = 305; // 5 full packages of 61 elements

struct Merit_t
{
    union
    {
        struct
        {
            uint16 id;    // merit id
            uint8  next;  // required merit points for next upgrade
            uint8  count; // number of upgrades
        };

        uint32 data; // data sent in packet
    };

    uint32            value;      // the coefficient of variation of the parameter that is bound to merit
    uint8             upgrade;    // maximum number of upgrades, and the length of costs
    uint32            jobs;       // bitmask of jobs for which merit has effect
    xi::MeritCategory category;   // category which merit belongs to
    uint16            spellid;    // associated spell ID to learn/unlearn
    uint16            wsunlockid; // associated Weaponskill Unlock ID to learn/unlearn
    const uint8*      costs;      // merit points required for each successive upgrade, owned by the dataset
};

class CCharEntity;

class CMeritPoints
{
public:
    CMeritPoints(CCharEntity* PChar);

    auto GetLimitPoints() const -> uint16;
    auto GetMeritPoints() const -> uint8;
    auto GetMeritValue(xi::Merit merit, const CCharEntity* PChar) -> int32;
    auto GetMeritCountInSameCategory(xi::Merit merit) const -> uint16;

    auto AddLimitPoints(uint16 points) -> bool;
    auto IsMeritExist(xi::Merit merit) const -> bool;

    void RaiseMerit(xi::Merit merit);
    void LowerMerit(xi::Merit merit);

    void SetLimitPoints(uint16 points); // used for loading player limit points on login
    void SetMeritPoints(uint16 points); // used for loading player merit points on login

    auto GetMerit(xi::Merit merit) -> const Merit_t*;
    auto GetMeritByIndex(uint16 index) const -> const Merit_t*;

    void LoadMeritPoints(uint32 charid);
    void SaveMeritPoints(uint32 charid);

private:
    uint16       m_LimitPoints;
    uint8        m_MeritPoints;
    CCharEntity* m_PChar;
    Merit_t      merits[kMeritPacketSlots]{};

    auto GetMeritPointer(xi::Merit merit) -> Merit_t*;
};

namespace meritNameSpace
{

void LoadMeritsList(); // load the global list of merits

auto GetSkillMerit(xi::SkillType skill) -> std::optional<xi::Merit>;

}; // namespace meritNameSpace
