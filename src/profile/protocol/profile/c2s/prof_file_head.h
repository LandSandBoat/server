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

#include "common/cbasetypes.h"

namespace profile
{

#pragma pack(push, 1)

// File request header
// Used by __sqProfReadFileCheck(), __sqProfWriteFileCheck(), __sqProfDeleteFileCheck()
struct ProfFileHead
{
    uint8  ownerHandleNumber;
    uint8  targetHandleNumber;
    uint8  unused02[6];
    uint64 target;      // polpro POL id; 0 = the requester's own files
    char   path[0x180]; // NUL terminated
    uint32 offset;      // the list calls put a u16 max entries here
    uint32 length;
};

// File request with a checksum, for ReadFile and the file lists
struct ProfFileRequest
{
    ProfFileHead head;
    uint32       unused198;
    uint32       checksum;
};

#pragma pack(pop)

} // namespace profile
