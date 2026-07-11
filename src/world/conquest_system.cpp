/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "conquest_system.h"

#include "ipc_server.h"

#include "common/ipp.h"

#include "common/settings.h"

ConquestSystem::ConquestSystem(WorldEngine& worldServer)
: worldServer_(worldServer)
{
}

bool ConquestSystem::handleMessage(uint8 messageType, IPPMessage&& message)
{
    const auto conquestMsgType = static_cast<ConquestMessage>(messageType);
    switch (conquestMsgType)
    {
        case ConquestMessage::M2W_GM_WeeklyUpdate:
        {
            updateWeekConquest();
            return true;
        }
        break;
        case ConquestMessage::M2W_GM_ConquestUpdate:
        {
            // Trigger a full update of influence points
            sendInfluencesMsg(ShouldUpdateZones::Yes);
            return true;
        }
        break;
        case ConquestMessage::M2W_AddInfluencePoints:
        {
            if (const auto object = ipc::fromBytes<ConquestAddInfluencePoints>(message.payload))
            {
                // We update influence but do not immediately send this update to all map servers
                // Influence updates are sent periodically via time_server instead.
                // It is okay for map servers to be eventually consistent.
                updateInfluencePoints((*object).points, (*object).nation, static_cast<REGION_TYPE>((*object).region));
            }
            return true;
        }
        break;
        default:
        {
            ShowWarningFmt("Message: unknown conquest type message received: {} from {}",
                           conquestMsgType,
                           message.ipp.toString());
        }
        break;
    }

    return false;
}

void ConquestSystem::sendTallyStartMsg()
{
    worldServer_.ipcServer_->broadcastMessage(ipc::ConquestEvent{
        .type = ConquestMessage::W2M_WeeklyUpdateStart,
    });
}

void ConquestSystem::sendInfluencesMsg(ShouldUpdateZones shouldUpdateZones)
{
    worldServer_.ipcServer_->broadcastMessage(ipc::ConquestEvent{
        .type    = ConquestMessage::W2M_BroadcastInfluencePoints,
        .payload = ipc::toBytes(ConquestInfluenceUpdate{
            .shouldUpdateZones = shouldUpdateZones,
            .influences        = getRegionalInfluences(),
        }),
    });
}

void ConquestSystem::sendRegionControlsMsg(ConquestMessage msgType)
{
    worldServer_.ipcServer_->broadcastMessage(ipc::ConquestEvent{
        .type    = msgType,
        .payload = ipc::toBytes(ConquestRegionControlUpdate{
            .regionControls = getRegionControls(),
        }),
    });
}

bool ConquestSystem::updateInfluencePoints(int points, unsigned int nation, REGION_TYPE region)
{
    if (region == REGION_TYPE::UNKNOWN)
    {
        return false;
    }

    const auto rset = db::preparedStmt("SELECT sandoria_influence, bastok_influence, windurst_influence, beastmen_influence FROM conquest_system WHERE region_id = ?",
                                       static_cast<uint8>(region));
    if (!rset || rset->rowsCount() == 0 || !rset->next())
    {
        return false;
    }

    int influences[4] = {
        rset->get<int>("sandoria_influence"),
        rset->get<int>("bastok_influence"),
        rset->get<int>("windurst_influence"),
        rset->get<int>("beastmen_influence"),
    };

    // Read from main settings. Protect against 0 or too high of number.
    // Restricted by a factor of 100 because of packet lines in 0x05e_conquest.cpp
    const int32 influenceCap = std::clamp<int32>(settings::get<int32>("main.CONQUEST_INFLUENCE_CAP"), 1, 20000000);

    int total = influences[0] + influences[1] + influences[2] + influences[3];
    int room  = influenceCap - total;

    if (points <= room) // Pool is not capped and there is space. Straight add.
    {
        influences[nation] += points;
    }
    else // Pool is full. Gains come out of the other nations.
    {
        // Fill the remaining room first, then redistribute the overflow.
        influences[nation] += room;
        int overflow = points - room;

        // Do not adjust anything if the nation is already at the pool maximum.
        if (influences[nation] < influenceCap)
        {
            auto lost = 0;
            for (auto i = 0u; i < 4; ++i)
            {
                if (i == nation)
                {
                    continue;
                }

                const int64 share = static_cast<int64>(overflow) * influences[i] / (influenceCap - influences[nation]);
                auto        loss  = std::min<int>(static_cast<int>(share), influences[i]);
                influences[i] -= loss;
                lost += loss;
            }

            influences[nation] += lost;
        }
    }

    const auto rset2 = db::preparedStmt(
        "UPDATE conquest_system SET sandoria_influence = ?, bastok_influence = ?, "
        "windurst_influence = ?, beastmen_influence = ? WHERE region_id = ?",
        influences[0],
        influences[1],
        influences[2],
        influences[3],
        static_cast<uint8>(region));

    return !rset2;
}

