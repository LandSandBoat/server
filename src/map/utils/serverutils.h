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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#pragma once

#include "common/cbasetypes.h"

namespace serverutils
{

auto GetServerVar(const std::string& var) -> uint32;
void SetServerVar(const std::string& var, int32 value, uint32 expiry = 0);
void PersistServerVar(const std::string& var, int32 value, uint32 expiry = 0);

auto GetVolatileServerVar(const std::string& var) -> int32;
void SetVolatileServerVar(const std::string& var, int32 value, uint32 expiry = 0);

void PersistVolatileServerVars();

} // namespace serverutils
