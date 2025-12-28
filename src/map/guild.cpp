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
#include "lua/luautils.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"

CGuild::CGuild(uint8 id, const std::string& _pointsName)
: m_id(id)
{
    earth_time::duration currentTime = std::chrono::seconds(earth_time::vanadiel_timestamp()) - 24h;
    uint32               elapsedDays = std::chrono::floor<std::chrono::days>(currentTime).count();

    for (size_t i = 0; i < m_GPItemsRank.size(); ++i)
    {
        m_GPItemsRank[i] = static_cast<uint8>(elapsedDays % (i + 4));
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

        const auto rset = db::preparedStmt("SELECT itemid, points, max_points FROM guild_item_points WHERE "
                                           "guildid = ? AND pattern = ? AND rank = ?",
                                           m_id,
                                           pattern,
                                           m_GPItemsRank[i]);

        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                const auto itemId    = rset->get<uint16>("itemid");
                const auto points    = rset->get<uint16>("points");
                const auto maxPoints = rset->get<uint16>("max_points");

                m_GPItems[i].emplace_back(itemutils::GetItemPointer(itemId), maxPoints, points);
            }
        }
    }
}

auto CGuild::addGuildPoints(CCharEntity* PChar, const CItem* PItem) const -> std::pair<uint8, int16>
{
    uint8 rank = PChar->RealSkills.rank[m_id + 48];

    rank                   = std::clamp<uint8>(rank, 3, 9);
    const uint16 curPoints = PChar->getCharVar("[GUILD]daily_points");

    if (curPoints == 1)
    {
        // curPoints set to 1 means the player is not eligible for points
        // due to changing guilds recently.
        return { 0, 0 };
    }

    if (PItem)
    {
        for (auto& GPItem : m_GPItems[rank - 3])
        {
            if (GPItem.item->getID() == PItem->getID())
            {
                // if a player ranks up to a new pattern whose maxpoints are fewer than the player's current daily points
                // then we'd be trying to push a negative number into quantity. our edit to CGuild::getDailyGPItem should
                // prevent this, but let's be doubly sure.
                uint16 quantity    = std::min<uint16>((((GPItem.maxpoints - std::clamp<uint16>(curPoints, 0, GPItem.maxpoints)) / GPItem.points) + 1), PItem->getReserve());
                uint16 pointsToAdd = GPItem.points * quantity;

                if (curPoints <= GPItem.maxpoints)
                {
                    pointsToAdd = std::clamp<uint16>(pointsToAdd, 0, GPItem.maxpoints - curPoints);
                }
                else
                {
                    pointsToAdd = 0;
                }

                charutils::AddPoints(PChar, pointsName.c_str(), pointsToAdd);
                // Tally of earned points expire at JST midnight.
                PChar->setCharVar("[GUILD]daily_points", curPoints + pointsToAdd, luautils::JstMidnight());

                return { quantity, pointsToAdd };
            }
        }
    }

    return { 0, 0 };
}

auto CGuild::getDailyGPItem(CCharEntity* PChar) const -> std::pair<uint16, uint16>
{
    uint8 rank = PChar->RealSkills.rank[m_id + 48];

    rank = std::clamp<uint8>(rank, 3, 9);

    const auto GPItem    = m_GPItems[rank - 3];
    const auto curPoints = static_cast<uint16>(PChar->getCharVar("[GUILD]daily_points"));

    // curPoints set to 1 means the player recently changed guild and is barred from trading for the day.
    if (curPoints == 1)
    {
        return std::make_pair(GPItem[0].item->getID(), 0);
    }

    // a rank-up can land player in a new pattern that rewards fewer max points than they
    // have traded in today. we prevent remainingPoints from going negative here so that
    // we don't later calculate a negative quantity in CGuild::addGuildPoints
    return std::make_pair(GPItem[0].item->getID(), GPItem[0].maxpoints - std::clamp<uint16>(curPoints, 0, GPItem[0].maxpoints));
}
