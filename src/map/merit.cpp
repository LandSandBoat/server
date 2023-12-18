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

#include <cstring>

#include "entities/charentity.h"
#include "map.h"
#include "merit.h"
#include "packets/char_abilities.h"
#include "packets/char_spells.h"
#include "utils/charutils.h"

static uint8 upgrade[10][45] = {
    { 1, 2, 3, 4, 5, 5, 5, 5, 5, 7, 7, 7, 9, 9, 9 },           // HP-MP
    { 3, 6, 9, 9, 9, 12, 12, 12, 12, 15, 15, 15, 15, 18, 18 }, // Attributes
    { 1, 2, 3, 3, 3, 3, 3, 3 },                                // Combat Skills
    { 1, 2, 3, 3, 3, 3, 3, 3 },                                // Defensive Skills
    { 1, 2, 3, 3, 3, 3, 3, 3 },                                // Magic Skills
    { 1, 2, 3, 4, 5 },                                         // Others
    { 1, 2, 3, 4, 5 },                                         // Job Group 1
    { 3, 4, 5, 5, 5 },                                         // Job Group 2
    { 20, 22, 24, 27, 30 },                                    // Weapon Skills
    { 1, 3, 5, 7, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39,
      42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 48, 48, 48,
      48, 48, 48, 48, 48, 48, 48, 51, 51, 51, 51, 51, 51, 51,
      51, 51 } // Max merits
};

#define MAX_LIMIT_POINTS 10000

// TODO: Transfer all this to the database

static uint8 cap[100] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,           // 00-09  0
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,           // 10-19  1
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2,           // 20-29  2
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3,           // 30-39  3
    4, 4, 4, 4, 4, 4, 4, 4, 4, 4,           // 40-49  4
    5, 5, 5, 5, 5,                          // 50-54  5
    6, 6, 6, 6, 6,                          // 55-59  6
    7, 7, 7, 7, 7,                          // 60-64  7
    8, 8, 8, 8, 8,                          // 65-69  8
    9, 9, 9, 9, 9,                          // 70-74  9
    10, 10, 10, 10, 10,                     // 75-79 10
    15, 15, 15, 15, 15, 15, 15, 15, 15, 15, // 80-89 15
    15, 15, 15, 15, 15, 15, 15, 15, 15, 15, // 90-99 15
};

struct MeritCategoryInfo_t
{
    int8  MeritsInCat; // number of elements in a group
    uint8 MaxPoints;   // the maximum number of points that can be put into a group
    uint8 UpgradeID;   // group index in upgrade array
};

