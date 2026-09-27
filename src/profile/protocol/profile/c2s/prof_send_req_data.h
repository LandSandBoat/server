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

#include "enums/prof_request.h"

#include "common/cbasetypes.h"

#include <array>

namespace profile
{

#pragma pack(push, 1)

// Request header
// Used by MakeSendReqData()
struct ProfSendReqData
{
    uint8                 kind; // 2
    uint8                 command;
    uint8                 subCommand;
    uint8                 padding03;
    uint32                size; // bytes of objects the client sends after this header
    uint8                 unused08[16];
    std::array<uint8, 16> signature; // MD5(pol id, password, session value)

    auto request() const -> ProfRequest
    {
        return static_cast<ProfRequest>(command << 8 | subCommand);
    }
};

#pragma pack(pop)

} // namespace profile
