/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "map_session_container.h"

#include "map_networking.h"
#include "map_session.h"
#include "status_effect_container.h"

#include "common/database.h"
#include "common/xi.h"

#include "entities/charentity.h"

#include "utils/charutils.h"
#include "utils/petutils.h"

auto MapSessionContainer::createSession(IPP ipp) -> MapSession*
{
    TracyZoneScoped;

    ShowDebugFmt("Creating session for {}", ipp.getIPString());

    const auto rset = db::preparedStmt("SELECT charid FROM accounts_sessions WHERE client_addr = ? LIMIT 1", ipp.getIP());
    if (!rset)
    {
        ShowError("SQL query failed in MapSessionContainer::createSession!");
        return nullptr;
    }

    if (rset->rowsCount() == 0)
    {
        // This is noisy and not really necessary
        DebugSocketsFmt("recv_parse: Invalid login attempt from {}", ipp.getIPString());
        return nullptr;
    }

    auto map_session_data = std::make_unique<MapSession>();

    map_session_data->last_update = timer::now();
    map_session_data->client_ipp  = ipp;

    sessions_[ipp] = std::move(map_session_data);

    return sessions_[ipp].get();
}

auto MapSessionContainer::createPendingSession(uint32 charId) -> MapSession*
{
    TracyZoneScoped;

    ShowDebugFmt("Creating pending session for character id {}", charId);

    const auto rset = db::preparedStmt("SELECT charid FROM accounts_sessions WHERE charid = ? LIMIT 1", charId);
    if (!rset)
    {
        ShowError("SQL query failed in MapSessionContainer::createPendingSession");
        return nullptr;
    }

    auto map_session_data = std::make_unique<MapSession>();

    map_session_data->last_update = timer::now(); // This may need adjustment if sessions feel like they take too long to free
    map_session_data->charID      = charId;

    pending_sessions_[charId] = std::move(map_session_data);

    return pending_sessions_[charId].get();
}

auto MapSessionContainer::getSessionByIPP(IPP ipp) -> MapSession*
{
    TracyZoneScoped;

    if (sessions_.find(ipp) != sessions_.end())
    {
        return sessions_[ipp].get();
    }

    return nullptr;
}

auto MapSessionContainer::getSessionByIPP(uint64 ipp) -> MapSession*
{
    TracyZoneScoped;

    auto ippObj = IPP(ipp);

    if (sessions_.find(ippObj) != sessions_.end())
    {
        return sessions_[ippObj].get();
    }

    return nullptr;
}

auto MapSessionContainer::getSessionByChar(CCharEntity* PChar) -> MapSession*
{
    TracyZoneScoped;

    if (PChar == nullptr)
    {
        return nullptr;
    }

    for (const auto& [_, session] : sessions_)
    {
        if (session->PChar->id == PChar->id)
        {
            return session.get();
        }
    }

    return nullptr;
}

auto MapSessionContainer::getSessionByCharId(uint32 charId) -> MapSession*
{
    TracyZoneScoped;

    for (const auto& [_, session] : sessions_)
    {
        if (session->charID == charId)
        {
            return session.get();
        }
    }

    return nullptr;
}

auto MapSessionContainer::getPendingSessionByCharId(uint32 charId) -> MapSession*
{
    TracyZoneScoped;

    if (pending_sessions_.contains(charId))
    {
        return pending_sessions_[charId].get();
    }

    return nullptr;
}

auto MapSessionContainer::getSessionByAccountId(uint32 accountId) -> MapSession*
{
    TracyZoneScoped;

    for (const auto& [_, session] : sessions_)
    {
        if (session->accountID == accountId)
        {
            return session.get();
        }
    }

    return nullptr;
}

auto MapSessionContainer::getSessionByCharName(const std::string& name) -> MapSession*
{
    TracyZoneScoped;

    for (const auto& [_, session] : sessions_)
    {
        if (session->PChar && session->PChar->name == name)
        {
            return session.get();
        }
    }

    return nullptr;
}

