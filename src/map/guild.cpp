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

#include "guild.h"
#include "entities/charentity.h"
#include "items/item.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"

CGuild::CGuild(uint8 id, const std::string& _pointsName)
: m_id(id)
{
    for (size_t i = 0; i < m_GPItemsRank.size(); ++i)
    {
        m_GPItemsRank[i] = (uint8)((CVanaTime::getInstance()->getVanaTime() / (60 * 60 * 24)) % (i + 4));
    }

    pointsName = _pointsName;
}

CGuild::~CGuild() = default;

uint8 CGuild::id() const
{
    return m_id;
}

void CGuild::updateGuildPointsPattern(uint8 pattern)
{
    for (auto& GPItems : m_GPItems)
    {
        GPItems.clear();
    }

    for (size_t i = 0; i < m_GPItemsRank.size(); ++i)
    {
        m_GPItemsRank[i] = (m_GPItemsRank[i] + 1) % (i + 4);

        std::string query = "SELECT itemid, points, max_points FROM guild_item_points WHERE "
                            "guildid = %u AND pattern = %u AND rank = %u";
        int         ret   = _sql->Query(query.c_str(), m_id, pattern, m_GPItemsRank[i]);

        if (ret != SQL_ERROR && _sql->NumRows() > 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                m_GPItems[i].emplace_back(
                    GPItem_t(itemutils::GetItemPointer(_sql->GetUIntData(0)), _sql->GetUIntData(2), _sql->GetUIntData(1)));
            }
        }
    }
}

std::pair<uint8, int16> CGuild::addGuildPoints(CCharEntity* PChar, CItem* PItem)
{
    uint8 rank = PChar->RealSkills.rank[m_id + 48];

    rank = std::clamp<uint8>(rank, 3, 9);

    if (PItem)
    {
        int32 curPoints = PChar->getCharVar("[GUILD]daily_points");
        if (curPoints != 1)
        {
            for (auto& GPItem : m_GPItems[rank - 3])
            {
                if (GPItem.item->getID() == PItem->getID())
                {
                    // if a player ranks up to a new pattern whose maxpoints are fewer than the player's current daily points
                    // then we'd be trying to push a negative number into quantity. our edit to CGuild::getDailyGPItem should
                    // prevent this, but let's be doubly sure.
                    uint16 quantity = std::max<uint16>(0, std::min<uint16>((((GPItem.maxpoints - curPoints) / GPItem.points) + 1), PItem->getReserve()));
                    uint16 points   = GPItem.points * quantity;
                    if (points > GPItem.maxpoints - curPoints)
                    {
                        points = GPItem.maxpoints - curPoints;
                    }

                    charutils::AddPoints(PChar, pointsName.c_str(), points);

                    PChar->setCharVar("[GUILD]daily_points", curPoints + points);

                    return {
                        std::clamp<uint8>(quantity, 0, std::numeric_limits<uint8>::max()), points
                    };
                }
            }
        }
    }

    return { 0, 0 };
}

std::pair<uint16, uint16> CGuild::getDailyGPItem(CCharEntity* PChar)
{
    uint8 rank = PChar->RealSkills.rank[m_id + 48];

    rank = std::clamp<uint8>(rank, 3, 9);

    auto GPItem    = m_GPItems[rank - 3];
    auto curPoints = (uint16)PChar->getCharVar("[GUILD]daily_points");

    if (curPoints == 1) // char_var set to 1 in crafting.lua file when done getting points forthe day. Deleted in guildutils.cpp
    {
        return std::make_pair(GPItem[0].item->getID(), 0);
    }
    else
    {
        // a rank-up can land player in a new pattern that rewards fewer max points than they
        // have traded in today. we prevent remainingPoints from going negative here so that
        // we don't later calculate a negative quantity in CGuild::addGuildPoints
        return std::make_pair(GPItem[0].item->getID(), std::max<uint16>(0, (GPItem[0].maxpoints - curPoints)));
    }
}
