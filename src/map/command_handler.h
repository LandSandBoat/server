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

#ifndef _COMMAND_HANDLER_H
#define _COMMAND_HANDLER_H

#include "../common/cbasetypes.h"
#include "../common/logging.h"

#include <list>
#include <string>

class CCharEntity;
namespace sol
{
    class state;
}

class CCommandHandler
{
public:
    static int32 call(sol::state& lua, CCharEntity* PChar, const std::string& commandline);
    static void  registerCommand(std::string const& commandName, std::string const& path);
};

#endif // _COMMAND_HANDLER_H