void ConquestSystem::updateWeekConquest()
{
    TracyZoneScoped;

    sendTallyStartMsg();

    // Update the nation that controlled the region previously. Used in rare situations.
    db::preparedStmt("UPDATE conquest_system SET region_control_prev = region_control");

    const auto query = "UPDATE conquest_system SET region_control = "
                       "IF(sandoria_influence > bastok_influence AND sandoria_influence > windurst_influence AND "
                       "sandoria_influence > beastmen_influence, 0, "
                       "IF(bastok_influence > sandoria_influence AND bastok_influence > windurst_influence AND "
                       "bastok_influence > beastmen_influence, 1, "
                       "IF(windurst_influence > bastok_influence AND windurst_influence > sandoria_influence AND "
                       "windurst_influence > beastmen_influence, 2, "
                       "IF(beastmen_influence > sandoria_influence AND beastmen_influence > bastok_influence AND "
                       "beastmen_influence > windurst_influence, 3, 5))))";

    const auto rset = db::preparedStmt(query);
    if (!rset)
    {
        ShowError("handleWeeklyUpdate() failed");
    }

    // Reset influence for the new week.
    const auto resetRset = db::preparedStmt("UPDATE conquest_system SET sandoria_influence = 0, bastok_influence = 0, "
                                            "windurst_influence = 0, beastmen_influence = 0");
    if (!resetRset)
    {
        ShowError("updateWeekConquest: Failed to reset influence");
    }

    // Push the zeroed influence out.
    sendInfluencesMsg(ShouldUpdateZones::No);

    sendRegionControlsMsg(ConquestMessage::W2M_WeeklyUpdateEnd);
}

void ConquestSystem::updateHourlyConquest()
{
    sendInfluencesMsg(ShouldUpdateZones::Yes);
}

void ConquestSystem::updateVanaHourlyConquest()
{
    sendInfluencesMsg(ShouldUpdateZones::No);
}

auto ConquestSystem::getRegionalInfluences() -> std::vector<influence_t> const
{
    const auto rset = db::preparedStmt("SELECT sandoria_influence, bastok_influence, windurst_influence, beastmen_influence FROM conquest_system");

    std::vector<influence_t> influences;
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            influence_t influence{};
            influence.sandoria_influence = rset->get<int32>("sandoria_influence");
            influence.bastok_influence   = rset->get<int32>("bastok_influence");
            influence.windurst_influence = rset->get<int32>("windurst_influence");
            influence.beastmen_influence = rset->get<int32>("beastmen_influence");
            influences.emplace_back(influence);
        }
    }

    return influences;
}

auto ConquestSystem::getRegionControls() -> std::vector<region_control_t> const
{
    const auto rset = db::preparedStmt("SELECT region_control, region_control_prev FROM conquest_system");

    std::vector<region_control_t> controllers;
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            region_control_t regionControl{};
            regionControl.current = rset->get<uint8>("region_control");
            regionControl.prev    = rset->get<uint8>("region_control_prev");
            controllers.emplace_back(regionControl);
        }
    }

    return controllers;
}
