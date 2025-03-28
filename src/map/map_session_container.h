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

#pragma once

#include "common/ipp.h"

class CCharEntity;
struct MapSession;

class MapSessionContainer
{
public:
    auto createSession(IPP ipp) -> MapSession*;

    auto getSessionByIPP(IPP ipp) -> MapSession*;
    auto getSessionByIPP(uint64 ipp) -> MapSession*;
    auto getSessionByChar(CCharEntity* PChar) -> MapSession*;
    auto getSessionByCharId(uint32 charId) -> MapSession*;
    auto getSessionByCharName(const std::string& name) -> MapSession*;

    void cleanupSessions(IPP mapIPP);

    void destroySession(IPP ipp);
    void destroySession(MapSession* map_session_data);

private:
    std::map<IPP, std::unique_ptr<MapSession>> sessions_;
};