void MapSessionContainer::cleanupSessions(IPP mapIPP)
{
    TracyZoneScoped;

    auto timeoutSetting = settings::get<uint16>("map.MAX_TIME_LASTUPDATE");

    auto it = sessions_.begin();
    while (it != sessions_.end())
    {
        auto& map_session_data = it->second;

        auto* PChar = map_session_data->PChar.get();
        auto  now   = timer::now();

        if (now > map_session_data->last_update + 5s)
        {
            if (PChar != nullptr && !PChar->isLinkDead)
            {
                db::preparedStmt("UPDATE char_flags SET disconnecting = 1 WHERE charid = ?", map_session_data->charID);

                PChar->isLinkDead = true;
                PChar->updatemask |= UPDATE_HP;

                // Is this unintentionally sending extra packets when a player is disconnecting?
                if (PChar->status == STATUS_TYPE::NORMAL)
                {
                    PChar->loc.zone->SpawnPCs(PChar);
                }
            }

            if (now > map_session_data->last_update + std::chrono::seconds(timeoutSetting))
            {
                bool otherMap = false;

                // check if session is attached to a different map server...
                auto rset = db::preparedStmt("SELECT server_addr, server_port FROM accounts_sessions WHERE charid = ?", map_session_data->charID);
                if (rset && rset->rowsCount() && rset->next())
                {
                    uint32 server_addr = rset->get<uint32>("server_addr");
                    uint32 server_port = rset->get<uint32>("server_port");

                    // s_addr of 0 is single process map server without IP address set explicitly in commandline
                    // map_port is 0 without the port being explicitly set in commandline
                    if ((mapIPP.getIP() != 0 && server_addr != mapIPP.getIP()) || (mapIPP.getPort() != 0 && server_port != mapIPP.getPort()))
                    {
                        otherMap = true;
                    }
                }

                if (PChar != nullptr)
                {
                    ShowDebug(fmt::format("Clearing map server session for player: '{}' in zone: '{}' (On other map server = {})", PChar->name, PChar->loc.zone ? PChar->loc.zone->getName() : "None", otherMap ? "Yes" : "No"));

                    // Player session is attached to this map process and has stopped responding.
                    if (!otherMap)
                    {
                        map_session_data->PChar->StatusEffectContainer->SaveStatusEffects(true);
                        db::preparedStmt("DELETE FROM accounts_sessions WHERE charid = ?", map_session_data->charID);

                        // Save position if d/c or logout/shutdown
                        if (map_session_data->shuttingDown == 0 || map_session_data->shuttingDown == 1)
                        {
                            charutils::SaveCharPosition(PChar);
                        }
                    }

                    // uncharm pet if player d/c
                    if (PChar->PPet != nullptr && PChar->PPet->objtype == TYPE_MOB)
                    {
                        petutils::DespawnPet(PChar);
                    }

                    PChar->status = STATUS_TYPE::SHUTDOWN;

                    charutils::removeCharFromZone(PChar);

                    map_session_data->PChar.reset();

                    sessions_.erase(it++);
                }
                else
                {
                    ShowWarning("map_cleanup: WITHOUT CHAR timed out, session closed on this process");
                    if (!otherMap)
                    {
                        db::preparedStmt("DELETE FROM accounts_sessions WHERE charid = ?", map_session_data->charID);
                    }

                    sessions_.erase(it++);
                }

                continue;
            }
        }
        else if (PChar != nullptr && PChar->isLinkDead)
        {
            db::preparedStmt("UPDATE char_flags SET disconnecting = 0 WHERE charid = ?", map_session_data->charID);

            PChar->isLinkDead = false;
            PChar->updatemask |= UPDATE_HP;

            if (PChar->status == STATUS_TYPE::NORMAL)
            {
                PChar->loc.zone->SpawnPCs(PChar);
            }
            charutils::SaveCharStats(PChar);
        }
        ++it;
    }

    xi::eraseIf(
        pending_sessions_,
        [&](auto& pair)
        {
            auto& map_session_data = pair.second;

            auto now = timer::now();

            if (now > map_session_data->last_update + std::chrono::seconds(timeoutSetting))
            {
                ShowDebug(fmt::format("Clearing map server pending session for pending char ID: '{}'", map_session_data->charID));

                db::preparedStmt("DELETE FROM accounts_sessions WHERE charid = ?", map_session_data->charID);

                return true; // Erase
            }

            return false; // Keep
        });
}

void MapSessionContainer::destroySession(IPP ipp)
{
    TracyZoneScoped;

    if (auto map_session_data = getSessionByIPP(ipp))
    {
        destroySession(map_session_data);
    }
}

void MapSessionContainer::destroySession(MapSession* map_session_data)
{
    TracyZoneScoped;

    if (map_session_data == nullptr)
    {
        return;
    }

    ShowDebugFmt("Closing session for {}", map_session_data->client_ipp.toString());

    // clear accounts_sessions if character is logging out (not when zoning)
    if (map_session_data->shuttingDown == 1)
    {
        db::preparedStmt("DELETE FROM accounts_sessions WHERE charid = ?", map_session_data->charID);
    }

    if (map_session_data->PChar)
    {
        CZone* PZone = map_session_data->PChar->loc.zone;
        if (PZone)
        {
            // This should already be done in removeCharFromZone, but just to be safe...
            PZone->DecreaseZoneCounter(map_session_data->PChar.get());
        }
        map_session_data->PChar.reset();
    }

    sessions_.erase(map_session_data->client_ipp);
}

void MapSessionContainer::destroyPendingSession(MapSession* map_session_data)
{
    TracyZoneScoped;

    if (map_session_data == nullptr)
    {
        return;
    }

    ShowDebugFmt("Closing pending session for character id {}", map_session_data->charID);

    pending_sessions_.erase(map_session_data->charID);
}

void MapSessionContainer::destroyPendingSession(uint32 charId)
{
    TracyZoneScoped;

    if (auto map_session_data = getPendingSessionByCharId(charId))
    {
        ShowDebugFmt("Closing pending session for character id {}", map_session_data->charID);

        pending_sessions_.erase(charId);
    }
}