static const MeritCategoryInfo_t meritCatInfo[] = {
    { 3, 75, 0 },   // MCATEGORY_HP_MP       catNumber 00 (HP 15, MP 15, Max_merits 45)
    { 7, 105, 1 },  // MCATEGORY_ATTRIBUTES  catNumber 01
    { 19, 152, 2 }, // MCATEGORY_COMBAT      catNumber 02
    { 14, 112, 4 }, // MCATEGORY_MAGIC       catNumber 03
    { 5, 10, 5 },   // MCATEGORY_OTHERS      catNumber 04

    { 5, 10, 6 }, // MCATEGORY_WAR_1       catNumber 05
    { 5, 10, 6 }, // MCATEGORY_MNK_1       catNumber 06
    { 5, 10, 6 }, // MCATEGORY_WHM_1       catNumber 07
    { 7, 10, 6 }, // MCATEGORY_BLM_1       catNumber 08
    { 7, 10, 6 }, // MCATEGORY_RDM_1       catNumber 09
    { 5, 10, 6 }, // MCATEGORY_THF_1       catNumber 10
    { 5, 10, 6 }, // MCATEGORY_PLD_1       catNumber 11
    { 5, 10, 6 }, // MCATEGORY_DRK_1       catNumber 12
    { 5, 10, 6 }, // MCATEGORY_BST_1       catNumber 13
    { 5, 10, 6 }, // MCATEGORY_BRD_1       catNumber 14
    { 5, 10, 6 }, // MCATEGORY_RNG_1       catNumber 15
    { 5, 10, 6 }, // MCATEGORY_SAM_1       catNumber 16
    { 7, 10, 6 }, // MCATEGORY_NIN_1       catNumber 17
    { 5, 10, 6 }, // MCATEGORY_DRG_1       catNumber 18
    { 5, 10, 6 }, // MCATEGORY_SMN_1       catNumber 19
    { 5, 10, 6 }, // MCATEGORY_BLU_1       catNumber 20
    { 5, 10, 6 }, // MCATEGORY_COR_1       catNumber 21
    { 5, 10, 6 }, // MCATEGORY_PUP_1       catNumber 22
    { 4, 10, 6 }, // MCATEGORY_DNC_1       catNumber 23
    { 4, 10, 6 }, // MCATEGORY_SCH_1       catNumber 24

    { 14, 15, 8 }, // MCATEGORY_WS          catNumber 25

    { 5, 10, 6 }, // MCATEGORY_GEO_1       catNumber 26
    { 5, 10, 6 }, // MCATEGORY_RUN_1       catNumber 27

    { 0, 0, 8 }, // MCATEGORY_UNK_0       catNumber 28
    { 0, 0, 8 }, // MCATEGORY_UNK_1       catNumber 29
    { 0, 0, 8 }, // MCATEGORY_UNK_2       catNumber 30

    { 4, 10, 7 },  // MCATEGORY_WAR_2       catNumber 31
    { 4, 10, 7 },  // MCATEGORY_MNK_2       catNumber 32
    { 6, 10, 7 },  // MCATEGORY_WHM_2       catNumber 33
    { 12, 10, 7 }, // MCATEGORY_BLM_2       catNumber 34
    { 12, 10, 7 }, // MCATEGORY_RDM_2       catNumber 35
    { 4, 10, 7 },  // MCATEGORY_THF_2       catNumber 36
    { 4, 10, 7 },  // MCATEGORY_PLD_2       catNumber 37
    { 4, 10, 7 },  // MCATEGORY_DRK_2       catNumber 38
    { 4, 10, 7 },  // MCATEGORY_BST_2       catNumber 39
    { 6, 10, 7 },  // MCATEGORY_BRD_2       catNumber 40
    { 4, 10, 7 },  // MCATEGORY_RNG_2       catNumber 41
    { 4, 10, 7 },  // MCATEGORY_SAM_2       catNumber 42
    { 12, 10, 7 }, // MCATEGORY_NIN_2       catNumber 43
    { 4, 10, 7 },  // MCATEGORY_DRG_2       catNumber 44
    { 6, 10, 7 },  // MCATEGORY_SMN_2       catNumber 45
    { 4, 10, 7 },  // MCATEGORY_BLU_2       catNumber 46
    { 4, 10, 7 },  // MCATEGORY_COR_2       catNumber 47
    { 4, 10, 7 },  // MCATEGORY_PUP_2       catNumber 48
    { 4, 10, 7 },  // MCATEGORY_DNC_2       catNumber 49
    { 6, 10, 7 },  // MCATEGORY_SHC_2       catNumber 50

    { 0, 0, 7 }, // MCATEGORY_UNK_3       catNumber 51

    { 4, 10, 7 }, // MCATEGORY_GEO_2       catNumber 52
    { 4, 10, 7 }, // MCATEGORY_RUN_2       catNumber 53
};

#define GetMeritCategory(merit) (((merit) >> 6) - 1)  // get category from merit
#define GetMeritID(merit)       (((merit)&0x3F) >> 1) // get the offset in the category from merit

