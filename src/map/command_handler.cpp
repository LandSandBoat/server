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

#include "command_handler.h"

#include "common/database.h"
#include "common/utils.h"

#include "autotranslate.h"

#include "entities/charentity.h"

#include "lua/lua_baseentity.h"
#include "lua/luautils.h"

#include <algorithm>
#include <charconv>
#include <iostream>
#include <string>
#include <string_view>
#include <unordered_map>
#include <variant>
#include <vector>

using CommandArg = std::variant<bool, int, double, std::string>;

auto CCommandHandler::call(Scheduler& scheduler, sol::state& lua, CCharEntity* const PChar, const std::string& commandline) -> CommandResult
{
    TracyZoneScoped;

    if (!PChar)
    {
        ShowError("cmdhandler::call: nullptr character attempted to use command");
        return CommandResult::Failure;
    }

    constexpr auto trimLeft = [](std::string_view& sv)
    {
        sv.remove_prefix(std::min(sv.find_first_not_of(" \t"), sv.size()));
    };

    constexpr auto popToken = [](std::string_view& sv) -> std::string_view
    {
        const auto end   = sv.find_first_of(" \t");
        const auto token = sv.substr(0, end);

        sv.remove_prefix(end != std::string_view::npos ? end + 1 : sv.size());

        return token;
    };

    auto cmdView = std::string_view(commandline);
    trimLeft(cmdView);

    if (cmdView.empty())
    {
        ShowError("cmdhandler::call: function name was empty");
        return CommandResult::Failure;
    }

    const auto cmdName = std::string(popToken(cmdView));

    TracyZoneString(PChar->name);
    TracyZoneString(commandline);

    const auto maybeCommand = lua["xi"]["commands"][cmdName].get<sol::optional<sol::table>>();
    if (!maybeCommand)
    {
        ShowError("cmdhandler::call: Function does not exist (%s)", cmdName.c_str());
        return CommandResult::Failure;
    }
    const auto& commandTable = *maybeCommand;

    const auto maybeCmdProp = commandTable.get<sol::optional<sol::table>>("cmdprops");
    if (!maybeCmdProp)
    {
        ShowError("cmdhandler::call: (%s): Undefined 'cmdprops' table", cmdName.c_str());
        return CommandResult::Failure;
    }
    const auto& cmdprops = *maybeCmdProp;

    const auto maybePerm   = cmdprops.get<sol::optional<int8>>("permission");
    const auto maybeParams = cmdprops.get<sol::optional<std::string>>("parameters");
    if (!maybePerm || !maybeParams)
    {
        ShowError("cmdhandler::call: (%s): Invalid or missing permission/parameters in cmdprops", cmdName.c_str());
        return CommandResult::Failure;
    }

    const auto& permission = *maybePerm;
    const auto& parameters = *maybeParams;

    if (permission > PChar->m_GMlevel)
    {
        ShowWarning("cmdhandler::call: Character %s attempting to use higher permission command %s", PChar->name.c_str(), cmdName.c_str());
        return CommandResult::Failure;
    }

    const auto auditLevel = settings::get<uint8>("map.AUDIT_GM_CMD");
    if (auditLevel <= permission && auditLevel > 0)
    {
        scheduler.postToWorkerThread(
            [name = PChar->name, cmd = cmdName, cmdlinestr = autotranslate::replaceBytes(commandline)]() mutable
            {
                const auto query = "INSERT into audit_gm (date_time, gm_name, command, full_string) VALUES(CURRENT_TIMESTAMP(3), ?, ?, ?)";
                if (!db::preparedStmt(query, db::escapeString(name), db::escapeString(cmd), db::escapeString(cmdlinestr)))
                {
                    ShowError("cmdhandler::call: Failed to log GM command.");
                }
            });
    }

    const auto maybeOnTrigger = commandTable.get<sol::optional<sol::function>>("onTrigger");
    if (!maybeOnTrigger)
    {
        ShowError("cmdhandler::call: (%s) missing onTrigger function", cmdName.c_str());
        return CommandResult::Failure;
    }
    const auto& onTrigger = *maybeOnTrigger;

    auto args = std::vector<CommandArg>{};
    args.reserve(parameters.size());

    for (const auto paramType : parameters)
    {
        if (paramType == 'b')
        {
            args.emplace_back(commandline);
            continue;
        }

        trimLeft(cmdView);
        if (cmdView.empty())
        {
            break;
        }

        if (paramType == 's')
        {
            if (parameters.size() == 1)
            {
                args.emplace_back(std::string(cmdView));
                cmdView = {};
                break;
            }
            args.emplace_back(std::string(popToken(cmdView)));
        }
        else if (paramType == 'i')
        {
            auto       val   = 0;
            const auto token = popToken(cmdView);
            std::from_chars(token.data(), token.data() + token.size(), val);
            args.emplace_back(val);
        }
        else if (paramType == 'd')
        {
            auto       val   = 0.0;
            const auto token = popToken(cmdView);
            std::from_chars(token.data(), token.data() + token.size(), val);
            args.emplace_back(val);
        }
        else
        {
            ShowError("cmdhandler::call: (%s) undefined type for param: symbol: %c", cmdName.c_str(), paramType);
        }
    }

    const auto result = onTrigger(PChar, sol::as_args(args));
    if (!result.valid())
    {
        const sol::error err = result;
        ShowError("cmdhandler::call: (%s) error: %s", cmdName.c_str(), err.what());
        return CommandResult::Failure;
    }

    return CommandResult::Success;
}
