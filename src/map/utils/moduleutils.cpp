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

#include "moduleutils.h"

#include "common/cbasetypes.h"
#include "../lua/luautils.h"

#include <filesystem>

namespace moduleutils
{
    void LoadModules()
    {
        sol::state& lua = luautils::lua;

        // Load the helper file
        lua.script_file("./modules/module_utils.lua");

        // Load each module file that isn't the helpers.lua file
        for (auto const& entry : std::filesystem::recursive_directory_iterator("modules"))
        {
            auto path          = entry.path().relative_path();
            bool isHelpersFile = path.filename() == "module_utils.lua";

            if (!entry.is_directory() &&
                path.extension() == ".lua" &&
                !isHelpersFile)
            {
                std::string filename  = path.filename().generic_string();
                std::string pathNoExt = path.replace_extension("").generic_string();

                // Note: Doing this in C++ resulted in self.overrides not being available to Module:apply()
                auto result = lua.safe_script(fmt::format(R"(
                    local m = require("{0}")
                    if m.enabled then
                        m:apply()
                    end
                    return m
                )", pathNoExt));

                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError(err.what());
                }
                else
                {
                    sol::table table = result;
                    if (table["enabled"])
                    {
                        std::string name = table["name"];
                        ShowScript(fmt::format("Loaded module: {}", name));
                    }
                }
            }
        }
    }
}; // namespace moduleutils