CMeritPoints::CMeritPoints(CCharEntity* PChar)
{
    if (sizeof(merits) != sizeof(meritNameSpace::GMeritsTemplate))
    {
        ShowWarning("Size mismatch between merits and GMeritsTemplate for %s.", PChar->getName());
        return;
    }

    memcpy(merits, meritNameSpace::GMeritsTemplate, sizeof(merits));

    m_PChar = PChar;
    LoadMeritPoints(PChar->id);

    m_LimitPoints = 0;
    m_MeritPoints = 0;
}

void CMeritPoints::LoadMeritPoints(uint32 charid)
{
    uint8 catNumber   = 0;
    uint8 maxCatCount = 54;

    for (uint16 i = 0; i < MERITS_COUNT; ++i)
    {
        if ((catNumber < maxCatCount && i == meritNameSpace::groupOffset[catNumber]) || (catNumber > 27 && catNumber < 31) || catNumber == 51) // Increment category number if known (or known unknown)
        {
            if ((catNumber > 27 && catNumber < 31) || catNumber == 51) // 28-30 and 51 are UNK.
            {
                Categories[catNumber] = &merits[163]; // point these to valid merits to prevent crash
            }
            else
            {
                Categories[catNumber] = &merits[i];
            }

            catNumber++;
        }

        merits[i].count = 0;
        merits[i].next  = upgrade[merits[i].upgradeid][merits[i].count];
    }

    if (_sql->Query("SELECT meritid, upgrades FROM char_merit WHERE charid = %u", charid) != SQL_ERROR)
    {
        for (uint64 j = 0; j < _sql->NumRows(); j++)
        {
            if (_sql->NextRow() == SQL_SUCCESS)
            {
                uint32 meritID  = _sql->GetUIntData(0);
                uint32 upgrades = _sql->GetUIntData(1);
                for (auto& merit : merits)
                {
                    if (merit.id == meritID)
                    {
                        merit.count = upgrades;
                        merit.next  = upgrade[merit.upgradeid][merit.count];
                    }
                }
            }
        }
    }
}

void CMeritPoints::SaveMeritPoints(uint32 charid)
{
    for (auto& merit : merits)
    {
        if (merit.count > 0)
        {
            _sql->Query("INSERT INTO char_merit (charid, meritid, upgrades) VALUES(%u, %u, %u) ON DUPLICATE KEY UPDATE upgrades = %u", charid,
                        merit.id, merit.count, merit.count);
        }
        else
        {
            _sql->Query("DELETE FROM char_merit WHERE charid = %u AND meritid = %u", charid, merit.id);
        }
    }
}

uint16 CMeritPoints::GetLimitPoints() const
{
    return m_LimitPoints;
}

uint8 CMeritPoints::GetMeritPoints() const
{
    return m_MeritPoints;
}

uint16 CMeritPoints::GetMeritCountInSameCategory(MERIT_TYPE merit)
{
    if (!this->IsMeritExist(merit))
    {
        return 0;
    }

    Merit_t* PMerit = Categories[GetMeritCategory(merit)];

    uint16 total = 0;

    for (int i = 0; i < meritCatInfo[GetMeritCategory(merit)].MeritsInCat; ++i)
    {
        total += PMerit->count;
        PMerit++;
    }

    return total;
}

// true - If merit was added

bool CMeritPoints::AddLimitPoints(uint16 points)
{
    m_LimitPoints += points;

    if (m_LimitPoints >= MAX_LIMIT_POINTS)
    {
        // check if player has reached cap
        if (m_MeritPoints == settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(MERIT_MAX_MERIT, m_PChar))
        {
            m_LimitPoints = MAX_LIMIT_POINTS - 1;
            return false;
        }

        uint8 MeritPoints = std::min(m_MeritPoints + m_LimitPoints / MAX_LIMIT_POINTS, settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(MERIT_MAX_MERIT, m_PChar));

        m_LimitPoints = m_LimitPoints % MAX_LIMIT_POINTS;

        if (m_MeritPoints != MeritPoints)
        {
            m_MeritPoints = MeritPoints;
            return true;
        }
    }
    return false;
}

