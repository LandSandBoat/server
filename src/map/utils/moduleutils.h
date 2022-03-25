/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Teams

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

#ifndef _MODULEUTILS_H
#define _MODULEUTILS_H

namespace moduleutils
{
    // The program has two "states":
    // - Load-time: As all data is being loaded and init'd
    // - Run-time: Once the main server tick starts
    //
    // There are multiple points where we'd like to override
    // the functionality of our Lua scripts, but it's hard
    // to determine when is the correct time to apply everything.
    //
    // So instead, we maintain a list of overrides specified by
    // active modules, and try multiple times during load-time
    // to apply them - looking for whether or not the cache
    // entry they want to modify exists.
    //
    // When run-time starts, we will be left with a list of
    // overrides that were either successfully or unsuccessfully
    // applied, and we can warn the user if there have been any
    // problems.

    void LoadLuaModules();
    void TryApplyModules();
    void ReportModuleUsage();
}; // namespace moduleutils

#endif // _MODULEUTILS_H
