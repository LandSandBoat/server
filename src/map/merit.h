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
#include "enums/merit_category.h"

#define MERITS_COUNT 305 // 5 full packages of 61 elements

enum class MeritType : uint16;
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

    uint32 value;      // the coefficient of variation of the parameter that is bound to merit
    uint8  upgrade;    // maximum number of upgrades
    uint32 jobs;       // bitmask of jobs for which merit has effect
    uint8  upgradeid;  // which set of upgrade values the merit will use
    uint8  catid;      // category which merit belongs to
    uint16 spellid;    // associated spell ID to learn/unlearn
    uint16 wsunlockid; // associated Weaponskill Unlock ID to learn/unlearn
};

class CCharEntity;

class CMeritPoints
{
public:
    CMeritPoints(CCharEntity* PChar);

    auto GetLimitPoints() const -> uint16;
    auto GetMeritPoints() const -> uint8;
    auto GetMeritValue(MeritType merit, const CCharEntity* PChar) const -> int32;
    auto GetMeritCountInSameCategory(MeritType merit) const -> uint16;

    auto AddLimitPoints(uint16 points) -> bool;
    auto IsMeritExist(MeritType merit) const -> bool;

    void RaiseMerit(MeritType merit);
    void LowerMerit(MeritType merit);

    void SetLimitPoints(uint16 points); // used for loading player limit points on login
    void SetMeritPoints(uint16 points); // used for loading player merit points on login

    auto GetMerit(MeritType merit) const -> const Merit_t*;
    auto GetMeritByIndex(uint16 index) const -> const Merit_t*;

    void LoadMeritPoints(uint32 charid);
    void SaveMeritPoints(uint32 charid);

private:
    uint16       m_LimitPoints;
    uint8        m_MeritPoints;
    CCharEntity* m_PChar;
    Merit_t      merits[MERITS_COUNT]{};

    Merit_t* GetMeritPointer(MeritType merit) const;
    Merit_t* Categories[static_cast<uint16>(MeritCategory::Count) / 64 - 1]{}; // 51 pointers to the first merit of each category
};

namespace meritNameSpace
{
    void LoadMeritsList(); // load the global list of merits

    extern Merit_t GMeritsTemplate[MERITS_COUNT];
    extern int16   groupOffset[static_cast<uint16>(MeritCategory::Count) / 64 - 1]; // the first merit offset of each category
}; // namespace meritNameSpace