void CMeritPoints::SetLimitPoints(uint16 points)
{
    m_LimitPoints = std::min<uint16>(points, MAX_LIMIT_POINTS - 1);
}

void CMeritPoints::SetMeritPoints(uint16 points)
{
    m_MeritPoints = std::min<uint8>((uint8)points, settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(MERIT_MAX_MERIT, m_PChar));
}

/************************************************************************
 *                                                                       *
 *  Check the availability of merit. Should only be used if receiving    *
 *  meritid from a character                                             *
 *                                                                       *
 ************************************************************************/

bool CMeritPoints::IsMeritExist(MERIT_TYPE merit)
{
    if ((int16)merit < MCATEGORY_START)
    {
        return false;
    }
    if ((int16)merit >= MCATEGORY_COUNT)
    {
        return false;
    }

    if ((GetMeritID(merit)) >= meritCatInfo[GetMeritCategory(merit)].MeritsInCat)
    {
        return false;
    }

    return true;
}

const Merit_t* CMeritPoints::GetMerit(MERIT_TYPE merit)
{
    return GetMeritPointer(merit);
}

const Merit_t* CMeritPoints::GetMeritByIndex(uint16 index)
{
    if (index >= MERITS_COUNT)
    {
        ShowWarning("Invalid Merit Index (%d) passed to function.", index);
        return nullptr;
    }

    return &merits[index];
}

Merit_t* CMeritPoints::GetMeritPointer(MERIT_TYPE merit)
{
    if (IsMeritExist(merit))
    {
        return &Categories[GetMeritCategory(merit)][GetMeritID(merit)];
    }
    return nullptr;
}

void CMeritPoints::RaiseMerit(MERIT_TYPE merit)
{
    Merit_t* PMerit = GetMeritPointer(merit);

    if (m_MeritPoints >= PMerit->next && PMerit->count < PMerit->upgrade && GetMeritCountInSameCategory(merit) < meritCatInfo[GetMeritCategory(merit)].MaxPoints)
    {
        m_MeritPoints -= PMerit->next;

        PMerit->next = upgrade[PMerit->upgradeid][PMerit->count + 1];
        if (PMerit->spellid != 0)
        {
            if (charutils::addSpell(m_PChar, PMerit->spellid))
            {
                charutils::SaveSpell(m_PChar, PMerit->spellid);
                m_PChar->pushPacket(new CCharSpellsPacket(m_PChar));
            }
        }

        if (PMerit->wsunlockid != 0 && !charutils::hasLearnedWeaponskill(m_PChar, PMerit->wsunlockid))
        {
            charutils::addLearnedWeaponskill(m_PChar, PMerit->wsunlockid);
            charutils::BuildingCharWeaponSkills(m_PChar);
            charutils::SaveLearnedAbilities(m_PChar);
            m_PChar->pushPacket(new CCharAbilitiesPacket(m_PChar));
        }

        PMerit->count++;

        // Reset traits
        charutils::BuildingCharTraitsTable(m_PChar);
    }
}

void CMeritPoints::LowerMerit(MERIT_TYPE merit)
{
    Merit_t* PMerit = GetMeritPointer(merit);

    if (PMerit->count > 0)
    {
        PMerit->next = upgrade[meritCatInfo[GetMeritCategory(merit)].UpgradeID][--PMerit->count];
    }

    if (PMerit->spellid != 0 && PMerit->count == 0)
    {
        if (charutils::delSpell(m_PChar, PMerit->spellid))
        {
            charutils::DeleteSpell(m_PChar, PMerit->spellid);
            m_PChar->pushPacket(new CCharSpellsPacket(m_PChar));

            // Reset traits
            charutils::BuildingCharTraitsTable(m_PChar);
        }
    }

    if (PMerit->wsunlockid != 0 && PMerit->count == 0 && charutils::hasLearnedWeaponskill(m_PChar, PMerit->wsunlockid))
    {
        charutils::delLearnedWeaponskill(m_PChar, PMerit->wsunlockid);
        charutils::BuildingCharWeaponSkills(m_PChar);
        charutils::SaveLearnedAbilities(m_PChar);
        m_PChar->pushPacket(new CCharAbilitiesPacket(m_PChar));
    }
}

