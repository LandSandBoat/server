-----------------------------------
-- func: adddynatime
-- desc: Adds an amount of time to the given dynamis instance.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
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

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!adddynatime <zoneName> <minutes>")
end

function onTrigger(player, zoneName, minutes)
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

    minutes = tonumber(minutes)
    if not minutes or minutes < 1 then
        error(player, "Please provide a valid number for minutes.")
    end

    local token = GetServerVariable(string.format("[DYNA]Token_%s", zone:getID()))
    local expire = GetServerVariable(string.format("[DYNA]Timepoint_%s", zone:getID()))

    -- Check that Dynamis is active and in-progress
    if not token or not expire or os.clock() > expire then
        error(player, string.format("No Dynamis is in-progress for %s", zoneName))
        return
    end

    -- Add the time
    xi.dynamis.addMinutesToDynamis(zone, minutes)
    player:PrintToPlayer(string.format("AddDynaTime: Added %s minutes to DYNAMIS_%s", minutes, zoneName))
end
