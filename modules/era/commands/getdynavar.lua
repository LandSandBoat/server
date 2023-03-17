-----------------------------------
-- func: getdynavar
-- desc: Retrieves the current value of a Dynamis variable
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

local zoneMap =
{
    ["BASTOK"] = xi.zone.DYNAMIS_BASTOK,
    ["WINDURST"] = xi.zone.DYNAMIS_WINDURST,
    ["SAN_DORIA"] = xi.zone.DYNAMIS_SAN_DORIA,
    ["JEUNO"] = xi.zone.DYNAMIS_JEUNO,
    ["BEAUCEDINE"] = xi.zone.DYNAMIS_BEAUCEDINE,
    ["XARCABARD"] = xi.zone.DYNAMIS_XARCABARD,
    ["VALKURM"] = xi.zone.DYNAMIS_VALKURM,
    ["QUFIM"] = xi.zone.DYNAMIS_QUFIM,
    ["BUBURIMU"] = xi.zone.DYNAMIS_BUBURIMU,
    ["TAVNAZIA"] = xi.zone.DYNAMIS_TAVNAZIA
}

local varNames =
{
    ["registered_players"] = function(zone)
        return GetServerVariable(string.format("[DYNA]RegisteredPlayers_%s", zone:getID()))
    end,
    ["token"] = function(zone)
        return GetServerVariable(string.format("[DYNA]Token_%s", zone:getID()))
    end,
    ["timepoint"] = function(zone)
        local timepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", zone:getID()))
        if timepoint then
            return xi.dynamis.getDynaTimeRemaining(timepoint)
        else
            return 0
        end
    end,
    ["10minwarning"] = function(zone)
        return GetServerVariable(string.format("[DYNA]Given10MinuteWarning_%s", zone:getID()))
    end,
    ["3minwarning"] = function(zone)
        return GetServerVariable(string.format("[DYNA]Given3MinuteWarning_%s", zone:getID()))
    end,
    ["1minwarning"] = function(zone)
        return GetServerVariable(string.format("[DYNA]Given1MinuteWarning_%s", zone:getID()))
    end,
    ["registrant"] = function(zone)
        return GetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", zone:getID()))
    end,
    ["wave"] = function(zone)
        return GetServerVariable(string.format("[DYNA]CurrentWave_%s", zone:getID()))
    end,
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getdynavar <zoneName> <varName>")
end

function onTrigger(player, zoneName, varName)
    if not zoneName or zoneName == "" then
        error(player, "Invalid zone name provided.")
    end

    zoneName = string.upper(zoneName)
    local zoneKey = zoneMap[zoneName]
    if not zoneKey then
        error(player, "Invalid zone name provided.")
        player:PrintToPlayer("Valid options: bastok, windurst, san_doria, jeuno, beaucedine, xarcabard, valkurm, qufim, buburimu, tavnazia")
        return
    end

    local zone = GetZone(zoneMap[zoneName])
    if not zone then
        error(player, "Failed to get dynamis zone.")
        return
    end

    if not varName or varName == "" then
        error(player, "[GetDynaVar] You must provide a valid variable name.")
        return
    end

    local formatter = varNames[string.lower(varName)]
    if not formatter then
        error(player, string.format("[GetDynaVar] '%s' is not a valid variable name.", varName))
        return
    end

    local result = formatter(zone)
    player:PrintToPlayer(string.format("[GetDynaVar] %s: %s", result))
end