int32 CMeritPoints::GetMeritValue(MERIT_TYPE merit, CCharEntity* PChar)
{
    Merit_t* PMerit     = GetMeritPointer(merit);
    uint16   meritValue = 0;

    if (PMerit)
    {
        if (PMerit->catid < 5 || (PMerit->jobs & (1 << (PChar->GetMJob() - 1)) && PChar->GetMLevel() >= 75))
        {
            meritValue = merit == MERIT_MAX_MERIT ? PMerit->count : std::min(PMerit->count, cap[PChar->GetMLevel()]);
        }

        if (PMerit->catid == 25 && PChar->GetMLevel() < 96)
        { // categoryID 25 is for merit weaponskills, which only apply if the player is lv 96+
            meritValue = 0;
        }

        meritValue *= PMerit->value;
    }

    return meritValue;
}

namespace meritNameSpace
{
    Merit_t GMeritsTemplate[MERITS_COUNT]         = {};    // global list of merits and their properties
    int16   groupOffset[MCATEGORY_COUNT / 64 - 1] = { 0 }; // the first merit offset of each category

    void LoadMeritsList()
    {
        int32 ret = _sql->Query("SELECT m.meritid, m.value, m.jobs, m.upgrade, m.upgradeid, m.catagoryid, sl.spellid, ws.unlock_id FROM merits m LEFT JOIN \
            spell_list sl ON m.name = sl.name LEFT JOIN weapon_skills ws ON m.name = ws.name ORDER BY m.meritid ASC LIMIT %u",
                                MERITS_COUNT);

        if (ret != SQL_ERROR && _sql->NumRows() != MERITS_COUNT)
        {
            // issue with unknown catagories causing massive confusion

            uint16 index            = 0; // global merit template count (to 255)
            uint8  catIndex         = 0; // global merit category count (to 51)
            int8   previousCatIndex = 0; // will be set on every loop, used for detecting a category change
            int8   catMeritIndex    = 0; // counts number of merits in a category

            while (_sql->NextRow() == SQL_SUCCESS)
            {
                Merit_t Merit = {}; // creat a new merit template.

                Merit.id         = _sql->GetUIntData(0); // set data from db.
                Merit.value      = _sql->GetUIntData(1);
                Merit.jobs       = _sql->GetUIntData(2);
                Merit.upgrade    = _sql->GetUIntData(3);
                Merit.upgradeid  = _sql->GetUIntData(4);
                Merit.catid      = _sql->GetUIntData(5);
                Merit.next       = upgrade[Merit.upgradeid][0];
                Merit.spellid    = _sql->GetUIntData(6);
                Merit.wsunlockid = _sql->GetUIntData(7);

                GMeritsTemplate[index] = Merit; // add the merit to the array

                previousCatIndex = Merit.catid; // previousCatIndex is set on everyloop to detect a catogory change.

                if (previousCatIndex != catIndex) // check for category change.
                {
                    groupOffset[catIndex] = index - catMeritIndex; // set index offset, first merit of each group.
                    catIndex++;                                    // now on next category.
                    catMeritIndex = 0;                             // reset the merit category count to 0.

                    if (previousCatIndex != catIndex)
                    { // this deals with the problem with unknown catagories.
                        catIndex = previousCatIndex;
                    }
                }

                catMeritIndex++; // next index within category.
                index++;         // next global template index.
            }

            groupOffset[catIndex] = index - catMeritIndex; // add the last offset manually since loop finishes before hand.
        }
        else
        {
            ShowError("The merits table is damaged");
        }
    }

}; // namespace meritNameSpace
