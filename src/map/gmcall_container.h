/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "packets/c2s/0x0d3_faq_gmcall.h"

#include <vector>

class CCharEntity;
class GMCallContainer
{
public:
    auto addPacket(const GP_CLI_COMMAND_FAQ_GMCALL& packet) -> bool;
    void processCall(const CCharEntity* PChar) const;
    void sendPendingResponse(CCharEntity* PChar) const;
    void acknowledgeOldestResponse(CCharEntity* PChar) const;
    void clear();

private:
    uint8_t                                pktId_{};
    std::vector<GP_CLI_COMMAND_FAQ_GMCALL> packets_;
};
